<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>The Bookshelf - Shop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/PublicArea/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/PublicArea/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/PublicArea/css/shop.css">
</head>
<body>
    <jsp:include page="header.jsp" />

    
  
    <section class="products_cont" id="products">
    <h2 class="section-title">Featured Books</h2>
    <div class="pro_box_cont">
        <!-- Product 1 -->
        <div class="pro_box">
            <img src="${pageContext.request.contextPath}/images/book1.jpg" alt="Book Cover">
            <h3>The Great Gatsby</h3>
            <p>Rs. 1200/-</p>
            <form action="${pageContext.request.contextPath}/AddToCartServlet" method="post" class="product-form">
                <input type="number" name="quantity" min="1" value="1">
                <input type="hidden" name="book_id" value="1">
                <input type="hidden" name="book_name" value="The Great Gatsby">
                <input type="hidden" name="price" value="1200">
                <input type="hidden" name="image" value="book1.jpg">
                <button type="submit" class="product_btn">Add to Cart</button>
            </form>
        </div>
        
        <!-- Product 2 -->
        <div class="pro_box">
            <img src="${pageContext.request.contextPath}/images/book2.jpg" alt="Book Cover">
            <h3>To Kill a Mockingbird</h3>
            <p>Rs. 950/-</p>
            <form action="${pageContext.request.contextPath}/AddToCartServlet" method="post" class="product-form">
                <input type="number" name="quantity" min="1" value="1">
                <input type="hidden" name="book_id" value="2">
                <input type="hidden" name="book_name" value="To Kill a Mockingbird">
                <input type="hidden" name="price" value="950">
                <input type="hidden" name="image" value="book2.jpg">
                <button type="submit" class="product_btn">Add to Cart</button>
            </form>
        </div>
        
        <!-- Product 3 -->
        <div class="pro_box">
            <img src="${pageContext.request.contextPath}/images/book3.jpg" alt="Book Cover">
            <h3>The Psychology of Money</h3>
            <p>Rs. 1150/-</p>
            <form action="${pageContext.request.contextPath}/AddToCartServlet" method="post" class="product-form">
                <input type="number" name="quantity" min="1" value="1">
                <input type="hidden" name="book_id" value="3">
                <input type="hidden" name="book_name" value="The Psychology of Money">
                <input type="hidden" name="price" value="1150">
                <input type="hidden" name="image" value="book3.jpg">
                <button type="submit" class="product_btn">Add to Cart</button>
            </form>
        </div>
        
        <button class="see-more-btn product_btn" id="seeMoreBtn">See More</button>
    </div>
</section>

    <jsp:include page="footer.jsp" />

    <script src="${pageContext.request.contextPath}/PublicArea/js/shop.js"></script>
</body>
</html>