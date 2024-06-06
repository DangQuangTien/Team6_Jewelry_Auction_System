/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity.Auction;

import java.time.LocalTime;
import java.util.Date;

/**
 *
 * @author User
 */
public class Auction {
    private String auctionID;
    private Date startDate;
    private LocalTime startTime;
    private LocalTime endTime;
    private int status;

    public Auction() {
    }

    public Auction(String auctionID, Date startDate, LocalTime startTime, LocalTime endTime, int status) {
        this.auctionID = auctionID;
        this.startDate = startDate;
        this.startTime = startTime;
        this.endTime = endTime;
        this.status = status;
    }

    public String getAuctionID() {
        return auctionID;
    }

    public void setAuctionID(String auctionID) {
        this.auctionID = auctionID;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public LocalTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalTime startTime) {
        this.startTime = startTime;
    }

    public LocalTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalTime endTime) {
        this.endTime = endTime;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    
    
    
}
