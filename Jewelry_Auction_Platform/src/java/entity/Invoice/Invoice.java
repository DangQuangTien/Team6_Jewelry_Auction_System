/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity.Invoice;

import java.math.BigDecimal;

/**
 *
 * @author User
 */
public class Invoice {

    private String invoiceID;
    private String memberID;
    private String jewelryID;
    private String invoiceDate;
    private BigDecimal totalAmount;
    private String firstName;
    private String lastName;
    private String jewelryName;
    private String photos;

    public Invoice() {
    }

    public Invoice(String invoiceID, String memberID, String jewelryID, String invoiceDate, BigDecimal totalAmount, String firstName, String lastName, String jewelryName, String photos) {
        this.invoiceID = invoiceID;
        this.memberID = memberID;
        this.jewelryID = jewelryID;
        this.invoiceDate = invoiceDate;
        this.totalAmount = totalAmount;
        this.firstName = firstName;
        this.lastName = lastName;
        this.jewelryName = jewelryName;
        this.photos = photos;
    }
    
    
    // Constructor
    public Invoice(String invoiceID, String memberID, String jewelryID, String invoiceDate, BigDecimal totalAmount) {
        this.invoiceID = invoiceID;
        this.memberID = memberID;
        this.jewelryID = jewelryID;
        this.invoiceDate = invoiceDate;
        this.totalAmount = totalAmount;
        
    }

    // Getters and Setters
    public String getInvoiceID() {
        return invoiceID;
    }

    public void setInvoiceID(String invoiceID) {
        this.invoiceID = invoiceID;
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

    public String getInvoiceDate() {
        return invoiceDate;
    }

    public void setInvoiceDate(String invoiceDate) {
        this.invoiceDate = invoiceDate;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getJewelryName() {
        return jewelryName;
    }

    public void setJewelryName(String jewelryName) {
        this.jewelryName = jewelryName;
    }

    public String getPhotos() {
        return photos;
    }

    public void setPhotos(String photos) {
        this.photos = photos;
    }
    
    
}
