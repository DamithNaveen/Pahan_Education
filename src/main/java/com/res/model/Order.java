package com.res.model;

import java.util.List;

public class Order {
    private int id;
    private String userId;
    private String name;
    private String number;
    private String email;
    private String method;
    private String address;
    private double totalPrice;
    private String orderDate;
    private String paymentStatus;
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getNumber() { return number; }
    public void setNumber(String number) { this.number = number; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getMethod() { return method; }
    public void setMethod(String method) { this.method = method; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }
    public String getOrderDate() { return orderDate; }
    public void setOrderDate(String orderDate) { this.orderDate = orderDate; }
    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }
}