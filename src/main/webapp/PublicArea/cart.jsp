<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Shopping Cart - The Bookshelf</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/PublicArea/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/PublicArea/css/cart.css">
    
    <style>
        .cart-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }
        
        .cart-header {
            margin-bottom: 2rem;
            text-align: center;
        }
        
        .cart-item {
            display: flex;
            align-items: center;
            padding: 1.5rem;
            border-bottom: 1px solid #eee;
            transition: all 0.3s ease;
        }
        
        .cart-item:hover {
            background-color: #f9f9f9;
        }
        
        .cart-item-img {
            width: 100px;
            height: 120px;
            object-fit: cover;
            margin-right: 1.5rem;
            border-radius: 4px;
        }
        
        .cart-item-details {
            flex-grow: 1;
        }
        
        .cart-item-title {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
        
        .cart-item-price {
            font-weight: 500;
            color: #333;
        }
        
        .cart-item-actions {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
        }
        
        .quantity-control {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
        }
        
        .quantity-input {
            width: 60px;
            text-align: center;
            margin: 0 0.5rem;
            padding: 0.375rem;
        }
        
        .remove-btn {
            color: #dc3545;
            background: none;
            border: none;
            cursor: pointer;
            font-size: 1.2rem;
        }
        
        .cart-summary {
            background-color: #f8f9fa;
            padding: 2rem;
            border-radius: 8px;
            margin-top: 2rem;
        }
        
        .cart-total {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
        }
        
        .cart-actions {
            display: flex;
            justify-content: space-between;
        }
        
        .empty-cart {
            text-align: center;
            padding: 3rem 0;
        }
        
        .empty-cart-icon {
            font-size: 3rem;
            color: #6c757d;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="cart-container">
        <div class="cart-header">
            <h1>Your Shopping Cart</h1>
        </div>
        
        <c:choose>
            <c:when test="${empty cartItems || cartItems.size() == 0}">
                <div class="empty-cart">
                    <div class="empty-cart-icon">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    <h3>Your cart is empty</h3>
                    <p>Start shopping to add items to your cart</p>
                    <a href="${pageContext.request.contextPath}/shop.jsp" class="btn btn-primary">Continue Shopping</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="cart-items">
                    <c:forEach var="item" items="${cartItems}">
                        <div class="cart-item">
                            <img src="${pageContext.request.contextPath}/images/${item.image}" 
                                 alt="${item.bookName}" 
                                 class="cart-item-img">
                            
                            <div class="cart-item-details">
                                <h3 class="cart-item-title">${item.bookName}</h3>
                                <p class="cart-item-price">Rs. ${item.price}/-</p>
                            </div>
                            
                            <div class="cart-item-actions">
                                <form action="${pageContext.request.contextPath}/UpdateCartServlet" method="post" class="quantity-control">
                                    <input type="number" name="quantity" 
                                           value="${item.quantity}" 
                                           min="1" 
                                           class="form-control quantity-input">
                                    <input type="hidden" name="book_id" value="${item.bookId}">
                                    <button type="submit" class="btn btn-sm btn-outline-secondary">Update</button>
                                </form>
                                
                                <a href="${pageContext.request.contextPath}/RemoveFromCartServlet?book_id=${item.bookId}" 
                                   class="remove-btn"
                                   onclick="return confirm('Are you sure you want to remove this item?');">
                                    <i class="fas fa-trash-alt"></i> Remove
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <div class="cart-summary">
                    <div class="cart-total">
                        Total: Rs. ${cartTotal}/-
                    </div>
                    
                    <div class="cart-actions">
                        <a href="${pageContext.request.contextPath}/shop.jsp" class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left"></i> Continue Shopping
                        </a>
                        
                        <div>
                            <a href="${pageContext.request.contextPath}/ClearCartServlet" 
                               class="btn btn-danger me-2"
                               onclick="return confirm('Are you sure you want to clear your cart?');">
                                <i class="fas fa-trash"></i> Clear Cart
                            </a>
                            
                            <a href="${pageContext.request.contextPath}/checkout.jsp" class="btn btn-primary">
                                <i class="fas fa-credit-card"></i> Proceed to Checkout
                            </a>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <jsp:include page="footer.jsp" />
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Quantity input validation
        document.querySelectorAll('.quantity-input').forEach(input => {
            input.addEventListener('change', function() {
                if (this.value < 1) {
                    this.value = 1;
                }
            });
        });
    </script>
</body>
</html>