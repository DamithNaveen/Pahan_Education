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
    
    /* Reset default styles */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: "Segoe UI", Arial, sans-serif;
    background: #f5f7fa;
    color: #333;
    padding: 15px;
    line-height: 1.5;
}

/* Container box */
.container {
    max-width: 700px; /* smaller width */
    margin: auto;
    background: #fff;
    padding: 20px; /* reduced padding */
    border-radius: 10px;
    box-shadow: 0 3px 15px rgba(0,0,0,0.08);
}

/* Success heading */
h2 {
    color: #28a745;
    text-align: center;
    margin-bottom: 15px;
    font-size: 24px; /* slightly smaller */
    font-weight: 700;
}

/* Success message */
.success-message {
    background-color: #d4edda;
    color: #155724;
    padding: 12px 15px; /* reduced padding */
    margin-bottom: 20px;
    border-radius: 5px;
    text-align: center;
    font-weight: 600;
    font-size: 15px;
    border: 1px solid #c3e6cb;
}

/* Order details box */
.order-details {
    margin-bottom: 20px;
    padding: 15px; /* reduced padding */
    background: #f9f9f9;
    border-left: 4px solid #28a745;
    border-radius: 6px;
}

.order-details p {
    margin: 6px 0; /* smaller margin */
    font-size: 14px;
}

/* Table styling */
table {
    width: 100%;
    margin-top: 10px;
    border-collapse: collapse;
    background: #fff;
    border-radius: 6px;
    overflow: hidden;
}

table thead {
    background: #28a745;
    color: #fff;
}

th, td {
    padding: 10px; /* reduced padding */
    text-align: left;
    border-bottom: 1px solid #eee;
    font-size: 14px;
}

th {
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

/* Product image + info */
.book-info {
    display: flex;
    align-items: center;
    gap: 10px; /* reduced gap */
}

.book-image {
    width: 50px; /* smaller image */
    height: 70px;
    object-fit: contain;
    border: 1px solid #ddd;
    border-radius: 5px;
    background: #fff;
    padding: 2px;
}

/* Total price box */
.total-price {
    font-size: 16px; /* smaller font */
    font-weight: bold;
    text-align: right;
    margin-top: 20px;
    padding: 12px; /* smaller padding */
    background: #f1f1f1;
    border-radius: 6px;
    border: 1px solid #ddd;
}

/* Responsive design */
@media (max-width: 768px) {
    .book-info {
        flex-direction: column;
        align-items: flex-start;
    }

    .book-image {
        margin-bottom: 5px;
    }

    table, thead, tbody, th, td, tr {
        display: block;
        width: 100%;
    }

    tr {
        margin-bottom: 12px;
    }

    th {
        display: none;
    }

    td {
        padding: 8px;
        border: none;
        border-bottom: 1px solid #eee;
    }

    td:before {
        content: attr(data-label);
        font-weight: 600;
        display: block;
        margin-bottom: 4px;
        color: #555;
    }

    .total-price {
        text-align: center;
    }
}

    
    
    </style>
    
       
</head>
<body>

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
    
           


</body>
</html>