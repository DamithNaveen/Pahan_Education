<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/MegacabLogo.png">
    <title>Pahan Edu - Sign Up</title>
    <link rel="stylesheet" href="../PublicArea/css/SignUp.css">
    
</head>

<body>

    <!-- Header Start -->
    <section class="promo-sec">
        <div class="container">
            <div class="promo-wrap text-center">
                <h2>Create Account</h2>
            </div>
        </div>
    </section>
    <!-- Header End -->

    <!-- Main Content Start -->
    <main class="main">
        <div class="container">
            <div class="signup-form">
                <h2 class="sub-title">Sign Up</h2>
                
                <!-- Success/Error Messages -->
                <c:if test="${not empty success}">
                    <div class="alert alert-success">
                        ${success}
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        ${error}
                    </div>
                </c:if>
                
                <form action="${pageContext.request.contextPath}/register" method="post" autocomplete="off">
                    <input type="hidden" name="action" value="register">
                    
                    <div class="form-group">
                        <label for="full_name">Full Name:</label>
                        <input type="text" id="full_name" name="full_name" required autocomplete="off" 
                               placeholder="Enter your full name" value="${fn:escapeXml(param.full_name)}">
                    </div>
                    
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" required autocomplete="off" 
                               placeholder="Enter your email" value="${fn:escapeXml(param.email)}">
                    </div>
                    
                    <div class="form-group">
                        <label for="username">Username:</label>
                        <input type="text" id="username" name="username" required autocomplete="off" 
                               placeholder="Choose a username" value="${fn:escapeXml(param.username)}">
                    </div>
                    
                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input type="password" id="password" name="password" required 
                               autocomplete="new-password" placeholder="Create a password (min 8 characters)">
                    </div>
                    
                    <div class="form-group">
                        <label for="address">Address:</label>
                        <textarea id="address" name="address" rows="3" required autocomplete="off" 
                                  placeholder="Enter your full address">${fn:escapeXml(param.address)}</textarea>
                    </div>
                    
                    <div class="form-group">
                        <label for="phone">Phone Number:</label>
                        <input type="tel" id="phone" name="phone" required autocomplete="off" 
                               placeholder="Enter 10-digit phone number" pattern="[0-9]{10}" value="${fn:escapeXml(param.phone)}">
                    </div>
                    
                    <button type="submit">Register</button>
                    
                    <div class="login-link">
                        Already have an account? <a href="${pageContext.request.contextPath}/PublicArea/signIn.jsp">Sign In</a>
                    </div>
                </form>
            </div>
        </div>
    </main>
    <!-- Main Content End -->

</body>

</html>
