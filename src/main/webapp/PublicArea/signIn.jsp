<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Login</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="../images/customerlogin.jpg">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/PublicArea/css/SignIn.css">
</head>
<body>
  <div class="container">
    <div class="myform">
      <form action="${pageContext.request.contextPath}/customerLogin" method="POST">
        <h2>CUSTOMER LOGIN</h2>
        
        <c:if test="${not empty success}">
            <div class="success-message">
                ${success}
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="error-message">
                <strong>Error:</strong> ${error}
            </div>
        </c:if>
        
        <input type="text" id="username" name="username" placeholder="Enter Username" required value="${param.username}">
        <input type="password" id="password" name="password" placeholder="Enter Password" required>
        <button type="submit">SIGN IN</button>
        
        <p class="signup-link">Don't have an account? 
           <a href="${pageContext.request.contextPath}/PublicArea/signUp.jsp">Sign up</a>
        </p>
      </form>
    </div>
    <div class="image">
      <img src="${pageContext.request.contextPath}/PublicArea/images/customer-login-image.jpg" alt="Customer Login Image">
    </div>
  </div>
</body>
</html>