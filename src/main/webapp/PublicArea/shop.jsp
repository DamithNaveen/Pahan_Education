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

    <section class="shop-container">
        <div class="category-sidebar">
            <h3 class="section-title">Categories</h3>
            <ul class="category-list">
                <li><a href="#" class="category-link active" data-category="all">All Books</a></li>
                <li><a href="#" class="category-link" data-category="al">A/L Books</a></li>
                <li><a href="#" class="category-link" data-category="ol">O/L Books</a></li>
                <li><a href="#" class="category-link" data-category="grade5">Grade 5</a></li>
                <li><a href="#" class="category-link" data-category="story">Story Books</a></li>
                <li><a href="#" class="category-link" data-category="novel">Novels</a></li>
            </ul>
        </div>

        <div class="products-section">
            <h2 class="section-title">Our Collection</h2>
            <div class="pro_box_cont" id="productsContainer">
                <c:forEach var="book" items="${books}">
                    <div class="pro_box" data-category="${book.category}">
                        <img src="${pageContext.request.contextPath}/images/${book.image}" alt="${book.title}">
                        <h3>${book.title}</h3>
                        <p>Rs. ${book.price}/-</p>
                        <form action="cart" method="post">
                            <input type="number" name="product_quantity" min="1" value="1">
                            <input type="hidden" name="product_name" value="${book.title}">
                            <input type="hidden" name="product_price" value="${book.price}">
                            <input type="hidden" name="product_image" value="${book.image}">
                            <input type="submit" value="Add to Cart" name="add_to_cart" class="product_btn">
                        </form>
                    </div>
                </c:forEach>
            </div>
        </div>
    </section>

    <jsp:include page="footer.jsp" />

    <script src="${pageContext.request.contextPath}/PublicArea/js/shop.js"></script>
</body>
</html>