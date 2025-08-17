package com.res.dao;

import com.res.model.Product;
import util.DatabaseUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    public void addProduct(Product product) throws SQLException {
        String sql = "INSERT INTO products (product_name, price, availability, quantity, image_path) " +
                     "VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, product.getProductName());
            pstmt.setDouble(2, product.getPrice());
            pstmt.setString(3, product.getAvailability());
            pstmt.setInt(4, product.getQuantity());
            pstmt.setString(5, product.getImagePath());
            pstmt.executeUpdate();
        }
    }

    public List<Product> getAllProducts() throws SQLException {
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT * FROM products ORDER BY id DESC";
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setProductName(rs.getString("product_name"));
                product.setPrice(rs.getDouble("price"));
                product.setAvailability(rs.getString("availability"));
                product.setQuantity(rs.getInt("quantity"));
                product.setImagePath(rs.getString("image_path"));
                productList.add(product);
            }
        }
        return productList;
    }

    public void deleteProduct(int productId) throws SQLException {
        String sql = "DELETE FROM products WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, productId);
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Deleting product failed, no rows affected.");
            }
        }
    }

    public Product getProductById(int id) throws SQLException {
        String sql = "SELECT * FROM products WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Product product = new Product();
                    product.setId(rs.getInt("id"));
                    product.setProductName(rs.getString("product_name"));
                    product.setPrice(rs.getDouble("price"));
                    product.setAvailability(rs.getString("availability"));
                    product.setQuantity(rs.getInt("quantity"));
                    product.setImagePath(rs.getString("image_path"));
                    return product;
                }
            }
        }
        return null;
    }

    public void updateProduct(Product product) throws SQLException {
        String sql = "UPDATE products SET product_name = ?, price = ?, " +
                     "availability = ?, quantity = ?, image_path = ? WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, product.getProductName());
            pstmt.setDouble(2, product.getPrice());
            pstmt.setString(3, product.getAvailability());
            pstmt.setInt(4, product.getQuantity());
            pstmt.setString(5, product.getImagePath());
            pstmt.setInt(6, product.getId());
            pstmt.executeUpdate();
        }
    }
}