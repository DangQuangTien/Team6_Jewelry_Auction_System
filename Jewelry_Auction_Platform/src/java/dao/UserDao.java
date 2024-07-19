package dao;

import dto.UserDTO;
import entity.Auction.Auction;
import entity.Invoice.Invoice;
import entity.address.Address;
import entity.creditCard.CreditCard;
import entity.member.Member;
import entity.product.Category;
import entity.product.Jewelry;
import entity.product.RandomJewelry;
import entity.request_shipment.RequestShipment;
import entity.user.User;
import entity.valuation.Valuation;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
/**
 * UserDao Interface
 */
public interface UserDao {

    // Authentication
    UserDTO checkLogin(String username, String password);

    boolean registerUser(String firstName, String lastName, String email, String username, String password, String phoneNumber, String gender, Date dob);

    boolean checkDuplicateUsername(String username);

    // Member Information
    Member getInformation(String userID);

    // Category Operations
    ArrayList<Category> listCategory();

    // Valuation Operations
    boolean insertValuationRequest(String name, String email, String phone, String communicationMethod, String photos, String description, String memberID);

    ArrayList<Valuation> displayValuationRequest();

    // Jewelry Operations
    boolean insertJewelry(String category, String jewelryName, String artist,
            String circa, String material, String dial,
            String braceletMaterial, String caseDimensions,
            String braceletSize, String serialNumber,
            String referenceNumber, String caliber, String movement,
            String condition, String metal, String gemstones,
            String measurements, String weight, String stamped,
            String ringSize, String minPrice, String maxPrice,
            String tempPrice, String valuationID, String photos);

    List<Jewelry> getJewelryByUserID(String userID);

    boolean updateJewelry(Jewelry jewelry);

    boolean updateFinalPrice(String jewelryID, String finalPrice);

    boolean approveFinalPrice(String jewelryID);

    boolean sendToSeller(String jewelryID);

    boolean confirmToAuction(String jewelryID);

    boolean rejectToAuction(String jewelryID);

    List<Jewelry> displayAllJewelryForManager();

    List<Jewelry> displayAllJewelryForStaff();

    List<Jewelry> displayApprovedJewelry();

    List<Jewelry> displayConfirmedJewelry(int page, int pageSize);

    List<RandomJewelry> displayRandomJewelry();

    List<Jewelry> AuctionJewelryRegister(String memberID);

    Jewelry getJewelryDetails(String jewelryID);

    // Auction Operations
    boolean createAuction(String auctionStartDate, String auctionEndDate, String startTime, String endTime, String[] selectedJewelryIDs);

    List<Auction> displayAuction();

    Auction getAuctionByID(String auctionID);

    List<Jewelry> displayCatalog(String auctionID);

    // Request Shipment Operations
    boolean requestShipment(String valuationID, String content);

    List<RequestShipment> displayRequestShipment(String userID);

    boolean confirmReceipt(String valuationID);

    // Bidding Operations
    boolean registerToBid(String memberID, String cardID);

    List<Jewelry> displayJewelryInRoom(String auctionID);

    boolean checkAvailableSession(String jewelryID);

    boolean isJewelryOwnedByMember(String jewelryID, String memberID);

    boolean placeBid(String preBid_Amount, String jewelryID, String memberID);

    boolean editBid(String preBid_Amount, String jewelryID, String memberID);

    boolean saveBid(String preBid_Amount, String jewelryID, String memberID);

    Double getTheHighestBid(String jewelryID);

    // Address Operations
    boolean insertAddress(String country, String state, String city, String address1, String address2, String zipCode, String memberID,
            String holderName, String cardNumber, String cvvCode, Date expiryDate);

    // Additional Operations
    boolean findAndSetWinner(String jewelryID);

    boolean updateAllPlacedToLost(String jewelryID);

    boolean closeSession(String jewelryID);

    //Payment online
    boolean updateRegisterBidStatus(String memberID, String jewelryID);

    public void insertInvoice(Invoice invoice);

    List<Invoice> showAllInvoices();

    List<Invoice> showAllPastInvoices();

    boolean confirmPayment(String jewelryID);

    void updateSoldAmount(String jewelryID);

    //----------------------------
    List<CreditCard> displayAllRegisteringCard();

    boolean addUserForManager(String username, String email, String password, String roleID);

    boolean updateUserForManager(String userID, String username, String email, String password, String roleID);

    boolean deleteUserForManager(String userID);

    boolean checkBidderMatchSeller(String jewelryID, String memberID);

    boolean reactivateUserForManager(String userID);

    boolean rejectCard(String memberID);

    CreditCard getCardInformation(String userID);

    Address getAddressInformation(String userID);
    
    boolean deleteProfile(String memberID);
    
    boolean updateProfile(String memberID, String firstName, String lastName, String phoneNumber, String gender, String dob, String city, String state, String zipCode, String country, String address1, String address2);

    
    List<User> displayAllUserForManager();
    
}
