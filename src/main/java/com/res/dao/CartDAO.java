package com.res.dao;

import com.res.model.CartItem;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.DatabaseUtil;

public class CartDAO {
    private static final Logger logger = Logger.getLogger(CartDAO.class.getName());
    private Connection connection;

    public CartDAO() {
        try {
            this.connection = DatabaseUtil.getConnection();
            logger.log(Level.INFO, "Successfully connected to database");
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Failed to connect to database", e);
            throw new RuntimeException("Failed to initialize CartDAO", e);
        }
    }

    public boolean addItem(CartItem item) {
        String sql = "INSERT INTO cart(user_id, book_id, name, price, quantity, image) VALUES(?,?,?,?,?,?)";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, item.getUserId());
            ps.setInt(2, item.getBookId());
            ps.setString(3, item.getBookName());
            ps.setDouble(4, item.getPrice());
            ps.setInt(5, item.getQuantity());
            ps.setString(6, item.getImage());
            
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error adding item to cart", e);
            throw new RuntimeException("Failed to add item to cart", e);
        }
    }

    public List<CartItem> getCartItems(String userId) {
        List<CartItem> items = new ArrayList<>();
        String sql = "SELECT * FROM cart WHERE user_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, userId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem();
                    item.setId(rs.getInt("id"));
                    item.setUserId(rs.getString("user_id"));
                    item.setBookId(rs.getInt("book_id"));
                    item.setBookName(rs.getString("name"));
                    item.setPrice(rs.getDouble("price"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setImage(rs.getString("image"));
                    items.add(item);
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving cart items", e);
            throw new RuntimeException("Failed to get cart items", e);
        }
        return items;
    }

    public void close() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                logger.log(Level.INFO, "Database connection closed");
            }
        } catch (SQLException e) {
            logger.log(Level.WARNING, "Error closing connection", e);
        }
    }
}