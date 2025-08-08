<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <style>
        /* Base styles for both views */
        .product-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
            transition: all 0.3s;
        }
        
        .product-img {
            width: 100%;
            height: 200px;
            object-fit: contain;
            margin-bottom: 15px;
        }
        
        /* Customer specific styles */
        .customer-view .product-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 10px;
        }
        
        .customer-view .product-price {
            font-size: 1.25rem;
            font-weight: 700;
            color: #2a5885;
            margin-bottom: 15px;
        }
        
        .customer-view .add-to-cart-btn {
            width: 100%;
        }
        
        /* Admin specific styles */
        .admin-view {
            display: none;
        }
        
        .admin-mode .admin-view {
            display: block;
        }
        
        .admin-mode .customer-view {
            display: none;
        }
        
        .admin-toggle {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 1000;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            font-size: 1.5rem;
        }
        
        .admin-badge {
            position: absolute;
            top: 5px;
            right: 5px;
        }
        
        .availability-in-stock {
            color: green;
            font-weight: bold;
        }
        
        .availability-out-of-stock {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body class="${sessionScope.user.role == 'ADMIN' ? 'admin-mode' : ''}">
    <div class="container mt-4">
        <!-- Customer View Header -->
        <div class="customer-view">
            <h1 class="mb-4">Our Products</h1>
        </div>
        
        <!-- Admin View Header -->
        <div class="admin-view">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class='bx bx-shield-alt-2'></i> Admin Product Management</h2>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addProductModal">
                    <i class='bx bx-plus'></i> Add Product
                </button>
            </div>
        </div>

        <!-- Admin Toggle Button -->
        <c:if test="${sessionScope.user.role == 'ADMIN'}">
            <button class="btn btn-secondary admin-toggle" onclick="document.body.classList.toggle('admin-mode')">
                <i class='bx bx-cog'></i>
            </button>
        </c:if>

        <!-- Messages -->
        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-success alert-dismissible fade show">
                ${sessionScope.message}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="message" scope="session"/>
        </c:if>

        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger alert-dismissible fade show">
                ${sessionScope.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="error" scope="session"/>
        </c:if>

        <div class="row">
            <c:forEach var="product" items="${products}">
                <div class="col-md-4 col-lg-3 mb-4">
                    <div class="product-card position-relative">
                        <!-- Admin Badge -->
                        <c:if test="${sessionScope.user.role == 'ADMIN'}">
                            <span class="badge bg-danger admin-badge">ID: ${product.id}</span>
                        </c:if>
                        
                        <!-- Customer View -->
                        <div class="customer-view">
                            <img src="${pageContext.request.contextPath}/${product.imagePath}" 
                                 alt="${product.productName}" class="product-img">
                            <h3 class="product-title">${product.productName}</h3>
                            <div class="product-price">$${product.price}</div>
                            
                            <form action="${pageContext.request.contextPath}/AddToCartServlet" method="post">
                                <input type="hidden" name="product_id" value="${product.id}">
                                <input type="hidden" name="product_name" value="${product.productName}">
                                <input type="hidden" name="price" value="${product.price}">
                                <input type="hidden" name="image" value="${product.imagePath}">
                                <button type="submit" class="btn btn-primary add-to-cart-btn">
                                    <i class='bx bx-cart-add'></i> Add to Cart
                                </button>
                            </form>
                        </div>
                        
                        <!-- Admin View -->
                        <div class="admin-view">
                            <img src="${pageContext.request.contextPath}/${product.imagePath}" 
                                 alt="${product.productName}" class="product-img">
                            
                            <table class="table table-sm table-bordered">
                                <tr>
                                    <th width="30%">Name:</th>
                                    <td>${product.productName}</td>
                                </tr>
                                <tr>
                                    <th>Description:</th>
                                    <td>${product.description}</td>
                                </tr>
                                <tr>
                                    <th>Price:</th>
                                    <td>$${product.price}</td>
                                </tr>
                                <tr>
                                    <th>Category:</th>
                                    <td>${product.category}</td>
                                </tr>
                                <tr>
                                    <th>Status:</th>
                                    <td class="${product.availability == 'In Stock' ? 'availability-in-stock' : 'availability-out-of-stock'}">
                                        ${product.availability}
                                    </td>
                                </tr>
                                <tr>
                                    <th>Quantity:</th>
                                    <td>${product.quantity}</td>
                                </tr>
                                <tr>
                                    <th>Image Path:</th>
                                    <td>${product.imagePath}</td>
                                </tr>
                            </table>
                            
                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <button class="btn btn-sm btn-outline-primary me-md-2" 
                                        data-bs-toggle="modal" data-bs-target="#editProductModal${product.id}">
                                    <i class='bx bx-edit'></i> Edit
                                </button>
                                <button class="btn btn-sm btn-outline-danger" 
                                        data-bs-toggle="modal" data-bs-target="#deleteProductModal${product.id}">
                                    <i class='bx bx-trash'></i> Delete
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Edit Product Modal -->
                <div class="modal fade" id="editProductModal${product.id}" tabindex="-1" 
                     aria-labelledby="editProductModalLabel${product.id}" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editProductModalLabel${product.id}">Edit Product</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <form action="${pageContext.request.contextPath}/product" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="id" value="${product.id}">
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Product Name</label>
                                                <input type="text" class="form-control" name="productName" value="${product.productName}" required>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Category</label>
                                                <input type="text" class="form-control" name="category" value="${product.category}" required>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Price</label>
                                                <input type="number" step="0.01" class="form-control" name="price" value="${product.price}" required>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Availability</label>
                                                <select class="form-select" name="availability" required>
                                                    <option value="In Stock" ${product.availability == 'In Stock' ? 'selected' : ''}>In Stock</option>
                                                    <option value="Out of Stock" ${product.availability == 'Out of Stock' ? 'selected' : ''}>Out of Stock</option>
                                                </select>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Quantity</label>
                                                <input type="number" class="form-control" name="quantity" value="${product.quantity}" required>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Product Image</label>
                                                <input type="file" class="form-control" name="newImage">
                                                <small class="text-muted">Current: ${product.imagePath}</small>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Description</label>
                                        <textarea class="form-control" name="description" rows="3" required>${product.description}</textarea>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                    <button type="submit" class="btn btn-primary">Update</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Delete Product Modal -->
                <div class="modal fade" id="deleteProductModal${product.id}" tabindex="-1" 
                     aria-labelledby="deleteProductModalLabel${product.id}" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="deleteProductModalLabel${product.id}">Delete Product</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="text-center mb-3">
                                    <i class='bx bx-error-circle' style="font-size: 4rem; color: #dc3545;"></i>
                                </div>
                                <h6 class="text-center fw-bold">Confirm Deletion</h6>
                                <p class="text-center">Are you sure you want to delete "${product.productName}"?</p>
                                <p class="text-center text-danger">This action cannot be undone.</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <a href="${pageContext.request.contextPath}/product?action=delete&id=${product.id}" 
                                   class="btn btn-danger">Delete</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- Add Product Modal -->
    <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addProductModalLabel">Add New Product</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="${pageContext.request.contextPath}/product" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="add">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Product Name</label>
                                    <input type="text" class="form-control" name="productName" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Category</label>
                                    <input type="text" class="form-control" name="category" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Price</label>
                                    <input type="number" step="0.01" class="form-control" name="price" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Availability</label>
                                    <select class="form-select" name="availability" required>
                                        <option value="In Stock">In Stock</option>
                                        <option value="Out of Stock">Out of Stock</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Quantity</label>
                                    <input type="number" class="form-control" name="quantity" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Product Image</label>
                                    <input type="file" class="form-control" name="image" required>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" name="description" rows="3" required></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Add Product</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
</body>
</html>