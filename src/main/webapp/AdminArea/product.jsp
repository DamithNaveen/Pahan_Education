<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Product Management</title>
    <style>
        table { border-collapse: collapse; width: 90%; margin: 20px auto; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: left; vertical-align: middle; }
        th { background-color: #f2f2f2; }
        img { max-width: 100px; max-height: 80px; }
        form { margin: 30px auto; width: 90%; max-width: 600px; }
        label { display: block; margin: 10px 0 5px; }
        input, textarea, select, button { width: 100%; padding: 8px; box-sizing: border-box; }
        button { width: auto; margin-top: 15px; cursor: pointer; }
        .alert-success { color: green; }
        .alert-danger { color: red; }
        .action-buttons button {
            margin-right: 5px;
            cursor: pointer;
        }
        .deleteBtn {
            background-color: #ff4444;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 3px;
        }
        .deleteBtn:hover {
            background-color: #cc0000;
        }
        /* Modal styles */
        #updateFormContainer {
            display: none;
            position: fixed;
            top: 5%;
            left: 50%;
            transform: translateX(-50%);
            background: #fff;
            border: 1px solid #ccc;
            padding: 20px;
            z-index: 1000;
            max-width: 400px;
            width: 90%;
            box-shadow: 0 0 10px rgba(0,0,0,0.25);
            max-height: 90vh;
            overflow-y: auto;
        }
        #updateFormContainer.active {
            display: block;
        }
        #updateFormContainer button.close {
            float: right;
            background: red;
            color: white;
            border: none;
            padding: 5px 10px;
            font-weight: bold;
            cursor: pointer;
            margin-bottom: 10px;
        }
    </style>
    <script>
        function openUpdateForm(product) {
            document.getElementById('updateFormContainer').classList.add('active');

            document.getElementById('updateProductId').value = product.id;
            document.getElementById('updateProductName').value = product.productName;
            
            document.getElementById('updatePrice').value = parseFloat(product.price) || '';
            
            document.getElementById('updateAvailability').value = product.availability;
            document.getElementById('updateQuantity').value = parseInt(product.quantity) || 0;
            document.getElementById('updateImage').value = ''; // Clear file input
        }

        function closeUpdateForm() {
            document.getElementById('updateFormContainer').classList.remove('active');
        }

        function confirmDelete(productName) {
            return confirm('Are you sure you want to delete "' + productName + '"? This action cannot be undone.');
        }

        window.onload = function () {
            document.querySelectorAll('table tbody tr').forEach(row => {
                // Find the Update button in the row
                const updateBtn = row.querySelector('button.updateBtn');
                if (updateBtn) {
                    updateBtn.onclick = function () {
                        // Map product data from table cells
                        const product = {
                            id: row.children[0].textContent.trim(),
                            productName: row.children[1].textContent.trim(),
                            
                            price: row.children[3].textContent.trim(),
                            
                            availability: row.children[5].textContent.trim(),
                            quantity: row.children[6].textContent.trim()
                        };
                        openUpdateForm(product);
                    };
                }
            });
        }
    </script>
</head>
<body>
<h1 style="text-align:center;">Products</h1>

<c:if test="${not empty sessionScope.alertMessage}">
    <div class="alert-${sessionScope.alertType}" style="width:90%; max-width:600px; margin: 0 auto 20px auto; padding: 10px; border-radius: 4px;">
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
        <th>Price</th>
        <th>Availability</th>
        <th>Quantity</th>
        <th>Image</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="product" items="${productList}">
        <tr>
            <td>${product.id}</td>
            <td>${product.productName}</td>
            
            <td>${product.price}</td>
            
            <td>${product.availability}</td>
            <td>${product.quantity}</td>
            <td>
                <c:choose>
                    <c:when test="${not empty product.imagePath}">
                        <img src="${pageContext.request.contextPath}/${product.imagePath}" alt="Product Image"/>
                    </c:when>
                    <c:otherwise>
                        <span>No Image</span>
                    </c:otherwise>
                </c:choose>
            </td>
            <td class="action-buttons">
                <button type="button" class="updateBtn">Update</button>

                <form action="${pageContext.request.contextPath}/product" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" name="id" value="${product.id}"/>
                    <button type="submit" class="deleteBtn" 
                            onclick="return confirmDelete('${product.productName}')">Delete</button>
                </form>
            </td>
        </tr>
    </c:forEach>
    <c:if test="${empty productList}">
        <tr><td colspan="9" style="text-align:center;">No products found.</td></tr>
    </c:if>
    </tbody>
</table>

<h2 style="text-align:center;">Add New Product</h2>
<form action="${pageContext.request.contextPath}/product" method="post" enctype="multipart/form-data">
    <input type="hidden" name="action" value="add"/>
    <label for="productName">Name:</label>
    <input type="text" id="productName" name="productName" required/>

   

    <label for="price">Price:</label>
    <input type="number" id="price" name="price" step="0.01" required/>

    

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

<div id="updateFormContainer">
    <button class="close" onclick="closeUpdateForm()">X</button>
    <h2>Update Product</h2>
    <form action="${pageContext.request.contextPath}/product" method="post" enctype="multipart/form-data">
        <input type="hidden" name="action" value="update"/>
        <input type="hidden" id="updateProductId" name="id"/>

        <label for="updateProductName">Name:</label>
        <input type="text" id="updateProductName" name="productName" required/>

        

        <label for="updatePrice">Price:</label>
        <input type="number" id="updatePrice" name="price" step="0.01" required/>

        

        <label for="updateAvailability">Availability:</label>
        <select id="updateAvailability" name="availability" required>
            <option value="In Stock">In Stock</option>
            <option value="Out of Stock">Out of Stock</option>
        </select>

        <label for="updateQuantity">Quantity:</label>
        <input type="number" id="updateQuantity" name="quantity" required/>

        <label for="updateImage">Product Image (leave blank to keep current):</label>
        <input type="file" id="updateImage" name="image" accept="image/*"/>

        <button type="submit">Update Product</button>
    </form>
</div>
</body>
</html>