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
        }

        table {
            width: 100%;
            margin-top: 15px;
            border-collapse: collapse;
        }

        th, td {
            border-bottom: 1px solid #ccc;
            padding: 10px;
        }

        th {
            background: #f1f1f1;
        }
    </style>
    <jsp:include page="header.jsp" />
</head>
<body>
<div class="container">
    <h2>Thank you for your order!</h2>

    <p><strong>Placed On:</strong> ${orderDate}</p>
    <p><strong>Name:</strong> ${name}</p>
    <p><strong>Number:</strong> ${number}</p>
    <p><strong>Email:</strong> ${email}</p>
    <p><strong>Address:</strong> ${address}</p>
    <p><strong>Payment Method:</strong> ${method}</p>
    <p><strong>Payment Status:</strong> ${paymentStatus}</p>

    <h3>Your Orders:</h3>
    <table>
        <tr>
            <th>Book</th>
            <th>Price (Rs.)</th>
            <th>Qty</th>
            <th>Total</th>
        </tr>
        <c:forEach items="${cartItems}" var="item">
            <tr>
                <td>${item.bookName}</td>
                <td>${item.price}</td>
                <td>${item.quantity}</td>
                <td>${item.price * item.quantity}</td>
            </tr>
        </c:forEach>
    </table>

    <p><strong>Total Price: Rs. ${totalPrice}</strong></p>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>
