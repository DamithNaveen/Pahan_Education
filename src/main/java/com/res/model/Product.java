package com.res.model;

public class Product {
    private int id;
    private String productName;
    private double price;
    private String availability;
    private int quantity;
    private String imagePath;

    public Product() {}

    public Product(String productName, double price, 
                   String availability, int quantity, String imagePath) {
        this.productName = productName;
        this.price = price;
        this.availability = availability;
        this.quantity = quantity;
        this.imagePath = imagePath;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getAvailability() { return availability; }
    public void setAvailability(String availability) { this.availability = availability; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }
}