<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    /* Add CSS for the new 'loginorreg' container to style it */
    .loginorreg {
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .loginorreg a {
        text-decoration: none;
        color: #C1121F;
        font-weight: bold;
    }

    /* All other CSS styles from your original code go here */
    /* ... (your existing CSS) ... */

    /* The rest of your CSS remains the same */
    /* Message Notification */
    .message {
        background-color: antiquewhite;
        width: 100%;
        z-index: 100000;
        position: fixed;
        top: 0;
        left: 0;
        margin-bottom: 1rem;
        padding: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .message span {
        font-size: 1rem;
        color: black;
    }
    .message i {
        cursor: pointer;
        color: #C1121F;
        font-size: 1rem;
        margin-left: 15px;
    }
    .message i:hover {
        transform: rotate(90deg);
    }
    header {
        background-color: white;
        padding: 20px 5%;
        position: sticky;
        top: 0;
        z-index: 1000;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    .logo-cont {
        display: flex;
        align-items: center;
        gap: 10px;
    }
    .logo-cont img {
        width: 40px;
        height: 40px;
    }
    .logo {
        font-size: 28px;
        font-weight: bold;
        color: #003049;
        text-decoration: none;
    }
    .logo span {
        color: #C1121F;
    }
    nav {
        display: flex;
        gap: 30px;
    }
    nav a {
        color: #333;
        text-decoration: none;
        font-size: 16px;
        transition: color 0.3s;
        font-weight: 500;
    }
    nav a:hover {
        color: #C1121F;
    }
    .icons {
        display: flex;
        gap: 20px;
        align-items: center;
    }
    .icons a, .icons div {
        color: #333;
        font-size: 20px;
        transition: color 0.3s;
        position: relative;
        cursor: pointer;
    }
    .icons a:hover, .icons div:hover {
        color: #C1121F;
    }
    .quantity {
        position: absolute;
        top: -10px;
        right: -10px;
        background: #C1121F;
        color: white;
        border-radius: 50%;
        width: 20px;
        height: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 12px;
        font-weight: bold;
    }
    #menu-btn {
        display: none;
        cursor: pointer;
        font-size: 24px;
        color: #333;
    }
    .header_acc_box {
        position: absolute;
        top: 120%;
        right: 2rem;
        background: white;
        box-shadow: 0 2px 15px rgba(0,0,0,0.1);
        border-radius: 5px;
        padding: 15px;
        display: none;
        animation: fadeIn 0.2s linear;
        z-index: 1001;
        width: 200px;
        border: 1px solid #eee;
    }
    @keyframes fadeIn {
        0% {
            transform: translateY(-10px);
            opacity: 0;
        }
        100% {
            transform: translateY(0);
            opacity: 1;
        }
    }
    .header_acc_box p {
        margin-bottom: 10px;
        color: #333;
        font-size: 14px;
    }
    .header_acc_box p span {
        color: #C1121F;
        font-weight: bold;
    }
    .delete-btn {
        display: inline-block;
        background-color: #C1121F;
        color: white;
        padding: 8px 15px;
        border-radius: 5px;
        text-decoration: none;
        transition: background 0.3s;
        font-size: 14px;
        width: 100%;
        text-align: center;
    }
    .delete-btn:hover {
        background-color: #A10E1A;
    }
    .header_acc_box.active {
        display: block;
    }
    @media (max-width: 768px) {
        nav {
            position: fixed;
            top: 80px;
            left: -100%;
            width: 100%;
            background: white;
            flex-direction: column;
            align-items: center;
            padding: 20px 0;
            transition: all 0.3s;
            box-shadow: 0 5px 10px rgba(0,0,0,0.1);
        }
        nav.active {
            left: 0;
        }
        #menu-btn {
            display: block;
        }
        .header_acc_box {
            right: 1rem;
        }
    }
</style>

<c:if test="${not empty message}">
    <div class="message">
        <span>${message}</span>
        <i class="fa-solid fa-xmark" onclick="this.parentElement.remove();"></i>
    </div>
</c:if>

<header>
    <div class="logo-cont">
        <img src="${pageContext.request.contextPath}/images/book_logo.png" alt="Book Logo">
        <a href="Index.jsp" class="logo">BOOK<span>SHELF</span></a>
    </div>
    
    <nav id="nav-links">
        <a href="${pageContext.request.contextPath}/PublicArea/Index.jsp">Home</a>
        <a href="${pageContext.request.contextPath}/PublicArea/about.jsp">About</a>
        <a href="${pageContext.request.contextPath}/PublicArea/shop.jsp">Shop</a>
        <a href="${pageContext.request.contextPath}/PublicArea/contact.jsp">Contact</a>
        <a href="${pageContext.request.contextPath}/PublicArea/orders.jsp">Orders</a>
    </nav>
    
    <div class="icons">
        <a href="${pageContext.request.contextPath}/PublicArea/search.jsp"><i class="fas fa-search"></i></a>

        <div class="loginorreg">
  <p> 
    <a href="${pageContext.request.contextPath}/publicAreaArea/signIn.jsp">Login</a> | 
    <a href="${pageContext.request.contextPath}/PublicArea/signUp.jsp">Register</a>
  </p>
</div>
        
        <c:choose>
            <c:when test="${not empty sessionScope.user_id}">
                <div class="fas fa-user" id="user_btn"></div>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/PublicArea/signIn.jsp" class="fas fa-user"></a>
            </c:otherwise>
        </c:choose>
        
        <a href="${pageContext.request.contextPath}/PublicArea/cart.jsp">
            <i class="fas fa-shopping-cart"></i>
            <c:if test="${not empty sessionScope.cartCount && sessionScope.cartCount > 0}">
                <span class="quantity">${sessionScope.cartCount}</span>
            </c:if>
        </a>
        
        <div class="fas fa-bars" id="user_menu_btn"></div>
    </div>
    
    <c:if test="${not empty sessionScope.user_name}">
        <div class="header_acc_box" id="accountBox">
            <p>Username: <span>${sessionScope.user_name}</span></p>
            <p>Email: <span>${sessionScope.user_email}</span></p>
            <a href="${pageContext.request.contextPath}/UserArea/logout.jsp" class="delete-btn">Logout</a>
        </div>
    </c:if>
</header>

<script>
    // Mobile menu toggle
    document.getElementById('user_menu_btn').addEventListener('click', function() {
        document.getElementById('nav-links').classList.toggle('active');
    });
    
    // User account box toggle
    const userBtn = document.getElementById('user_btn');
    const accountBox = document.getElementById('accountBox');
    
    if (userBtn && accountBox) {
        userBtn.addEventListener('click', function() {
            accountBox.classList.toggle('active');
        });
    }
    
    // Close message box when clicking X
    const messageClose = document.querySelector('.message i');
    if (messageClose) {
        messageClose.addEventListener('click', function() {
            this.parentElement.remove();
        });
    }
    
    // Close account box when clicking outside
    document.addEventListener('click', function(event) {
        if (accountBox && userBtn) {
            if (!accountBox.contains(event.target) && event.target !== userBtn) {
                accountBox.classList.remove('active');
            }
        }
    });
</script>