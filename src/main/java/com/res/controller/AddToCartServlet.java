package com.res.controller;

import com.res.dao.CartDAO;
import com.res.model.CartItem;
import java.io.IOException;
import java.sql.SQLException;
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
        String userId = (String) session.getAttribute("user_id");
        
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int bookId = Integer.parseInt(request.getParameter("book_id"));
            String bookName = request.getParameter("book_name");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String image = request.getParameter("image");

            CartItem item = new CartItem(userId, bookId, bookName, price, quantity, image);
            CartDAO cartDAO = new CartDAO();
            
            if (cartDAO.addItem(item)) {
                session.setAttribute("cartItems", cartDAO.getCartItems(userId));
                session.setAttribute("message", bookName + " added to cart!");
            } else {
                session.setAttribute("error", "Failed to add item to cart");
            }
            
            cartDAO.close();
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid product data");
        } catch (SQLException e) {
            session.setAttribute("error", "Database error occurred");
            e.printStackTrace();
        }
        
        response.sendRedirect(request.getHeader("referer"));
    }
}