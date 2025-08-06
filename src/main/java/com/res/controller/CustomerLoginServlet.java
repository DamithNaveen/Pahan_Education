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

@WebServlet("/customerLogin")
public class CustomerLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CustomerService customerService = new CustomerService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        HttpSession session = request.getSession();
        
        try {
            // Input validation
            if (username == null || username.trim().isEmpty() || 
                password == null || password.trim().isEmpty()) {
                session.setAttribute("error", "Username and password are required");
                response.sendRedirect(request.getContextPath() + "/PublicArea/signIn.jsp");
                return;
            }
            
            Customer customer = customerService.loginCustomer(username, password);
            
            if (customer != null) {
                // Login successful
                session.setAttribute("user", customer);
                session.setAttribute("success", "Welcome back, " + customer.getFullName() + "!");
                response.sendRedirect(request.getContextPath() + "/PublicArea/Index.jsp");
            } else {
                // Login failed
                session.setAttribute("error", "Invalid username or password");
                response.sendRedirect(request.getContextPath() + "/PublicArea/signIn.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "System error during login: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/PublicArea/signIn.jsp");
        }
    }
}