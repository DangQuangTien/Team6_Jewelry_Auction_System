/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
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
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import utils.DBUtils;

/**
 *
 * @author User
 */
public class UserDAOImpl implements UserDao {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    @Override
    public UserDTO checkLogin(String usernameOrEmailOrPhone, String password) {
        String query = "SELECT TK.USERID, TK.USERNAME, VT.ROLE_NAME "
                + "FROM USERS TK "
                + "JOIN ROLE VT ON VT.ROLEID = TK.ROLEID "
                + "LEFT JOIN Member M ON M.userID = TK.userID "
                + "WHERE (TK.USERNAME = ? AND TK.PASSWORD = ? "
                + "       OR TK.EMAIL = ? AND TK.PASSWORD = ? "
                + "       OR M.phoneNumber = ? AND TK.PASSWORD = ?)"
                + "       AND (TK.active_status = 1)";

        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, usernameOrEmailOrPhone);
            ps.setString(2, password);
            ps.setString(3, usernameOrEmailOrPhone);
            ps.setString(4, password);
            ps.setString(5, usernameOrEmailOrPhone);
            ps.setString(6, password);

            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new UserDTO(rs.getString("USERID"), rs.getString("USERNAME"), rs.getString("ROLE_NAME"));
                }
            }
        } catch (SQLException | ClassNotFoundException ex) {
            // Handle or log the exception appropriately
            ex.printStackTrace();
        }

        return null; // Return null if no user found or an exception occurred
    }

    @Override
    public Member getInformation(String userID) {
        String query = "SELECT m.* FROM Member m JOIN Users u ON m.userID = u.userID WHERE u.userID = ?";
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, userID);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Member(rs.getString(1), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getDate(7), rs.getString(8), rs.getInt(9));
            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public ArrayList<Valuation> displayValuationRequest() {
        ArrayList<Valuation> lst = new ArrayList<>();
        String query = "SELECT * FROM REQUESTVALUATION";
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Valuation val = new Valuation();
                val.setValuationID(rs.getString(1));
                val.setName(rs.getString(2));
                val.setEmail(rs.getString(3));
                val.setPhone(rs.getString(4));
                val.setCommunication(rs.getString(5));
                val.setDescription(rs.getString(6));
                val.setPhoto(rs.getString(7));
                val.setStatus(rs.getInt(9));
                val.setFinal_Status(rs.getInt(10));
                lst.add(val);
            }
            return lst;
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public ArrayList<Category> listCategory() {
        ArrayList<Category> listCategory = new ArrayList<>();
        String query = "SELECT * FROM CATEGORY";
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Category category = new Category();
                category.setCategoryID(rs.getString(1));
                category.setCategoryName(rs.getString(2));
                listCategory.add(category);
            }
            return listCategory;

        } catch (ClassNotFoundException | SQLException ex) {
            ex.getMessage();
        }
        return null;
    }

    @Override
    public boolean insertValuationRequest(String name, String email, String phone, String communicationMethod, String photos, String description, String username) {
        boolean flag = true;
        String query = "insert into RequestValuation ([name], email, phonenumber, communication, photos, [description], memberId) values (?, ?, ?, ?, ?, ?, (select m.memberID from Users u, [Member] m where u.userID = m.userID and u.username = ?))";
        if (username.equals("Guest")) {
            query = "insert into valuation ([name], email, phonenumber, communication, photos, [description]) values (?, ?, ?, ?, ?, ?)";
            flag = false;
        }
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, communicationMethod);
            ps.setString(5, photos);
            ps.setString(6, description);
            if (flag != false) {
                ps.setString(7, username);
            }
            int result = ps.executeUpdate();
            return result > 0;
        } catch (ClassNotFoundException | SQLException ex) {
            ex.getMessage();
        }
        return false;
    }

    @Override
    public boolean insertJewelry(String category, String jewelryName, String artist, String circa, String material, String dial, String braceletMaterial, String caseDimensions, String braceletSize, String serialNumber, String referenceNumber, String caliber, String movement, String condition, String metal, String gemstones, String measurements, String weight, String stamped, String ringSize, String minPrice, String maxPrice, String tempPrice, String valuationID, String photos) {
        String query = "INSERT INTO Jewelry (categoryID, jewelryName, artist, circa, material, dial, braceletMaterial, caseDimensions, braceletSize, serialNumber, referenceNumber, caliber, movement, [condition], metal, gemstones, measurements, [weight], stamped, ringSize, minPrice, maxPrice, temp_Price, valuationId, photos) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, category);
            ps.setString(2, jewelryName);
            ps.setString(3, artist);
            ps.setString(4, circa);
            ps.setString(5, material);
            ps.setString(6, dial);
            ps.setString(7, braceletMaterial);
            ps.setString(8, caseDimensions);
            ps.setString(9, braceletSize);
            ps.setString(10, serialNumber);
            ps.setString(11, referenceNumber);
            ps.setString(12, caliber);
            ps.setString(13, movement);
            ps.setString(14, condition);
            ps.setString(15, metal);
            ps.setString(16, gemstones);
            ps.setString(17, measurements);
            ps.setString(18, weight);
            ps.setString(19, stamped);
            ps.setString(20, ringSize);
            ps.setString(21, minPrice);
            ps.setString(22, maxPrice);
            ps.setString(23, tempPrice);
            ps.setString(24, valuationID);
            ps.setString(25, photos);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    @Override
    public List<Jewelry> getJewelryByUserID(String userID) {
        List<Jewelry> jewelryList = new ArrayList<>();
        String query = "SELECT j.* FROM Jewelry j "
                + "JOIN RequestValuation v ON j.valuationID = v.valuationID "
                + "JOIN [Member] m ON v.memberID = m.memberID "
                + "WHERE m.userID = ?";
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, userID);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Jewelry jewelry = new Jewelry();
                    jewelry.setJewelryID(rs.getString("jewelryID"));
                    jewelry.setCategoryName(rs.getString("categoryID"));
                    jewelry.setJewelryName(rs.getString("jewelryName"));
                    jewelry.setArtist(rs.getString("artist"));
                    jewelry.setCirca(rs.getString("circa"));
                    jewelry.setMaterial(rs.getString("material"));
                    jewelry.setDial(rs.getString("dial"));
                    jewelry.setBraceletMaterial(rs.getString("braceletMaterial"));
                    jewelry.setCaseDimensions(rs.getString("caseDimensions"));
                    jewelry.setBraceletSize(rs.getString("braceletSize"));
                    jewelry.setSerialNumber(rs.getString("serialNumber"));
                    jewelry.setReferenceNumber(rs.getString("referenceNumber"));
                    jewelry.setCaliber(rs.getString("caliber"));
                    jewelry.setMovement(rs.getString("movement"));
                    jewelry.setCondition(rs.getString("condition"));
                    jewelry.setMetal(rs.getString("metal"));
                    jewelry.setGemstones(rs.getString("gemstones"));
                    jewelry.setMeasurements(rs.getString("measurements"));
                    jewelry.setWeight(rs.getString("weight"));
                    jewelry.setStamped(rs.getString("stamped"));
                    jewelry.setRingSize(rs.getString("ringSize"));
                    jewelry.setMinPrice(rs.getString("minPrice"));
                    jewelry.setMaxPrice(rs.getString("maxPrice"));
                    jewelry.setTemp_Price(rs.getString("temp_Price"));
                    jewelry.setFinal_Price(rs.getString("final_Price"));
                    jewelry.setValuationId(rs.getString("valuationID"));
                    jewelry.setStatus(rs.getString("status"));
                    jewelry.setPhotos(rs.getString("photos"));
                    jewelry.setTotalAmount(rs.getBigDecimal("Sold"));
                    jewelryList.add(jewelry);
                }
            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        }
        return jewelryList;
    }

    @Override
    public List<RequestShipment> displayRequestShipment(String userID) {
        String query = "select n.notificationID, n.content from Notification n, RequestValuation v, Users u, Member m where u.userID = ? and n.valuationID = v.valuationID and u.userID = m.userID";
        List<RequestShipment> listRequestShipment = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, userID);
            rs = ps.executeQuery();
            while (rs.next()) {
                RequestShipment request = new RequestShipment();
                request.setId(rs.getString(1));
                request.setContent(rs.getString(2));
                listRequestShipment.add(request);
            }
            return listRequestShipment;
        } catch (ClassNotFoundException | SQLException ex) {
            ex.getMessage();
        }
        return null;
    }

    @Override
    public boolean requestShipment(String valuationID, String content) {
        String query = "Insert Into Notification (valuationID, content) values (?, ?);";
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, valuationID);
            ps.setString(2, content);
            int result = ps.executeUpdate();
            return result > 0;

        } catch (ClassNotFoundException | SQLException ex) {
            ex.getMessage();
        }
        return false;
    }

    @Override
    public boolean confirmReceipt(String valuationID) {
        String updateJewelryQuery = "UPDATE JEWELRY SET [STATUS] = 'Received' WHERE VALUATIONID = ?";
        String updateRequestValuationQuery = "UPDATE RequestValuation SET final_Status = 1 WHERE valuationId = ?";

        Connection conn = null;
        PreparedStatement psJewelry = null;
        PreparedStatement psRequestValuation = null;

        try {
            conn = DBUtils.getConnection();
            conn.setAutoCommit(false); // Start transaction

            // Update Jewelry table
            psJewelry = conn.prepareStatement(updateJewelryQuery);
            psJewelry.setString(1, valuationID);
            int resultJewelry = psJewelry.executeUpdate();

            // Update RequestValuation table
            psRequestValuation = conn.prepareStatement(updateRequestValuationQuery);
            psRequestValuation.setString(1, valuationID);
            int resultRequestValuation = psRequestValuation.executeUpdate();

            if (resultJewelry > 0 && resultRequestValuation > 0) {
                conn.commit(); // Commit transaction
                return true;
            } else {
                conn.rollback(); // Rollback transaction
                return false;
            }

        } catch (ClassNotFoundException | SQLException ex) {
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback transaction on error
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            ex.printStackTrace();
            return false;
        } finally {
            if (psJewelry != null) {
                try {
                    psJewelry.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (psRequestValuation != null) {
                try {
                    psRequestValuation.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    @Override
    public List<Jewelry> displayAllJewelryForManager() {
        List<Jewelry> listJewelry = new ArrayList<>();
        String query = "SELECT * FROM JEWELRY WHERE STATUS = 'Final-Evaluated'";
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Jewelry jewelry = new Jewelry();
                    jewelry.setJewelryID(rs.getString("jewelryID"));
                    jewelry.setCategoryName(rs.getString("categoryID"));
                    jewelry.setJewelryName(rs.getString("jewelryName"));
                    jewelry.setArtist(rs.getString("artist"));
                    jewelry.setCirca(rs.getString("circa"));
                    jewelry.setMaterial(rs.getString("material"));
                    jewelry.setDial(rs.getString("dial"));
                    jewelry.setBraceletMaterial(rs.getString("braceletMaterial"));
                    jewelry.setCaseDimensions(rs.getString("caseDimensions"));
                    jewelry.setBraceletSize(rs.getString("braceletSize"));
                    jewelry.setSerialNumber(rs.getString("serialNumber"));
                    jewelry.setReferenceNumber(rs.getString("referenceNumber"));
                    jewelry.setCaliber(rs.getString("caliber"));
                    jewelry.setMovement(rs.getString("movement"));
                    jewelry.setCondition(rs.getString("condition"));
                    jewelry.setMetal(rs.getString("metal"));
                    jewelry.setGemstones(rs.getString("gemstones"));
                    jewelry.setMeasurements(rs.getString("measurements"));
                    jewelry.setWeight(rs.getString("weight"));
                    jewelry.setStamped(rs.getString("stamped"));
                    jewelry.setRingSize(rs.getString("ringSize"));
                    jewelry.setMinPrice(rs.getString("minPrice"));
                    jewelry.setMaxPrice(rs.getString("maxPrice"));
                    jewelry.setValuationId(rs.getString("valuationID"));
                    jewelry.setStatus(rs.getString("status"));
                    jewelry.setFinal_Price(rs.getString("final_Price"));
                    jewelry.setPhotos(rs.getString("photos"));
                    listJewelry.add(jewelry);
                }
            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        }
        return listJewelry;
    }

    @Override
    public List<Jewelry> displayAllJewelryForStaff() {
        List<Jewelry> listJewelry = new ArrayList<>();
        String query = "SELECT j.*, c.categoryName FROM JEWELRY j, Category c WHERE STATUS = 'Received' and j.categoryID = c.categoryID";
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Jewelry jewelry = new Jewelry();
                    jewelry.setJewelryID(rs.getString("jewelryID"));
                    jewelry.setCategoryName(rs.getString("categoryName"));
                    jewelry.setJewelryName(rs.getString("jewelryName"));
                    jewelry.setArtist(rs.getString("artist"));
                    jewelry.setCirca(rs.getString("circa"));
                    jewelry.setMaterial(rs.getString("material"));
                    jewelry.setDial(rs.getString("dial"));
                    jewelry.setBraceletMaterial(rs.getString("braceletMaterial"));
                    jewelry.setCaseDimensions(rs.getString("caseDimensions"));
                    jewelry.setBraceletSize(rs.getString("braceletSize"));
                    jewelry.setSerialNumber(rs.getString("serialNumber"));
                    jewelry.setReferenceNumber(rs.getString("referenceNumber"));
                    jewelry.setCaliber(rs.getString("caliber"));
                    jewelry.setMovement(rs.getString("movement"));
                    jewelry.setCondition(rs.getString("condition"));
                    jewelry.setMetal(rs.getString("metal"));
                    jewelry.setGemstones(rs.getString("gemstones"));
                    jewelry.setMeasurements(rs.getString("measurements"));
                    jewelry.setWeight(rs.getString("weight"));
                    jewelry.setStamped(rs.getString("stamped"));
                    jewelry.setRingSize(rs.getString("ringSize"));
                    jewelry.setMinPrice(rs.getString("minPrice"));
                    jewelry.setMaxPrice(rs.getString("maxPrice"));
                    jewelry.setValuationId(rs.getString("valuationID"));
                    jewelry.setStatus(rs.getString("status"));
                    jewelry.setFinal_Price(rs.getString("final_Price"));
                    jewelry.setPhotos(rs.getString("photos"));
                    listJewelry.add(jewelry);
                }
            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        }
        return listJewelry;
    }

    @Override
    public boolean updateFinalPrice(String jewelryID, String finalPrice) {
        String query = "Update Jewelry Set final_Price = ? Where jewelryID = ?";
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, finalPrice);
            ps.setString(2, jewelryID);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (ClassNotFoundException | SQLException ex) {
            ex.getMessage();
        }
        return false;
    }

    @Override
    public boolean approveFinalPrice(String jewelryID) {
        String query = "Update Jewelry Set [status] = 'Approved' Where jewelryID = ?";
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, jewelryID);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (ClassNotFoundException | SQLException ex) {
            ex.getMessage();
        }
        return false;
    }

    @Override
    public List<Jewelry> displayApprovedJewelry() {
        List<Jewelry> listJewelry = new ArrayList<>();
        String query = "SELECT * FROM JEWELRY WHERE STATUS = 'Approved'";
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Jewelry jewelry = new Jewelry();
                    jewelry.setJewelryID(rs.getString("jewelryID"));
                    jewelry.setCategoryName(rs.getString("categoryID"));
                    jewelry.setJewelryName(rs.getString("jewelryName"));
                    jewelry.setArtist(rs.getString("artist"));
                    jewelry.setCirca(rs.getString("circa"));
                    jewelry.setMaterial(rs.getString("material"));
                    jewelry.setDial(rs.getString("dial"));
                    jewelry.setBraceletMaterial(rs.getString("braceletMaterial"));
                    jewelry.setCaseDimensions(rs.getString("caseDimensions"));
                    jewelry.setBraceletSize(rs.getString("braceletSize"));
                    jewelry.setSerialNumber(rs.getString("serialNumber"));
                    jewelry.setReferenceNumber(rs.getString("referenceNumber"));
                    jewelry.setCaliber(rs.getString("caliber"));
                    jewelry.setMovement(rs.getString("movement"));
                    jewelry.setCondition(rs.getString("condition"));
                    jewelry.setMetal(rs.getString("metal"));
                    jewelry.setGemstones(rs.getString("gemstones"));
                    jewelry.setMeasurements(rs.getString("measurements"));
                    jewelry.setWeight(rs.getString("weight"));
                    jewelry.setStamped(rs.getString("stamped"));
                    jewelry.setRingSize(rs.getString("ringSize"));
                    jewelry.setMinPrice(rs.getString("minPrice"));
                    jewelry.setMaxPrice(rs.getString("maxPrice"));
                    jewelry.setValuationId(rs.getString("valuationID"));
                    jewelry.setStatus(rs.getString("status"));
                    jewelry.setFinal_Price(rs.getString("final_Price"));
                    jewelry.setPhotos(rs.getString("photos"));
                    listJewelry.add(jewelry);
                }
            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        }
        return listJewelry;
    }

    @Override
    public boolean sendToSeller(String jewelryID) {
        String query = "Update Jewelry Set [status] = 'Pending Confirm' Where jewelryID = ?";
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, jewelryID);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (ClassNotFoundException | SQLException ex) {
            ex.getMessage();
        }
        return false;
    }

    @Override
    public boolean confirmToAuction(String jewelryID) {
        String query = "Update Jewelry Set [status] = 'Confirmed' Where jewelryID = ?";
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, jewelryID);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (ClassNotFoundException | SQLException ex) {
            ex.getMessage();
        }
        return false;
    }

    @Override
    public boolean rejectToAuction(String jewelryID) {
        String query = "Update Jewelry Set [status] = 'Received' Where jewelryID = ?";
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, jewelryID);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (ClassNotFoundException | SQLException ex) {
            ex.getMessage();
        }
        return false;

    }

    @Override
    public List<Jewelry> displayConfirmedJewelry(int currentPage, int pageSize) {
        List<Jewelry> listJewelry = new ArrayList<>();
        String query = "SELECT j.*\n"
                + "FROM Jewelry j\n"
                + "LEFT JOIN Session s ON j.jewelryID = s.jewelryID\n"
                + "WHERE s.jewelryID IS NULL and j.status = 'Confirmed'\n"
                + "ORDER BY j.jewelryID\n"
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, (currentPage - 1) * pageSize); // Calculate the offset
            ps.setInt(2, pageSize); // Set the number of rows to fetch

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Jewelry jewelry = new Jewelry();
                    jewelry.setJewelryID(rs.getString("jewelryID"));
                    jewelry.setCategoryName(rs.getString("categoryID"));
                    jewelry.setJewelryName(rs.getString("jewelryName"));
                    jewelry.setArtist(rs.getString("artist"));
                    jewelry.setCirca(rs.getString("circa"));
                    jewelry.setMaterial(rs.getString("material"));
                    jewelry.setDial(rs.getString("dial"));
                    jewelry.setBraceletMaterial(rs.getString("braceletMaterial"));
                    jewelry.setCaseDimensions(rs.getString("caseDimensions"));
                    jewelry.setBraceletSize(rs.getString("braceletSize"));
                    jewelry.setSerialNumber(rs.getString("serialNumber"));
                    jewelry.setReferenceNumber(rs.getString("referenceNumber"));
                    jewelry.setCaliber(rs.getString("caliber"));
                    jewelry.setMovement(rs.getString("movement"));
                    jewelry.setCondition(rs.getString("condition"));
                    jewelry.setMetal(rs.getString("metal"));
                    jewelry.setGemstones(rs.getString("gemstones"));
                    jewelry.setMeasurements(rs.getString("measurements"));
                    jewelry.setWeight(rs.getString("weight"));
                    jewelry.setStamped(rs.getString("stamped"));
                    jewelry.setRingSize(rs.getString("ringSize"));
                    jewelry.setMinPrice(rs.getString("minPrice"));
                    jewelry.setMaxPrice(rs.getString("maxPrice"));
                    jewelry.setValuationId(rs.getString("valuationID"));
                    jewelry.setFinal_Price(rs.getString("final_Price"));
                    jewelry.setPhotos(rs.getString("photos"));
                    listJewelry.add(jewelry);
                }
            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        }
        return listJewelry;
    }

    public int getTotalConfirmedJewelryCount() {
        int count = 0;
        String query = "SELECT COUNT(*) AS total FROM Jewelry j\n"
                + "LEFT JOIN Session s ON j.jewelryID = s.jewelryID\n"
                + "WHERE s.jewelryID IS NULL and j.status = 'Confirmed'";
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(query);  ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        }
        return count;
    }

    @Override
    public boolean createAuction(String auctionStartDate, String auctionEndDate, String startTime, String endTime, String[] selectedJewelryIDs) {
        String insertAuctionQuery = "INSERT INTO Auction (startDate, endDate, startTime, endTime) VALUES (?, ?, ?, ?)";
        String selectAuctionQuery = "SELECT TOP 1 auctionID FROM Auction WHERE status = 0 ORDER BY auctionID DESC";
        String insertSessionQuery = "INSERT INTO [Session] (auctionID, jewelryID) VALUES (?, ?)";
        String updateAuctionStatusQuery = "UPDATE Auction SET status = 1 WHERE auctionID = ?";

        try ( Connection conn = DBUtils.getConnection();  PreparedStatement psInsertAuction = conn.prepareStatement(insertAuctionQuery);  PreparedStatement psSelectAuction = conn.prepareStatement(selectAuctionQuery);  PreparedStatement psInsertSession = conn.prepareStatement(insertSessionQuery);  PreparedStatement psUpdateAuctionStatus = conn.prepareStatement(updateAuctionStatusQuery)) {

            // Insert auction
            psInsertAuction.setString(1, auctionStartDate);
            psInsertAuction.setString(2, auctionEndDate);
            psInsertAuction.setString(3, startTime);
            psInsertAuction.setString(4, endTime);
            int result = psInsertAuction.executeUpdate();

            if (result > 0) {
                // Get the latest auction ID
                try ( ResultSet rs = psSelectAuction.executeQuery()) {
                    if (rs.next()) {
                        String auctionID = rs.getString("auctionID");
                        // Insert selected jewelry into session
                        for (String id : selectedJewelryIDs) {
                            psInsertSession.setString(1, auctionID);
                            psInsertSession.setString(2, id);
                            psInsertSession.executeUpdate();
                        }
                        // Update auction status
                        psUpdateAuctionStatus.setString(1, auctionID);
                        int updated = psUpdateAuctionStatus.executeUpdate();
                        return updated > 0;
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace(); // Handle or log the exception properly
        }
        return false;
    }

    @Override
    public List<Auction> displayAuction() {
        String query = "SELECT * FROM AUCTION WHERE STATUS = 1";
        List<Auction> listAuction = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Auction auction = new Auction();
                auction.setAuctionID(rs.getString(1));
                auction.setStartDate(rs.getDate("startDate"));
                auction.setEndDate(rs.getDate("endDate"));
                auction.setStartTime(LocalTime.parse(rs.getString("startTime")));
                auction.setEndTime(LocalTime.parse(rs.getString("endTime")));
                listAuction.add(auction);
            }
            return listAuction;
        } catch (ClassNotFoundException | SQLException ex) {
            ex.getMessage();
        }
        return null;
    }

    @Override
    public Auction getAuctionByID(String auctionID) {
        String query = "SELECT * FROM AUCTION WHERE AUCTIONID = ?";
        Auction auction = new Auction();
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, auctionID);
            rs = ps.executeQuery();
            while (rs.next()) {
                auction.setAuctionID(rs.getString(1));
                auction.setStartDate(rs.getDate("startDate"));
                auction.setEndDate(rs.getDate("endDate"));
                auction.setStartTime(LocalTime.parse(rs.getString("startTime")));
                auction.setEndTime(LocalTime.parse(rs.getString("endTime")));

            }
            return auction;
        } catch (ClassNotFoundException | SQLException ex) {
            ex.getMessage();
        }
        return null;
    }

    @Override
    public List<Jewelry> displayCatalog(String auctionID) {
        String query = "WITH MaxPreBid AS (\n"
                + "    SELECT \n"
                + "        S.jewelryID,\n"
                + "        MAX(RB.preBid_Amount) AS max_preBid_Amount\n"
                + "    FROM \n"
                + "        Register_Bid RB\n"
                + "    JOIN \n"
                + "        Session S ON RB.sessionID = S.sessionID\n"
                + "    GROUP BY \n"
                + "        S.jewelryID\n"
                + ")\n"
                + "SELECT \n"
                + "    J.*, \n"
                + "    C.CATEGORYNAME, \n"
                + "    MP.max_preBid_Amount\n"
                + "FROM \n"
                + "    JEWELRY J\n"
                + "JOIN \n"
                + "    CATEGORY C ON J.CATEGORYID = C.CATEGORYID\n"
                + "JOIN \n"
                + "    Session S ON J.jewelryID = S.jewelryID\n"
                + "JOIN \n"
                + "    Auction AUC ON S.AUCTIONID = AUC.AUCTIONID\n"
                + "LEFT JOIN \n"
                + "    MaxPreBid MP ON J.jewelryID = MP.jewelryID\n"
                + "WHERE \n"
                + "    AUC.AUCTIONID = ?;";
        List<Jewelry> listJewelry = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, auctionID);
            rs = ps.executeQuery();
            while (rs.next()) {
                Jewelry jewelry = new Jewelry();
                jewelry.setJewelryID(rs.getString("jewelryID"));
                jewelry.setPhotos(rs.getString("photos"));
                jewelry.setJewelryName(rs.getString("jewelryName"));
                jewelry.setCategoryName(rs.getString("CATEGORYNAME"));
                jewelry.setMinPrice(rs.getString("minPrice"));
                jewelry.setMaxPrice(rs.getString("maxPrice"));
                jewelry.setCurrentBid(rs.getDouble("max_preBid_Amount"));
                listJewelry.add(jewelry);
            }
            return listJewelry;
        } catch (Exception ex) {
            ex.getMessage();
        }
        return null;
    }

    @Override
    public Jewelry getJewelryDetails(String jewelryID) {
        String query = "SELECT * FROM JEWELRY j, category c WHERE c.categoryID = j.categoryID and j.jewelryID = ?";
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, jewelryID);
            rs = ps.executeQuery();
            Jewelry jewelry = new Jewelry();
            if (rs.next()) {
                jewelry.setJewelryID(rs.getString("jewelryID"));
                jewelry.setCategoryName(rs.getString("categoryName"));
                jewelry.setJewelryName(rs.getString("jewelryName"));
                jewelry.setArtist(rs.getString("artist"));
                jewelry.setCirca(rs.getString("circa"));
                jewelry.setMaterial(rs.getString("material"));
                jewelry.setDial(rs.getString("dial"));
                jewelry.setBraceletMaterial(rs.getString("braceletMaterial"));
                jewelry.setCaseDimensions(rs.getString("caseDimensions"));
                jewelry.setBraceletSize(rs.getString("braceletSize"));
                jewelry.setSerialNumber(rs.getString("serialNumber"));
                jewelry.setReferenceNumber(rs.getString("referenceNumber"));
                jewelry.setCaliber(rs.getString("caliber"));
                jewelry.setMovement(rs.getString("movement"));
                jewelry.setCondition(rs.getString("condition"));
                jewelry.setMetal(rs.getString("metal"));
                jewelry.setGemstones(rs.getString("gemstones"));
                jewelry.setMeasurements(rs.getString("measurements"));
                jewelry.setWeight(rs.getString("weight"));
                jewelry.setStamped(rs.getString("stamped"));
                jewelry.setRingSize(rs.getString("ringSize"));
                jewelry.setMinPrice(rs.getString("minPrice"));
                jewelry.setMaxPrice(rs.getString("maxPrice"));
                jewelry.setValuationId(rs.getString("valuationID"));
                jewelry.setStatus(rs.getString("status"));
                jewelry.setFinal_Price(rs.getString("final_Price"));
                jewelry.setPhotos(rs.getString("photos"));
            }
            return jewelry;

        } catch (ClassNotFoundException | SQLException ex) {
            ex.getMessage();
        }
        return null;
    }

    @Override
    public boolean insertAddress(String country, String state, String city, String address1, String address2, String zipCode, String memberID,
            String holderName, String cardNumber, String cvvCode, Date expiryDate) {
        String query = "INSERT INTO [Address] (city, state, zipcode, country, memberID, Address1, Address2) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String query1 = "INSERT INTO [Credit_Card] (memberID, holderName, cardNumber, cvvCode, expiryDate) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(query); PreparedStatement ps1 = conn.prepareStatement(query1)) {
            ps.setString(1, city);
            ps.setString(2, state);
            ps.setString(3, zipCode);
            ps.setString(4, country);
            ps.setString(5, memberID);
            ps.setString(6, address1);
            ps.setString(7, address2);

            ps1.setString(1, memberID);
            ps1.setString(2, holderName);
            ps1.setString(3, cardNumber);
            ps1.setString(4, cvvCode);
            ps1.setDate(5, expiryDate);

            int rowsAffected = ps.executeUpdate();
            int rowsAffected1 = ps1.executeUpdate();
            return (rowsAffected > 0 && rowsAffected1 > 0);

        } catch (ClassNotFoundException | SQLException ex) {
            // Log the exception
            ex.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean registerToBid(String memberID, String cardID) {
        String query = "UPDATE Member SET status_register_to_bid = 1 WHERE memberID = ?";
        String query1 = "UPDATE Credit_Card SET status = 1 WHERE cardID = ?";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(query); PreparedStatement ps1 = conn.prepareStatement(query1)) {
            ps.setString(1, memberID);

            ps1.setString(1, cardID);
            int result = ps.executeUpdate();
            int result1 = ps1.executeUpdate();
            return (result > 0 && result1 > 0);
        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    @Override
    public List<RandomJewelry> displayRandomJewelry() {
        String query = "SELECT TOP 10 j.photos, j.jewelryName, s.auctionID FROM Jewelry j, Auction auc, Session s where s.auctionID = auc.auctionId and s.jewelryID = j.jewelryID ORDER BY NEWID()";
        List<RandomJewelry> listJewelry = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                RandomJewelry jewelry = new RandomJewelry();
                jewelry.setPhoto(rs.getString(1));
                jewelry.setJewelryName(rs.getString(2));
                jewelry.setAuctionID(rs.getString(3));
                listJewelry.add(jewelry);
            }
            return listJewelry;

        } catch (ClassNotFoundException | SQLException ex) {
            ex.getMessage();
        }
        return null;
    }
  
    @Override
    public boolean isJewelryOwnedByMember(String jewelryID, String memberID) {
        String checkJewelryOwnership = "SELECT 1 FROM Jewelry j JOIN RequestValuation rv ON j.valuationId = rv.valuationId WHERE j.jewelryID = ? AND rv.memberId = ?";

        try ( Connection conn = DBUtils.getConnection();  PreparedStatement psCheckOwnership = conn.prepareStatement(checkJewelryOwnership)) {

            psCheckOwnership.setString(1, jewelryID);
            psCheckOwnership.setString(2, memberID);
            try ( ResultSet rsCheckOwnership = psCheckOwnership.executeQuery()) {
                return rsCheckOwnership.next();
            }
        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean placeBid(String preBid_Amount, String jewelryID, String memberID) {
        String mainQuery = "INSERT INTO Register_Bid(sessionID, memberID, preBid_Amount, bidAmount_Current) VALUES(?, ?, ?, ?)";
        String getSessionID = "SELECT s.sessionID FROM Session s JOIN Jewelry j ON s.jewelryID = j.jewelryID WHERE j.jewelryID = ?";

        try ( Connection conn = DBUtils.getConnection();  PreparedStatement psGetSessionID = conn.prepareStatement(getSessionID)) {

            psGetSessionID.setString(1, jewelryID);
            try ( ResultSet rs = psGetSessionID.executeQuery()) {
                if (rs.next()) {
                    String sessionID = rs.getString(1);

                    try ( PreparedStatement psMainQuery = conn.prepareStatement(mainQuery)) {
                        psMainQuery.setString(1, sessionID);
                        psMainQuery.setString(2, memberID);
                        psMainQuery.setString(3, preBid_Amount);
                        psMainQuery.setString(4, preBid_Amount);
                        int result = psMainQuery.executeUpdate();
                        return result > 0;
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }


    @Override
    public boolean editBid(String preBid_Amount, String jewelryID, String memberID) {
        String mainQuery = "UPDATE REGISTER_BID SET PREBID_AMOUNT = ?, PREBID_TIME = ? WHERE MEMBERID = ? AND SESSIONID = ?";
        String getSessionID = "SELECT s.sessionID FROM Session s JOIN Jewelry j ON s.jewelryID = j.jewelryID WHERE j.jewelryID = ?";

        try ( Connection conn = DBUtils.getConnection();  PreparedStatement psGetSessionID = conn.prepareStatement(getSessionID)) {
            psGetSessionID.setString(1, jewelryID);
            try ( ResultSet rs = psGetSessionID.executeQuery()) {
                if (rs.next()) {
                    String sessionID = rs.getString(1);
                    try ( PreparedStatement psMainQuery = conn.prepareStatement(mainQuery)) {
                        psMainQuery.setString(1, preBid_Amount);
                        psMainQuery.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
                        psMainQuery.setString(3, memberID);
                        psMainQuery.setString(4, sessionID);
                        int result = psMainQuery.executeUpdate();
                        return result > 0;
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean saveBid(String bid_Amount, String jewelryID, String memberID) {
        String mainQuery = "UPDATE REGISTER_BID SET bidAmount_Current = ?, bidTime_Current = ? WHERE MEMBERID = ? AND SESSIONID = ?";
        String getSessionID = "SELECT s.sessionID FROM Session s JOIN Jewelry j ON s.jewelryID = j.jewelryID WHERE j.jewelryID = ?";
        String trackBid = "INSERT INTO Bid_Track(bidAmount, bidTime, sessionID, memberID) VALUES (?, ?, ?, ?)";

        try ( Connection conn = DBUtils.getConnection();  PreparedStatement psGetSessionID = conn.prepareStatement(getSessionID);  PreparedStatement psTrackBid = conn.prepareStatement(trackBid)) {

            psGetSessionID.setString(1, jewelryID);

            try ( ResultSet rs = psGetSessionID.executeQuery()) {
                if (rs.next()) {
                    String sessionID = rs.getString(1);

                    // Execute the main update query
                    try ( PreparedStatement psMainQuery = conn.prepareStatement(mainQuery)) {
                        psMainQuery.setString(1, bid_Amount);
                        psMainQuery.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
                        psMainQuery.setString(3, memberID);
                        psMainQuery.setString(4, sessionID);
                        int result = psMainQuery.executeUpdate();
                        if (result > 0) {
                            // Execute the trackBid query
                            psTrackBid.setString(1, bid_Amount);
                            psTrackBid.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
                            psTrackBid.setString(3, sessionID);
                            psTrackBid.setString(4, memberID);

                            int trackResult = psTrackBid.executeUpdate();

                            return trackResult > 0;
                        }
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    @Override
    public Double getTheHighestBid(String jewelryID) {
        String getSessionIDQuery = "SELECT sessionID FROM Session WHERE jewelryID = ?";
        String getHighestBidQuery = "SELECT MAX(bidAmount_Current) AS maxBidAmount FROM Register_Bid WHERE sessionID = ?";
        Connection connection = null;
        PreparedStatement getSessionIDStatement = null;
        PreparedStatement getHighestBidStatement = null;
        ResultSet resultSet = null;
        Double maxBidAmount = null;

        try {
            connection = DBUtils.getConnection();
            getSessionIDStatement = connection.prepareStatement(getSessionIDQuery);
            getSessionIDStatement.setString(1, jewelryID);
            ResultSet sessionIDResult = getSessionIDStatement.executeQuery();

            String sessionID = null;
            if (sessionIDResult.next()) {
                sessionID = sessionIDResult.getString("sessionID");
            }

            if (sessionID != null) {
                getHighestBidStatement = connection.prepareStatement(getHighestBidQuery);
                getHighestBidStatement.setString(1, sessionID);
                ResultSet maxBidResult = getHighestBidStatement.executeQuery();
                if (maxBidResult.next()) {
                    maxBidAmount = maxBidResult.getDouble("maxBidAmount");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserDAOImpl.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (getHighestBidStatement != null) {
                    getHighestBidStatement.close();
                }
                if (getSessionIDStatement != null) {
                    getSessionIDStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return maxBidAmount;
    }

    @Override
    public boolean updateJewelry(Jewelry jewelry) {
        String sql = "UPDATE Jewelry SET artist=?, circa=?, material=?, dial=?, braceletMaterial=?, caseDimensions=?, braceletSize=?, "
                + "serialNumber=?, referenceNumber=?, caliber=?, movement=?, [condition]=?, metal=?, gemstones=?, measurements=?, "
                + "weight=?, stamped=?, ringSize=?, jewelryName = ? WHERE jewelryID=?";

        try ( Connection con = DBUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, jewelry.getArtist());
            ps.setString(2, jewelry.getCirca());
            ps.setString(3, jewelry.getMaterial());
            ps.setString(4, jewelry.getDial());
            ps.setString(5, jewelry.getBraceletMaterial());
            ps.setString(6, jewelry.getCaseDimensions());
            ps.setString(7, jewelry.getBraceletSize());
            ps.setString(8, jewelry.getSerialNumber());
            ps.setString(9, jewelry.getReferenceNumber());
            ps.setString(10, jewelry.getCaliber());
            ps.setString(11, jewelry.getMovement());
            ps.setString(12, jewelry.getCondition());
            ps.setString(13, jewelry.getMetal());
            ps.setString(14, jewelry.getGemstones());
            ps.setString(15, jewelry.getMeasurements());
            ps.setString(16, jewelry.getWeight());
            ps.setString(17, jewelry.getStamped());
            ps.setString(18, jewelry.getRingSize());
            ps.setString(19, jewelry.getJewelryName());
            ps.setString(20, jewelry.getJewelryID());
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserDAOImpl.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    @Override
    public boolean registerUser(String firstName, String lastName, String email, String username, String password, String phoneNumber, String gender, Date dob) {
        String insertUserSql = "INSERT INTO Users (username, email, password, roleID, joined_at) VALUES (?, ?, ?, 'Role01', GETDATE())";
        //String getLastInsertIdSql = "SELECT CAST(SCOPE_IDENTITY() AS VARCHAR(50)) AS lastUserId";
        String selectUserId = "SELECT userID FROM Users WHERE username = ?";
        String insertMemberSql = "INSERT INTO Member (userID, firstName, lastName, phoneNumber, gender, dob) VALUES (?, ?, ?, ?, ?, ?)";
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ps1 = conn.prepareStatement(insertUserSql);  PreparedStatement ps2 = conn.prepareStatement(selectUserId);  PreparedStatement ps3 = conn.prepareStatement(insertMemberSql)) {
            ps1.setString(1, username);
            ps1.setString(2, email);
            ps1.setString(3, password);
            int rowsAffected1 = ps1.executeUpdate();
            if (rowsAffected1 > 0) {
                ps2.setString(1, username);
                try ( ResultSet rs = ps2.executeQuery()) {
                    if (rs.next()) {
                        String userID = rs.getString("userID");
                        ps3.setString(1, userID);
                        ps3.setString(2, firstName);
                        ps3.setString(3, lastName);
                        ps3.setString(4, phoneNumber);
                        ps3.setString(5, gender);
                        ps3.setDate(6, dob);
                        int rowsAffected2 = ps3.executeUpdate();
                        if (rowsAffected2 > 0) {
                            return true;
                        }
                    }
                }
            }

        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean checkDuplicateUsername(String username) {
        String checkQuery = "SELECT * FROM Users WHERE username = ?";
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(checkQuery)) {
            ps.setString(1, username);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return true;
                }
            }
        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }


    @Override
    public boolean closeSession(String jewelryID) {
        String query = "UPDATE  SESSION SET STATUS = 1 WHERE JEWELRYID = ?";
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, jewelryID);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (ClassNotFoundException | SQLException ex) {
            ex.getMessage();
        }
        return false;
    }

    @Override
    public List<Jewelry> displayJewelryInRoom(String auctionID) {
        String query = "WITH MaxPreBid AS (\n"
                + "    SELECT \n"
                + "        S.jewelryID,\n"
                + "        MAX(RB.preBid_Amount) AS max_preBid_Amount\n"
                + "    FROM \n"
                + "        Register_Bid RB\n"
                + "    JOIN \n"
                + "        Session S ON RB.sessionID = S.sessionID\n"
                + "    GROUP BY \n"
                + "        S.jewelryID\n"
                + ")\n"
                + "SELECT \n"
                + "    J.*, \n"
                + "    C.CATEGORYNAME, \n"
                + "    MP.max_preBid_Amount\n"
                + "FROM \n"
                + "    JEWELRY J\n"
                + "JOIN \n"
                + "    CATEGORY C ON J.CATEGORYID = C.CATEGORYID\n"
                + "JOIN \n"
                + "    Session S ON J.jewelryID = S.jewelryID\n"
                + "JOIN \n"
                + "    Auction AUC ON S.AUCTIONID = AUC.AUCTIONID\n"
                + "LEFT JOIN \n"
                + "    MaxPreBid MP ON J.jewelryID = MP.jewelryID\n"
                + "WHERE \n"
                + "    AUC.AUCTIONID = ? AND S.Status = 0";

        List<Jewelry> listJewelry = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, auctionID);
            rs = ps.executeQuery();
            while (rs.next()) {
                Jewelry jewelry = new Jewelry();
                jewelry.setJewelryID(rs.getString("jewelryID"));
                jewelry.setPhotos(rs.getString("photos"));
                jewelry.setJewelryName(rs.getString("jewelryName"));
                jewelry.setCurrentBid(rs.getDouble("max_preBid_Amount"));
                jewelry.setCategoryName(rs.getString("CATEGORYNAME"));
                jewelry.setArtist(rs.getString("artist"));
                jewelry.setCirca(rs.getString("circa"));
                jewelry.setMaterial(rs.getString("material"));
                jewelry.setDial(rs.getString("dial"));
                jewelry.setBraceletMaterial(rs.getString("braceletMaterial"));
                jewelry.setCaseDimensions(rs.getString("caseDimensions"));
                jewelry.setBraceletSize(rs.getString("braceletSize"));
                jewelry.setSerialNumber(rs.getString("serialNumber"));
                jewelry.setReferenceNumber(rs.getString("referenceNumber"));
                jewelry.setCaliber(rs.getString("caliber"));
                jewelry.setMovement(rs.getString("movement"));
                jewelry.setCondition(rs.getString("condition"));
                jewelry.setMetal(rs.getString("metal"));
                jewelry.setGemstones(rs.getString("gemstones"));
                jewelry.setMeasurements(rs.getString("measurements"));
                jewelry.setWeight(rs.getString("weight"));
                jewelry.setStamped(rs.getString("stamped"));
                jewelry.setRingSize(rs.getString("ringSize"));
                jewelry.setMinPrice(rs.getString("minPrice"));
                jewelry.setMaxPrice(rs.getString("maxPrice"));
                jewelry.setValuationId(rs.getString("valuationID"));
                jewelry.setStatus(rs.getString("status"));
                jewelry.setFinalPrice(rs.getDouble("final_Price"));
                listJewelry.add(jewelry);
            }
            return listJewelry;
        } catch (Exception ex) {
            ex.getMessage();
        }
        return null;
    }

    @Override
    public boolean checkAvailableSession(String jewelryID) {
        String query = "SELECT status FROM Session WHERE jewelryID = ?";
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, jewelryID);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("status") == 1;
                }
            }
        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    @Override
    public List<Jewelry> AuctionJewelryRegister(String memberID) {
        List<Jewelry> listJewelry = new ArrayList<>();
        String query = "select j.jewelryID, j.jewelryName, j.photos, r.bidAmount_Current, r.status from Register_Bid r, Session s, Jewelry j where r.sessionID = s.sessionID and j.jewelryID = s.jewelryID and r.memberID = ?";
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, memberID);
            rs = ps.executeQuery();
            while (rs.next()) {
                Jewelry jewelry = new Jewelry();
                jewelry.setJewelryID(rs.getString(1));
                jewelry.setJewelryName(rs.getString(2));
                jewelry.setPhotos(rs.getString(3));
                jewelry.setCurrentBid(rs.getDouble(4));
                jewelry.setStatusBid(rs.getString(5));
                listJewelry.add(jewelry);
            }
            return listJewelry;
        } catch (Exception ex) {
            ex.getMessage();
        }
        return null;
    }

    @Override
    public boolean findAndSetWinner(String jewelryID) {
        String selectQuery = "SELECT TOP 1 "
                + "    rb.memberID, "
                + "    MAX(rb.bidAmount_Current) AS maxBidAmount "
                + "FROM "
                + "    Register_Bid rb "
                + "    JOIN [Session] s ON rb.sessionID = s.sessionID "
                + "WHERE "
                + "    s.jewelryID = ? AND "
                + "    rb.status = 'Placed' "
                + "GROUP BY "
                + "    rb.memberID "
                + "ORDER BY "
                + "    maxBidAmount DESC";

        String updateQuery = "UPDATE Register_Bid SET status = 'Pending Payment' "
                + "WHERE memberID = ? AND sessionID IN "
                + "    (SELECT sessionID FROM [Session] WHERE jewelryID = ?)";

        try ( Connection conn = DBUtils.getConnection();  PreparedStatement psSelect = conn.prepareStatement(selectQuery);  PreparedStatement psUpdate = conn.prepareStatement(updateQuery)) {

            // Set jewelryID parameter for select query
            psSelect.setString(1, jewelryID);

            // Execute select query to find memberID with max bid for given jewelryID
            try ( ResultSet rs = psSelect.executeQuery()) {
                if (rs.next()) {
                    String memberID = rs.getString("memberID");

                    // Update winnerID and status in Register_Bid table
                    psUpdate.setString(1, memberID);
                    psUpdate.setString(2, jewelryID);

                    int updatedRows = psUpdate.executeUpdate();

                    if (updatedRows > 0) {
                        System.out.println("Winner updated for jewelryID " + jewelryID);
                        return true;
                    } else {
                        System.out.println("No records updated.");
                    }
                } else {
                    System.out.println("No winner found for jewelryID " + jewelryID);
                }
            }

        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean updateAllPlacedToLost(String jewelryID) {
        String updateQuery = "UPDATE Register_Bid "
                + "SET status = 'Lost' "
                + "WHERE sessionID IN (SELECT sessionID FROM [Session] WHERE jewelryID = ?) "
                + "AND status = 'Placed'";

        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(updateQuery)) {

            ps.setString(1, jewelryID);

            int updatedRows = ps.executeUpdate();

            if (updatedRows > 0) {
                return true; // Update successful
            }

        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
        }

        return false; // Update failed or no records updated
    }

    @Override
    public boolean updateRegisterBidStatus(String memberID, String jewelryID) {
        String updateQuery = "UPDATE Register_Bid \n"
                + "SET status = 'Paid'\n"
                + "WHERE memberID = ? \n"
                + "  AND status = 'Pending Payment'\n"
                + "  AND sessionID IN (\n"
                + "    SELECT s.sessionID\n"
                + "    FROM Session s\n"
                + "    WHERE s.jewelryID = ?\n"
                + "  );";

        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(updateQuery)) {

            ps.setString(1, memberID);
            ps.setString(2, jewelryID);

            int rowAffected = ps.executeUpdate();
            return rowAffected > 0;

        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();  // Consider using a logging framework like SLF4J for better logging
        }
        return false;
    }

    @Override
    public void insertInvoice(Invoice invoice) {
        String INSERT_INVOICE_SQL = "INSERT INTO Invoice (invoiceID, memberID, jewelryID, invoiceDate, totalAmount) VALUES (?, ?, ?, ?, ?)";
        try ( Connection connection = DBUtils.getConnection();  PreparedStatement preparedStatement = connection.prepareStatement(INSERT_INVOICE_SQL)) {
            preparedStatement.setString(1, invoice.getInvoiceID());
            preparedStatement.setString(2, invoice.getMemberID());
            preparedStatement.setString(3, invoice.getJewelryID());
            preparedStatement.setString(4, invoice.getInvoiceDate());
            preparedStatement.setBigDecimal(5, invoice.getTotalAmount());
            preparedStatement.executeUpdate();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserDAOImpl.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(UserDAOImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public List<Invoice> showAllInvoices() {
        String SELECT_ALL_INVOICES_SQL
                = "SELECT inv.invoiceID, inv.invoiceDate, inv.totalAmount, j.jewelryID, j.jewelryName, j.photos, m.firstName, m.lastName\n"
                + "FROM Invoice inv\n"
                + "JOIN Jewelry j ON inv.jewelryID = j.jewelryID\n"
                + "JOIN Member m ON inv.memberID = m.memberID\n"
                + "WHERE j.status = 'Confirmed';";
        List<Invoice> invoices = new ArrayList<>();
        try ( Connection connection = DBUtils.getConnection();  PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_INVOICES_SQL);  ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                String invoiceID = resultSet.getString("invoiceID");
                String invoiceDate = resultSet.getString("invoiceDate");
                BigDecimal totalAmount = resultSet.getBigDecimal("totalAmount");
                String jewelryID = resultSet.getString("jewelryID");
                String jewelryName = resultSet.getString("jewelryName");
                String photos = resultSet.getString("photos");
                String firstName = resultSet.getString("firstName");
                String lastName = resultSet.getString("lastName");

                Invoice invoice = new Invoice();
                invoice.setInvoiceID(invoiceID);
                invoice.setInvoiceDate(invoiceDate);
                invoice.setTotalAmount(totalAmount);
                invoice.setJewelryID(jewelryID);
                invoice.setJewelryName(jewelryName);
                invoice.setPhotos(photos);
                invoice.setFirstName(firstName);
                invoice.setLastName(lastName);

                invoices.add(invoice);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserDAOImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return invoices;
    }

    @Override
    public boolean confirmPayment(String jewelryID) {
        String sql = "UPDATE rb\n"
                + "SET rb.status = 'Delivery'\n"
                + "FROM Register_Bid rb\n"
                + "INNER JOIN [Session] s ON rb.sessionID = s.sessionID\n"
                + "WHERE s.jewelryID = ? and rb.status = 'Paid'";

        String updateJewelryStatus = "UPDATE Jewelry SET status = 'SOLD' WHERE jewelryID = ?";

        try ( Connection connection = DBUtils.getConnection();  PreparedStatement preparedStatement = connection.prepareStatement(sql);  PreparedStatement ps = connection.prepareStatement(updateJewelryStatus)) {

            // Set parameter for jewelryID in the first query
            preparedStatement.setString(1, jewelryID);
            // Execute the first update
            int rowsUpdated = preparedStatement.executeUpdate();

            // Set parameter for jewelryID in the second query
            ps.setString(1, jewelryID);
            // Execute the second update
            int rowsUpdatedJewelry = ps.executeUpdate();

            // Return true if at least one row was updated in both queries
            return rowsUpdated > 0 && rowsUpdatedJewelry > 0;

        } catch (SQLException e) {
            return false;
        } catch (ClassNotFoundException e) {
            return false;
        }
    }

    @Override
    public List<Invoice> showAllPastInvoices() {
        String SELECT_ALL_INVOICES_SQL
                = "SELECT inv.invoiceID, inv.invoiceDate, inv.totalAmount, j.jewelryID, j.jewelryName, j.photos, m.firstName, m.lastName\n"
                + "FROM Invoice inv\n"
                + "JOIN Jewelry j ON inv.jewelryID = j.jewelryID\n"
                + "JOIN Member m ON inv.memberID = m.memberID\n";
        List<Invoice> invoices = new ArrayList<>();
        try ( Connection connection = DBUtils.getConnection();  PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_INVOICES_SQL);  ResultSet resultSet = preparedStatement.executeQuery()) {
            while (resultSet.next()) {
                String invoiceID = resultSet.getString("invoiceID");
                String invoiceDate = resultSet.getString("invoiceDate");
                BigDecimal totalAmount = resultSet.getBigDecimal("totalAmount");
                String jewelryID = resultSet.getString("jewelryID");
                String jewelryName = resultSet.getString("jewelryName");
                String photos = resultSet.getString("photos");
                String firstName = resultSet.getString("firstName");
                String lastName = resultSet.getString("lastName");

                Invoice invoice = new Invoice();
                invoice.setInvoiceID(invoiceID);
                invoice.setInvoiceDate(invoiceDate);
                invoice.setTotalAmount(totalAmount);
                invoice.setJewelryID(jewelryID);
                invoice.setJewelryName(jewelryName);
                invoice.setPhotos(photos);
                invoice.setFirstName(firstName);
                invoice.setLastName(lastName);

                invoices.add(invoice);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserDAOImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return invoices;
    }

    @Override
    public void updateSoldAmount(String jewelryID) {
        String query = "UPDATE j\n"
                + "SET j.Sold = i.totalAmount\n"
                + "FROM Jewelry j\n"
                + "JOIN Invoice i ON j.jewelryID = i.jewelryID\n"
                + "WHERE j.jewelryID = ?";
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, jewelryID);
            ps.executeUpdate();

        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        }
    }
    
     //--------------------------------
    @Override
    public List<CreditCard> displayAllRegisteringCard() {
        List<CreditCard> listCreditCard = new ArrayList<>();
        String query = "SELECT * FROM Credit_Card WHERE status = 0";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CreditCard cc = new CreditCard();
                    cc.setCardID(rs.getString("cardID"));
                    cc.setMemberID(rs.getString("memberID"));
                    cc.setHolderName(rs.getString("holderName"));
                    cc.setCardNumber(rs.getString("cardNumber"));
                    cc.setCvvCode(rs.getString("cvvCode"));
                    cc.setExpiryDate(rs.getDate("expiryDate"));
                    cc.setStatus(rs.getInt("status"));
                    listCreditCard.add(cc);
                }
            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, null, ex);
        }
        return listCreditCard;
    }

    @Override
    public List<User> displayAllUserForManager() {
        List<User> listUser = new ArrayList<>();
        String query = "SELECT * FROM Users";
        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(query)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    User u = new User();
                    u.setUserID(rs.getString("userID"));
                    u.setUsername(rs.getString("username"));
                    u.setEmail(rs.getString("email"));
                    u.setPassword(rs.getString("password"));
                    u.setRoleID(rs.getString("roleID"));
                    u.setJoined_at(rs.getDate("joined_at"));
                    u.setActive_status(rs.getInt("active_status"));
                    listUser.add(u);
                }
            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, null, ex);
        }
        return listUser;
    }

    @Override
    public boolean addUserForManager(String username, String email, String password, String roleID) {
        String insertUserQuery = "INSERT INTO Users (username, email, password, roleID, joined_at) VALUES (?, ?, ?, ?, GETDATE())";
        String checkUser = "SELECT userID FROM Users WHERE username = ? AND roleID = 'Role01'";
        String insertMemberQuery = "INSERT INTO Member (userID) VALUES (?)";
        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps1 = conn.prepareStatement(insertUserQuery);
                PreparedStatement ps2 = conn.prepareStatement(checkUser);
                PreparedStatement ps3 = conn.prepareStatement(insertMemberQuery)) {
            ps1.setString(1, username);
            ps1.setString(2, email);
            ps1.setString(3, password);
            ps1.setString(4, roleID);
            int rowsAffected1 = ps1.executeUpdate();
            if (rowsAffected1 > 0) {
                ps2.setString(1, username);
                try (ResultSet rs = ps2.executeQuery()) {
                    if (rs.next()) {
                        String userID = rs.getString("userID");
                        ps3.setString(1, userID);
                        int rowsAffected2 = ps3.executeUpdate();
                        if (rowsAffected2 > 0) {
                            return true;
                        }
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(UserDAOImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public boolean updateUserForManager(String userID, String username, String email, String password, String roleID) {
        String updateUserQuery = "UPDATE Users SET username = ?, email = ?, password = ?, roleID = ? WHERE userID = ?";
        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(updateUserQuery)) {
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, roleID);
            ps.setString(5, userID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(UserDAOImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public boolean deleteUserForManager(String userID) {
        String deleteUser = "UPDATE Users SET active_status = 0 WHERE userID = ?";
        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(deleteUser)) {
            ps.setString(1, userID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(UserDAOImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    @Override
    public boolean reactivateUserForManager(String userID) {
        String deleteUser = "UPDATE Users SET active_status = 1 WHERE userID = ?";
        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(deleteUser)) {
            ps.setString(1, userID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(UserDAOImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public boolean checkBidderMatchSeller(String jewelryID, String memberID) {
        String query = "SELECT j.jewelryID FROM Jewelry j JOIN RequestValuation rv ON j.valuationId = rv.valuationId WHERE rv.memberId = ?";
        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, memberID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    if (jewelryID == rs.getString("jewelryID")) {
                        return true;
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(UserDAOImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public boolean rejectCard(String memberID) {
        String addressQuery = "DELETE FROM [Address] WHERE memberID = ?";
        String cardQuery = "DELETE FROM [Credit_Card] WHERE memberID = ?";
        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps1 = conn.prepareStatement(addressQuery);
                PreparedStatement ps2 = conn.prepareStatement(cardQuery)) {
            ps1.setString(1, memberID);
            ps2.setString(1, memberID);

            int result1 = ps1.executeUpdate();
            int result2 = ps2.executeUpdate();
            return (result1 > 0 && result2 > 0);

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserDAOImpl.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(UserDAOImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public CreditCard getCardInformation(String userID) {
        String query = "SELECT cc.* FROM Credit_Card cc JOIN Member m ON cc.memberID = m.memberID JOIN Users u ON m.userID = u.userID WHERE u.userID = ?";
        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, userID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new CreditCard(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getDate(6), rs.getInt(7));
            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(UserDAOImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public Address getAddressInformation(String userID) {
        String query = "SELECT a.* FROM Address a JOIN Member m ON a.memberID = m.memberID JOIN Users u ON m.userID = u.userID WHERE u.userID = ?";
        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, userID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Address(rs.getString("addressID"), rs.getString("country"), rs.getString("city"), rs.getString("state"), rs.getString("zipcode"), rs.getString("address1"), rs.getString(2), rs.getString("memberID"));
            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(UserDAOImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public boolean updateProfile(String memberID, String firstName, String lastName, String phoneNumber, String gender, String dob, String city, String state, String zipCode, String country, String address1, String address2) {
        String memberQuery = "UPDATE Member SET firstName = ?, lastName = ?, phoneNumber = ?, gender = ?, dob = ? WHERE memberID = ?";
        String addressQuery = "UPDATE Address SET city = ?, state = ?, zipcode = ?, country = ?, Address1 = ?, Address2 = ? WHERE memberID = ?";
        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps1 = conn.prepareStatement(memberQuery);
                PreparedStatement ps2 = conn.prepareStatement(addressQuery)) {
            ps1.setString(1, firstName);
            ps1.setString(2, lastName);
            ps1.setString(3, phoneNumber);
            ps1.setString(4, gender);
            ps1.setString(5, dob);
            ps1.setString(6, memberID);

            ps2.setString(1, city);
            ps2.setString(2, state);
            ps2.setString(3, zipCode);
            ps2.setString(4, country);
            ps2.setString(5, address1);
            ps2.setString(6, address2);
            ps2.setString(7, memberID);

            int result1 = ps1.executeUpdate();
            int result2 = ps2.executeUpdate();
            return (result1 > 0 && result2 > 0);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(UserDAOImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public boolean deleteProfile(String memberID) {
        String query = "UPDATE u SET u.active_status = 0 FROM Member m JOIN Users u ON m.userID = u.userID WHERE m.memberID = ?";
        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, memberID);
            int result = ps.executeUpdate();
            return result > 0;
       
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(UserDAOImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    //-------------------------------------
}
