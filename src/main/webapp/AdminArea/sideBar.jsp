<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<section id="sidebar">
  <a href="#" class="brand">
  <i class='bx bxs-car icon'></i> Pahan Edu
  </a>
  <ul class="side-menu">
    <li>
      <a href="./dashboard.jsp" class="active">
        <i class='bx bxs-dashboard icon'></i> Dashboard
      </a>
    </li>
  
    <li>
      <a href="./product.jsp">
        <i class='bx bxs-calendar-check icon'></i> Product 
      </a>
    </li>
    
   <li>
  <a href="./admin-orders.jsp">
    <i class='bx bxs-cart icon'></i> Orders
  </a>
</li>



<li>
  <a href="./messages.jsp">
    <i class='bx bxs-message-rounded icon'></i> Messages
  </a>
</li>



<li class="nav-item">
    <a class="nav-link" href="${pageContext.request.contextPath}/admincustomers">
        <i class="fas fa-users"></i> Customers
    </a>
</li>
    
  </ul>
</section>		