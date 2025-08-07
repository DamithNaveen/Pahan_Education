package com.res.dao;

import com.res.model.CartItem;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.DatabaseUtil;

public class CartDAO {
    private Connection connection;

    public CartDAO() throws SQLException {
        this.connection = DatabaseUtil.getConnection();
    }

    public boolean addItem(CartItem item) throws SQLException {
        String sql = "INSERT INTO cart (user_id, book_id, name, price, quantity, image) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, item.getUserId());
            ps.setInt(2, item.getBookId());
            ps.setString(3, item.getBookName());
            ps.setDouble(4, item.getPrice());
            ps.setInt(5, item.getQuantity());
            ps.setString(6, item.getImage());
            return ps.executeUpdate() > 0;
        }
    }

    public List<CartItem> getCartItems(String userId) throws SQLException {
        List<CartItem> items = new ArrayList<>();
        String sql = "SELECT * FROM cart WHERE user_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            
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
        return items;
    }

    public boolean removeItem(String userId, int bookId) throws SQLException {
        String sql = "DELETE FROM cart WHERE user_id = ? AND book_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setInt(2, bookId);
            return ps.executeUpdate() > 0;
        }
    }

    public void close() throws SQLException {
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }
    }
}