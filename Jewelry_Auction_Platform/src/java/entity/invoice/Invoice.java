/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity.invoice;

import java.time.LocalDateTime;

/**
 *
 * @author T14
 */
public class Invoice {
    private String invoiceID;
    private LocalDateTime invoiceDate;
    private double totalAmount;

    public Invoice() {
    }

    public Invoice(String invoiceID, LocalDateTime invoiceDate, double totalAmount) {
        this.invoiceID = invoiceID;
        this.invoiceDate = invoiceDate;
        this.totalAmount = totalAmount;
    }

    public String getInvoiceID() {
        return invoiceID;
    }

    public void setInvoiceID(String invoiceID) {
        this.invoiceID = invoiceID;
    }

    public LocalDateTime getInvoiceDate() {
        return invoiceDate;
    }

    public void setInvoiceDate(LocalDateTime invoiceDate) {
        this.invoiceDate = invoiceDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }
}
