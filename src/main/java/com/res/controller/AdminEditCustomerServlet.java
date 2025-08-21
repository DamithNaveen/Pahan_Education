package com.res.controller;

import com.res.model.Customer;
import service.CustomerService;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/editCustomer")
public class AdminEditCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            CustomerService service = new CustomerService();
            Customer customer = service.getCustomerById(id);
            
            if (customer != null) {
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("/AdminArea/editCustomer.jsp").forward(request, response);
            } else {
                request.getSession().setAttribute("error", "Customer not found");
                response.sendRedirect(request.getContextPath() + "/admin/customers");
            }
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Error fetching customer: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/customers");
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            
            Customer customer = new Customer();
            customer.setId(id);
            customer.setUsername(username);
            customer.setPassword(password);
            customer.setFullName(fullName);
            customer.setEmail(email);
            customer.setPhone(phone);
            customer.setAddress(address);
            
            CustomerService service = new CustomerService();
            boolean updated = service.updateCustomer(customer);
            
            if (updated) {
                request.getSession().setAttribute("success", "Customer updated successfully");
                response.sendRedirect(request.getContextPath() + "/admin/customers");
            } else {
                request.getSession().setAttribute("error", "Failed to update customer");
                response.sendRedirect(request.getContextPath() + "/admin/editCustomer?id=" + id);
            }
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Error updating customer: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/customers");
            e.printStackTrace();
        }
    }
}