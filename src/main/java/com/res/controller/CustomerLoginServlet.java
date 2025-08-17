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
        
        String username = request.getParameter("username") != null ? request.getParameter("username").trim() : "";
        String password = request.getParameter("password") != null ? request.getParameter("password").trim() : "";
        HttpSession session = request.getSession();
        
        try {
            CustomerService service = new CustomerService();
            Customer customer = service.loginCustomer(username, password);
            
            if (customer != null) {
                // Set user attributes in session
                session.setAttribute("user_id", customer.getId());
                session.setAttribute("user_name", customer.getFullName());
                session.setAttribute("user_obj", customer);
                
                // Fixed redirect with context path to home page
                response.sendRedirect(request.getContextPath() + "/PublicArea/ndex.jsp");
                return;
            } else {
                session.setAttribute("error", "Invalid username or password");
            }
        } catch (IllegalArgumentException e) {
            session.setAttribute("error", e.getMessage());
        } catch (Exception e) {
            session.setAttribute("error", "System error during login. Please try again.");
            e.printStackTrace();
        }
        
        // Preserve username on error
        session.setAttribute("formUsername", username);
        
        // Fixed redirect with context path back to login page
        response.sendRedirect(request.getContextPath() + "/PublicArea/signIn.jsp");
    }
}