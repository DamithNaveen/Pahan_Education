<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>BookShelf</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Base Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        /* Message Notification */
        .message {
            background-color: #f8f9fa;
            border-left: 4px solid #28a745;
            width: 100%;
            z-index: 100000;
            position: fixed;
            top: 0;
            left: 0;
            padding: 15px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .message.error {
            border-left-color: #dc3545;
            background-color: #f8d7da;
        }
        .message span {
            font-size: 1rem;
            color: #212529;
        }
        .message i {
            cursor: pointer;
            color: #6c757d;
            font-size: 1.2rem;
            margin-left: 15px;
            transition: all 0.3s;
        }
        .message i:hover {
            color: #212529;
            transform: scale(1.1);
        }
        
        /* Header Styles */
        header {
            background-color: #ffffff;
            padding: 15px 5%;
            position: sticky;
            top: 0;
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }
        
        /* Logo Styles */
        .logo-cont {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .logo-cont img {
            width: 40px;
            height: 40px;
            object-fit: contain;
        }
        .logo {
            font-size: 1.8rem;
            font-weight: 700;
            color: #343a40;
            text-decoration: none;
            letter-spacing: 0.5px;
        }
        .logo span {
            color: #28a745;
        }
        
        /* Navigation Styles */
        nav {
            display: flex;
            gap: 25px;
            align-items: center;
        }
        nav a {
            color: #495057;
            text-decoration: none;
            font-size: 1rem;
            font-weight: 500;
            transition: all 0.3s;
            position: relative;
            padding: 5px 0;
        }
        nav a:hover {
            color: #28a745;
        }
        nav a:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 2px;
            background-color: #28a745;
            transition: width 0.3s;
        }
        nav a:hover:after {
            width: 100%;
        }
        
        /* Icons and User Controls */
        .icons {
            display: flex;
            gap: 20px;
            align-items: center;
        }
        .icons a, .icons div {
            color: #495057;
            font-size: 1.2rem;
            transition: all 0.3s;
            position: relative;
            cursor: pointer;
        }
        .icons a:hover, .icons div:hover {
            color: #28a745;
            transform: translateY(-2px);
        }
        .quantity {
            position: absolute;
            top: -8px;
            right: -8px;
            background: #dc3545;
            color: white;
            border-radius: 50%;
            width: 18px;
            height: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.7rem;
            font-weight: bold;
        }
        
        /* Login/Register Links */
        .loginorreg {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 0.9rem;
        }
        .loginorreg a {
            text-decoration: none;
            color: #28a745;
            font-weight: 500;
            transition: all 0.3s;
        }
        .loginorreg a:hover {
            color: #218838;
            text-decoration: underline;
        }
        
        /* User Account Dropdown */
        .header_acc_box {
            position: absolute;
            top: 120%;
            right: 2rem;
            background: #ffffff;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            border-radius: 8px;
            padding: 20px;
            display: none;
            animation: fadeIn 0.2s ease-out;
            z-index: 1001;
            width: 250px;
            border: 1px solid #e9ecef;
        }
        @keyframes fadeIn {
            0% {
                opacity: 0;
                transform: translateY(-10px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .header_acc_box p {
            margin-bottom: 12px;
            color: #495057;
            font-size: 0.9rem;
            line-height: 1.5;
        }
        .header_acc_box p span {
            color: #28a745;
            font-weight: 600;
        }
        .delete-btn {
            display: inline-block;
            background-color: #dc3545;
            color: white;
            padding: 8px 15px;
            border-radius: 5px;
            text-decoration: none;
            transition: all 0.3s;
            font-size: 0.9rem;
            width: 100%;
            text-align: center;
            border: none;
            cursor: pointer;
            margin-top: 10px;
        }
        .delete-btn:hover {
            background-color: #c82333;
            transform: translateY(-2px);
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .header_acc_box.active {
            display: block;
        }
        
        /* Mobile Menu Button */
        #menu-btn {
            display: none;
            cursor: pointer;
            font-size: 1.5rem;
            color: #495057;
            transition: all 0.3s;
        }
        #menu-btn:hover {
            color: #28a745;
        }
        
        /* Responsive Styles */
        @media (max-width: 992px) {
            nav {
                gap: 15px;
            }
            .icons {
                gap: 15px;
            }
        }
        
        @media (max-width: 768px) {
            header {
                padding: 15px 3%;
            }
            nav {
                position: fixed;
                top: 70px;
                left: -100%;
                width: 100%;
                background: #ffffff;
                flex-direction: column;
                align-items: center;
                padding: 20px 0;
                gap: 20px;
                transition: all 0.3s ease;
                box-shadow: 0 5px 10px rgba(0,0,0,0.1);
                z-index: 999;
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
            .loginorreg {
                display: none;
            }
        }
    </style>
    
    
    
</head>


<body>
    <c:if test="${not empty message}">
        <div class="message ${fn:contains(message, 'error') ? 'error' : ''}">
            <span>${message}</span>
            <i class="fa-solid fa-xmark" onclick="this.parentElement.remove();"></i>
        </div>
    </c:if>

    <header>
        <div class="logo-cont">
            <img src="${pageContext.request.contextPath}/images/book_logo.png" alt="Book Logo">
            <a href="${pageContext.request.contextPath}/PublicArea/Index.jsp" class="logo">BOOK<span>SHELF</span></a>
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

            <c:choose>
                <c:when test="${empty sessionScope.user_id}">
                    <div class="loginorreg">
                        <a href="${pageContext.request.contextPath}/PublicArea/signIn.jsp">Login</a> | 
                        <a href="${pageContext.request.contextPath}/PublicArea/signUp.jsp">Register</a>
                    </div>
                </c:when>
            </c:choose>
            
            <c:choose>
                <c:when test="${not empty sessionScope.user_id}">
                    <div class="fas fa-user" id="user_btn" title="Account"></div>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/PublicArea/signIn.jsp" class="fas fa-user" title="Login"></a>
                </c:otherwise>
            </c:choose>
            
            <a href="${pageContext.request.contextPath}/PublicArea/cart.jsp">
                <i class="fas fa-shopping-cart"></i>
                <c:if test="${not empty sessionScope.cartCount && sessionScope.cartCount > 0}">
                    <span class="quantity">${sessionScope.cartCount}</span>
                </c:if>
            </a>
            
            <div class="fas fa-bars" id="menu-btn"></div>
        </div>
        
        <c:if test="${not empty sessionScope.user_id}">
            <div class="header_acc_box" id="accountBox">
                <c:choose>
                    <c:when test="${not empty sessionScope.user_name}">
                        <p>Welcome, <span>${sessionScope.user_name}</span></p>
                    </c:when>
                    <c:otherwise>
                        <p>Welcome!</p>
                    </c:otherwise>
                </c:choose>
                
                <c:if test="${not empty sessionScope.user_email}">
                    <p>Email: <span>${sessionScope.user_email}</span></p>
                </c:if>
                
                <a href="${pageContext.request.contextPath}/logout" class="delete-btn">Logout</a>
            </div>
        </c:if>
    </header>

    <script>
        // Mobile menu toggle
        document.getElementById('menu-btn').addEventListener('click', function() {
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
            
            // Close mobile menu when clicking outside
            const navLinks = document.getElementById('nav-links');
            const menuBtn = document.getElementById('menu-btn');
            if (navLinks && menuBtn) {
                if (!navLinks.contains(event.target) && event.target !== menuBtn) {
                    navLinks.classList.remove('active');
                }
            }
        });
    </script>
</body>
</html>