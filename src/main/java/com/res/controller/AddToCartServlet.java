package com.res.controller;

import com.res.dao.CartDAO;
import com.res.model.CartItem;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("user_id");
        
        if (userId == null) {
            response.sendRedirect("login.jsp?redirect=" + request.getRequestURI());
            return;
        }
        
        try {
            // Validate and parse request parameters
            int bookId = validateAndParseInt(request.getParameter("book_id"), "Book ID");
            String bookName = validateString(request.getParameter("book_name"), "Book name");
            double price = validateAndParseDouble(request.getParameter("price"), "Price");
            int quantity = validateAndParseInt(request.getParameter("quantity"), "Quantity");
            String image = validateString(request.getParameter("image"), "Image");
            
            // Create cart item
            CartItem item = new CartItem(userId, bookId, bookName, price, quantity, image);
            
            // Add to cart
            CartDAO cartDAO = new CartDAO();
            try {
                boolean added = cartDAO.addItem(item);
                
                if (added) {
                    session.setAttribute("message", bookName + " added to cart successfully!");
                } else {
                    session.setAttribute("error", "Failed to add item to cart");
                }
            } finally {
                cartDAO.close();
            }
            
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid number format: " + e.getMessage());
        } catch (IllegalArgumentException e) {
            session.setAttribute("error", e.getMessage());
        } catch (Exception e) {
            session.setAttribute("error", "System error: " + e.getMessage());
        }
        
        response.sendRedirect(request.getHeader("referer"));
    }
    
    private int validateAndParseInt(String value, String fieldName) {
        if (value == null || value.trim().isEmpty()) {
            throw new IllegalArgumentException(fieldName + " is required");
        }
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Invalid " + fieldName + " format");
        }
    }
    
    private double validateAndParseDouble(String value, String fieldName) {
        if (value == null || value.trim().isEmpty()) {
            throw new IllegalArgumentException(fieldName + " is required");
        }
        try {
            return Double.parseDouble(value);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Invalid " + fieldName + " format");
        }
    }
    
    private String validateString(String value, String fieldName) {
        if (value == null || value.trim().isEmpty()) {
            throw new IllegalArgumentException(fieldName + " is required");
        }
        return value.trim();
    }
}