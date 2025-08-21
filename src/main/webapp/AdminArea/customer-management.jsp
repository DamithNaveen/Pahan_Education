<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin - Customer Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/PublicArea/css/styles.css">
    <style>
        body { font-family: Arial, sans-serif; background: #f4f6f9; padding: 20px; }
        .container { max-width: 1400px; margin: auto; background: #fff; padding: 20px; border-radius: 6px; }
        h2 { text-align: center; margin-bottom: 20px; color: #333; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; border: 1px solid #ddd; text-align: center; }
        th { background: #f8f9fa; font-weight: bold; }
        tr:hover { background: #f8f9fa; }
        .actions a {
            margin: 0 5px;
            text-decoration: none;
            padding: 6px 12px;
            border-radius: 4px;
            color: #fff;
            font-size: 14px;
        }
        .view { background: #007bff; }
        .edit { background: #ffc107; }
        .delete { background: #dc3545; }
        .back-link { 
            display: inline-block; 
            margin-bottom: 20px; 
            padding: 10px 15px; 
            background: #6c757d; 
            color: white; 
            text-decoration: none; 
            border-radius: 4px; 
        }
        .stats-positive { color: #28a745; font-weight: bold; }
        .stats-zero { color: #6c757d; }
        .search-bar { 
            margin-bottom: 20px; 
            padding: 15px; 
            background: #f8f9fa; 
            border-radius: 5px; 
        }
        .search-bar input {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-right: 10px;
        }
        .search-bar button {
            padding: 8px 15px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .action-buttons {
            margin-bottom: 20px;
            text-align: center;
        }
        .action-buttons button {
            padding: 10px 20px;
            margin: 0 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }
        .btn-add { background: #28a745; color: white; }
        .btn-export { background: #17a2b8; color: white; }
        .btn-refresh { background: #6c757d; color: white; }
        .created-at { font-size: 12px; color: #6c757d; font-style: italic; }
    </style>
</head>
<body>
<div class="container">
    <a href="${pageContext.request.contextPath}/AdminArea/adminDashboard.jsp" class="back-link">← Back to Dashboard</a>
    <h2>Customer Management</h2>

    <c:if test="${not empty param.message}">
        <div style="background:#d4edda; color:#155724; padding:10px; margin-bottom:15px; border-radius:5px;">
            ✅ ${param.message}
        </div>
    </c:if>
    <c:if test="${not empty param.error}">
        <div style="background:#f8d7da; color:#721c24; padding:10px; margin-bottom:15px; border-radius:5px;">
            ❌ ${param.error}
        </div>
    </c:if>

    <div class="action-buttons">
        <button class="btn-add" onclick="location.href='AdminCustomerServlet?action=add'">+ Add New Customer</button>
        <button class="btn-export" onclick="exportCustomers()">📊 Export Data</button>
        <button class="btn-refresh" onclick="location.reload()">🔄 Refresh</button>
    </div>

    <div class="search-bar">
        <form action="AdminCustomerServlet" method="get">
            <input type="text" name="search" placeholder="Search customers..." value="${param.search}">
            <button type="submit">Search</button>
            <a href="AdminCustomerServlet" style="margin-left: 10px; color: #6c757d;">Clear</a>
        </form>
    </div>

    <c:choose>
        <c:when test="${not empty customers}">
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Address</th>
                    <th>Total Orders</th>
                    <th>Total Spent</th>
                    <th>Created At</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <!-- Sample Customer Data - Replace with dynamic data from servlet -->
                <tr>
                    <td>1</td>
                    <td>allie</td>
                    <td>Allie Quintana</td>
                    <td>Allie123@gmail.com</td>
                    <td>0701374899</td>
                    <td>Alli Quintana 50 George street sydeney</td>
                    <td class="stats-positive">5</td>
                    <td class="stats-positive">Rs. 12,500</td>
                    <td class="created-at">2025-08-16 15:21:00</td>
                    <td class="actions">
                        <a href="AdminCustomerServlet?action=view&id=1" class="view">View</a>
                        <a href="AdminCustomerServlet?action=edit&id=1" class="edit">Edit</a>
                        <a href="AdminCustomerServlet?action=delete&id=1" class="delete"
                           onclick="return confirm('Are you sure you want to delete customer: allie?');">Delete</a>
                    </td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>sahan</td>
                    <td>sahan bandara</td>
                    <td>sahan123@gmail.com</td>
                    <td>0701122334</td>
                    <td>123/1, colombo road, kandy</td>
                    <td class="stats-positive">3</td>
                    <td class="stats-positive">Rs. 8,750</td>
                    <td class="created-at">2025-08-16 22:24:56</td>
                    <td class="actions">
                        <a href="AdminCustomerServlet?action=view&id=2" class="view">View</a>
                        <a href="AdminCustomerServlet?action=edit&id=2" class="edit">Edit</a>
                        <a href="AdminCustomerServlet?action=delete&id=2" class="delete"
                           onclick="return confirm('Are you sure you want to delete customer: sahan?');">Delete</a>
                    </td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>mota</td>
                    <td>Raquel Mota</td>
                    <td>mota123@gmail.com</td>
                    <td>0701374800</td>
                    <td>Alli Quintana 50 George street sydeney</td>
                    <td class="stats-zero">0</td>
                    <td class="stats-zero">Rs. 0</td>
                    <td class="created-at">2025-08-16 15:21:00</td>
                    <td class="actions">
                        <a href="AdminCustomerServlet?action=view&id=3" class="view">View</a>
                        <a href="AdminCustomerServlet?action=edit&id=3" class="edit">Edit</a>
                        <a href="AdminCustomerServlet?action=delete&id=3" class="delete"
                           onclick="return confirm('Are you sure you want to delete customer: mota?');">Delete</a>
                    </td>
                </tr>
                <tr>
                    <td>4</td>
                    <td>Jane</td>
                    <td>Jane Smith</td>
                    <td>JaneSmith123@gmail.com</td>
                    <td>0701124521</td>
                    <td>123 main St, springfield, IL 62701, USA</td>
                    <td class="stats-positive">2</td>
                    <td class="stats-positive">Rs. 5,200</td>
                    <td class="created-at">2025-08-17 17:19:04</td>
                    <td class="actions">
                        <a href="AdminCustomerServlet?action=view&id=4" class="view">View</a>
                        <a href="AdminCustomerServlet?action=edit&id=4" class="edit">Edit</a>
                        <a href="AdminCustomerServlet?action=delete&id=4" class="delete"
                           onclick="return confirm('Are you sure you want to delete customer: Jane?');">Delete</a>
                    </td>
                </tr>
                </tbody>
            </table>
            
            <div style="margin-top: 20px; text-align: center; color: #6c757d;">
                Total Customers: 4 | Active Customers: 3 | Total Revenue: Rs. 26,450
            </div>
        </c:when>
        <c:otherwise>
            <!-- Display sample data even when no dynamic data is available -->
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Address</th>
                    <th>Total Orders</th>
                    <th>Total Spent</th>
                    <th>Created At</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>1</td>
                    <td>allie</td>
                    <td>Allie Quintana</td>
                    <td>Allie123@gmail.com</td>
                    <td>0701374899</td>
                    <td>Alli Quintana 50 George street sydeney</td>
                    <td class="stats-positive">5</td>
                    <td class="stats-positive">Rs. 12,500</td>
                    <td class="created-at">2025-08-16 15:21:00</td>
                    <td class="actions">
                        <a href="AdminCustomerServlet?action=view&id=1" class="view">View</a>
                        <a href="AdminCustomerServlet?action=edit&id=1" class="edit">Edit</a>
                        <a href="AdminCustomerServlet?action=delete&id=1" class="delete"
                           onclick="return confirm('Are you sure you want to delete customer: allie?');">Delete</a>
                    </td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>sahan</td>
                    <td>sahan bandara</td>
                    <td>sahan123@gmail.com</td>
                    <td>0701122334</td>
                    <td>123/1, colombo road, kandy</td>
                    <td class="stats-positive">3</td>
                    <td class="stats-positive">Rs. 8,750</td>
                    <td class="created-at">2025-08-16 22:24:56</td>
                    <td class="actions">
                        <a href="AdminCustomerServlet?action=view&id=2" class="view">View</a>
                        <a href="AdminCustomerServlet?action=edit&id=2" class="edit">Edit</a>
                        <a href="AdminCustomerServlet?action=delete&id=2" class="delete"
                           onclick="return confirm('Are you sure you want to delete customer: sahan?');">Delete</a>
                    </td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>mota</td>
                    <td>Raquel Mota</td>
                    <td>mota123@gmail.com</td>
                    <td>0701374800</td>
                    <td>Alli Quintana 50 George street sydeney</td>
                    <td class="stats-zero">0</td>
                    <td class="stats-zero">Rs. 0</td>
                    <td class="created-at">2025-08-16 15:21:00</td>
                    <td class="actions">
                        <a href="AdminCustomerServlet?action=view&id=3" class="view">View</a>
                        <a href="AdminCustomerServlet?action=edit&id=3" class="edit">Edit</a>
                        <a href="AdminCustomerServlet?action=delete&id=3" class="delete"
                           onclick="return confirm('Are you sure you want to delete customer: mota?');">Delete</a>
                    </td>
                </tr>
                <tr>
                    <td>4</td>
                    <td>Jane</td>
                    <td>Jane Smith</td>
                    <td>JaneSmith123@gmail.com</td>
                    <td>0701124521</td>
                    <td>123 main St, springfield, IL 62701, USA</td>
                    <td class="stats-positive">2</td>
                    <td class="stats-positive">Rs. 5,200</td>
                    <td class="created-at">2025-08-17 17:19:04</td>
                    <td class="actions">
                        <a href="AdminCustomerServlet?action=view&id=4" class="view">View</a>
                        <a href="AdminCustomerServlet?action=edit&id=4" class="edit">Edit</a>
                        <a href="AdminCustomerServlet?action=delete&id=4" class="delete"
                           onclick="return confirm('Are you sure you want to delete customer: Jane?');">Delete</a>
                    </td>
                </tr>
                </tbody>
            </table>
            
            <div style="margin-top: 20px; text-align: center; color: #6c757d;">
                Total Customers: 4 | Active Customers: 3 | Total Revenue: Rs. 26,450
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
function exportCustomers() {
    alert('Export functionality would be implemented here. This would typically download a CSV or PDF report of all customers.');
    // In a real implementation, this would redirect to an export servlet
    // window.location.href = 'AdminCustomerServlet?action=export';
}
</script>
</body>
</html>