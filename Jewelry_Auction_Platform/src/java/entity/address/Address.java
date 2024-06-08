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
    private String street;
    private String city;
    private String zipcode;
    private String country;
    private String memberID;

    public Address() {
    }

    public Address(String addressID, String street, String city, String zipcode, String country, String memberID) {
        this.addressID = addressID;
        this.street = street;
        this.city = city;
        this.zipcode = zipcode;
        this.country = country;
        this.memberID = memberID;
    }

    public String getAddressID() {
        return addressID;
    }

    public void setAddressID(String addressID) {
        this.addressID = addressID;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getZipcode() {
        return zipcode;
    }

    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
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
}
