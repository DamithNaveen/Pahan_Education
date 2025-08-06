package com.res.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.res.model.Customer;
import util.DatabaseUtil;

public class CustomerDAO {
    
    public boolean addCustomer(Customer customer) throws SQLException {
        String sql = "INSERT INTO customers (full_name, username, email, password, address, phone) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setString(1, customer.getFullName());
            pstmt.setString(2, customer.getUsername());
            pstmt.setString(3, customer.getEmail());
            pstmt.setString(4, customer.getPassword());
            pstmt.setString(5, customer.getAddress());
            pstmt.setString(6, customer.getPhone());

            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows == 0) {
                return false;
            }

            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    customer.setId(generatedKeys.getInt(1));
                }
            }
            return true;
        }
    }

    public Customer getCustomerByUsername(String username) throws SQLException {
        String sql = "SELECT * FROM customers WHERE username = ?";
        return getCustomer(sql, username);
    }

    public Customer getCustomerByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM customers WHERE email = ?";
        return getCustomer(sql, email);
    }

    private Customer getCustomer(String sql, String param) throws SQLException {
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, param);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Customer customer = new Customer();
                    customer.setId(rs.getInt("customer_id"));
                    customer.setFullName(rs.getString("full_name"));
                    customer.setUsername(rs.getString("username"));
                    customer.setEmail(rs.getString("email"));
                    customer.setPassword(rs.getString("password"));
                    customer.setAddress(rs.getString("address"));
                    customer.setPhone(rs.getString("phone"));
                    return customer;
                }
            }
        }
        return null;
    }

    public boolean isUsernameExists(String username) throws SQLException {
        return isFieldExists("username", username);
    }

    public boolean isEmailExists(String email) throws SQLException {
        return isFieldExists("email", email);
    }

    public boolean isPhoneExists(String phone) throws SQLException {
        return isFieldExists("phone", phone);
    }

    private boolean isFieldExists(String field, String value) throws SQLException {
        String sql = "SELECT 1 FROM customers WHERE " + field + " = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, value);
            try (ResultSet rs = pstmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    public List<Customer> getAllCustomers() throws SQLException {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customers";
        
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Customer customer = new Customer();
                customer.setId(rs.getInt("customer_id"));
                customer.setFullName(rs.getString("full_name"));
                customer.setUsername(rs.getString("username"));
                customer.setEmail(rs.getString("email"));
                customer.setAddress(rs.getString("address"));
                customer.setPhone(rs.getString("phone"));
                customers.add(customer);
            }
        }
        return customers;
    }
}