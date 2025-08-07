<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Shopping Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .cart-container { max-width: 1200px; margin: 2rem auto; }
        .cart-img { width: 60px; height: 90px; object-fit: cover; margin-right: 15px; }
        .product-cell { display: flex; align-items: center; }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="container cart-container">
        <h2 class="mb-4">Your Shopping Cart</h2>
        
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
            <c:remove var="message" scope="session"/>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
            <c:remove var="error" scope="session"/>
        </c:if>

        <c:choose>
            <c:when test="${empty cartItems}">
                <div class="alert alert-info text-center py-4">
                    <i class="fas fa-shopping-cart fa-3x mb-3"></i>
                    <h4>Your cart is empty</h4>
                    <a href="shop.jsp" class="btn btn-primary mt-2">Continue Shopping</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead class="table-light">
                            <tr>
                                <th>Product</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${cartItems}">
                                <tr>
                                    <td class="product-cell">
                                        <img src="${pageContext.request.contextPath}/images/${item.image}" 
                                             class="cart-img" 
                                             alt="${item.bookName}">
                                        ${item.bookName}
                                    </td>
                                    <td>Rs. ${item.price}</td>
                                    <td>
                                        <form action="UpdateCartServlet" method="post" class="d-flex">
                                            <input type="number" name="quantity" 
                                                   value="${item.quantity}" 
                                                   min="1" 
                                                   class="form-control form-control-sm" 
                                                   style="width: 70px;">
                                            <input type="hidden" name="book_id" value="${item.bookId}">
                                            <button type="submit" class="btn btn-sm btn-outline-primary ms-2">
                                                Update
                                            </button>
                                        </form>
                                    </td>
                                    <td>Rs. ${item.price * item.quantity}</td>
                                    <td>
                                        <a href="RemoveFromCartServlet?book_id=${item.bookId}" 
                                           class="btn btn-sm btn-outline-danger"
                                           onclick="return confirm('Remove this item?')">
                                            <i class="fas fa-trash-alt"></i> Remove
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <div class="d-flex justify-content-between align-items-center mt-4">
                    <a href="shop.jsp" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left"></i> Continue Shopping
                    </a>
                    
                    <div class="text-end">
                        <h4>Grand Total: Rs. ${cartTotal}</h4>
                        <a href="checkout.jsp" class="btn btn-success mt-2">
                            <i class="fas fa-credit-card"></i> Proceed to Checkout
                        </a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <jsp:include page="footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>