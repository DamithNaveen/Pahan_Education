package com.res.dao;

import com.res.model.CartItem;
import com.res.model.Order;
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

    // Cart Methods
    public boolean addItem(CartItem item) throws SQLException {
        // Check if item already exists in cart
        if (getCartItem(item.getUserId(), item.getBookId()) != null) {
            return updateQuantity(item.getUserId(), item.getBookId(), 
                getCartItem(item.getUserId(), item.getBookId()).getQuantity() + item.getQuantity());
        }

        String sql = "INSERT INTO cart (user_id, book_id, name, price, quantity, image) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, item.getUserId());
            stmt.setInt(2, item.getBookId());
            stmt.setString(3, item.getBookName());
            stmt.setDouble(4, item.getPrice());
            stmt.setInt(5, item.getQuantity());
            stmt.setString(6, item.getImage());
            return stmt.executeUpdate() > 0;
        }
    }

    public List<CartItem> getCartItems(String userId) throws SQLException {
        List<CartItem> items = new ArrayList<>();
        String sql = "SELECT * FROM cart WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    items.add(mapCartItem(rs));
                }
            }
        }
        return items;
    }

    public boolean removeItem(String userId, int bookId) throws SQLException {
        String sql = "DELETE FROM cart WHERE user_id = ? AND book_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, userId);
            stmt.setInt(2, bookId);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean updateQuantity(String userId, int bookId, int quantity) throws SQLException {
        String sql = "UPDATE cart SET quantity = ? WHERE user_id = ? AND book_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, quantity);
            stmt.setString(2, userId);
            stmt.setInt(3, bookId);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean clearCart(String userId) throws SQLException {
        String sql = "DELETE FROM cart WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, userId);
            return stmt.executeUpdate() >= 0;
        }
    }

    // Order Methods
    public boolean saveOrder(String userId, String name, String number, String email, 
                           String method, String address, double totalPrice, 
                           String orderDate, String paymentStatus) throws SQLException {
        String sql = "INSERT INTO orders (user_id, name, number, email, method, address, " +
                    "total_price, order_date, payment_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, userId);
            stmt.setString(2, name);
            stmt.setString(3, number);
            stmt.setString(4, email);
            stmt.setString(5, method);
            stmt.setString(6, address);
            stmt.setDouble(7, totalPrice);
            stmt.setString(8, orderDate);
            stmt.setString(9, paymentStatus);
            
            return stmt.executeUpdate() > 0;
        }
    }

    public List<Order> getOrdersByUser(String userId) throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    orders.add(mapOrder(rs));
                }
            }
        }
        return orders;
    }

    // Helper methods
    private CartItem getCartItem(String userId, int bookId) throws SQLException {
        String sql = "SELECT * FROM cart WHERE user_id = ? AND book_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, userId);
            stmt.setInt(2, bookId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapCartItem(rs);
                }
            }
        }
        return null;
    }

    private CartItem mapCartItem(ResultSet rs) throws SQLException {
        CartItem item = new CartItem();
        item.setId(rs.getInt("id"));
        item.setUserId(rs.getString("user_id"));
        item.setBookId(rs.getInt("book_id"));
        item.setBookName(rs.getString("name"));
        item.setPrice(rs.getDouble("price"));
        item.setQuantity(rs.getInt("quantity"));
        item.setImage(rs.getString("image"));
        return item;
    }

    private Order mapOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setId(rs.getInt("id"));
        order.setUserId(rs.getString("user_id"));
        order.setName(rs.getString("name"));
        order.setNumber(rs.getString("number"));
        order.setEmail(rs.getString("email"));
        order.setMethod(rs.getString("method"));
        order.setAddress(rs.getString("address"));
        order.setTotalPrice(rs.getDouble("total_price"));
        order.setOrderDate(rs.getString("order_date"));
        order.setPaymentStatus(rs.getString("payment_status"));
        return order;
    }
}