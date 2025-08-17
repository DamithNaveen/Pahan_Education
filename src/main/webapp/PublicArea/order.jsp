<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/PublicArea/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/PublicArea/css/home.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f8f9fa;
            padding: 20px;
        }

        .container {
            max-width: 800px;
            margin: auto;
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        h2 {
            color: #28a745;
            text-align: center;
        }

        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
            text-align: center;
            font-weight: bold;
        }

        table {
            width: 100%;
            margin-top: 15px;
            border-collapse: collapse;
        }

        th, td {
            border-bottom: 1px solid #ccc;
            padding: 10px;
            text-align: left;
            vertical-align: middle;
        }

        th {
            background: #f1f1f1;
        }

        .book-image {
            width: 60px;
            height: 80px;
            object-fit: contain;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-right: 10px;
        }

        .book-info {
            display: flex;
            align-items: center;
        }

        .order-details {
            margin-bottom: 20px;
            padding: 15px;
            background: #f9f9f9;
            border-radius: 5px;
        }

        .order-details p {
            margin: 8px 0;
        }

        .total-price {
            font-size: 18px;
            font-weight: bold;
            text-align: right;
            margin-top: 20px;
            padding: 10px;
            background: #f1f1f1;
            border-radius: 5px;
        }
    </style>
    <jsp:include page="header.jsp" />
</head>
<body>
<div class="container">
    <h2>Thank you for your order!</h2>
    
    <!-- Success Message -->
    <c:if test="${not empty sessionScope.successMessage}">
        <div class="success-message">
            ${sessionScope.successMessage}
        </div>
    </c:if>

    <div class="order-details">
        <p><strong>Order Date:</strong> ${sessionScope.orderDate}</p>
        <p><strong>Name:</strong> ${sessionScope.name}</p>
        <p><strong>Phone Number:</strong> ${sessionScope.number}</p>
        <p><strong>Email:</strong> ${sessionScope.email}</p>
        <p><strong>Delivery Address:</strong> ${sessionScope.address}</p>
        <p><strong>Payment Method:</strong> ${sessionScope.method}</p>
        <p><strong>Payment Status:</strong> ${sessionScope.paymentStatus}</p>
    </div>

    <h3>Your Order Summary</h3>
    <table>
        <thead>
            <tr>
                <th>Book</th>
                <th>Price (Rs.)</th>
                <th>Quantity</th>
                <th>Total</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${sessionScope.cartItems}" var="item">
                <tr>
                    <td>
                        <div class="book-info">
                            <img src="${pageContext.request.contextPath}/images/${item.image}" 
                                 alt="${item.bookName}" class="book-image">
                            <span>${item.bookName}</span>
                        </div>
                    </td>
                    <td>${item.price}</td>
                    <td>${item.quantity}</td>
                    <td>Rs. ${item.price * item.quantity}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div class="total-price">
        <p>Total Price: Rs. ${sessionScope.totalPrice}</p>
    </div>
    
    <div style="text-align: center; margin-top: 30px;">
        <a href="${pageContext.request.contextPath}/ClearOrderServlet" 
           style="padding: 10px 20px; background: #28a745; color: white; text-decoration: none; border-radius: 4px;">
            Return to Home
        </a>
    </div>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>