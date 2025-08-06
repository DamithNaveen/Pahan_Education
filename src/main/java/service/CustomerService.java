package service;

import java.sql.SQLException;
import com.res.model.Customer;
import com.res.dao.CustomerDAO;

public class CustomerService {
    private CustomerDAO customerDAO = new CustomerDAO();

    public Customer loginCustomer(String username, String password) throws SQLException {
        // Input validation
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            throw new IllegalArgumentException("Username and password are required");
        }

        // Get customer from database
        Customer customer = customerDAO.getCustomerByUsername(username.trim());
        
        // Simple password comparison (not secure for production)
        if (customer != null && password.equals(customer.getPassword())) {
            return createSafeCustomer(customer);
        }
        return null;
    }

    // Registration without password hashing
    public boolean registerCustomer(Customer customer) throws SQLException {
        // Input validation
        if (customer == null || 
            !isValid(customer.getUsername()) ||
            !isValid(customer.getPassword())) {
            throw new IllegalArgumentException("Username and password are required");
        }

        // Check if username exists
        if (customerDAO.isUsernameExists(customer.getUsername().trim())) {
            throw new IllegalArgumentException("Username already exists");
        }

        // Store password as plain text (not recommended)
        return customerDAO.addCustomer(customer);
    }

    // [Keep other methods unchanged]
    private Customer createSafeCustomer(Customer customer) {
        Customer safeCustomer = new Customer();
        safeCustomer.setId(customer.getId());
        safeCustomer.setUsername(customer.getUsername());
        // Don't include password in the returned object
        return safeCustomer;
    }

    private boolean isValid(String value) {
        return value != null && !value.trim().isEmpty();
    }
}