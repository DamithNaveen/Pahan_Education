<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin - Customer Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/PublicArea/css/styles.css">
    <style>
        body { 
            font-family: Arial, sans-serif; 
            background: #f4f6f9; 
            padding: 20px; 
            margin: 0;
        }
        .container { 
            max-width: 1400px; 
            margin: auto; 
            background: #fff; 
            padding: 20px; 
            border-radius: 6px; 
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h2 { 
            text-align: center; 
            margin-bottom: 20px; 
            color: #333;
        }
        table { 
            width: 100%; 
            border-collapse: collapse; 
            margin-top: 20px; 
            font-size: 14px;
            color: #000000;
        }
        th, td { 
            padding: 12px; 
            border: 1px solid #ddd; 
            text-align: left; 
            color: #000000;
        }
        th { 
            background: #f8f9fa; 
            font-weight: bold;
            color: #000000;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .actions a {
            margin: 0 5px;
            text-decoration: none;
            padding: 6px 12px;
            border-radius: 4px;
            color: #fff;
            font-size: 12px;
            display: inline-block;
        }
        .view { background: #007bff; }
        .update { background: #28a745; }
        .delete { background: #dc3545; }
        .back-link { 
            display: inline-block; 
            margin-bottom: 20px; 
            padding: 10px 15px; 
            background: #6c757d; 
            color: white; 
            text-decoration: none; 
            border-radius: 4px; 
        }
        .back-link:hover {
            background: #5a6268;
        }
        .alert {
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 4px;
            font-weight: bold;
        }
        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .no-data {
            text-align: center;
            padding: 40px;
            background: #f8f9fa;
            border-radius: 5px;
            color: #6c757d;
        }
        .debug-info {
            background: #e9ecef;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 15px;
            font-family: monospace;
            font-size: 12px;
        }
        .actions {
    display: flex;
    gap: 8px;
}

.actions .btn {
    padding: 6px 14px;
    border-radius: 4px;
    font-size: 13px;
    font-weight: 600;
    text-decoration: none;
    color: #fff;
    transition: background 0.3s ease, transform 0.2s ease;
}

.actions .btn:hover {
    transform: scale(1.05);
}

.actions .view {
    background-color: #007bff;
}
.actions .view:hover {
    background-color: #0056b3;
}

.actions .update {
    background-color: #28a745;
}
.actions .update:hover {
    background-color: #1e7e34;
}

.actions .delete {
    background-color: #dc3545;
}
.actions .delete:hover {
    background-color: #a71d2a;
}
        
    </style>
</head>
<body>
<div class="container">
    <a href="${pageContext.request.contextPath}/AdminArea/adminDashboard.jsp" class="back-link">← Back to Dashboard</a>
    <h2>Customer Management</h2>

    <!-- Debug Information -->
    <div class="debug-info">
        Customers attribute: ${not empty customers ? 'EXISTS' : 'NULL'}<br>
        Customers size: ${not empty customers ? customers.size() : 0}<br>
        Servlet: ${pageContext.request.servletPath}
    </div>

    <!-- Success Message -->
    <c:if test="${not empty sessionScope.message}">
        <div class="alert alert-success">
            ${sessionScope.message}
            <c:remove var="message" scope="session"/>
        </div>
    </c:if>
    
    <!-- Error Message -->
    <c:if test="${not empty sessionScope.error}">
        <div class="alert alert-error">
            ${sessionScope.error}
            <c:remove var="error" scope="session"/>
        </div>
    </c:if>

    <c:choose>
        <c:when test="${not empty customers}">
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Address</th>
                    <th>Total Orders</th>
                    <th>Total Spent</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${customers}" var="customer">
                    <tr>
                        <td>${customer.id}</td>
                        <td>${customer.username}</td>
                        <td>${customer.fullName}</td>
                        <td>${customer.email}</td>
                        <td>${customer.phone != null ? customer.phone : 'N/A'}</td>
                        <td>${customer.address != null ? customer.address : 'N/A'}</td>
                        <td>${customer.orderCount}</td>
                        <td>Rs. <fmt:formatNumber value="${customer.totalSpent}" pattern="#,##0.00"/></td>
                        <td class="actions">
                            <<div class="actions">
                                <a href="${pageContext.request.contextPath}/AdminCustomerServlet?action=edit&id=${customer.id}" class="btn update">Edit</a>
                                <a href="${pageContext.request.contextPath}/AdminCustomerServlet?action=delete&id=${customer.id}" class="btn delete"
                                   onclick="return confirm('Are you sure you want to delete customer: ${customer.username}? All associated orders will also be deleted.');">Delete</a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <div class="no-data">
                <p>No customers found in the system.</p>
                <p>Customers will appear here once they register through the signup page.</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
    // Auto-hide messages after 5 seconds
    setTimeout(function() {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            alert.style.transition = 'opacity 0.5s ease';
            alert.style.opacity = '0';
            setTimeout(() => alert.remove(), 500);
        });
    }, 5000);
</script>
</body>
</html>