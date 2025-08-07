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

@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Object userIdObj = session.getAttribute("user_id");
        String userId = null;

        // Extract user ID safely
        if (userIdObj instanceof Integer) {
            userId = String.valueOf(userIdObj);
        } else if (userIdObj instanceof String) {
            userId = (String) userIdObj;
        }

        if (userId == null || userId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/PublicArea/signIn.jsp");
            return;
        }

        // Validate book ID
        String bookIdStr = request.getParameter("book_id");
        if (bookIdStr == null || bookIdStr.trim().isEmpty()) {
            session.setAttribute("error", "No item specified to remove.");
            response.sendRedirect(request.getContextPath() + "/cart.jsp");
            return;
        }

        try {
            int bookId = Integer.parseInt(bookIdStr.trim());

            try (CartDAO cartDAO = new CartDAO()) {
                boolean removed = cartDAO.removeItem(userId, bookId);

                if (removed) {
                    // Update cart in session
                    List<CartItem> cartItems = cartDAO.getCartItems(userId);
                    session.setAttribute("cartItems", cartItems);

                    double total = cartItems.stream()
                        .mapToDouble(item -> item.getPrice() * item.getQuantity())
                        .sum();
                    session.setAttribute("cartTotal", total);

                    // Set success message
                    session.setAttribute("message", "Item removed successfully!");
                } else {
                    session.setAttribute("error", "Item could not be removed.");
                }
            }
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid product ID.");
        } catch (SQLException e) {
            session.setAttribute("error", "Database error: " + e.getMessage());
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/PublicArea/cart.jsp");
    }
}
