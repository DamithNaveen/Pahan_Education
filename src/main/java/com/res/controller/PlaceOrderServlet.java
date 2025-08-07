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

            double totalPrice = cartItems.stream()
                    .mapToDouble(item -> item.getPrice() * item.getQuantity())
                    .sum();

            String orderDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());

            // Set attributes for order.jsp
            request.setAttribute("orderDate", orderDate);
            request.setAttribute("name", name);
            request.setAttribute("number", number);
            request.setAttribute("email", email);
            request.setAttribute("address", address);
            request.setAttribute("method", method);
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("totalPrice", totalPrice);
            request.setAttribute("paymentStatus", "Pending");

            RequestDispatcher dispatcher = request.getRequestDispatcher("PublicArea/order.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while placing the order.");
            request.getRequestDispatcher("PublicArea/cart.jsp").forward(request, response);
        }
    }
}
