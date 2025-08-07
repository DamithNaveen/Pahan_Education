<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>The Bookshelf - Explore Our Collection</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/PublicArea/css/styles.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/PublicArea/css/cart.css">
<title>Your Shopping Cart</title>

<jsp:include page="header.jsp" />
</head>
<body>

<!-- Popup alert for message -->
<c:if test="${not empty message}">
    <script>
        alert("${message}");
    </script>
    <c:remove var="message" scope="session"/>
</c:if>

<!-- Popup alert for error -->
<c:if test="${not empty error}">
    <script>
        alert("${error}");
    </script>
    <c:remove var="error" scope="session"/>
</c:if>

<div class="container cart-container">
    <h2 class="mb-4">Your Shopping Cart</h2>

    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show">
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="message" scope="session"/>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show">
            ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="error" scope="session"/>
    </c:if>

    <c:choose>
        <c:when test="${empty cartItems}">
            <div class="alert alert-info text-center py-5">
                <h4>Your cart is empty</h4>
                <a href="${pageContext.request.contextPath}/shop.jsp" class="btn btn-primary mt-3">
                    Continue Shopping
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="table-responsive">
                <table class="table table-bordered align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Product</th>
                            <th class="text-end">Price</th>
                            <th>Quantity</th>
                            <th class="text-end">Total</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${cartItems}" var="item">
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <img src="${pageContext.request.contextPath}/images/${item.image}" 
                                             class="cart-img me-3" 
                                             alt="${item.bookName}">
                                        <div>
                                            <h5 class="mb-1">${item.bookName}</h5>
                                            <small class="text-muted">ID: ${item.bookId}</small>
                                        </div>
                                    </div>
                                </td>
                                <td class="text-end">Rs. ${item.price}</td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/UpdateCartServlet" method="post" class="d-flex gap-2">
                                        <input type="number" name="quantity" 
                                               value="${item.quantity}" 
                                               min="1" 
                                               class="form-control quantity-input">
                                        <input type="hidden" name="book_id" value="${item.bookId}">
                                        <button type="submit" class="btn btn-sm btn-outline-primary">
                                            Update
                                        </button>
                                    </form>
                                </td>
                                <td class="text-end">Rs. ${item.price * item.quantity}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/RemoveFromCartServlet?book_id=${item.bookId}" 
                                       class="btn btn-sm btn-outline-danger"
                                       onclick="return confirm('Remove this item from cart?')">
                                        Remove
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot class="table-active">
                        <tr>
                            <td colspan="3" class="text-end fw-bold">Grand Total:</td>
                            <td class="text-end fw-bold">Rs. ${cartTotal}</td>
                            <td></td>
                        </tr>
                    </tfoot>
                </table>
            </div>

            <div class="d-flex justify-content-between mt-4">
                <a href="${pageContext.request.contextPath}/PublicArea/shop.jsp" class="btn btn-outline-secondary">
                    Continue Shopping
                </a>
                <a href="${pageContext.request.contextPath}/PublicArea/checkout.jsp" class="btn btn-success">
                    Proceed to Checkout
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="footer.jsp" />

<script>
    // Auto-hide alerts after 5 seconds
    setTimeout(() => {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            new bootstrap.Alert(alert).close();
        });
    }, 5000);
</script>
</body>
</html>
