package com.res.dao;

import com.res.model.CartItem;
import com.res.model.Order;
import util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO implements AutoCloseable {
    private Connection connection;

    public OrderDAO() throws SQLException {
        this.connection = DatabaseUtil.getConnection();
    }

    // --- CREATE ORDER (customer) ---
    public boolean createOrder(String userId, String name, String number, String email,
                               String method, String address, double totalPrice, List<CartItem> cartItems) throws SQLException {

        String orderSql = "INSERT INTO orders (user_id, name, number, email, method, address, total_price, order_date, payment_status) " +
                          "VALUES (?, ?, ?, ?, ?, ?, ?, NOW(), 'Pending')";

        try (PreparedStatement orderStmt = connection.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {
            orderStmt.setString(1, userId);
            orderStmt.setString(2, name);
            orderStmt.setString(3, number);
            orderStmt.setString(4, email);
            orderStmt.setString(5, method);
            orderStmt.setString(6, address);
            orderStmt.setDouble(7, totalPrice);

            int affectedRows = orderStmt.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet generatedKeys = orderStmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int orderId = generatedKeys.getInt(1);

                        String itemSql = "INSERT INTO order_items (order_id, book_id, quantity, price) VALUES (?, ?, ?, ?)";
                        try (PreparedStatement itemStmt = connection.prepareStatement(itemSql)) {
                            for (CartItem item : cartItems) {
                                itemStmt.setInt(1, orderId);
                                itemStmt.setInt(2, item.getBookId());
                                itemStmt.setInt(3, item.getQuantity());
                                itemStmt.setDouble(4, item.getPrice());
                                itemStmt.addBatch();
                            }
                            itemStmt.executeBatch();
                        }
                        return true;
                    }
                }
            }
            return false;
        }
    }

    // --- LIST ORDERS (admin with filters + pagination) ---
    public List<Order> getOrders(String status, String dateFrom, String dateTo, int offset, int limit) throws SQLException {
        List<Order> orders = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM orders WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (status != null && !status.isEmpty()) {
            sql.append(" AND payment_status = ?");
            params.add(status);
        }
        if (dateFrom != null && !dateFrom.isEmpty()) {
            sql.append(" AND DATE(order_date) >= ?");
            params.add(dateFrom);
        }
        if (dateTo != null && !dateTo.isEmpty()) {
            sql.append(" AND DATE(order_date) <= ?");
            params.add(dateTo);
        }

        sql.append(" ORDER BY order_date DESC LIMIT ? OFFSET ?");
        params.add(limit);
        params.add(offset);

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    orders.add(mapOrderFromResultSet(rs));
                }
            }
        }
        return orders;
    }

    public int getTotalOrderCount(String status, String dateFrom, String dateTo) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM orders WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (status != null && !status.isEmpty()) {
            sql.append(" AND payment_status = ?");
            params.add(status);
        }
        if (dateFrom != null && !dateFrom.isEmpty()) {
            sql.append(" AND DATE(order_date) >= ?");
            params.add(dateFrom);
        }
        if (dateTo != null && !dateTo.isEmpty()) {
            sql.append(" AND DATE(order_date) <= ?");
            params.add(dateTo);
        }

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return 0;
    }

    // --- GET SINGLE ORDER ---
    public Order getOrderById(int orderId) throws SQLException {
        String sql = "SELECT * FROM orders WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return mapOrderFromResultSet(rs);
            }
        }
        return null;
    }

    // --- GET ORDER ITEMS ---
    public List<CartItem> getOrderItems(int orderId) throws SQLException {
        List<CartItem> items = new ArrayList<>();
        String sql = "SELECT oi.*, b.name as book_name, b.image FROM order_items oi " +
                     "JOIN books b ON oi.book_id = b.id WHERE oi.order_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem();
                    item.setBookId(rs.getInt("book_id"));
                    item.setBookName(rs.getString("book_name"));
                    item.setPrice(rs.getDouble("price"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setImage(rs.getString("image"));
                    items.add(item);
                }
            }
        }
        return items;
    }

    // --- UPDATE ORDER STATUS ---
    public boolean updateOrderStatus(int orderId, String status) throws SQLException {
        String sql = "UPDATE orders SET payment_status = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            return stmt.executeUpdate() > 0;
        }
    }

    // --- DELETE ORDER ---
    public boolean deleteOrder(int orderId) throws SQLException {
        try (PreparedStatement stmt = connection.prepareStatement("DELETE FROM order_items WHERE order_id = ?")) {
            stmt.setInt(1, orderId);
            stmt.executeUpdate();
        }
        try (PreparedStatement stmt = connection.prepareStatement("DELETE FROM orders WHERE id = ?")) {
            stmt.setInt(1, orderId);
            return stmt.executeUpdate() > 0;
        }
    }

    // --- MAP ORDER RESULTSET ---
    private Order mapOrderFromResultSet(ResultSet rs) throws SQLException {
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

    @Override
    public void close() {
        try {
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
