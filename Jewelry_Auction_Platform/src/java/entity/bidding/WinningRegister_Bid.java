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
public class WinningRegister_Bid {
    private String registerBidID;
    private String memberID;
    private String jewelryID;
    private String jewelryName;
    private Double bidAmount_Current;
    private LocalDateTime bidTime_Current;

    public WinningRegister_Bid() {
    }

    public WinningRegister_Bid(String registerBidID, String memberID, String jewelryID, String jewelryName, Double bidAmount_Current, LocalDateTime bidTime_Current) {
        this.registerBidID = registerBidID;
        this.memberID = memberID;
        this.jewelryID = jewelryID;
        this.jewelryName = jewelryName;
        this.bidAmount_Current = bidAmount_Current;
        this.bidTime_Current = bidTime_Current;
    }

    public String getRegisterBidID() {
        return registerBidID;
    }

    public void setRegisterBidID(String registerBidID) {
        this.registerBidID = registerBidID;
    }

    public String getMemberID() {
        return memberID;
    }

    public void setMemberID(String memberID) {
        this.memberID = memberID;
    }

    public String getJewelryID() {
        return jewelryID;
    }

    public void setJewelryID(String jewelryID) {
        this.jewelryID = jewelryID;
    }

    public String getJewelryName() {
        return jewelryName;
    }

    public void setJewelryName(String jewelryName) {
        this.jewelryName = jewelryName;
    }

    public Double getBidAmount_Current() {
        return bidAmount_Current;
    }

    public void setBidAmount_Current(Double bidAmount_Current) {
        this.bidAmount_Current = bidAmount_Current;
    }

    public LocalDateTime getBidTime_Current() {
        return bidTime_Current;
    }

    public void setBidTime_Current(LocalDateTime bidTime_Current) {
        this.bidTime_Current = bidTime_Current;
    }
    
}
