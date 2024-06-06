/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity.Session;

/**
 *
 * @author User
 */
public class Session {
    private String sessionID;
    private String auctionID;
    private String jewelryID;
    private String startBid;
    private String winnerID;
    private int status;

    public Session() {
    }

    public Session(String sessionID, String auctionID, String jewelryID, String startBid, String winnerID, int status) {
        this.sessionID = sessionID;
        this.auctionID = auctionID;
        this.jewelryID = jewelryID;
        this.startBid = startBid;
        this.winnerID = winnerID;
        this.status = status;
    }

    public String getSessionID() {
        return sessionID;
    }

    public void setSessionID(String sessionID) {
        this.sessionID = sessionID;
    }

    public String getAuctionID() {
        return auctionID;
    }

    public void setAuctionID(String auctionID) {
        this.auctionID = auctionID;
    }

    public String getJewelryID() {
        return jewelryID;
    }

    public void setJewelryID(String jewelryID) {
        this.jewelryID = jewelryID;
    }

    public String getStartBid() {
        return startBid;
    }

    public void setStartBid(String startBid) {
        this.startBid = startBid;
    }

    public String getWinnerID() {
        return winnerID;
    }

    public void setWinnerID(String winnerID) {
        this.winnerID = winnerID;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    
    
    
}
