package com.res.dao;

import com.res.model.CartItem;
import util.DatabaseUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO implements AutoCloseable {
    private Connection connection;
    private PreparedStatement preparedStatement;
    private ResultSet resultSet;

    public CartDAO() throws SQLException {
        this.connection = DatabaseUtil.getConnection();
    }

    @Override
    public void close() {
        try {
            if (resultSet != null) resultSet.close();
            if (preparedStatement != null) preparedStatement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            System.err.println("Error closing CartDAO resources: " + e.getMessage());
        }
    }

    public boolean removeItem(String userId, int bookId) throws SQLException {
        String sql = "DELETE FROM cart WHERE user_id = ? AND book_id = ?";
        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, userId);
            preparedStatement.setInt(2, bookId);
            return preparedStatement.executeUpdate() > 0;
        } finally {
            if (preparedStatement != null) preparedStatement.close();
        }
    }

    public boolean addItem(CartItem item) throws SQLException {
        String sql = "INSERT INTO cart (user_id, book_id, name, price, quantity, image) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, item.getUserId());
            preparedStatement.setInt(2, item.getBookId());
            preparedStatement.setString(3, item.getBookName());
            preparedStatement.setDouble(4, item.getPrice());
            preparedStatement.setInt(5, item.getQuantity());
            preparedStatement.setString(6, item.getImage());
            return preparedStatement.executeUpdate() > 0;
        } finally {
            if (preparedStatement != null) preparedStatement.close();
        }
    }

    public List<CartItem> getCartItems(String userId) throws SQLException {
        List<CartItem> items = new ArrayList<>();
        String sql = "SELECT * FROM cart WHERE user_id = ?";
        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, userId);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                CartItem item = new CartItem();
                item.setId(resultSet.getInt("id"));
                item.setUserId(resultSet.getString("user_id"));
                item.setBookId(resultSet.getInt("book_id"));
                item.setBookName(resultSet.getString("name"));
                item.setPrice(resultSet.getDouble("price"));
                item.setQuantity(resultSet.getInt("quantity"));
                item.setImage(resultSet.getString("image"));
                items.add(item);
            }
        } finally {
            if (resultSet != null) resultSet.close();
            if (preparedStatement != null) preparedStatement.close();
        }
        return items;
    }

    // <-- This is the method you need to fix the servlet error:
    public boolean updateQuantity(String userId, int bookId, int quantity) throws SQLException {
        String sql = "UPDATE cart SET quantity = ? WHERE user_id = ? AND book_id = ?";
        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, quantity);
            preparedStatement.setString(2, userId);
            preparedStatement.setInt(3, bookId);
            return preparedStatement.executeUpdate() > 0;
        } finally {
            if (preparedStatement != null) preparedStatement.close();
        }
    }
}
