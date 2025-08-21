package com.res.controller;

import com.res.model.Customer;
import service.CustomerService;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminCustomerListServlet", urlPatterns = {"/admin/customers"})
public class AdminCustomerListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CustomerService customerService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.customerService = new CustomerService();
        System.out.println("AdminCustomerListServlet initialized");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        System.out.println("AdminCustomerListServlet doGet() called");
        
        // Set response content type first
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            System.out.println("Fetching customers from service...");
            List<Customer> customers = customerService.getAllCustomers();
            
            // Debug output
            System.out.println("Number of customers fetched: " + customers.size());
            if (!customers.isEmpty()) {
                System.out.println("First customer: " + customers.get(0).getUsername());
            }
            
            // Set attributes for JSP
            request.setAttribute("customers", customers);
            
            // Forward to JSP
            System.out.println("Forwarding to /WEB-INF/AdminArea/adminCustomers.jsp");
            request.getRequestDispatcher("/WEB-INF/AdminArea/adminCustomers.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("ERROR in AdminCustomerListServlet:");
            e.printStackTrace();
            
            // Set error attribute
            request.setAttribute("error", "Error loading customers: " + e.getMessage());
            
            // Forward to error page or back to JSP
            request.getRequestDispatcher("/WEB-INF/AdminArea/adminCustomers.jsp").forward(request, response);
        }
    }
}