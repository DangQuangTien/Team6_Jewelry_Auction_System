package jewelryauction.controller.web.auction;

import dao.UserDAOImpl;
import org.json.JSONException;
import org.json.JSONObject;
import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

@ServerEndpoint(value = "/BiddingRoomServer/{auctionID}")
public class BiddingRoomServerEndpoint {

    private static final Map<String, Set<Session>> auctionSessions = new ConcurrentHashMap<>();
    private static final UserDAOImpl dao = new UserDAOImpl();

    @OnOpen
    public void onOpen(Session session, @PathParam("auctionID") String auctionID) {
        // Initialize session set for the auction if not already present
        auctionSessions.computeIfAbsent(auctionID, k -> ConcurrentHashMap.newKeySet()).add(session);
        session.getUserProperties().put("auctionID", auctionID);
        System.out.println("WebSocket connection opened for auctionID " + auctionID + ": " + session.getId());
        sendMessageToClient(session, "Connected to auction: " + auctionID);
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        try {
            JSONObject json = new JSONObject(message);
            if (json.has("status") && "finished".equals(json.getString("status"))) {
                handleFinishedStatus(json);
                return;
            }

            String jewelryID = json.getString("jewelryID");
            String bid = json.getString("bid");
            String memberID = json.getString("member");
            String auctionID = (String) session.getUserProperties().get("auctionID");

            processBid(session, jewelryID, bid, memberID, auctionID);

        } catch (JSONException e) {
            sendMessageToClient(session, "Invalid JSON message format: " + message);
        } catch (NumberFormatException e) {
            sendMessageToClient(session, "Error processing bid value: " + message);
        }
    }

    private void handleFinishedStatus(JSONObject json) throws JSONException {
        String selectedJewelryID = json.getString("selectedJewelryID");
        dao.closeSession(selectedJewelryID);
        dao.findAndSetWinner(selectedJewelryID);
        dao.updateAllPlacedToLost(selectedJewelryID);
        
    }

    private void processBid(Session session, String jewelryID, String bid, String memberID, String auctionID) {
        try {
            boolean isValidSession = dao.checkAvailableSession(jewelryID);
            if (!isValidSession) {
                handleValidSession(session, jewelryID, bid, memberID, auctionID);
            } else {
                sendMessageToClient(session, "Jewelry no longer exists!");
            }
        } catch (SQLException e) {
            sendMessageToClient(session, "Error checking session for jewelry: " + jewelryID);
        }
    }

    private void handleValidSession(Session session, String jewelryID, String bid, String memberID, String auctionID) throws SQLException {
        boolean isOwnedByMember = dao.isJewelryOwnedByMember(jewelryID, memberID);
        if (isOwnedByMember) {
            sendMessageToClient(session, "You cannot place a bid on your own jewelry!");
            return;
        }
        Double theHighestBid = dao.getTheHighestBid(jewelryID);
        Double bidCurrent = Double.parseDouble(bid);
        if (bidCurrent > theHighestBid) {
            boolean result = dao.saveBid(bid, jewelryID, memberID);
            if (!result) {
                dao.placeBid(bid, jewelryID, memberID);
                dao.saveBid(bid, jewelryID, memberID);
            }
            sendMessageToClient(session, "You are winning with $" + bidCurrent);
            String bidMessage = createBidMessage(bid);
            broadcastBid(auctionID, bidMessage);
        } else {
            sendMessageToClient(session, "Your bid must be higher than the current highest bid: $" + theHighestBid);
        }
    }

    private String createBidMessage(String bid) {
        Timestamp timestamp = Timestamp.valueOf(LocalDateTime.now());
        return String.format("Floor Bid: %s at %s", bid, timestamp.toString());
    }

    @OnClose
    public void onClose(Session session) {
        String auctionID = (String) session.getUserProperties().get("auctionID");
        if (auctionID != null) {
            Set<Session> sessions = auctionSessions.getOrDefault(auctionID, Collections.emptySet());
            sessions.remove(session);
            System.out.println("WebSocket connection closed for auctionID " + auctionID + ": " + session.getId());
        }
    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        String auctionID = (String) session.getUserProperties().get("auctionID");
        if (auctionID != null) {
            System.err.println("Error occurred for auctionID " + auctionID + ": " + throwable.getMessage());
        }
    }

    private void sendMessageToClient(Session session, String message) {
        try {
            session.getBasicRemote().sendText(message);
        } catch (IOException e) {
        }
    }

    private void broadcastBid(String auctionID, String message) {
        Set<Session> sessions = auctionSessions.getOrDefault(auctionID, Collections.emptySet());
        for (Session session : sessions) {
            synchronized (session) {
                try {
                    session.getBasicRemote().sendText(message);
                } catch (IOException e) {
                }
            }
        }
    }
}
