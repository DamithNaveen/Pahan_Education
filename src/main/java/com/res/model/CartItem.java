package com.res.model;

public class CartItem {
    private int id;
    private String userId;
    private int bookId;
    private String bookName;
    private double price;
    private int quantity;
    private String image;
    
    public CartItem() {}
    
    public CartItem(String userId, int bookId, String bookName, double price, int quantity, String image) {
        this.userId = userId;
        this.bookId = bookId;
        this.bookName = bookName;
        this.price = price;
        this.quantity = quantity;
        this.image = image;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }
    public String getBookName() { return bookName; }
    public void setBookName(String bookName) { this.bookName = bookName; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
    
    public double getTotalPrice() {
        return price * quantity;
    }
}