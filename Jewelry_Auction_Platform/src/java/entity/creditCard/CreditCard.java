/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity.creditCard;

import java.sql.Date;

/**
 *
 * @author T14
 */
public class CreditCard {
    
    private String cardID;
    private String memberID;
    private String holderName;
    private String cardNumber;
    private String cvvCode;
    private Date expiryDate;
    private int status;

    public CreditCard() {
    }
    
    public CreditCard(String cardID, String memberID, String holderName, String cardNumber, String cvvCode, Date expiryDate, int status) {
        this.cardID = cardID;
        this.memberID = memberID;
        this.holderName = holderName;
        this.cardNumber = cardNumber;
        this.cvvCode = cvvCode;
        this.expiryDate = expiryDate;
        this.status = status;
    }

    public String getCardID() {
        return cardID;
    }

    public void setCardID(String cardID) {
        this.cardID = cardID;
    }

    public String getMemberID() {
        return memberID;
    }

    public void setMemberID(String memberID) {
        this.memberID = memberID;
    }

    public String getHolderName() {
        return holderName;
    }

    public void setHolderName(String holderName) {
        this.holderName = holderName;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public String getCvvCode() {
        return cvvCode;
    }

    public void setCvvCode(String cvvCode) {
        this.cvvCode = cvvCode;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }
    
    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
