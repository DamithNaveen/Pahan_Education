package com.res.controller;

import com.res.model.Product;
import service.ProductService;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.UUID;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/product")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,    // 1MB
    maxFileSize = 1024 * 1024 * 5,      // 5MB
    maxRequestSize = 1024 * 1024 * 5 * 5 // 25MB
)
public class ProductServlet extends HttpServlet {
    private ProductService productService;
    private static final String UPLOAD_DIRECTORY = "product_images";

    @Override
    public void init() throws ServletException {
        super.init();
        productService = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        
        try {
            if ("edit".equals(action)) {
                handleEditRequest(request, response, session);
            } else if ("delete".equals(action)) {
                handleDeleteRequest(request, response, session);
            } else {
                handleListRequest(request, response, session);
            }
        } catch (Exception e) {
            handleError(session, "Error processing request: " + e.getMessage(), e);
            response.sendRedirect(request.getContextPath() + "/AdminArea/product.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        
        try {
            if ("update".equals(action)) {
                updateProduct(request, response, session);
            } else if ("delete".equals(action)) {
                handleDeleteRequest(request, response, session);
            } else {
                addProduct(request, response, session);
            }
        } catch (Exception e) {
            handleError(session, "Error processing request: " + e.getMessage(), e);
            response.sendRedirect(request.getContextPath() + "/AdminArea/product.jsp");
        }
    }

    private void handleEditRequest(HttpServletRequest request, HttpServletResponse response, HttpSession session) 
            throws SQLException, ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("id"));
        Product product = productService.getProductById(productId);
        
        if (product == null) {
            handleError(session, "Product not found with ID: " + productId, null);
            response.sendRedirect(request.getContextPath() + "/AdminArea/product.jsp");
            return;
        }
        
        request.setAttribute("product", product);
        request.getRequestDispatcher("/AdminArea/edit_product.jsp").forward(request, response);
    }

    private void handleDeleteRequest(HttpServletRequest request, HttpServletResponse response, HttpSession session) 
            throws SQLException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("id"));
            
            Product product = productService.getProductById(productId);
            if (product == null) {
                session.setAttribute("alertMessage", "Product not found with ID: " + productId);
                session.setAttribute("alertType", "danger");
                response.sendRedirect(request.getContextPath() + "/AdminArea/product.jsp");
                return;
            }
            
            productService.deleteProduct(productId);
            
            if (product.getImagePath() != null && !product.getImagePath().isEmpty()) {
                String imagePath = getServletContext().getRealPath("") + product.getImagePath();
                File imageFile = new File(imagePath);
                if (imageFile.exists()) {
                    imageFile.delete();
                }
            }
            
            List<Product> productList = productService.getAllProducts();
            session.setAttribute("productList", productList);
            
            session.setAttribute("alertMessage", "Product deleted successfully!");
            session.setAttribute("alertType", "success");
        } catch (NumberFormatException e) {
            session.setAttribute("alertMessage", "Invalid product ID format");
            session.setAttribute("alertType", "danger");
        } catch (SQLException e) {
            session.setAttribute("alertMessage", "Database error while deleting product");
            session.setAttribute("alertType", "danger");
            e.printStackTrace();
        }
        
        response.sendRedirect(request.getContextPath() + "/AdminArea/product.jsp");
    }

    private void handleListRequest(HttpServletRequest request, HttpServletResponse response, HttpSession session) 
            throws SQLException, ServletException, IOException {
        List<Product> productList = productService.getAllProducts();
        session.setAttribute("productList", productList);
        request.getRequestDispatcher("/AdminArea/product.jsp").forward(request, response);
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response, HttpSession session) 
            throws SQLException, IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        String productName = request.getParameter("productName");
        double price = Double.parseDouble(request.getParameter("price"));
        String availability = request.getParameter("availability");
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Product product = productService.getProductById(id);
        if (product == null) {
            handleError(session, "Product not found with ID: " + id, null);
            response.sendRedirect(request.getContextPath() + "/AdminArea/product.jsp");
            return;
        }

        product.setProductName(productName);
        product.setPrice(price);
        product.setAvailability(availability);
        product.setQuantity(quantity);

        Part filePart = request.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            if (product.getImagePath() != null && !product.getImagePath().isEmpty()) {
                String oldImagePath = getServletContext().getRealPath("") + product.getImagePath();
                File oldImageFile = new File(oldImagePath);
                if (oldImageFile.exists()) {
                    oldImageFile.delete();
                }
            }
            
            String imagePath = handleFileUpload(filePart);
            if (imagePath != null) {
                product.setImagePath(imagePath);
            }
        }

        productService.updateProduct(product);
        
        List<Product> productList = productService.getAllProducts();
        session.setAttribute("productList", productList);
        
        session.setAttribute("alertMessage", "Product updated successfully!");
        session.setAttribute("alertType", "success");
        response.sendRedirect(request.getContextPath() + "/AdminArea/product.jsp");
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response, HttpSession session) 
            throws SQLException, IOException, ServletException {
        String productName = request.getParameter("productName");
        double price = Double.parseDouble(request.getParameter("price"));
        String availability = request.getParameter("availability");
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Part filePart = request.getPart("image");
        if (filePart == null || filePart.getSize() == 0) {
            handleError(session, "Product image is required", null);
            response.sendRedirect(request.getContextPath() + "/AdminArea/product.jsp");
            return;
        }

        String imagePath = handleFileUpload(filePart);
        if (imagePath == null) {
            handleError(session, "Failed to upload product image", null);
            response.sendRedirect(request.getContextPath() + "/AdminArea/product.jsp");
            return;
        }

        Product product = new Product(productName, price, availability, quantity, imagePath);
        productService.addProduct(product);
        
        List<Product> productList = productService.getAllProducts();
        session.setAttribute("productList", productList);
        
        session.setAttribute("alertMessage", "New product added successfully!");
        session.setAttribute("alertType", "success");
        response.sendRedirect(request.getContextPath() + "/AdminArea/product.jsp");
    }

    private String handleFileUpload(Part filePart) throws IOException {
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String fileExtension = fileName.substring(fileName.lastIndexOf("."));
        String newFileName = UUID.randomUUID().toString() + fileExtension;
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        
        String filePath = uploadPath + File.separator + newFileName;
        filePart.write(filePath);
        
        return UPLOAD_DIRECTORY + File.separator + newFileName;
    }

    private void handleError(HttpSession session, String message, Exception e) {
        session.setAttribute("alertMessage", message);
        session.setAttribute("alertType", "danger");
        if (e != null) {
            e.printStackTrace();
        }
    }
}