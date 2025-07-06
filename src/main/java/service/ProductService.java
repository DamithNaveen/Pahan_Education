package service;

import com.res.dao.ProductDAO;
import com.res.model.Product;
import java.sql.SQLException;
import java.util.List;

public class ProductService {
    private ProductDAO productDAO = new ProductDAO();

    public void addProduct(Product product) throws SQLException {
        productDAO.addProduct(product);
    }

    public List<Product> getAllProducts() throws SQLException {
        return productDAO.getAllProducts();
    }

    public void deleteProduct(int productId) throws SQLException {
        productDAO.deleteProduct(productId);
    }

    public Product getProductById(int id) throws SQLException {
        return productDAO.getProductById(id);
    }

    public void updateProduct(Product product) throws SQLException {
        productDAO.updateProduct(product);
    }
}