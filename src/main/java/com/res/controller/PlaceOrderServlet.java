package com.res.controller;

import com.res.dao.CartDAO;
import com.res.model.CartItem;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String number = request.getParameter("number");
        String email = request.getParameter("email");
        String method = request.getParameter("method");
        String address = request.getParameter("address");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("PublicArea/signIn.jsp");
            return;
        }

        String userId = session.getAttribute("user_id").toString();

        try (CartDAO cartDAO = new CartDAO()) {
            List<CartItem> cartItems = cartDAO.getCartItems(userId);

            if (cartItems.isEmpty()) {
                request.setAttribute("error", "Your cart is empty");
                request.getRequestDispatcher("/PublicArea/cart.jsp").forward(request, response);
                return;
            }

            double totalPrice = cartItems.stream()
                    .mapToDouble(item -> item.getPrice() * item.getQuantity())
                    .sum();

            String orderDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());

            // Save order to database
            boolean orderSaved = cartDAO.saveOrder(userId, name, number, email, method, 
                                                  address, totalPrice, orderDate, "Pending");

            if (orderSaved) {
                // Clear cart after successful order
                cartDAO.clearCart(userId);

                // Store in session for current view
                session.setAttribute("orderDate", orderDate);
                session.setAttribute("name", name);
                session.setAttribute("number", number);
                session.setAttribute("email", email);
                session.setAttribute("address", address);
                session.setAttribute("method", method);
                session.setAttribute("cartItems", cartItems);
                session.setAttribute("totalPrice", totalPrice);
                session.setAttribute("paymentStatus", "Pending");
                session.setAttribute("successMessage", "Your order has been placed successfully!");

                response.sendRedirect(request.getContextPath() + "/PublicArea/order.jsp?success=true");
            } else {
                request.setAttribute("error", "Failed to save order. Please try again.");
                request.getRequestDispatcher("/PublicArea/checkout.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while placing the order.");
            request.getRequestDispatcher("/PublicArea/cart.jsp").forward(request, response);
        }
    }
}