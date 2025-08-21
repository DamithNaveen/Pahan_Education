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
        
        HttpSession session = request.getSession();
        
        // Get all form parameters with trimming
        String username = request.getParameter("username") != null ? request.getParameter("username").trim() : "";
        String password = request.getParameter("password") != null ? request.getParameter("password").trim() : "";
        String fullName = request.getParameter("full_name") != null ? request.getParameter("full_name").trim() : "";
        String email = request.getParameter("email") != null ? request.getParameter("email").trim() : "";
        String phone = request.getParameter("phone") != null ? request.getParameter("phone").trim() : "";
        String address = request.getParameter("address") != null ? request.getParameter("address").trim() : "";
        
        try {
            Customer customer = new Customer();
            customer.setUsername(username);
            customer.setPassword(password);
            customer.setFullName(fullName);
            customer.setEmail(email);
            customer.setPhone(phone);
            customer.setAddress(address);
            
            CustomerService service = new CustomerService();
            boolean registered = service.registerCustomer(customer);
            
            if (registered) {
                session.setAttribute("success", "Registration successful! Please login.");
                
                // You could add admin notification logic here
                // For example, store in session for admin to see new registrations
                session.setAttribute("newRegistration", "New customer registered: " + username);
                
                response.sendRedirect(request.getContextPath() + "/PublicArea/signIn.jsp");
                return;
            } else {
                session.setAttribute("error", "Registration failed. Please try again.");
            }
        } catch (IllegalArgumentException e) {
            session.setAttribute("error", e.getMessage());
        } catch (Exception e) {
            session.setAttribute("error", "System error during registration. Please try again.");
            e.printStackTrace();
        }
        
        // Preserve form data on error
        session.setAttribute("formUsername", username);
        session.setAttribute("formEmail", email);
        session.setAttribute("formFullName", fullName);
        session.setAttribute("formPhone", phone);
        session.setAttribute("formAddress", address);
        
        response.sendRedirect(request.getContextPath() + "/PublicArea/signUp.jsp");
    }
}