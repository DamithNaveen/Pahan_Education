package com.res.controller;

import com.res.dao.CartDAO;
import com.res.model.CartItem;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ViewCartServlet")
public class ViewCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Object userIdObj = session.getAttribute("user_id");
        
        if (userIdObj == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userId = userIdObj.toString();
        CartDAO cartDAO = new CartDAO();
        
        try {
            List<CartItem> cartItems = cartDAO.getCartItems(userId);
            
            double total = 0;
            for (CartItem item : cartItems) {
                total += item.getPrice() * item.getQuantity();
            }
            
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("cartTotal", total);
            
        } catch (SQLException e) {
            request.setAttribute("error", "Error loading cart. Please try again.");
            e.printStackTrace();
        } finally {
            try {
                cartDAO.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }
}