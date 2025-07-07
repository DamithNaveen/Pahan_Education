<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <style>
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

        /* Header Styles */
        header {
            background-color: #111;
            padding: 20px 5%;
            position: sticky;
            top: 0;
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
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
            color: #FFC107;
            text-decoration: none;
        }
        
        .logo span {
            color: white;
        }
        
        nav {
            display: flex;
            gap: 30px;
        }
        
        nav a {
            color: white;
            text-decoration: none;
            font-size: 16px;
            transition: color 0.3s;
        }
        
        nav a:hover {
            color: #FFC107;
        }
        
        .icons {
            display: flex;
            gap: 20px;
            align-items: center;
        }
        
        .icons a {
            color: white;
            font-size: 20px;
            transition: color 0.3s;
            position: relative;
        }
        
        .icons a:hover {
            color: #FFC107;
        }
        
        .quantity {
            position: absolute;
            top: -10px;
            right: -10px;
            background: #FFC107;
            color: #111;
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
            color: white;
        }
        
        /* User Account Box */
        .header_acc_box {
            position: absolute;
            top: 120%;
            right: 2rem;
            background: white;
            box-shadow: 2px 2px 10px grey;
            border-radius: 5px;
            padding: 15px;
            display: none;
            animation: fadeIn 0.2s linear;
            z-index: 1001;
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
            color: #111;
        }
        
        .header_acc_box p span {
            color: #C1121F;
            font-weight: bold;
        }
        
        .delete-btn {
            display: inline-block;
            background-color: #C1121F;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            text-decoration: none;
            transition: background 0.3s;
        }
        
        .delete-btn:hover {
            background-color: #A10E1A;
        }
        
        .header_acc_box.active {
            display: block;
        }
        
        /* Responsive Styles */
        @media (max-width: 768px) {
            nav {
                position: fixed;
                top: 80px;
                left: -100%;
                width: 100%;
                background: #111;
                flex-direction: column;
                align-items: center;
                padding: 20px 0;
                transition: all 0.3s;
            }
            
            nav.active {
                left: 0;
            }
            
            #menu-btn {
                display: block;
            }
            
            .header_acc_box {
                right: 1rem;
                width: 200px;
            }
        }
    </style>
</head>
<body>
    <!-- Message Notification -->
    <c:if test="${not empty message}">
        <div class="message">
            <span>${message}</span>
            <i class="fa-solid fa-xmark" onclick="this.parentElement.remove();"></i>
        </div>
    </c:if>

    <header>
        <div class="logo-cont">
            <img src="../images/book_logo.png" alt="Book Logo">
            <a href="home.jsp" class="logo">BOOK<span>SHELF</span></a>
        </div>
        
        <nav id="nav-links">
            <a href="../PublicArea/Index.jsp">Home</a>
            <a href="../PublicArea/about.jsp">About</a>
            <a href="shop.jsp">Shop</a>
            <a href="../PublicArea/contact.jsp">Contact</a>
            <a href="orders.jsp">Orders</a>
        </nav>
        
        <div class="icons">
            <a href="search.jsp"><i class="fas fa-search"></i></a>
            
            <c:choose>
                <c:when test="${empty sessionScope.user_id}">
                    <div class="loginorreg">
                        <a href="../PublicArea/signIn.jsp">Login</a> | <a href="../PublicArea/SignUp.jsp">Register</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="fas fa-user" id="user_btn"></div>
                </c:otherwise>
            </c:choose>
            
            <a href="cart.jsp">
                <i class="fas fa-shopping-cart"></i>
                <c:if test="${not empty cartCount}">
                    <span class="quantity">(${cartCount})</span>
                </c:if>
            </a>
            
            <div class="fas fa-bars" id="user_menu_btn"></div>
        </div>
        
        <c:if test="${not empty sessionScope.user_name}">
            <div class="header_acc_box" id="accountBox">
                <p>Username : <span>${sessionScope.user_name}</span></p>
                <p>Email : <span>${sessionScope.user_email}</span></p>
                <a href="logout.jsp" class="delete-btn">Logout</a>
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
    </script>
</body>
</html>