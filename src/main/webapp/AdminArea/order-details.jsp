<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/PublicArea/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
   >

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="fas fa-file-alt me-2"></i>Order Details #${order.id}</h2>
            <a href="${pageContext.request.contextPath}/AdminOrderServlet" class="btn btn-secondary">
                <i class="fas fa-arrow-left me-1"></i> Back to Orders
            </a>
        </div>

        <!-- Order Information -->
        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0">Order Information</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <p><strong>Customer Name:</strong> ${order.name}</p>
                        <p><strong>Email:</strong> ${order.email}</p>
                        <p><strong>Phone:</strong> ${order.number}</p>
                    </div>
                    <div class="col-md-6">
                        <p><strong>Order Date:</strong> ${order.orderDate}</p>
                        <p><strong>Status:</strong> 
                            <span class="badge ${order.paymentStatus == 'Pending' ? 'bg-warning' : 
                                              order.paymentStatus == 'Completed' ? 'bg-success' : 'bg-danger'}">
                                ${order.paymentStatus}
                            </span>
                        </p>
                        <p><strong>Payment Method:</strong> ${order.method}</p>
                    </div>
                </div>
                <p><strong>Delivery Address:</strong> ${order.address}</p>
                <p><strong>Total Amount:</strong> Rs. ${order.totalPrice}</p>
            </div>
        </div>

        <!-- Order Items -->
        <div class="card">
            <div class="card-header bg-secondary text-white">
                <h5 class="mb-0">Order Items</h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Book</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${orderItems}" var="item">
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <img src="${pageContext.request.contextPath}/images/${item.image}" 
                                                 alt="${item.bookName}" 
                                                 style="width: 50px; height: 70px; object-fit: cover; margin-right: 15px;">
                                            <div>
                                                <strong>${item.bookName}</strong><br>
                                                <small class="text-muted">ID: ${item.bookId}</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>Rs. ${item.price}</td>
                                    <td>${item.quantity}</td>
                                    <td>Rs. ${item.price * item.quantity}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot>
                            <tr class="table-primary">
                                <td colspan="3" class="text-end"><strong>Grand Total:</strong></td>
                                <td><strong>Rs. ${order.totalPrice}</strong></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
    </div>

    
</body>
</html>