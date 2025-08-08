package com.res.controller;

import com.res.model.Product;
import service.ProductService;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

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
        try {
            request.setAttribute("productList", productService.getAllProducts());
            request.getRequestDispatcher("/AdminArea/product.jsp").forward(request, response);
        } catch (Exception e) {
            session.setAttribute("alertMessage", "Error loading products: " + e.getMessage());
            session.setAttribute("alertType", "danger");
            response.sendRedirect(request.getContextPath() + "/product");
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
            } else {
                addProduct(request, response, session);
            }
        } catch (Exception e) {
            session.setAttribute("alertMessage", "Error processing request: " + e.getMessage());
            session.setAttribute("alertType", "danger");
            response.sendRedirect(request.getContextPath() + "/product");
        }
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response, HttpSession session) 
            throws SQLException, IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        String productName = request.getParameter("productName");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        String category = request.getParameter("category");
        String availability = request.getParameter("availability");
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Product product = productService.getProductById(id);
        if (product == null) {
            session.setAttribute("alertMessage", "Product not found with ID: " + id);
            session.setAttribute("alertType", "danger");
            response.sendRedirect(request.getContextPath() + "/product");
            return;
        }

        product.setProductName(productName);
        product.setDescription(description);
        product.setPrice(price);
        product.setCategory(category);
        product.setAvailability(availability);
        product.setQuantity(quantity);

        Part filePart = request.getPart("newImage");
        if (filePart != null && filePart.getSize() > 0) {
            String imagePath = handleFileUpload(filePart);
            if (imagePath != null) {
                product.setImagePath(imagePath);
            }
        }

        productService.updateProduct(product);
        session.setAttribute("alertMessage", "Product updated successfully!");
        session.setAttribute("alertType", "success");
        response.sendRedirect(request.getContextPath() + "/product");
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response, HttpSession session) 
            throws SQLException, IOException, ServletException {
        String productName = request.getParameter("productName");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        String category = request.getParameter("category");
        String availability = request.getParameter("availability");
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Part filePart = request.getPart("image");
        if (filePart == null || filePart.getSize() == 0) {
            session.setAttribute("alertMessage", "Product image is required");
            session.setAttribute("alertType", "danger");
            response.sendRedirect(request.getContextPath() + "/product");
            return;
        }

        String imagePath = handleFileUpload(filePart);
        if (imagePath == null) {
            session.setAttribute("alertMessage", "Failed to upload product image");
            session.setAttribute("alertType", "danger");
            response.sendRedirect(request.getContextPath() + "/product");
            return;
        }

        Product product = new Product(productName, description, price, category, availability, quantity, imagePath);
        productService.addProduct(product);
        session.setAttribute("alertMessage", "New product added successfully!");
        session.setAttribute("alertType", "success");
        response.sendRedirect(request.getContextPath() + "/product");
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
}
