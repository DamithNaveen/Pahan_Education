<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Customer - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/PublicArea/css/styles.css">
    <style>
        body { font-family: Arial, sans-serif; background: #f4f6f9; padding: 20px; }
        .container { max-width: 800px; margin: auto; background: #fff; padding: 30px; border-radius: 8px; }
        h2 { text-align: center; margin-bottom: 30px; color: #333; }
        .customer-details { margin-bottom: 30px; }
        .detail-row { display: flex; margin-bottom: 15px; padding: 12px; background: #f8f9fa; border-radius: 5px; }
        .detail-label { font-weight: bold; width: 150px; color: #495057; }
        .detail-value { flex: 1; color: #212529; }
        .back-link { 
            display: inline-block; 
            margin-bottom: 20px; 
            padding: 10px 15px; 
            background: #6c757d; 
            color: white; 
            text-decoration: none; 
            border-radius: 4px; 
        }
        .action-buttons { text-align: center; margin-top: 30px; }
        .action-buttons a {
            margin: 0 10px;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            color: white;
        }
        .edit-btn { background: #ffc107; }
        .delete-btn { background: #dc3545; }
        .back-btn { background: #6c757d; }
    </style>
</head>
<body>
<div class="container">
    <a href="${pageContext.request.contextPath}/AdminCustomerServlet" class="back-link">← Back to Customers</a>
    
    <h2>Customer Details</h2>
    
    <c:if test="${not empty customer}">
        <div class="customer-details">
            <div class="detail-row">
                <span class="detail-label">Customer ID:</span>
                <span class="detail-value">${customer.id}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Username:</span>
                <span class="detail-value">${customer.username}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Full Name:</span>
                <span class="detail-value">${customer.fullName}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Email:</span>
                <span class="detail-value">${customer.email}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Phone:</span>
                <span class="detail-value">${customer.phone}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Address:</span>
                <span class="detail-value">${customer.address}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Total Orders:</span>
                <span class="detail-value">${customer.orderCount}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Total Spent:</span>
                <span class="detail-value">Rs. ${customer.totalSpent}</span>
            </div>
        </div>
        
        <div class="action-buttons">
            <a href="AdminCustomerServlet?action=edit&id=${customer.id}" class="edit-btn">Edit Customer</a>
            <a href="AdminCustomerServlet?action=delete&id=${customer.id}" class="delete-btn"
               onclick="return confirm('Are you sure you want to delete this customer?');">Delete Customer</a>
            <a href="AdminCustomerServlet" class="back-btn">Back to List</a>
        </div>
    </c:if>
    
    <c:if test="${empty customer}">
        <div style="text-align: center; padding: 40px; color: #dc3545;">
            <h3>Customer not found</h3>
            <p>The requested customer could not be found.</p>
            <a href="AdminCustomerServlet" class="back-btn">Back to Customers</a>
        </div>
    </c:if>
</div>
</body>
</html>