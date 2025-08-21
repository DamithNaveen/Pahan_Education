<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Customer Management</title>
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
        .customer-card {
            border: 1px solid #dee2e6;
            border-radius: 8px;
            margin-bottom: 15px;
            transition: box-shadow 0.3s;
        }
        .customer-card:hover {
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .stats-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            background: #e9ecef;
            color: #495057;
        }
        .action-buttons .btn {
            margin-right: 5px;
        }
        .table th {
            background-color: #f8f9fa;
            font-weight: 600;
        }
    </style>
</head>
<body>
    

    <div class="admin-container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="fas fa-users me-2"></i>Customer Management</h2>
            <span class="badge bg-primary">Total Customers: ${totalRecords}</span>
        </div>

        <!-- Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show">
                ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show">
                ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Customers Table -->
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Username</th>
                                <th>Full Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Address</th>
                                <th>Orders</th>
                                <th>Total Spent</th>
                                <th>Registration Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${customers}" var="customer">
                                <tr>
                                    <td>${customer.id}</td>
                                    <td>${customer.username}</td>
                                    <td>${customer.fullName}</td>
                                    <td>${customer.email}</td>
                                    <td>${customer.phone}</td>
                                    <td>${customer.address}</td>
                                    <td>
                                        <span class="stats-badge">${customer.orderCount} orders</span>
                                    </td>
                                    <td>
                                        <span class="stats-badge">Rs. ${customer.totalSpent}</span>
                                    </td>
                                    <td>
                                        <!-- If you have registration date in your Customer model, display it here -->
                                        <span class="text-muted">N/A</span>
                                    </td>
                                </tr>
                            </c:forEach>
                            
                            <c:if test="${empty customers}">
                                <tr>
                                    <td colspan="9" class="text-center text-muted py-4">
                                        <i class="fas fa-users fa-3x mb-3"></i>
                                        <p>No customers found</p>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    

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