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

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Object userIdObj = session.getAttribute("user_id");
        String userId = null;
        
        // Handle both String and Integer user_id cases
        if (userIdObj instanceof Integer) {
            userId = String.valueOf((Integer) userIdObj);
        } else if (userIdObj instanceof String) {
            userId = (String) userIdObj;
        }

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String referer = request.getHeader("referer");

        try {
            int bookId = Integer.parseInt(request.getParameter("book_id"));
            String bookName = request.getParameter("book_name");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String image = request.getParameter("image");

            CartItem item = new CartItem(userId, bookId, bookName, price, quantity, image);
            
            try (CartDAO cartDAO = new CartDAO()) {
                if (cartDAO.addItem(item)) {
                    // Refresh the cart by getting updated items from database
                    List<CartItem> cartItems = cartDAO.getCartItems(userId);
                    session.setAttribute("cartItems", cartItems);
                    session.setAttribute("message", bookName + " added to cart successfully!");
                } else {
                    session.setAttribute("error", "Failed to add item to cart");
                }
            }
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid product data format");
        } catch (SQLException e) {
            session.setAttribute("error", "Database error occurred. Please try again.");
            e.printStackTrace();
        }
        
        response.sendRedirect(referer != null ? referer : "shop.jsp");
    }
}