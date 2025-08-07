<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>The Bookshelf - Explore Our Collection</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/PublicArea/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/PublicArea/css/home.css">
    <style>
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
        }

        .product_btn:hover {
            background-color: #218838;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp" />
<section>
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
    <form action="${pageContext.request.contextPath}/PlaceOrderServlet" method="post">

        <h2>Add Your Details</h2>

        <input type="text" name="name" required placeholder="Enter your name">
        <input type="tel" name="number" required placeholder="Enter your number">
        <input type="email" name="email" required placeholder="Enter your email">

        <select name="method" required>
            <option value="">Select payment method</option>
            <option value="cash on delivery">Cash on Delivery</option>
            
        </select>

        <textarea name="address" placeholder="Enter your address" rows="4" required></textarea>

        <input type="submit" value="Place Your Order" name="order_btn" class="product_btn">
    </form>
</section>

<jsp:include page="footer.jsp" />
</body>
</html>
