package controller.auction.roomserver;

import dao.UserDAOImpl;
import org.json.JSONException;
import org.json.JSONObject;
import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
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
            String jewelryID = json.getString("jewelryID");
            String bid = json.getString("bid");
            String memberID = json.getString("member");
            String auctionID = (String) session.getUserProperties().get("auctionID");
            Double TheHighestBid = dao.getTheHighestBid(jewelryID);
            Double bid_Current = Double.parseDouble(bid);
            if (bid_Current > TheHighestBid) {
                boolean result = dao.saveBid(bid, jewelryID, memberID);
                if (!result) {
                    dao.placeBid(bid, jewelryID, memberID);
                }
                sendMessageToClient(session, "You are winning with $" + bid_Current);
            } else {
                sendMessageToClient(session, "Your bid must be higher than the current highest bid: $" + TheHighestBid);
            }
            JSONObject bidMessage = new JSONObject();
            bidMessage.put("Floor Bid", bid);
            bidMessage.put("Time", Timestamp.valueOf(LocalDateTime.now()));
            broadcastBid(auctionID, bidMessage);
        } catch (JSONException e) {
            e.printStackTrace();
            sendMessageToClient(session, "Invalid JSON message format: " + message);
        } catch (Exception e) {
            e.printStackTrace();
            sendMessageToClient(session, "Error processing message: " + message);
        }
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
            e.printStackTrace();
        }
    }

    private void broadcastBid(String auctionID, JSONObject bidMessage) {
        Set<Session> sessions = auctionSessions.getOrDefault(auctionID, Collections.emptySet());
        for (Session session : sessions) {
            synchronized (session) {
                try {
                    session.getBasicRemote().sendText(bidMessage.toString());
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
