package com.res.controller;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/ClearOrderServlet")
public class ClearOrderServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            // Remove all order-related attributes
            session.removeAttribute("orderDate");
            session.removeAttribute("name");
            session.removeAttribute("number");
            session.removeAttribute("email");
            session.removeAttribute("address");
            session.removeAttribute("method");
            session.removeAttribute("cartItems");
            session.removeAttribute("totalPrice");
            session.removeAttribute("paymentStatus");
            session.removeAttribute("successMessage");
        }
        response.sendRedirect(request.getContextPath() + "/PublicArea/home.jsp");
    }
}