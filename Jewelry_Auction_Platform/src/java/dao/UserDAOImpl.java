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
import entity.request_shipment.RequestShipment;
import entity.valuation.Valuation;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
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
    public UserDTO checkLogin(String username, String password) {
        String query = "select tk.userID, tk.username, vt.role_name from Users tk, [Role] vt where vt.roleID = tk.roleID and tk.username = ? and tk.password = ?";
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new UserDTO(rs.getString(1), rs.getString(2), rs.getString(3));
            }
        } catch (ClassNotFoundException | SQLException ex) {
            ex.getMessage();
        }
        return null;
    }

    @Override
    public Member getInformation(String userID) {
        String query = "select m.* from Member m, Users u where m.userID = u.userID and u.userID = ?";
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, userID);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Member(rs.getString(1), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getDate(7), rs.getString(8), rs.getInt(9));
            }
        } catch (ClassNotFoundException | SQLException ex) {
            ex.getMessage();
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
            ex.getMessage();
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

        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
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
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, userID);
            try (ResultSet rs = ps.executeQuery()) {
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
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            try (ResultSet rs = ps.executeQuery()) {
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
        String query = "SELECT * FROM JEWELRY WHERE STATUS = 'Received'";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            try (ResultSet rs = ps.executeQuery()) {
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
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            try (ResultSet rs = ps.executeQuery()) {
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
        String query = "Update Jewelry Set [status] = 'Re-Evaluated' Where jewelryID = ?";
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
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, (currentPage - 1) * pageSize); // Calculate the offset
            ps.setInt(2, pageSize); // Set the number of rows to fetch

            try (ResultSet rs = ps.executeQuery()) {
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
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        }
        return count;
    }

    @Override
    public boolean createAuction(String auctionDate, String startTime, String endTime, String[] selectedJewelryIDs) {
        String insertAuctionQuery = "INSERT INTO Auction (startDate, startTime) VALUES (?, ?)";
        String selectAuctionQuery = "SELECT TOP 1 auctionID FROM Auction WHERE status = 0 ORDER BY auctionID DESC";
        String insertSessionQuery = "INSERT INTO [Session] (auctionID, jewelryID) VALUES (?, ?)";
        String updateAuctionStatusQuery = "UPDATE Auction SET status = 1 WHERE auctionID = ?";

        try (Connection conn = DBUtils.getConnection(); PreparedStatement psInsertAuction = conn.prepareStatement(insertAuctionQuery); PreparedStatement psSelectAuction = conn.prepareStatement(selectAuctionQuery); PreparedStatement psInsertSession = conn.prepareStatement(insertSessionQuery); PreparedStatement psUpdateAuctionStatus = conn.prepareStatement(updateAuctionStatusQuery)) {

            // Insert auction
            psInsertAuction.setString(1, auctionDate);
            psInsertAuction.setString(2, startTime);
            int result = psInsertAuction.executeUpdate();

            if (result > 0) {
                // Get the latest auction ID
                try (ResultSet rs = psSelectAuction.executeQuery()) {
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
                auction.setStartDate(rs.getDate(2));
                auction.setStartTime(LocalTime.parse(rs.getString(3)));
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
                auction.setStartDate(rs.getDate(2));
                auction.setStartTime(LocalTime.parse(rs.getString(3)));
            }
            return auction;
        } catch (ClassNotFoundException | SQLException ex) {
            ex.getMessage();
        }
        return null;
    }

    @Override
    public List<Jewelry> displayCatalog(String auctionID) {
        String query = "SELECT J.*, C.CATEGORYNAME \n"
                + "FROM JEWELRY J \n"
                + "JOIN CATEGORY C ON J.CATEGORYID = C.CATEGORYID\n"
                + "JOIN Session S ON J.JEWELRYID = S.JEWELRYID\n"
                + "JOIN Auction AUC ON S.AUCTIONID = AUC.AUCTIONID\n"
                + "WHERE AUC.AUCTIONID = ?";
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

            while (rs.next()) {
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
    
    //----------------------------------------------------------------------------------

    @Override
    public boolean createBidRegistry(String userID, String country, String address, String city, String state, String zipCode) {
        String memberID;
        String selectQuery = "SELECT m.memberID FROM [Member] m, Users u WHERE m.userID = u.userID AND u.userID = ?";
//        //sessionID where?
        String createQuery1 = "INSERT INTO Register_Bid (sessionID, memberID, status) VALUES (1, ?, 0)";
        String createQuery2 = "INSERT INTO Address (street, city, state, zipcode, country, memberID) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement pst = conn.prepareStatement(selectQuery)) {
            pst.setString(1, userID);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    memberID = rs.getString("memberID");
                    try (PreparedStatement ps1 = conn.prepareStatement(createQuery1)) {
                        ps1.setString(2, memberID);
                        try (PreparedStatement ps2 = conn.prepareStatement(createQuery2)) {
                            ps2.setString(1, country);
                            ps2.setString(2, address);
                            ps2.setString(3, city);
                            ps2.setString(4, state);
                            ps2.setString(5, zipCode);
                            ps2.setString(6, memberID);
                            int rowsAffected1 = ps1.executeUpdate();
                            int rowsAffected2 = ps2.executeUpdate();
                            if (rowsAffected1 > 0 && rowsAffected2 > 0) {
                                return true;
                            }
                        }
                    }
                }

            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    @Override
    // hien? thi. cac' auction session ma` member co' tham gia
    public List<Session> getSessionByMemberID(String userID) {
        List<Session> listSession = new ArrayList<>();
        String query = "SELECT s.* FROM Session s"
                + "JOIN Register_Bid rb ON s.sessionID = rb.sessionID "
                + "JOIN Member m ON rb.memberID = m.memberID "
                + "JOIN Users u ON m.userID = u.userID "
                + "WHERE u.userID = ?";

        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, userID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Session session = new Session();
                    session.setAuctionID(rs.getString("auctionID"));
                    session.setJewelryID(rs.getString("jewelryID"));
                    session.setStartBid(rs.getString("startBid"));
                    session.setStatus(rs.getInt("status"));
                    listSession.add(session);
                }
            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        }
        return listSession;

    }

    public boolean setNewBidPrice(String userID, Double bidAmount_Current) {
        String selectMemberQuery = "SELECT m.memberID FROM [Member] m, Users u WHERE m.userID = u.userID AND u.userID = ?";
        String selectBidQuery = "SELECT bidAmount_Current, bidTime_Current FROM Register_Bid WHERE memberID = ?";

        Double oldBidAmount;
        Timestamp oldBidTime;

        String registerBidQuery = "UPDATE Register_Bid "
                + "bidAmount_Current = ?, "
                + "bidTime_Current = ?"
                + "WHERE memberID = ?";
        String bidTrackQuery = "UPDATE Bid_Track SET bidAmount = ?, bidTime = ? WHERE memberID = ?";
        String memberID;
        LocalDateTime bidTime_CurrentTemp = LocalDateTime.now();
        Timestamp bidTime_Current = Timestamp.valueOf(bidTime_CurrentTemp);
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps1 = conn.prepareStatement(selectMemberQuery)) {
            ps1.setString(1, userID);
            try (ResultSet rs1 = ps1.executeQuery()) {
                if (rs1.next()) {
                    memberID = rs.getString("memberID");
                    try (PreparedStatement ps2 = conn.prepareStatement(selectBidQuery)) {
                        ps2.setString(1, memberID);
                        try (ResultSet rs2 = ps2.executeQuery()) {
                            if (rs2.next()) {
                                oldBidAmount = rs2.getDouble("bidAmount_Current");
                                oldBidTime = rs2.getTimestamp("bidTime_Current");
                                try (PreparedStatement ps3 = conn.prepareStatement(bidTrackQuery)) {
                                    ps3.setDouble(1, oldBidAmount);
                                    ps3.setTimestamp(2, oldBidTime);
                                    try(PreparedStatement ps4 = conn.prepareStatement(registerBidQuery)){
                                        ps4.setDouble(1, bidAmount_Current);
                                        ps4.setTimestamp(0, bidTime_Current);
                                        int rowsAffected1 = ps3.executeUpdate();
                                        int rowsAffected2 = ps4.executeUpdate();
                                        if(rowsAffected1 > 0 && rowsAffected2 > 0)
                                            return true;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException ex) {
            ex.getMessage();
        }
        return false;
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

            while (rs.next()) {
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
    public boolean insertAddress(String country, String state, String city, String address1, String address2, String zipCode, String memberID) {
        String query = "INSERT INTO [Address] (country, state, city, address1, address2, zipcode, memberID) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, country);
            ps.setString(2, state);
            ps.setString(3, city);
            ps.setString(4, address1);
            ps.setString(5, address2);
            ps.setString(6, zipCode);
            ps.setString(7, memberID);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (ClassNotFoundException | SQLException ex) {
            // Log the exception
            ex.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean registerToBid(String memberID) {
        String query = "UPDATE Member SET status_register_to_bid = 1 WHERE memberID = ?";
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, memberID);

            int result = ps.executeUpdate();
            return result > 0;
        } catch (ClassNotFoundException | SQLException ex) {
            // Log the exception
            ex.printStackTrace();
        }
        return false;
    }

}
