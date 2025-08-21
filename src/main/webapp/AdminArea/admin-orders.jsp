<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Order Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/PublicArea/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .admin-container {
            max-width: 1400px;
            margin: 20px auto;
            padding: 20px;
        }
        .filter-section {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .order-card {
            border: 1px solid #dee2e6;
            border-radius: 8px;
            margin-bottom: 15px;
            transition: box-shadow 0.3s;
        }
        .order-card:hover {
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }
        .status-pending { background: #fff3cd; color: #856404; }
        .status-completed { background: #d4edda; color: #155724; }
        .status-cancelled { background: #f8d7da; color: #721c24; }
        .action-buttons .btn {
            margin-right: 5px;
        }
    </style>
</head>
<body>
    <jsp:include page="../PublicArea/header.jsp" />

    <div class="admin-container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="fas fa-shopping-cart me-2"></i>Order Management</h2>
            <span class="badge bg-primary">Total Orders: ${totalRecords}</span>
        </div>

        <!-- Messages -->
        <c:if test="${not empty param.message}">
            <div class="alert alert-success alert-dismissible fade show">
                ${param.message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger alert-dismissible fade show">
                ${param.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Filter Section -->
        <div class="filter-section">
            <form method="get" action="${pageContext.request.contextPath}/AdminOrderServlet">
                <div class="row g-3">
                    <div class="col-md-3">
                        <label class="form-label">Status</label>
                        <select name="status" class="form-select">
                            <option value="">All Status</option>
                            <option value="Pending" ${param.status == 'Pending' ? 'selected' : ''}>Pending</option>
                            <option value="Completed" ${param.status == 'Completed' ? 'selected' : ''}>Completed</option>
                            <option value="Cancelled" ${param.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">From Date</label>
                        <input type="date" name="dateFrom" value="${param.dateFrom}" class="form-control">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">To Date</label>
                        <input type="date" name="dateTo" value="${param.dateTo}" class="form-control">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">&nbsp;</label>
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">Filter</button>
                            <a href="${pageContext.request.contextPath}/AdminOrderServlet" class="btn btn-secondary">Clear</a>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <!-- Orders Table -->
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>Order ID</th>
                                <th>Customer</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Total Amount</th>
                                <th>Order Date</th>
                                <th>Status</th>
                                <th>Payment Method</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${orders}" var="order">
                                <tr>
                                    <td>#${order.id}</td>
                                    <td>${order.name}</td>
                                    <td>${order.email}</td>
                                    <td>${order.number}</td>
                                    <td>Rs. ${order.totalPrice}</td>
                                    <td>${order.orderDate}</td>
                                    <td>
                                        <span class="status-badge status-${order.paymentStatus.toLowerCase()}">
                                            ${order.paymentStatus}
                                        </span>
                                    </td>
                                    <td>${order.method}</td>
                                    <td class="action-buttons">
                                        <a href="${pageContext.request.contextPath}/AdminOrderServlet?action=view&id=${order.id}" 
                                           class="btn btn-sm btn-info" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/AdminOrderServlet?action=edit&id=${order.id}" 
                                           class="btn btn-sm btn-warning" title="Edit Order">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <c:if test="${order.paymentStatus == 'Pending'}">
                                            <a href="${pageContext.request.contextPath}/AdminOrderServlet?action=confirm&id=${order.id}" 
                                               class="btn btn-sm btn-success" title="Confirm Order"
                                               onclick="return confirm('Confirm this order?')">
                                                <i class="fas fa-check"></i>
                                            </a>
                                        </c:if>
                                        <a href="${pageContext.request.contextPath}/AdminOrderServlet?action=delete&id=${order.id}" 
                                           class="btn btn-sm btn-danger" title="Delete Order"
                                           onclick="return confirm('Are you sure you want to delete this order?')">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            
                            <c:if test="${empty orders}">
                                <tr>
                                    <td colspan="9" class="text-center text-muted py-4">
                                        <i class="fas fa-inbox fa-3x mb-3"></i>
                                        <p>No orders found</p>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <nav aria-label="Order pagination">
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" 
                                   href="${pageContext.request.contextPath}/AdminOrderServlet?page=${currentPage - 1}&status=${param.status}&dateFrom=${param.dateFrom}&dateTo=${param.dateTo}">
                                    Previous
                                </a>
                            </li>
                            
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" 
                                       href="${pageContext.request.contextPath}/AdminOrderServlet?page=${i}&status=${param.status}&dateFrom=${param.dateFrom}&dateTo=${param.dateTo}">
                                        ${i}
                                    </a>
                                </li>
                            </c:forEach>
                            
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" 
                                   href="${pageContext.request.contextPath}/AdminOrderServlet?page=${currentPage + 1}&status=${param.status}&dateFrom=${param.dateFrom}&dateTo=${param.dateTo}">
                                    Next
                                </a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </div>
        </div>
    </div>

    <jsp:include page="../PublicArea/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Auto-hide alerts after 5 seconds
        setTimeout(() => {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                new bootstrap.Alert(alert).close();
            });
        }, 5000);
    </script>
</body>
</html>