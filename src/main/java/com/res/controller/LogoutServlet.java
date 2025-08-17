package com.res.controller;

import com.res.dao.CartDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // No need to save cart here since it's already in database
            session.invalidate();
        }
        
        response.sendRedirect(request.getContextPath() + "/Index.jsp?message=logout_success");
    }
}