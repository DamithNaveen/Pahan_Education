<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.res.model.User" %>
<%@ page import="com.res.model.Customer" %>


   
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="style.css">
  <link rel="icon" type="image/x-icon" href="./assets/images/LogoAdmin.png">
    <title>Admin Dashboard</title>
</head>
<body>

<c:if test="${empty sessionScope.user || sessionScope.user.role != 'ADMIN'}">
    <c:redirect url="/AdminArea/login.jsp" />
</c:if>

    
    <!-- SIDEBAR -->
    <jsp:include page="./sideBar.jsp" />
    <!-- SIDEBAR -->

    <!-- NAVBAR -->
    <section id="content">
        <!-- NAVBAR -->
        <jsp:include page="./navBar.jsp" />
        <!-- NAVBAR -->

        <!-- MAIN -->
        <main>
<div class="d-flex justify-content-between align-items-center mb-4">
    <h1 class="title">Admin Dashboard</h1>
    <a href="dashboardReport.jsp" class="btn btn-primary">
         <i class='bx bx-file'></i>  Report
    </a>
</div>
            <div class="info-data">
                <div class="card">
                    <div class="head">
                        <div>
                            <h2></h2>
                            <p>Total Orders</p>
                        </div>
                        <i class='bx bx-receipt icon'></i>
                    </div>
                    <span class="progress" data-value="100%"></span>
                    <span class="label">All Bookings</span>
                </div>
                <div class="card">
                    <div class="head">
                        <div>
                            <h2></h2>
                            <p>Completed Orders</p>
                        </div>
                        <i class='bx bx-check-circle icon'></i>
                    </div>
                    <span class="progress" data-value=""></span>
                    <span class="label"></span>
                </div>
                <div class="card">
                    <div class="head">
                        <div>
                            <h2></h2>
                            <p>Confirmed Orders</p>
                        </div>
                        <i class='bx bx-calendar-check icon'></i>
                    </div>
                    <span class="progress" data-value=""></span>
                    <span class="label"></span>
                </div>
                <div class="card">
                    <div class="head">
                        <div>
                            <h2></h2>
                            <p>Pending Orders</p>
                        </div>
                        <i class='bx bx-time icon'></i>
                    </div>
                    <span class="progress" data-value=""></span>
                    <span class="label"></span>
                </div>
            </div>
            
            <div class="info-data">
                <div class="card">
                    <div class="head">
                        <div>
                            <h2></h2>
                            <p>Total Revenue</p>
                        </div>
                        <i class='bx bx-money icon'></i>
                    </div>
                    <span class="progress" data-value="100%"></span>
                    <span class="label">Income</span>
                </div>
                <div class="card">
                    <div class="head">
                        <div>
                            <h2></h2>
                            <p>Total Drivers</p>
                        </div>
                        <i class='bx bx-user icon'></i>
                    </div>
                    <span class="progress" data-value="100%"></span>
                    <span class="label">Active Drivers</span>
                </div>
                <div class="card">
                    <div class="head">
                        <div>
                            <h2></h2>
                            <p>Total Vehicles</p>
                        </div>
                        <i class='bx bx-car icon'></i>
                    </div>
                    <span class="progress" data-value="100%"></span>
                    <span class="label">Fleet Size</span>
                </div>
                <div class="card">
                    <div class="head">
                        <div>
                            <h2></h2>
                            <p>Total Customers</p>
                        </div>
                        <i class='bx bx-group icon'></i>
                    </div>
                    <span class="progress" data-value="100%"></span>
                    <span class="label">Registered Users</span>
                </div>
            </div>
            
            <div class="data">
                <div class="content-data">
                    <div class="head">
                        <h3>Vehicle Fleet Summary</h3>
                        <div class="menu">
                            <i class='bx bx-dots-horizontal-rounded icon'></i>
                            <ul class="menu-link">
                                <li><a href="#">View All</a></li>
                                <li><a href="#">Refresh</a></li>
                            </ul>
                        </div>
                    </div>
                    <div id="vehicle-chart"></div>
                    <div class="stats-summary">
                        
                    </div>
                </div>
                
                <div class="content-data">
                    <div class="head">
                        <h3>Booking Performance</h3>
                        <div class="menu">
                            <i class='bx bx-dots-horizontal-rounded icon'></i>
                            <ul class="menu-link">
                                <li><a href="#">View Details</a></li>
                                <li><a href="#">Print Report</a></li>
                            </ul>
                        </div>
                    </div>
                    <div id="booking-chart"></div>
                    <div class="stats-summary">
                        
                    </div>
                </div>
            </div>
            
            <!-- BOOKINGS TABLE -->
            <div class="data">
                <div class="content-data">
                    <div class="head">
                        <h3>Booking Management</h3>
                        <div class="menu">
                            <i class='bx bx-dots-horizontal-rounded icon'></i>
                            <ul class="menu-link">
                                <li><a href="#">View All</a></li>
                                <li><a href="#">Export</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="table-responsive">
                       
                    </div>
                </div>
            </div>
        
        </main>
        <!-- MAIN -->
    </section>
    <!-- NAVBAR -->
    
 
    <script src="script.js"></script>
</body>

</html>