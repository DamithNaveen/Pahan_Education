package com.res.dao;

import com.res.model.CartItem;
import util.DatabaseUtil;
import java.sql.*;
import java.util.List;

public class OrderDAO implements AutoCloseable {
    private Connection connection;

    public OrderDAO() throws SQLException {
        this.connection = DatabaseUtil.getConnection();
    }

    public boolean createOrder(String userId, String name, String number, String email,
                             String method, String address, double totalPrice) throws SQLException {
        String sql = "INSERT INTO orders (user_id, name, number, email, method, address, total_price, order_date, payment_status) " +
                   "VALUES (?, ?, ?, ?, ?, ?, ?, NOW(), 'Pending')";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, userId);
            stmt.setString(2, name);
            stmt.setString(3, number);
            stmt.setString(4, email);
            stmt.setString(5, method);
            stmt.setString(6, address);
            stmt.setDouble(7, totalPrice);
            
            return stmt.executeUpdate() > 0;
        }
    }

    @Override
    public void close() {
        try {
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            System.err.println("Error closing OrderDAO connection: " + e.getMessage());
        }
    }
}