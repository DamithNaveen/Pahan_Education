package com.res.controller;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/orderConfirmation")
public class OrderConfirmationServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if(session == null || session.getAttribute("orderDate") == null) {
            response.sendRedirect(request.getContextPath() + "/checkout");
            return;
        }
        
        request.getRequestDispatcher("/PublicArea/order.jsp").forward(request, response);
    }
}