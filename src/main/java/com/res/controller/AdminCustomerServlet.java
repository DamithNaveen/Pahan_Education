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
import javax.servlet.http.HttpSession;

@WebServlet("/admincustomers")
public class AdminCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final CustomerService customerService;

    public AdminCustomerServlet() {
        this.customerService = new CustomerService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        try {
            if (action == null) {
                // Default: list all customers
                List<Customer> customers = customerService.getAllCustomersWithOrders();
                request.setAttribute("customers", customers);
                request.setAttribute("totalRecords", customers.size());
                request.getRequestDispatcher("/AdminArea/customers.jsp").forward(request, response);
            } 
            else if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Customer customer = customerService.getCustomerById(id);
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("/AdminArea/editCustomer.jsp").forward(request, response);
            } 
            else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                if (customerService.deleteCustomer(id)) {
                    session.setAttribute("message", "Customer deleted successfully.");
                } else {
                    session.setAttribute("error", "Failed to delete customer.");
                }
                response.sendRedirect(request.getContextPath() + "/admincustomers");
            }
        } catch (Exception e) {
            session.setAttribute("error", "Error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/AdminArea/dashboard.jsp");
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String username = request.getParameter("username");
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            Customer c = new Customer();
            c.setId(id);
            c.setUsername(username);
            c.setFullName(fullName);
            c.setEmail(email);
            c.setPhone(phone);
            c.setAddress(address);

            if (customerService.updateCustomer(c)) {
                session.setAttribute("message", "Customer updated successfully.");
            } else {
                session.setAttribute("error", "Failed to update customer.");
            }
            response.sendRedirect(request.getContextPath() + "/admincustomers");

        } catch (Exception e) {
            session.setAttribute("error", "Error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admincustomers");
            e.printStackTrace();
        }
    }
}
