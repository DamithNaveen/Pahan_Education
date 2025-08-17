<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>The Bookshelf - Checkout</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/PublicArea/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/PublicArea/css/home.css">
    <style>
        /* Popup Styles */
        .popup-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }
        
        .popup-content {
            background: white;
            padding: 30px;
            border-radius: 8px;
            max-width: 500px;
            width: 90%;
            text-align: center;
            box-shadow: 0 0 20px rgba(0,0,0,0.2);
            animation: popupFadeIn 0.3s ease-out;
        }
        
        @keyframes popupFadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .popup-content .btn-close {
            margin-top: 20px;
            padding: 8px 20px;
            background: #28a745;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background 0.2s;
        }
        
        .popup-content .btn-close:hover {
            background: #218838;
        }
        
        /* Error Message Styles */
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
            text-align: center;
        }
        
        /* Main Content Styles */
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        
        section {
            max-width: 700px;
            margin: 40px auto;
            background: #fff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
        }
        
        .product-preview {
            display: flex;
            align-items: center;
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 25px;
            background: #fafafa;
            transition: transform 0.2s;
        }
        
        .product-preview:hover {
            transform: translateY(-2px);
        }
        
        .product-image {
            width: 90px;
            height: 120px;
            border: 1px solid #ccc;
            object-fit: contain;
            margin-right: 20px;
        }
        
        .product-details {
            flex: 1;
        }
        
        .product-details h3 {
            margin: 0 0 5px 0;
            font-size: 18px;
            color: #333;
        }
        
        .product-details p {
            margin: 4px 0;
            font-size: 14px;
            color: #555;
        }
        
        form input[type="text"],
        form input[type="email"],
        form input[type="tel"],
        form select,
        form textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            font-size: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            transition: border 0.2s;
        }
        
        form input:focus,
        form select:focus,
        form textarea:focus {
            border-color: #28a745;
            outline: none;
        }
        
        .product_btn {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background 0.2s;
        }
        
        .product_btn:hover {
            background-color: #218838;
        }
        
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp" />

<!-- Success Popup -->
<div id="orderPopup" class="popup-overlay">
    <div class="popup-content">
        <h3><i class="fas fa-check-circle" style="color: #28a745;"></i> Order Confirmation</h3>
        <p id="popupMessage">Your order has been placed successfully!</p>
        <button class="btn-close" onclick="closePopupAndRedirect()">View Order Details</button>
    </div>
</div>

<section>
    <!-- Error message display -->
    <c:if test="${not empty error}">
        <div class="error-message">
            <i class="fas fa-exclamation-circle"></i> ${error}
        </div>
    </c:if>

    <!-- Product Preview from Cart -->
    <c:forEach items="${cartItems}" var="item">
        <div class="product-preview">
            <img src="${pageContext.request.contextPath}/images/${item.image}" alt="${item.bookName}" class="product-image">
            <div class="product-details">
                <h3>${item.bookName}</h3>
                <p>Price: Rs. ${item.price}</p>
                <p>Quantity: ${item.quantity}</p>
                <p>Total: Rs. ${item.price * item.quantity}</p>
            </div>
        </div>
    </c:forEach>

    <!-- Order Form -->
    <form id="orderForm" action="${pageContext.request.contextPath}/PlaceOrderServlet" method="post">
        <h2>Add Your Details</h2>

        <input type="text" name="name" required placeholder="Enter your name" value="${param.name}">
        <input type="tel" name="number" required placeholder="Enter your phone number" value="${param.number}">
        <input type="email" name="email" required placeholder="Enter your email" value="${param.email}">

        <select name="method" required>
            <option value="">Select payment method</option>
            <option value="cash on delivery" ${param.method == 'cash on delivery' ? 'selected' : ''}>Cash on Delivery</option>
            <option value="credit card" ${param.method == 'credit card' ? 'selected' : ''}>Credit Card</option>
            <option value="debit card" ${param.method == 'debit card' ? 'selected' : ''}>Debit Card</option>
        </select>

        <textarea name="address" placeholder="Enter your full address" rows="4" required>${param.address}</textarea>

        <input type="submit" value="Place Your Order" name="order_btn" class="product_btn">
    </form>
</section>

<jsp:include page="footer.jsp" />

<script>
    // Check for success message in URL parameters
    document.addEventListener('DOMContentLoaded', function() {
        const urlParams = new URLSearchParams(window.location.search);
        if(urlParams.has('success') && urlParams.get('success') === 'true') {
            showPopup("Your order has been placed successfully!");
            // Clear the success parameter from URL
            history.replaceState(null, '', window.location.pathname);
        }
    });

    // Popup functions
    function showPopup(message) {
        document.getElementById('popupMessage').textContent = message;
        document.getElementById('orderPopup').style.display = 'flex';
    }

    function closePopupAndRedirect() {
        document.getElementById('orderPopup').style.display = 'none';
        window.location.href = '${pageContext.request.contextPath}/PublicArea/order.jsp';
    }
</script>
</body>
</html>