package com.res.controller;

import com.res.dao.CartDAO;
import com.res.model.CartItem;
import java.io.IOException;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ViewCartServlet")
public class ViewCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private static final String LOGIN_PAGE = "/PublicArea/signIn.jsp";
    private static final String CART_PAGE = "/cart.jsp";
    private static final String ERROR_PAGE = "/error.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + LOGIN_PAGE);
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
            session.setAttribute("redirect", request.getRequestURI());
            session.setAttribute("error", "Please login to view your cart");
            response.sendRedirect(request.getContextPath() + LOGIN_PAGE);
            return;
        }

        List<CartItem> cartItems = new ArrayList<>();
        double cartTotal = 0.0;

        try (CartDAO cartDAO = new CartDAO()) {
            // Get cart items from database
            cartItems = cartDAO.getCartItems(userId);
            
            // Calculate total
            if (cartItems != null) {
                cartTotal = cartItems.stream()
                    .filter(item -> item != null)
                    .mapToDouble(item -> item.getPrice() * item.getQuantity())
                    .sum();
            }
            
            // Store in session for future requests
            session.setAttribute("cartItems", cartItems);
            
            // Format currency
            NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(Locale.US);
            request.setAttribute("formattedTotal", currencyFormat.format(cartTotal));
            
        } catch (SQLException e) {
            log("Database error in ViewCartServlet", e);
            request.setAttribute("error", "Unable to load your cart. Please try again.");
            request.getRequestDispatcher(ERROR_PAGE).forward(request, response);
            return;
        }

        request.setAttribute("cartItems", cartItems != null ? cartItems : new ArrayList<>());
        request.setAttribute("cartTotal", cartTotal);
        request.getRequestDispatcher(CART_PAGE).forward(request, response);
    }
}