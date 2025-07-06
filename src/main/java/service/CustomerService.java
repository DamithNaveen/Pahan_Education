package service;

import java.sql.SQLException;
import java.util.List;
import com.res.dao.CustomerDAO;
import com.res.model.Customer;

public class CustomerService {
    private CustomerDAO customerDAO = new CustomerDAO();

    public boolean registerCustomer(Customer customer) throws SQLException {
        return customerDAO.addCustomer(customer);
    }

    public boolean isEmailExists(String email) throws SQLException {
        return customerDAO.isEmailExists(email);
    }

    public boolean isUsernameExists(String username) throws SQLException {
        return customerDAO.isUsernameExists(username);
    }

    public boolean isPhoneExists(String phone) throws SQLException {
        return customerDAO.isPhoneExists(phone);
    }

    public Customer loginCustomer(String username, String password) throws SQLException {
        Customer customer = customerDAO.getCustomerByUsername(username);
        if (customer != null && customer.getPassword().equals(password)) {
            return customer;
        }
        return null;
    }
    
    public List<Customer> getAllCustomers() throws SQLException {
        return customerDAO.getAllCustomers();
    }
}