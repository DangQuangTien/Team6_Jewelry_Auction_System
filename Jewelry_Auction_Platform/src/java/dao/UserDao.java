/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dto.UserDTO;
import entity.Auction.Auction;
import entity.member.Member;
import entity.product.Category;
import entity.product.Jewelry;
import entity.product.RandomJewelry;
import entity.request_shipment.RequestShipment;
import entity.valuation.Valuation;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author User
 */
public interface UserDao {

    UserDTO checkLogin(String username, String password);

    Member getInformation(String userID);

    ArrayList<Category> listCategory();

    boolean insertValuationRequest(String name, String email, String phone, String communicationMethod, String photos, String description, String memberID);

    ArrayList<Valuation> displayValuationRequest();

    public boolean insertJewelry(String category, String jewelryName, String artist,
            String circa, String material, String dial,
            String braceletMaterial, String caseDimensions,
            String braceletSize, String serialNumber,
            String referenceNumber, String caliber, String movement,
            String condition, String metal, String gemstones,
            String measurements, String weight, String stamped,
            String ringSize, String minPrice, String maxPrice,
            String tempPrice, String valuationID, String photos);

    List<Jewelry> getJewelryByUserID(String userID);

    boolean requestShipment(String valuationID, String content);

    List<RequestShipment> displayRequestShipment(String userID);

    boolean confirmReceipt(String valuationID);

    List<Jewelry> displayAllJewelryForManager();

    List<Jewelry> displayAllJewelryForStaff();

    boolean updateJewelry(Jewelry jewelry);

    boolean updateFinalPrice(String jewelryID, String finalPrice);

    boolean approveFinalPrice(String jewelryID);

    List<Jewelry> displayApprovedJewelry();

    boolean sendToSeller(String jewelryID);

    boolean confirmToAuction(String jewelryID);

    boolean rejectToAuction(String jewelryID);

    List<Jewelry> displayConfirmedJewelry(int page, int pageSize);

    boolean createAuction(String auctionStartDate, String auctionEndDate, String startTime, String endTime, String[] selectedJewelryIDs);

    List<RandomJewelry> displayRandomJewelry();

    List<Auction> displayAuction();

    Auction getAuctionByID(String auctionID);

    List<Jewelry> displayCatalog(String auctionID);

    Jewelry getJewelryDetails(String jewelryID);

    boolean insertAddress(String country, String state, String city, String address1, String address2, String zipCode, String memberID);

    boolean registerToBid(String memberID);

    //Member Bidding
    List<Jewelry> displayJewelryInRoom(String auctionID);

    boolean checkAvailableSession(String jewelryID);

    boolean placeBid(String preBid_Amount, String jewelryID, String memberID);

    boolean editBid(String preBid_Amount, String jewelryID, String memberID);

    boolean saveBid(String preBid_Amount, String jewelryID, String memberID);

    Double getTheHighestBid(String jewelryID);

    //User register
    boolean registerUser(String firstName, String lastName, String email, String username, String password);

    //check if duplicated username
    boolean checkDuplicateUsername(String username);

    boolean closeSession(String jewelryID);

}
