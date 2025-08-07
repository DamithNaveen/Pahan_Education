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

@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            // No session, redirect to login
            response.sendRedirect(request.getContextPath() + "/PublicArea/signIn.jsp");
            return;
        }

        Object userIdObj = session.getAttribute("user_id");
        String userId = null;
        if (userIdObj instanceof Integer) {
            userId = String.valueOf((Integer) userIdObj);
        } else if (userIdObj instanceof String) {
            userId = (String) userIdObj;
        }

        if (userId == null || userId.trim().isEmpty()) {
            // User not logged in
            response.sendRedirect(request.getContextPath() + "/PublicArea/signIn.jsp");
            return;
        }

        String bookIdStr = request.getParameter("book_id");
        String quantityStr = request.getParameter("quantity");

        if (bookIdStr == null || quantityStr == null || bookIdStr.trim().isEmpty() || quantityStr.trim().isEmpty()) {
            session.setAttribute("error", "Invalid update request.");
            response.sendRedirect(request.getContextPath() + "/PublicArea/cart.jsp");
            return;
        }

        try {
            int bookId = Integer.parseInt(bookIdStr.trim());
            int quantity = Integer.parseInt(quantityStr.trim());

            if (quantity < 1) {
                session.setAttribute("error", "Quantity must be at least 1.");
                response.sendRedirect(request.getContextPath() + "/PublicArea/cart.jsp");
                return;
            }

            try (CartDAO cartDAO = new CartDAO()) {
                boolean updated = cartDAO.updateQuantity(userId, bookId, quantity);

                if (updated) {
                    // Reload updated cart items
                    List<CartItem> cartItems = cartDAO.getCartItems(userId);
                    session.setAttribute("cartItems", cartItems);

                    // Recalculate total
                    double cartTotal = cartItems.stream()
                        .mapToDouble(item -> item.getPrice() * item.getQuantity())
                        .sum();

                    session.setAttribute("cartTotal", cartTotal);
                    session.setAttribute("message", "Cart updated successfully.");
                } else {
                    session.setAttribute("error", "Failed to update cart item.");
                }
            }

        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid input format.");
        } catch (SQLException e) {
            session.setAttribute("error", "Database error occurred.");
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/PublicArea/cart.jsp");
    }
}
