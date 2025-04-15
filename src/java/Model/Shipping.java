/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

/**
 *
 * @author LENOVO
 */
public class Shipping {

    private int id;
    private int orderId;
    private String shippingAddress;
    private String shippingStatus;
    private String trackingNumber;
    private Date shippingDate;
    private Date estimatedDelivery;
    private String deliveryNotes;
    private Date updatedAt;

    public Shipping() {
    }

    public Shipping(int id, int orderId, String shippingAddress, String shippingStatus, String trackingNumber, Date shippingDate, Date estimatedDelivery, String deliveryNotes, Date updatedAt) {
        this.id = id;
        this.orderId = orderId;
        this.shippingAddress = shippingAddress;
        this.shippingStatus = shippingStatus;
        this.trackingNumber = trackingNumber;
        this.shippingDate = shippingDate;
        this.estimatedDelivery = estimatedDelivery;
        this.deliveryNotes = deliveryNotes;
        this.updatedAt = updatedAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public String getShippingStatus() {
        return shippingStatus;
    }

    public void setShippingStatus(String shippingStatus) {
        this.shippingStatus = shippingStatus;
    }

    public String getTrackingNumber() {
        return trackingNumber;
    }

    public void setTrackingNumber(String trackingNumber) {
        this.trackingNumber = trackingNumber;
    }

    public Date getShippingDate() {
        return shippingDate;
    }

    public void setShippingDate(Date shippingDate) {
        this.shippingDate = shippingDate;
    }

    public Date getEstimatedDelivery() {
        return estimatedDelivery;
    }

    public void setEstimatedDelivery(Date estimatedDelivery) {
        this.estimatedDelivery = estimatedDelivery;
    }

    public String getDeliveryNotes() {
        return deliveryNotes;
    }

    public void setDeliveryNotes(String deliveryNotes) {
        this.deliveryNotes = deliveryNotes;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

}
