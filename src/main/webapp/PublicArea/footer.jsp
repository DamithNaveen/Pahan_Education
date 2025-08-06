<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        footer {
            background-color: #111;
            color: white;
            padding: 50px 5% 25px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.5;
        }
        
        .footer-container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .footer-header {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
            gap: 12px;
        }
        
        .footer-logo {
            height: 35px;
            width: auto;
        }
        
        .footer-brand {
            color: #FFC107;
            font-size: 24px;
            font-weight: 700;
            text-decoration: none;
        }
        
        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 30px;
        }
        
        .footer-section h3 {
            color: #FFC107;
            font-size: 17px;
            margin-bottom: 18px;
            position: relative;
            padding-bottom: 8px;
        }
        
        .footer-section h3::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 40px;
            height: 2px;
            background-color: #FFC107;
        }
        
        .footer-section p, .footer-section a {
            color: #aaa;
            margin-bottom: 10px;
            display: block;
            font-size: 14px;
            transition: all 0.2s ease;
            text-decoration: none;
        }
        
        .footer-section a:hover {
            color: #FFC107;
            padding-left: 5px;
        }
        
        .contact-item {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            margin-bottom: 10px;
        }
        
        .contact-icon {
            color: #FFC107;
            font-size: 14px;
            margin-top: 3px;
        }
        
        .social-links {
            display: flex;
            gap: 12px;
            margin-top: 18px;
        }
        
        .social-links a {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 32px;
            height: 32px;
            background-color: #222;
            color: #FFC107;
            border-radius: 50%;
            font-size: 14px;
            transition: all 0.2s ease;
        }
        
        .social-links a:hover {
            background-color: #FFC107;
            color: #111;
        }
        
        .footer-bottom {
            text-align: center;
            margin-top: 40px;
            padding-top: 20px;
            border-top: 1px solid #333;
            color: #777;
            font-size: 13px;
        }
        
        .newsletter-input {
            display: flex;
            margin-top: 12px;
        }
        
        .newsletter-input input {
            padding: 9px 12px;
            border: none;
            background: #222;
            color: white;
            width: 100%;
            border-radius: 4px 0 0 4px;
            font-size: 13px;
        }
        
        .newsletter-input button {
            padding: 9px 15px;
            background: #FFC107;
            color: #111;
            border: none;
            cursor: pointer;
            font-weight: 600;
            border-radius: 0 4px 4px 0;
            font-size: 13px;
            white-space: nowrap;
        }
        
        @media (max-width: 768px) {
            .footer-content {
                grid-template-columns: 1fr 1fr;
                gap: 20px;
            }
        }
        
        @media (max-width: 480px) {
            .footer-content {
                grid-template-columns: 1fr;
            }
            
            .footer-header {
                justify-content: center;
            }
        }
    </style>
</head>
<body>
<footer>
    <div class="footer-container">
        <div class="footer-header">
            <img src="../images/book_logo.png" alt="Bookiee Logo" class="footer-logo">
            <a href="home.jsp" class="footer-brand">Bookiee</a>
        </div>
      
        <div class="footer-content">
            <div class="footer-section">
                <h3>Contact Us</h3>
                <div class="contact-item">
                    <i class="fas fa-phone contact-icon"></i>
                    <span>+94 76 123 4567</span>
                </div>
                <div class="contact-item">
                    <i class="fas fa-envelope contact-icon"></i>
                    <span>help@bookiee.lk</span>
                </div>
                <div class="contact-item">
                    <i class="fas fa-map-marker-alt contact-icon"></i>
                    <span>123 Book Street, Kandy</span>
                </div>
                <div class="contact-item">
                    <i class="fas fa-clock contact-icon"></i>
                    <span>Open 9am-9pm Daily</span>
                </div>
            </div>
            
            <div class="footer-section">
                <h3>Quick Links</h3>
                <a href="index.jsp"><i class="fas fa-home"></i> Home</a>
                <a href="products.jsp"><i class="fas fa-book"></i> Books</a>
                <a href="categories.jsp"><i class="fas fa-list"></i> Categories</a>
                <a href="bestsellers.jsp"><i class="fas fa-star"></i> Bestsellers</a>
            </div>
            
            <div class="footer-section">
                <h3>Customer Care</h3>
                <a href="account.jsp"><i class="fas fa-user"></i> My Account</a>
                <a href="cart.jsp"><i class="fas fa-shopping-cart"></i> Cart</a>
                <a href="orders.jsp"><i class="fas fa-truck"></i> Orders</a>
                <a href="faq.jsp"><i class="fas fa-question-circle"></i> FAQ</a>
            </div>
            
            <div class="footer-section">
                <h3>Stay Connected</h3>
                <p>Subscribe for updates and promotions</p>
                <div class="newsletter-input">
                    <input type="email" placeholder="Email address">
                    <button type="submit">Subscribe</button>
                </div>
                <div class="social-links">
                    <a href="#" title="Facebook"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" title="Twitter"><i class="fab fa-twitter"></i></a>
                    <a href="#" title="Instagram"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
        </div>
        
        <div class="footer-bottom">
            <p>&copy; 2025 Bookiee. All Rights Reserved. | <a href="privacy.jsp" style="color: #aaa;">Privacy Policy</a> | <a href="terms.jsp" style="color: #aaa;">Terms of Service</a></p>
        </div>
    </div>
</footer>
</body>
</html>