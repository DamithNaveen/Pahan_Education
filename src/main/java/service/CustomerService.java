package service;

import com.res.model.Customer;
import com.res.dao.CustomerDAO;
import java.sql.SQLException;

public class CustomerService {
    
    public Customer loginCustomer(String username, String password) throws SQLException {
        if (username == null || username.trim().isEmpty()) {
            throw new IllegalArgumentException("Username is required");
        }
        if (password == null || password.trim().isEmpty()) {
            throw new IllegalArgumentException("Password is required");
        }

        CustomerDAO dao = new CustomerDAO();
        Customer customer = dao.getCustomerByUsername(username);
        
        if (customer != null && password.equals(customer.getPassword())) {
            return customer;
        }
        return null;
    }

    public boolean registerCustomer(Customer customer) throws SQLException {
        validateCustomer(customer);
        
        CustomerDAO dao = new CustomerDAO();
        if (dao.isUsernameExists(customer.getUsername())) {
            throw new IllegalArgumentException("Username already exists");
        }
        if (dao.isEmailExists(customer.getEmail())) {
            throw new IllegalArgumentException("Email already registered");
        }
        
        return dao.addCustomer(customer);
    }

    private void validateCustomer(Customer customer) {
        if (customer == null) {
            throw new IllegalArgumentException("Customer cannot be null");
        }
        if (customer.getUsername() == null || customer.getUsername().trim().isEmpty()) {
            throw new IllegalArgumentException("Username is required");
        }
        if (customer.getPassword() == null || customer.getPassword().trim().isEmpty()) {
            throw new IllegalArgumentException("Password is required");
        }
        if (customer.getFullName() == null || customer.getFullName().trim().isEmpty()) {
            throw new IllegalArgumentException("Full name is required");
        }
        if (customer.getEmail() == null || customer.getEmail().trim().isEmpty()) {
            throw new IllegalArgumentException("Email is required");
        }
        if (customer.getPhone() != null && customer.getPhone().length() > 20) {
            throw new IllegalArgumentException("Phone number too long");
        }
    }
}