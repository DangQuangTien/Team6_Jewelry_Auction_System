/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity.bidding;

import java.time.LocalDateTime;

/**
 *
 * @author T14
 */
public class Bid_Track {
    private String bidID;
    private String sessionID;
    private String memberID;
    private Double bidAmount;
    private LocalDateTime bidTime;

    public Bid_Track() {
    }

    public Bid_Track(String bidID, String sessionID, String memberID, Double bidAmount, LocalDateTime bidTime) {
        this.bidID = bidID;
        this.sessionID = sessionID;
        this.memberID = memberID;
        this.bidAmount = bidAmount;
        this.bidTime = bidTime;
    }

    public String getBidID() {
        return bidID;
    }

    public void setBidID(String bidID) {
        this.bidID = bidID;
    }

    public String getSessionID() {
        return sessionID;
    }

    public void setSessionID(String sessionID) {
        this.sessionID = sessionID;
    }

    public String getMemberID() {
        return memberID;
    }

    public void setMemberID(String memberID) {
        this.memberID = memberID;
    }

    public Double getBidAmount() {
        return bidAmount;
    }

    public void setBidAmount(Double bidAmount) {
        this.bidAmount = bidAmount;
    }

    public LocalDateTime getBidTime() {
        return bidTime;
    }

    public void setBidTime(LocalDateTime bidTime) {
        this.bidTime = bidTime;
    }
}