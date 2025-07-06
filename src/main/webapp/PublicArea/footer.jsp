<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <style>
        footer {
            background-color: #111;
            color: white;
            padding: 50px 5%;
        }
        
        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 40px;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .footer-section h3 {
            color: #FFC107;
            font-size: 20px;
            margin-bottom: 20px;
        }
        
        .footer-section p, .footer-section a {
            color: #aaa;
            margin-bottom: 10px;
            display: block;
            transition: color 0.3s;
        }
        
        .footer-section a:hover {
            color: #FFC107;
        }
        
        .social-links {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }
        
        .social-links a {
            font-size: 20px;
        }
        
        .footer-bottom {
            text-align: center;
            margin-top: 50px;
            padding-top: 20px;
            border-top: 1px solid #333;
            color: #777;
        }
    </style>
</head>
<body>
<footer>
      <div class="footer_logo_cont">
        <img src="../imagesbook_logo.png" alt="">
      <a href="home.php" class="index.jsp">Bookiee</a>
            </div>
      
      
    <div class="footer-content">
        <div class="footer-section">
            <div class="footer-section">
            <h3>Contact Info</h3>
            <p><i class="fas fa-phone"></i> 1234567890</p>
      <p><i class="fas fa-envelope"></i> bookiee@gmail.com</p>
      <p><i class="fas fa-map-marker-alt"></i> Kandy, Sri Lanka - 902839</p>
      <p><i class="fa-solid fa-shop"></i> Shop Timings : 9am - 9pm</p>
    </div>
        </div>
        
        <div class="footer-section">
            <h3>Quick Links</h3>
            <a href="index.jsp">Home</a>
            <a href="products.jsp">Books</a>
            <a href="about.jsp">About</a>
            <a href="contact.jsp">Contact</a>
        </div>
        <div class="footer-section">
            <h3>Other Links Links</h3>
            <a href="index.jsp">Login</a>
            <a href="products.jsp">Register</a>
            <a href="about.jsp">Cart</a>
            <a href="contact.jsp">Orders</a>
        </div>
        
        
    </div>
    
    <div class="footer-bottom">
        <p>&copy; 2025 The Bookshelf. All Rights Reserved.</p>
    </div>
</footer>
</body>
</html>