/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity.address;

/**
 *
 * @author T14
 */
public class Address {
    private String addressID;
    private String city;
    private String state;
    private String zipCode;
    private String country;
    private String memberID;
    private String address1;
    private String address2;

    public Address() {
    }

    public Address(String addressID, String city, String state, String zipCode, String country, String address1, String address2,  String memberID) {
        this.addressID = addressID;
        this.city = city;
        this.state = state;
        this.zipCode = zipCode;
        this.country = country;
        this.address1 = address1;
        this.address2 = address2;
        this.memberID = memberID;
    }

    public String getAddressID() {
        return addressID;
    }

    public void setAddressID(String addressID) {
        this.addressID = addressID;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getMemberID() {
        return memberID;
    }

    public void setMemberID(String memberID) {
        this.memberID = memberID;
    }

    public String getAddress1() {
        return address1;
    }

    public void setAddress1(String address1) {
        this.address1 = address1;
    }

    public String getAddress2() {
        return address2;
    }

    public void setAddress2(String address2) {
        this.address2 = address2;
    }
}
