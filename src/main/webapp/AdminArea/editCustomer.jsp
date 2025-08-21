<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.res.model.Customer" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Customer</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
    }
    h1 {
        color: #333;
    }
    .form-container {
        max-width: 600px;
        margin: 0 auto;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 5px;
        background-color: #f9f9f9;
    }
    .form-group {
        margin-bottom: 15px;
    }
    label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
    }
    input[type="text"],
    input[type="password"],
    input[type="email"],
    textarea {
        width: 100%;
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-sizing: border-box;
    }
    .btn {
        padding: 8px 15px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        text-decoration: none;
        display: inline-block;
    }
    .btn-cancel {
        background-color: #f44336;
    }
    .message {
        padding: 10px;
        margin-bottom: 15px;
        border-radius: 4px;
    }
    .error {
        background-color: #f2dede;
        color: #a94442;
    }
</style>
</head>
<body>
    <div class="form-container">
        <h1>Edit Customer</h1>
        
        <% if (request.getSession().getAttribute("error") != null) { %>
            <div class="message error">
                <%= request.getSession().getAttribute("error") %>
            </div>
            <% request.getSession().removeAttribute("error"); %>
        <% } %>
        
        <% Customer customer = (Customer) request.getAttribute("customer"); 
           if (customer != null) { %>
            <form action="<%= request.getContextPath() %>/admin/editCustomer" method="post">
                <input type="hidden" name="id" value="<%= customer.getId() %>">
                
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username" value="<%= customer.getUsername() %>" required>
                </div>
                
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" value="<%= customer.getPassword() %>" required>
                </div>
                
                <div class="form-group">
                    <label for="fullName">Full Name:</label>
                    <input type="text" id="fullName" name="fullName" value="<%= customer.getFullName() %>" required>
                </div>
                
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="<%= customer.getEmail() %>" required>
                </div>
                
                <div class="form-group">
                    <label for="phone">Phone:</label>
                    <input type="text" id="phone" name="phone" value="<%= customer.getPhone() != null ? customer.getPhone() : "" %>">
                </div>
                
                <div class="form-group">
                    <label for="address">Address:</label>
                    <textarea id="address" name="address" rows="3"><%= customer.getAddress() != null ? customer.getAddress() : "" %></textarea>
                </div>
                
                <div class="form-group">
                    <button type="submit" class="btn">Update Customer</button>
                    <a href="<%= request.getContextPath() %>/admin/customers" class="btn btn-cancel">Cancel</a>
                </div>
            </form>
        <% } else { %>
            <p>Customer not found.</p>
            <a href="<%= request.getContextPath() %>/admin/customers" class="btn">Back to List</a>
        <% } %>
    </div>
</body>
</html>