package service;

import java.sql.SQLException;
import com.res.model.Customer;
import com.res.dao.CustomerDAO;

public class CustomerService {
    private CustomerDAO customerDAO;

    public CustomerService() throws SQLException {
        this.customerDAO = new CustomerDAO();
    }

    public Customer loginCustomer(String username, String password) throws SQLException {
        // Input validation
        if (username == null || username.trim().isEmpty()) {
            throw new IllegalArgumentException("Username is required");
        }
        if (password == null || password.trim().isEmpty()) {
            throw new IllegalArgumentException("Password is required");
        }

        // Get customer from database
        Customer customer = customerDAO.getCustomerByUsername(username.trim());
        
        if (customer == null) {
            System.out.println("No customer found with username: " + username);
            return null;
        }
        
        // Password comparison (in production, use hashed passwords)
        if (!password.equals(customer.getPassword())) {
            System.out.println("Password mismatch for user: " + username);
            return null;
        }
        
        return customer;
    }

    public boolean registerCustomer(Customer customer) throws SQLException {
        // Input validation
        if (customer == null) {
            throw new IllegalArgumentException("Customer cannot be null");
        }
        if (customer.getFullName() == null || customer.getFullName().trim().isEmpty()) {
            throw new IllegalArgumentException("Full name is required");
        }
        if (customer.getUsername() == null || customer.getUsername().trim().isEmpty()) {
            throw new IllegalArgumentException("Username is required");
        }
        if (customer.getEmail() == null || customer.getEmail().trim().isEmpty()) {
            throw new IllegalArgumentException("Email is required");
        }
        if (customer.getPassword() == null || customer.getPassword().trim().isEmpty()) {
            throw new IllegalArgumentException("Password is required");
        }

        // Check if username exists
        if (customerDAO.isUsernameExists(customer.getUsername().trim())) {
            throw new IllegalArgumentException("Username already exists");
        }

        // Check if email exists
        if (customerDAO.isEmailExists(customer.getEmail().trim())) {
            throw new IllegalArgumentException("Email already registered");
        }

        return customerDAO.addCustomer(customer);
    }

    public void close() throws SQLException {
        if (customerDAO != null) {
            customerDAO.close();
        }
    }
}