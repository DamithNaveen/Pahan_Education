<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Results</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
        }
        .results {
            margin-top: 20px;
        }
        .result-item {
            border-bottom: 1px solid #ddd;
            padding: 10px 0;
        }
        /* Style for search form */
        form#searchForm {
            margin-bottom: 20px;
        }
        form#searchForm input[type="text"] {
            padding: 8px;
            font-size: 1rem;
            width: 300px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        form#searchForm button {
            padding: 8px 12px;
            font-size: 1rem;
            border: none;
            background-color: #28a745;
            color: white;
            border-radius: 4px;
            cursor: pointer;
            margin-left: 5px;
        }
        form#searchForm button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp" />

<h1>Search Results</h1>

<!-- Add search form here -->
<form id="searchForm" action="search.jsp" method="get" role="search" aria-label="Search products">
    <input 
        type="text" 
        name="query" 
        id="searchInput" 
        placeholder="Search products..." 
        value="<%= request.getParameter("query") != null ? request.getParameter("query") : "" %>" 
        required 
        aria-label="Search products"
    />
    <button type="submit" title="Search">Search</button>
</form>

<%
    String searchQuery = request.getParameter("query");
    if (searchQuery == null || searchQuery.trim().isEmpty()) {
%>
    <p>Please enter a search term.</p>
<%
    } else {
        searchQuery = searchQuery.trim();

        // Mock product list — replace with your DB query logic
        class Product {
            String name, description;
            Product(String n, String d) { name = n; description = d; }
        }

        java.util.List<Product> products = new java.util.ArrayList<>();
        products.add(new Product("Java Programming Book", "Learn Java step-by-step"));
        products.add(new Product("Spring Boot Guide", "Comprehensive Spring Boot tutorial"));
        products.add(new Product("Python Cookbook", "Recipes for Python programming"));
        products.add(new Product("Cooking Basics", "Learn cooking from scratch"));

        // Filter products by query (case-insensitive)
        java.util.List<Product> matchedProducts = new java.util.ArrayList<>();
        for (Product p : products) {
            if (p.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
                p.description.toLowerCase().contains(searchQuery.toLowerCase())) {
                matchedProducts.add(p);
            }
        }
%>

    <p>Showing results for: <strong><%= searchQuery %></strong></p>

    <div class="results">
    <c:choose>
        <c:when test="${not empty matchedProducts}">
            <%
                for (Product p : matchedProducts) {
            %>
                <div class="result-item">
                    <h3><%= p.name %></h3>
                    <p><%= p.description %></p>
                </div>
            <%
                }
            %>
        </c:when>
        <c:otherwise>
            <p>No products found matching your search.</p>
        </c:otherwise>
    </c:choose>
    </div>

<%
    }
%>

<jsp:include page="footer.jsp" />
</body>
</html>
