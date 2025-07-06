package com.res.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.res.model.Customer;
import util.DatabaseUtil;

public class CustomerDAO {
    public boolean addCustomer(Customer customer) throws SQLException {
        String sql = "INSERT INTO customers (full_name, username, email, password, address, phone) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, customer.getFullName());
            pstmt.setString(2, customer.getUsername());
            pstmt.setString(3, customer.getEmail());
            pstmt.setString(4, customer.getPassword());
            pstmt.setString(5, customer.getAddress());
            pstmt.setString(6, customer.getPhone());
            return pstmt.executeUpdate() > 0;
        }
    }

    public boolean isEmailExists(String email) throws SQLException {
        return checkFieldExists("email", email);
    }

    public boolean isUsernameExists(String username) throws SQLException {
        return checkFieldExists("username", username);
    }

    public boolean isPhoneExists(String phone) throws SQLException {
        return checkFieldExists("phone", phone);
    }

    private boolean checkFieldExists(String field, String value) throws SQLException {
        String sql = "SELECT id FROM customers WHERE " + field + " = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, value);
            try (ResultSet rs = pstmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    public Customer getCustomerByUsername(String username) throws SQLException {
        String sql = "SELECT * FROM customers WHERE username = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapCustomerFromResultSet(rs);
                }
            }
        }
        return null;
    }
    
    public List<Customer> getAllCustomers() throws SQLException {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customers";
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                customers.add(mapCustomerFromResultSet(rs));
            }
        }
        return customers;
    }

    private Customer mapCustomerFromResultSet(ResultSet rs) throws SQLException {
        Customer customer = new Customer();
        customer.setId(rs.getInt("id"));
        customer.setFullName(rs.getString("full_name"));
        customer.setUsername(rs.getString("username"));
        customer.setEmail(rs.getString("email"));
        customer.setPassword(rs.getString("password"));
        customer.setAddress(rs.getString("address"));
        customer.setPhone(rs.getString("phone"));
        return customer;
    }
}