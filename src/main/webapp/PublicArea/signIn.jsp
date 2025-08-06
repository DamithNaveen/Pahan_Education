<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Login</title>
        <link rel="stylesheet" href="../PublicArea/css/SignIn.css">
    
</head>
<body>
    <div class="login-container">
        <h2>Customer Login</h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <!-- Changed action to customerLogin -->
        <form action="${pageContext.request.contextPath}/customerLogin" method="POST">
            <div class="input-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="input-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit">Sign In</button>
        </form>
        
        <p>Don't have an account? 
           <a href="${pageContext.request.contextPath}/PublicArea/signUp.jsp">Sign up</a>
        </p>
    </div>
</body>
</html>