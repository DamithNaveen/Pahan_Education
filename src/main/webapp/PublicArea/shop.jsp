<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>The Bookshelf - Shop Our Collection</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/PublicArea/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/PublicArea/css/home.css">
    <style>
        .sidebar-section {
            margin-bottom: 30px;
        }
        .sidebar-title {
            font-size: 1.2rem;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ddd;
        }
        .bestseller-item {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }
        .bestseller-item img {
            width: 60px;
            height: 90px;
            object-fit: cover;
            margin-right: 15px;
        }
        .bestseller-item h4 {
            font-size: 1rem;
            margin-bottom: 5px;
        }
        .bestseller-item p {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 5px;
        }
        .rating .fas {
            color: #ffc107; /* Star color */
        }
        .main-content {
            flex: 1;
        }
        .shop-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .sort-options select {
            padding: 8px;
            border-radius: 4px;
            border: 1px solid #ddd;
        }
        .products_cont {
            padding: 2rem;
        }
        .section-title {
            text-align: center;
            margin-bottom: 2rem;
        }
        .pro_box_cont {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 2rem;
        }
        .pro_box {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 1rem;
            transition: transform 0.3s;
        }
        .pro_box:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .pro_box img {
            width: 100%;
            height: 200px;
            object-fit: contain;
            margin-bottom: 1rem;
        }
        .pro_box h3 {
            margin-bottom: 0.5rem;
        }
        .product-form {
            margin-top: 1rem;
        }
        .product_btn {
            background-color: #1d3557;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }
        .product_btn:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }
        .cart-icon {
            position: fixed;
            top: 20px;
            right: 20px;
            background-color: #1d3557;
            color: white;
            padding: 10px 15px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            gap: 5px;
            z-index: 1000;
        }
        .cart-count {
            background-color: #e63946;
            border-radius: 50%;
            padding: 2px 6px;
            font-size: 0.8rem;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp" />

<!-- Success/Error Messages -->
<c:if test="${not empty message}">
    <div class="alert alert-success">${message}</div>
    <c:remove var="message" scope="session"/>
</c:if>
<c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
    <c:remove var="error" scope="session"/>
</c:if>

<!-- Cart Icon -->
<a href="${pageContext.request.contextPath}/PublicArea/cart.jsp" class="cart-icon">
    <i class="fas fa-shopping-cart"></i>
    <span class="cart-count">
        <c:choose>
            <c:when test="${not empty cartItems}">${cartItems.size()}</c:when>
            <c:otherwise>0</c:otherwise>
        </c:choose>
    </span>
</a>

<section class="products_cont" id="products">
    <h2 class="section-title">Featured Books</h2>
    <div class="pro_box_cont">
        <!-- Hardcoded Products -->
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
        
        <!-- Dynamically Added Products from Admin -->
        <c:forEach var="product" items="${productList}">
            <div class="pro_box">
                <c:choose>
                    <c:when test="${not empty product.imagePath}">
                        <img src="${pageContext.request.contextPath}/${product.imagePath}" 
                             alt="${product.productName}">
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/images/default-book.jpg" 
                             alt="Default Book Cover">
                    </c:otherwise>
                </c:choose>
                <h3>${product.productName}</h3>
                <p>Rs. ${product.price}</p>
                <form action="${pageContext.request.contextPath}/AddToCartServlet" method="post" class="product-form">
                    <input type="number" name="quantity" min="1" value="1" max="${product.quantity}">
                    <input type="hidden" name="book_id" value="${product.id}">
                    <input type="hidden" name="book_name" value="${product.productName}">
                    <input type="hidden" name="price" value="${product.price}">
                    <input type="hidden" name="image" value="${product.imagePath}">
                    <button type="submit" class="product_btn" 
                            ${product.quantity <= 0 ? 'disabled' : ''}>
                        ${product.quantity <= 0 ? 'Out of Stock' : 'Add to Cart'}
                    </button>
                </form>
            </div>
        </c:forEach>
    </div>
</section>

<jsp:include page="footer.jsp" />

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Sort functionality
    const sortSelect = document.getElementById('sort-by');
    if (sortSelect) {
        sortSelect.addEventListener('change', function() {
            console.log('Sorting by:', this.value);
            alert('Products would be sorted by: ' + this.options[this.selectedIndex].text);
        });
    }
    
    // Category and price filter links
    const filterLinks = document.querySelectorAll('.category-list a, .price-filter-list a');
    filterLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            console.log('Filtering by:', this.getAttribute('href'));
            alert('Products would be filtered by: ' + this.textContent);
        });
    });
});
</script>
</body>
</html>