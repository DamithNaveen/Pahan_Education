package com.res.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/AdminDashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Normally, fetch these values from DB or services
        int totalPaymentsPending = 15;
        int completedPayments = 45;
        int ordersPlaced = 100;
        int productsAdded = 30;
        int userCount = 80;
        int adminCount = 5;
        int totalAccounts = userCount + adminCount;
        int newMessages = 7;

        // Set attributes to request for JSP access
        request.setAttribute("totalPaymentsPending", totalPaymentsPending);
        request.setAttribute("completedPayments", completedPayments);
        request.setAttribute("ordersPlaced", ordersPlaced);
        request.setAttribute("productsAdded", productsAdded);
        request.setAttribute("userCount", userCount);
        request.setAttribute("adminCount", adminCount);
        request.setAttribute("totalAccounts", totalAccounts);
        request.setAttribute("newMessages", newMessages);

        // Forward to dashboard JSP
        request.getRequestDispatcher("/AdminArea/dashboard.jsp").forward(request, response);
    }
}
