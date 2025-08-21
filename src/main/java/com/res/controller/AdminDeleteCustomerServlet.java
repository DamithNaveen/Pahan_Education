package com.res.controller;

import service.CustomerService;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/deleteCustomer")
public class AdminDeleteCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            CustomerService service = new CustomerService();
            boolean deleted = service.deleteCustomer(id);
            
            if (deleted) {
                request.getSession().setAttribute("success", "Customer deleted successfully");
            } else {
                request.getSession().setAttribute("error", "Failed to delete customer");
            }
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Error deleting customer: " + e.getMessage());
            e.printStackTrace();
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/customers");
    }
}