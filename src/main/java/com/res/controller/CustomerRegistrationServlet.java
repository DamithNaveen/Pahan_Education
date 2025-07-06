package com.res.controller;

import java.io.IOException;
import java.sql.SQLException;
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
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");

        HttpSession session = request.getSession();
        CustomerService customerService = new CustomerService();

        // Validate inputs
        if (fullName == null || fullName.trim().isEmpty()) {
            session.setAttribute("error", "Full Name is required");
            response.sendRedirect("register.jsp");
            return;
        }

        if (username == null || username.trim().isEmpty()) {
            session.setAttribute("error", "Username is required");
            response.sendRedirect("register.jsp");
            return;
        }

        if (email == null || !email.matches("^[\\w-.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            session.setAttribute("error", "Invalid email format");
            response.sendRedirect("register.jsp");
            return;
        }

        if (password == null || password.length() < 8) {
            session.setAttribute("error", "Password must be at least 8 characters");
            response.sendRedirect("register.jsp");
            return;
        }

        if (address == null || address.trim().isEmpty()) {
            session.setAttribute("error", "Address is required");
            response.sendRedirect("register.jsp");
            return;
        }

        if (phone == null || !phone.matches("\\d{10}")) {
            session.setAttribute("error", "Phone must be 10 digits");
            response.sendRedirect("register.jsp");
            return;
        }

        try {
            // Check for existing user
            if (customerService.isUsernameExists(username)) {
                session.setAttribute("error", "Username already exists");
                response.sendRedirect("register.jsp");
                return;
            }

            if (customerService.isEmailExists(email)) {
                session.setAttribute("error", "Email already exists");
                response.sendRedirect("register.jsp");
                return;
            }

            if (customerService.isPhoneExists(phone)) {
                session.setAttribute("error", "Phone number already exists");
                response.sendRedirect("register.jsp");
                return;
            }

            // Create new customer
            Customer customer = new Customer(fullName, username, email, password, address, phone);
            boolean isRegistered = customerService.registerCustomer(customer);

            if (isRegistered) {
                session.setAttribute("success", "Registration successful! Please login.");
                response.sendRedirect("login.jsp");
            } else {
                session.setAttribute("error", "Registration failed. Please try again.");
                response.sendRedirect("register.jsp");
            }
        } catch (SQLException e) {
            session.setAttribute("error", "Database error: " + e.getMessage());
            response.sendRedirect("register.jsp");
        }
    }
}