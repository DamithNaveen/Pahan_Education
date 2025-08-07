package com.res.controller;

import com.res.model.Customer;
import service.CustomerService;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/register")
public class CustomerRegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("full_name");
        String email = request.getParameter("email");
        
        System.out.println("Registration attempt - Username: " + username + ", Email: " + email);
        
        HttpSession session = request.getSession();
        CustomerService customerService = null;
        
        try {
            // Create customer object
            Customer customer = new Customer();
            customer.setUsername(username);
            customer.setPassword(password);
            customer.setFullName(fullName);
            customer.setEmail(email);
            
            // Register customer
            customerService = new CustomerService();
            boolean success = customerService.registerCustomer(customer);
            
            if (success) {
                System.out.println("Registration successful for: " + username);
                session.setAttribute("success", "Registration successful! Please login.");
                response.sendRedirect("PublicArea/signIn.jsp");
                return;
            } else {
                session.setAttribute("error", "Registration failed. Please try again.");
            }
        } catch (IllegalArgumentException e) {
            session.setAttribute("error", e.getMessage());
            session.setAttribute("username", username);
            session.setAttribute("email", email);
            session.setAttribute("fullName", fullName);
            System.out.println("Validation error: " + e.getMessage());
        } catch (Exception e) {
            session.setAttribute("error", "System error during registration. Please try again.");
            session.setAttribute("username", username);
            session.setAttribute("email", email);
            session.setAttribute("fullName", fullName);
            System.err.println("Registration error: ");
            e.printStackTrace();
        } finally {
            if (customerService != null) {
                try {
                    customerService.close();
                } catch (Exception e) {
                    System.err.println("Error closing service: ");
                    e.printStackTrace();
                }
            }
        }
        
        // If we get here, there was an error
        response.sendRedirect("PublicArea/signUp.jsp");
    }
}