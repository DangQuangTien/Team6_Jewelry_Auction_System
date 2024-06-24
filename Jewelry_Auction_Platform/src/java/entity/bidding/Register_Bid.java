/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity.bidding;

import java.time.LocalTime;

/**
 *
 * @author T14
 */
public class Register_Bid {
    private String registerBidID;
    private String sessionID;
    private String memberID;
    private Double bidAmount_Current;
    private LocalTime bidTime_Current;
    private Double preBid_Amount;
    private LocalTime preBid_Time;
    private Byte status;

    public Register_Bid() {
    }

    public Register_Bid(String registerBidID, String sessionID, String memberID, Double bidAmount_Current, LocalTime bidTime_Current, Double preBid_Amount, LocalTime preBid_Time, Byte status) {
        this.registerBidID = registerBidID;
        this.sessionID = sessionID;
        this.memberID = memberID;
        this.bidAmount_Current = bidAmount_Current;
        this.bidTime_Current = bidTime_Current;
        this.preBid_Amount = preBid_Amount;
        this.preBid_Time = preBid_Time;
        this.status = status;
    }

    public String getRegisterBidID() {
        return registerBidID;
    }

    public void setRegisterBidID(String registerBidID) {
        this.registerBidID = registerBidID;
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

    public Double getBidAmount_Current() {
        return bidAmount_Current;
    }

    public void setBidAmount_Current(Double bidAmount_Current) {
        this.bidAmount_Current = bidAmount_Current;
    }

    public LocalTime getBidTime_Current() {
        return bidTime_Current;
    }

    public void setBidTime_Current(LocalTime bidTime_Current) {
        this.bidTime_Current = bidTime_Current;
    }

    public Double getPreBid_Amount() {
        return preBid_Amount;
    }

    public void setPreBid_Amount(Double preBid_Amount) {
        this.preBid_Amount = preBid_Amount;
    }

    public LocalTime getPreBid_Time() {
        return preBid_Time;
    }

    public void setPreBid_Time(LocalTime preBid_Time) {
        this.preBid_Time = preBid_Time;
    }

    public Byte getStatus() {
        return status;
    }

    public void setStatus(Byte status) {
        this.status = status;
    }
}
