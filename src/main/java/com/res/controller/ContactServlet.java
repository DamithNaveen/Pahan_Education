package com.res.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        // Validate input (optional but recommended)
        if (fullName == null || fullName.isEmpty() || 
            phone == null || phone.isEmpty() || 
            email == null || email.isEmpty() || 
            message == null || message.isEmpty()) {
            // If validation fails, redirect back with error
            response.sendRedirect(request.getContextPath() + "/contact.jsp?error=Please+fill+all+fields");
            return;
        }

        // Create a message string
        String fullMessage = "Name: " + fullName + ", Phone: " + phone + ", Email: " + email + ", Message: " + message;

        // Get or create the messages list in the servlet context
        ServletContext context = getServletContext();
        List<String> messages = (List<String>) context.getAttribute("messages");
        if (messages == null) {
            messages = new ArrayList<>();
        }
        messages.add(fullMessage);
        context.setAttribute("messages", messages);

        // Redirect back to the contact page with a success flag
        response.sendRedirect(request.getContextPath() + "/contact.jsp?success=true");
    }

    // Optional: override doGet to redirect to contact page or show a message
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/contact.jsp");
    }
}
