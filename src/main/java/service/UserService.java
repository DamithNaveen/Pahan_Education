package service;

import com.res.dao.UserDAO;
import com.res.model.User;
import com.res.model.UserRole;

import java.sql.SQLException;
import java.util.List;

public class UserService {
    private UserDAO userDAO = new UserDAO();

    public static final int AUTH_SUCCESS = 0;
    public static final int INVALID_EMAIL = 1;
    public static final int INVALID_PASSWORD = 2;
    public static final int INVALID_ROLE = 3;

    public int authenticateUser(String email, String password, String role) throws SQLException {
        return userDAO.authenticate(email, password, role);
    }

    public User getUserByEmail(String email) throws SQLException {
        return userDAO.getUserByEmail(email);
    }
    
    public User getUserById(int id) throws SQLException {
        return userDAO.getUserById(id);
    }
    
    public List<User> getAllUsers() throws SQLException {
        return userDAO.getAllUsers();
    }
    
    public void addUser(User user) throws SQLException {
        userDAO.addUser(user);
    }
    
    public void updateUser(User user) throws SQLException {
        userDAO.updateUser(user);
    }
    
    public void deleteUser(int id) throws SQLException {
        userDAO.deleteUser(id);
    }
    
    public boolean isEmailExists(String email) throws SQLException {
        return userDAO.isEmailExists(email);
    }
}