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

@WebServlet("/customerLogin")
public class CustomerLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        System.out.println("Login attempt - Username: " + username);
        
        HttpSession session = request.getSession();
        CustomerService customerService = null;
        
        try {
            customerService = new CustomerService();
            Customer customer = customerService.loginCustomer(username, password);
            
            if (customer != null) {
                System.out.println("Login successful for: " + customer.getUsername());
                session.setAttribute("user_id", customer.getId());
                session.setAttribute("user_name", customer.getFullName());
                session.setAttribute("user_obj", customer);
                session.setAttribute("success", "Welcome back, " + customer.getFullName() + "!");
                response.sendRedirect("PublicArea/Index.jsp");
                return;
            } else {
                System.out.println("Login failed for: " + username);
                session.setAttribute("error", "Invalid username or password");
            }
        } catch (IllegalArgumentException e) {
            session.setAttribute("error", e.getMessage());
            System.out.println("Validation error: " + e.getMessage());
        } catch (Exception e) {
            session.setAttribute("error", "System error during login. Please try again.");
            System.err.println("Login error: ");
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
        response.sendRedirect("PublicArea/signIn.jsp");
    }
}