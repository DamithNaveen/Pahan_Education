package service;

import com.res.model.Customer;
import com.res.dao.CustomerDAO;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CustomerService {
    private static final Logger LOGGER = Logger.getLogger(CustomerService.class.getName());
    private final CustomerDAO customerDAO;
    
    public CustomerService() {
        this.customerDAO = new CustomerDAO();
    }
    
    public Customer loginCustomer(String username, String password) throws SQLException {
        LOGGER.log(Level.INFO, "Attempting login for username: {0}", username);
        
        if (username == null || username.trim().isEmpty()) {
            throw new IllegalArgumentException("Username is required");
        }
        if (password == null || password.trim().isEmpty()) {
            throw new IllegalArgumentException("Password is required");
        }

        Customer customer = customerDAO.getCustomerByUsername(username);
        
        if (customer != null && password.equals(customer.getPassword())) {
            LOGGER.log(Level.INFO, "Login successful for username: {0}", username);
            return customer;
        }
        
        LOGGER.log(Level.WARNING, "Login failed for username: {0}", username);
        return null;
    }

    public boolean registerCustomer(Customer customer) throws SQLException {
        LOGGER.log(Level.INFO, "Registering new customer: {0}", customer);
        validateCustomer(customer);
        
        if (customerDAO.isUsernameExists(customer.getUsername())) {
            LOGGER.log(Level.WARNING, "Username already exists: {0}", customer.getUsername());
            throw new IllegalArgumentException("Username already exists");
        }
        if (customerDAO.isEmailExists(customer.getEmail())) {
            LOGGER.log(Level.WARNING, "Email already registered: {0}", customer.getEmail());
            throw new IllegalArgumentException("Email already registered");
        }
        
        boolean success = customerDAO.addCustomer(customer);
        LOGGER.log(Level.INFO, "Registration successful: {0}", success);
        return success;
    }

    public List<Customer> getAllCustomers() throws SQLException {
        LOGGER.log(Level.INFO, "Fetching all customers");
        List<Customer> customers = customerDAO.getAllCustomers();
        LOGGER.log(Level.INFO, "Fetched {0} customers", customers.size());
        return customers;
    }

    

    public Customer getCustomerById(int id) throws SQLException {
        LOGGER.log(Level.INFO, "Fetching customer by ID: {0}", id);
        return customerDAO.getCustomerById(id);
    }

    public boolean updateCustomer(Customer customer) throws SQLException {
        LOGGER.log(Level.INFO, "Updating customer: {0}", customer);
        validateCustomer(customer);
        return customerDAO.updateCustomer(customer);
    }

    public boolean deleteCustomer(int id) throws SQLException {
        LOGGER.log(Level.INFO, "Deleting customer with ID: {0}", id);
        return customerDAO.deleteCustomer(id);
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
    public List<Customer> getAllCustomersWithOrders() throws SQLException {
        LOGGER.log(Level.INFO, "Fetching all customers with order statistics");
        
        try {
            List<Customer> customers = customerDAO.getAllCustomersWithOrders();
            LOGGER.log(Level.INFO, "Fetched {0} customers with order data", customers.size());
            return customers;
        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "Error fetching customers with orders, returning basic data", e);
            // Fall back to basic customer data without order statistics
            List<Customer> customers = customerDAO.getAllCustomers();
            for (Customer customer : customers) {
                customer.setOrderCount(0);
                customer.setTotalSpent(0.0);
            }
            return customers;
        }
    }
}
