<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Product Management</title>
    <style>
        table { border-collapse: collapse; width: 90%; margin: 20px auto; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: left; }
        th { background-color: #f2f2f2; }
        img { max-width: 100px; }
        form { margin: 30px auto; width: 90%; max-width: 600px; }
        label { display: block; margin: 10px 0 5px; }
        input, textarea, select, button { width: 100%; padding: 8px; }
        button { width: auto; margin-top: 15px; }
        .alert-success { color: green; }
        .alert-danger { color: red; }
    </style>
</head>
<body>
<h1>Products</h1>

<!-- Alert message -->
<c:if test="${not empty sessionScope.alertMessage}">
    <div class="alert-${sessionScope.alertType}">
        ${sessionScope.alertMessage}
    </div>
    <%
        session.removeAttribute("alertMessage");
        session.removeAttribute("alertType");
    %>
</c:if>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Description</th>
        <th>Price</th>
        <th>Category</th>
        <th>Availability</th>
        <th>Quantity</th>
        <th>Image</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="product" items="${productList}">
        <tr>
            <td>${product.id}</td>
            <td>${product.productName}</td>
            <td>${product.description}</td>
            <td>${product.price}</td>
            <td>${product.category}</td>
            <td>${product.availability}</td>
            <td>${product.quantity}</td>
            <td>
                <c:if test="${not empty product.imagePath}">
                    <img src="${pageContext.request.contextPath}/${product.imagePath}" alt="Product Image"/>
                </c:if>
            </td>
        </tr>
    </c:forEach>
    <c:if test="${empty productList}">
        <tr><td colspan="8">No products found.</td></tr>
    </c:if>
    </tbody>
</table>

<h2>Add New Product</h2>
<form action="${pageContext.request.contextPath}/product" method="post" enctype="multipart/form-data">
    <input type="hidden" name="action" value="add"/>
    <label for="productName">Name:</label>
    <input type="text" id="productName" name="productName" required/>

    <label for="description">Description:</label>
    <textarea id="description" name="description" required></textarea>

    <label for="price">Price:</label>
    <input type="number" id="price" name="price" step="0.01" required/>

    <label for="category">Category:</label>
    <input type="text" id="category" name="category" required/>

    <label for="availability">Availability:</label>
    <select id="availability" name="availability" required>
        <option value="In Stock">In Stock</option>
        <option value="Out of Stock">Out of Stock</option>
    </select>

    <label for="quantity">Quantity:</label>
    <input type="number" id="quantity" name="quantity" required/>

    <label for="image">Product Image:</label>
    <input type="file" id="image" name="image" accept="image/*" required/>

    <button type="submit">Add Product</button>
</form>
</body>
</html>
