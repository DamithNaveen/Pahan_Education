<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.res.model.Product" %>
<%@ page import="service.ProductService" %>
<%
    try {
        ProductService productService = new ProductService();
        List<Product> productList = productService.getAllProducts();
        request.setAttribute("productList", productList);
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("errorMessage", "Error loading products: " + e.getMessage());
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="./assets/images/LogoAdmin.png">
    <title>Mega City Cab - Product Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <style>
        .product-img {
            max-width: 100px;
            max-height: 100px;
            object-fit: cover;
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
<body>
<c:if test="${empty sessionScope.user || sessionScope.user.role != 'ADMIN'}">
    <c:redirect url="/AdminArea/login.jsp" />
</c:if>
    <section id="content">
        <main class="p-4">
            <!-- Display Alert Messages -->
            <c:if test="${not empty alertMessage}">
                <div class="alert alert-${alertType} alert-dismissible fade show" role="alert">
                    ${alertMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            
            <!-- Display Error Messages -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="h3">Product Management</h1>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addProductModal">
                    <i class='bx bx-plus'></i> Add Product
                </button>
            </div>

            <c:choose>
                <c:when test="${not empty productList}">
                    <div class="card">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Image</th>
                                            <th>Product Name</th>
                                            <th>Category</th>
                                            <th>Price</th>
                                            <th>Availability</th>
                                            <th>Qty</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="product" items="${productList}">
                                            <tr>
                                                <td>${product.id}</td>
                                                <td>
                                                    <img src="${pageContext.request.contextPath}/${product.imagePath}" 
                                                         alt="Product Image" class="product-img rounded">
                                                </td>
                                                <td>${product.productName}</td>
                                                <td>${product.category}</td>
                                                <td>$${product.price}</td>
                                                <td class="${product.availability == 'In Stock' ? 'availability-in-stock' : 'availability-out-of-stock'}">
                                                    ${product.availability}
                                                </td>
                                                <td>${product.quantity}</td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" 
                                                            data-bs-target="#editProductModal${product.id}">
                                                        <i class='bx bx-edit'></i>
                                                    </button>
                                                    <button class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" 
                                                            data-bs-target="#deleteProductModal${product.id}">
                                                        <i class='bx bx-trash'></i>
                                                    </button>
                                                </td>
                                            </tr>

                                            <!-- Edit Modal -->
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
                                                                            <label for="productName" class="form-label">Product Name</label>
                                                                            <input type="text" class="form-control" id="productName" 
                                                                                   name="productName" value="${product.productName}" required>
                                                                        </div>
                                                                        <div class="mb-3">
                                                                            <label for="category" class="form-label">Category</label>
                                                                            <input type="text" class="form-control" id="category" 
                                                                                   name="category" value="${product.category}" required>
                                                                        </div>
                                                                        <div class="mb-3">
                                                                            <label for="price" class="form-label">Price</label>
                                                                            <input type="number" step="0.01" class="form-control" id="price" 
                                                                                   name="price" value="${product.price}" required>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <div class="mb-3">
                                                                            <label for="availability" class="form-label">Availability</label>
                                                                            <select class="form-select" id="availability" name="availability" required>
                                                                                <option value="In Stock" ${product.availability == 'In Stock' ? 'selected' : ''}>In Stock</option>
                                                                                <option value="Out of Stock" ${product.availability == 'Out of Stock' ? 'selected' : ''}>Out of Stock</option>
                                                                            </select>
                                                                        </div>
                                                                        <div class="mb-3">
                                                                            <label for="quantity" class="form-label">Quantity</label>
                                                                            <input type="number" class="form-control" id="quantity" 
                                                                                   name="quantity" value="${product.quantity}" required>
                                                                        </div>
                                                                        <div class="mb-3">
                                                                            <label for="newImage" class="form-label">Product Image</label>
                                                                            <input type="file" class="form-control" id="newImage" name="newImage">
                                                                            <small class="text-muted">Current: ${product.imagePath}</small>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="mb-3">
                                                                    <label for="description" class="form-label">Description</label>
                                                                    <textarea class="form-control" id="description" name="description" 
                                                                              rows="3" required>${product.description}</textarea>
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

                                            <!-- Delete Modal -->
                                            <div class="modal fade" id="deleteProductModal${product.id}" tabindex="-1" 
                                                 aria-labelledby="deleteProductModalLabel${product.id}" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="deleteProductModalLabel${product.id}">Delete Product</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="d-flex justify-content-center mb-1">
                                                                <img src="./assets/images/bin.gif" alt="" class="" width="80">
                                                            </div>
                                                            <h6 class="text-center fw-bold">You are about to delete a product</h6>
                                                            <p class="text-secondary text-center">This action will permanently delete the product. <span class="text-dark">Are you sure?</span></p>
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
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-warning">
                        No products found or unable to load products.
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </section>

    <!-- Add Product Modal -->
    <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addProductModalLabel">Add New Product</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="${pageContext.request.contextPath}/product" method="post" enctype="multipart/form-data">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="productName" class="form-label">Product Name</label>
                                    <input type="text" class="form-control" id="productName" name="productName" required>
                                </div>
                                <div class="mb-3">
                                    <label for="category" class="form-label">Category</label>
                                    <input type="text" class="form-control" id="category" name="category" required>
                                </div>
                                <div class="mb-3">
                                    <label for="price" class="form-label">Price</label>
                                    <input type="number" step="0.01" class="form-control" id="price" name="price" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="availability" class="form-label">Availability</label>
                                    <select class="form-select" id="availability" name="availability" required>
                                        <option value="In Stock">In Stock</option>
                                        <option value="Out of Stock">Out of Stock</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="quantity" class="form-label">Quantity</label>
                                    <input type="number" class="form-control" id="quantity" name="quantity" required>
                                </div>
                                <div class="mb-3">
                                    <label for="image" class="form-label">Product Image</label>
                                    <input type="file" class="form-control" id="image" name="image" required>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Submit</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
</body>
</html>