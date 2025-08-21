package com.res.dao;

import com.res.model.Customer;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.DatabaseUtil;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CustomerDAO {
    private static final Logger LOGGER = Logger.getLogger(CustomerDAO.class.getName());
    
    public Customer getCustomerByUsername(String username) throws SQLException {
        String sql = "SELECT * FROM customers WHERE username = ?";
        LOGGER.log(Level.FINE, "Executing SQL: {0}", sql);
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, username);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Customer customer = mapCustomer(rs);
                    LOGGER.log(Level.FINE, "Found customer: {0}", customer);
                    return customer;
                }
            }
        }
        LOGGER.log(Level.FINE, "No customer found with username: {0}", username);
        return null;
    }

    public boolean addCustomer(Customer customer) throws SQLException {
        String sql = "INSERT INTO customers (username, password, full_name, email, phone, address) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        LOGGER.log(Level.FINE, "Executing SQL: {0}", sql);
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, customer.getUsername());
            ps.setString(2, customer.getPassword());
            ps.setString(3, customer.getFullName());
            ps.setString(4, customer.getEmail());
            ps.setString(5, customer.getPhone());
            ps.setString(6, customer.getAddress());
            
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        customer.setId(generatedKeys.getInt(1));
                        LOGGER.log(Level.INFO, "Added new customer with ID: {0}", customer.getId());
                        return true;
                    }
                }
            }
            LOGGER.log(Level.WARNING, "Failed to add customer");
            return false;
        }
    }

    public boolean isUsernameExists(String username) throws SQLException {
        String sql = "SELECT 1 FROM customers WHERE username = ?";
        LOGGER.log(Level.FINE, "Checking username existence: {0}", username);
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                boolean exists = rs.next();
                LOGGER.log(Level.FINE, "Username {0} exists: {1}", new Object[]{username, exists});
                return exists;
            }
        }
    }

    public boolean isEmailExists(String email) throws SQLException {
        String sql = "SELECT 1 FROM customers WHERE email = ?";
        LOGGER.log(Level.FINE, "Checking email existence: {0}", email);
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                boolean exists = rs.next();
                LOGGER.log(Level.FINE, "Email {0} exists: {1}", new Object[]{email, exists});
                return exists;
            }
        }
    }

    public List<Customer> getAllCustomers() throws SQLException {
        String sql = "SELECT * FROM customers ORDER BY id";
        LOGGER.log(Level.INFO, "Fetching all customers");
        
        List<Customer> customers = new ArrayList<>();
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Customer customer = mapCustomer(rs);
                customers.add(customer);
                LOGGER.log(Level.FINEST, "Added customer: {0}", customer);
            }
        }
        
        LOGGER.log(Level.INFO, "Total customers fetched: {0}", customers.size());
        return customers;
    }

    public List<Customer> getAllCustomersWithOrders() throws SQLException {
        String sql = "SELECT c.*, COUNT(o.id) as order_count, " +
                     "COALESCE(SUM(o.total_price), 0) as total_spent " +
                     "FROM customers c " +
                     "LEFT JOIN orders o ON c.id = o.customer_id " +
                     "GROUP BY c.id " +
                     "ORDER BY c.id";
        
        LOGGER.log(Level.INFO, "Fetching all customers with order statistics");
        
        List<Customer> customers = new ArrayList<>();
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Customer customer = mapCustomerWithOrders(rs);
                customers.add(customer);
                LOGGER.log(Level.FINEST, "Added customer with orders: {0}", customer);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching customers with orders", e);
            throw e;
        }
        
        LOGGER.log(Level.INFO, "Fetched {0} customers with order data", customers.size());
        return customers;
    }

    public Customer getCustomerById(int id) throws SQLException {
        String sql = "SELECT * FROM customers WHERE id = ?";
        LOGGER.log(Level.FINE, "Fetching customer by ID: {0}", id);
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Customer customer = mapCustomer(rs);
                    LOGGER.log(Level.FINE, "Found customer: {0}", customer);
                    return customer;
                }
            }
        }
        LOGGER.log(Level.FINE, "No customer found with ID: {0}", id);
        return null;
    }

    public boolean updateCustomer(Customer customer) throws SQLException {
        String sql = "UPDATE customers SET username = ?, password = ?, full_name = ?, " +
                     "email = ?, phone = ?, address = ? WHERE id = ?";
        LOGGER.log(Level.INFO, "Updating customer: {0}", customer);
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, customer.getUsername());
            ps.setString(2, customer.getPassword());
            ps.setString(3, customer.getFullName());
            ps.setString(4, customer.getEmail());
            ps.setString(5, customer.getPhone());
            ps.setString(6, customer.getAddress());
            ps.setInt(7, customer.getId());
            
            int rowsUpdated = ps.executeUpdate();
            boolean success = rowsUpdated > 0;
            LOGGER.log(Level.INFO, "Update successful: {0}", success);
            return success;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating customer", e);
            throw e;
        }
    }

    public boolean deleteCustomer(int id) throws SQLException {
        String sql = "DELETE FROM customers WHERE id = ?";
        LOGGER.log(Level.INFO, "Deleting customer with ID: {0}", id);
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            int rowsDeleted = ps.executeUpdate();
            boolean success = rowsDeleted > 0;
            LOGGER.log(Level.INFO, "Delete successful: {0}", success);
            return success;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting customer", e);
            throw e;
        }
    }

   

    private Customer mapCustomerWithOrders(ResultSet rs) throws SQLException {
        Customer customer = mapCustomer(rs);
        
        // Safely get order_count and total_spent (they might not exist in all queries)
        try {
            customer.setOrderCount(rs.getInt("order_count"));
        } catch (SQLException e) {
            customer.setOrderCount(0); // Default value if column doesn't exist
        }
        
        try {
            customer.setTotalSpent(rs.getDouble("total_spent"));
        } catch (SQLException e) {
            customer.setTotalSpent(0.0); // Default value if column doesn't exist
        }
        
        return customer;
    }
    
 // In your CustomerDAO class, update the mapCustomer method:
    private Customer mapCustomer(ResultSet rs) throws SQLException {
        Customer customer = new Customer();
        customer.setId(rs.getInt("id"));
        customer.setUsername(rs.getString("username"));
        customer.setPassword(rs.getString("password"));
        customer.setFullName(rs.getString("full_name"));
        customer.setEmail(rs.getString("email"));
        customer.setPhone(rs.getString("phone"));
        customer.setAddress(rs.getString("address"));
        
        
        return customer;
    }
}