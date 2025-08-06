package com.res.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.res.model.Customer;
import service.CustomerService;

@WebServlet("/register")
public class CustomerRegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CustomerService customerService = new CustomerService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        
        try {
            // Get parameters
            String fullName = request.getParameter("full_name");
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");

            // Validate inputs
            if (fullName == null || fullName.trim().isEmpty() ||
                username == null || username.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
                throw new IllegalArgumentException("All required fields must be filled");
            }

            // Create customer object
            Customer customer = new Customer(
                fullName, 
                username, 
                email, 
                password, 
                address, 
                phone
            );

            // Register customer
            boolean isRegistered = customerService.registerCustomer(customer);

            if (isRegistered) {
                // Set customer in session and redirect to index
                session.setAttribute("user", customer);
                session.setAttribute("success", "Registration successful! Welcome, " + customer.getFullName() + "!");
                response.sendRedirect(request.getContextPath() + "/PublicArea/Index.jsp");
            } else {
                session.setAttribute("error", "Registration failed. Please try again.");
                response.sendRedirect(request.getContextPath() + "/PublicArea/signUp.jsp");
            }
        } catch (IllegalArgumentException e) {
            session.setAttribute("error", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/PublicArea/signUp.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "System error during registration: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/PublicArea/signUp.jsp");
        }
    }
}