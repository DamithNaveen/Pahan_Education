package com.res.controller;

import com.res.dao.OrderDAO;
import com.res.model.Order;
import com.res.model.CartItem;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/AdminOrderServlet")
public class AdminOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try (OrderDAO orderDAO = new OrderDAO()) {
            if (action == null) action = "";

            switch (action) {
                case "view" -> viewOrder(request, response, orderDAO);
                case "edit" -> showEditForm(request, response, orderDAO);
                case "delete" -> deleteOrder(request, response, orderDAO);
                case "confirm" -> confirmOrder(request, response, orderDAO);
                default -> listOrders(request, response, orderDAO);
            }
        } catch (SQLException e) {
            handleError(response, "Database error: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try (OrderDAO orderDAO = new OrderDAO()) {
            if ("update".equals(action)) {
                updateOrder(request, response, orderDAO);
            } else {
                listOrders(request, response, orderDAO);
            }
        } catch (SQLException e) {
            handleError(response, "Database error: " + e.getMessage());
        }
    }

    private void listOrders(HttpServletRequest request, HttpServletResponse response, OrderDAO orderDAO)
            throws ServletException, IOException, SQLException {

        String status = request.getParameter("status");
        String dateFrom = request.getParameter("dateFrom");
        String dateTo = request.getParameter("dateTo");
        int page = parseIntOrDefault(request.getParameter("page"), 1);
        int recordsPerPage = 10;

        List<Order> orders = orderDAO.getOrders(status, dateFrom, dateTo,
                (page - 1) * recordsPerPage, recordsPerPage);
        int totalRecords = orderDAO.getTotalOrderCount(status, dateFrom, dateTo);
        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

        request.setAttribute("orders", orders);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalRecords", totalRecords);

        forward(request, response, "/AdminArea/orders.jsp");
    }

    private void viewOrder(HttpServletRequest request, HttpServletResponse response, OrderDAO orderDAO)
            throws ServletException, IOException, SQLException {
        int orderId = parseIntOrDefault(request.getParameter("id"), -1);
        Order order = orderDAO.getOrderById(orderId);

        if (order != null) {
            List<CartItem> orderItems = orderDAO.getOrderItems(orderId);
            request.setAttribute("order", order);
            request.setAttribute("orderItems", orderItems);
            forward(request, response, "/AdminArea/view-order.jsp");
        } else {
            redirectWithError(response, "Order not found");
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response, OrderDAO orderDAO)
            throws ServletException, IOException, SQLException {
        int orderId = parseIntOrDefault(request.getParameter("id"), -1);
        Order order = orderDAO.getOrderById(orderId);

        if (order != null) {
            request.setAttribute("order", order);
            forward(request, response, "/AdminArea/edit-order.jsp");
        } else {
            redirectWithError(response, "Order not found");
        }
    }

    private void confirmOrder(HttpServletRequest request, HttpServletResponse response, OrderDAO orderDAO)
            throws IOException, SQLException {
        int orderId = parseIntOrDefault(request.getParameter("id"), -1);
        boolean success = orderDAO.updateOrderStatus(orderId, "Completed");
        if (success) redirectWithMessage(response, "Order confirmed successfully");
        else redirectWithError(response, "Failed to confirm order");
    }

    private void updateOrder(HttpServletRequest request, HttpServletResponse response, OrderDAO orderDAO)
            throws IOException, SQLException {
        int orderId = parseIntOrDefault(request.getParameter("orderId"), -1);
        String status = request.getParameter("status");
        boolean success = orderDAO.updateOrderStatus(orderId, status);

        if (success) redirectWithMessage(response, "Order updated successfully");
        else redirectWithError(response, "Failed to update order");
    }

    private void deleteOrder(HttpServletRequest request, HttpServletResponse response, OrderDAO orderDAO)
            throws IOException, SQLException {
        int orderId = parseIntOrDefault(request.getParameter("id"), -1);
        boolean success = orderDAO.deleteOrder(orderId);

        if (success) redirectWithMessage(response, "Order deleted successfully");
        else redirectWithError(response, "Failed to delete order");
    }

    // Helpers
    private void forward(HttpServletRequest request, HttpServletResponse response, String path)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher(path);
        dispatcher.forward(request, response);
    }

    private void redirectWithError(HttpServletResponse response, String errorMessage) throws IOException {
        response.sendRedirect("AdminOrderServlet?error=" + encodeURL(errorMessage));
    }

    private void redirectWithMessage(HttpServletResponse response, String message) throws IOException {
        response.sendRedirect("AdminOrderServlet?message=" + encodeURL(message));
    }

    private String encodeURL(String value) {
        return value.replace(" ", "+");
    }

    private int parseIntOrDefault(String value, int defaultValue) {
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private void handleError(HttpServletResponse response, String message) throws IOException {
        response.sendRedirect("AdminOrderServlet?error=" + encodeURL(message));
    }
}
