/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity.product;

/**
 *
 * @author User
 */
public class RandomJewelry {

    private String photo;
    private String jewelryName;
    private String auctionID;

    public RandomJewelry() {
    }

    public RandomJewelry(String photo, String jewelryName, String auctionID) {
        this.photo = photo;
        this.jewelryName = jewelryName;
        this.auctionID = auctionID;
    }

    public String getJewelryName() {
        return jewelryName;
    }

    public void setJewelryName(String jewelryName) {
        this.jewelryName = jewelryName;
    }

    public String getAuctionID() {
        return auctionID;
    }

    public void setAuctionID(String auctionID) {
        this.auctionID = auctionID;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }
}
