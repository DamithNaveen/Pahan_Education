<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Page - The Bookshelf</title>
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" 
          integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" 
          crossorigin="anonymous" referrerpolicy="no-referrer" />
    
    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/PublicArea/css/styles.css">
    <style>
        /* About Section */
        .about_cont {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 2rem;
            padding: 3rem 5%;
            background-color: #f9f9f9;
        }
        
        .about_cont img {
            flex: 1 1 40%;
            min-width: 300px;
            max-height: 500px;
            object-fit: cover;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        
        .about_descript {
            flex: 1 1 50%;
            min-width: 300px;
        }
        
        .about_descript h2 {
            font-size: 2rem;
            color: #333;
            margin-bottom: 1.5rem;
        }
        
        .about_descript p {
            font-size: 1.1rem;
            line-height: 1.6;
            color: #555;
            margin-bottom: 2rem;
        }
        
        /* Questions Section */
        .questions_cont {
            padding: 4rem 5%;
            text-align: center;
            background-color: #fff;
        }
        
        .questions {
            max-width: 800px;
            margin: 0 auto;
        }
        
        .questions h2 {
            font-size: 2rem;
            color: #333;
            margin-bottom: 1.5rem;
        }
        
        .questions p {
            font-size: 1.1rem;
            line-height: 1.6;
            color: #555;
            margin-bottom: 2rem;
        }
        
        .product_btn {
            display: inline-block;
            padding: 12px 30px;
            background-color: #0d6efd;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
        }
        
        .product_btn:hover {
            background-color: #0b5ed7;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        
        @media (max-width: 768px) {
            .about_cont {
                flex-direction: column;
                padding: 2rem;
            }
            
            .about_cont img,
            .about_descript {
                min-width: 100%;
            }
            
            .product_btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <section class="about_cont">
        <img src="${pageContext.request.contextPath}/images/about1.jpg" alt="Bookstore interior">
        <div class="about_descript">
            <h2>Why Choose Us?</h2>
            <p>With our extensive collection of books spanning various genres, you'll find the perfect read to satisfy your cravings. 
               Our knowledgeable staff of passionate book enthusiasts is always ready to offer personalized recommendations and guide 
               you toward hidden gems. We take pride in fostering an inclusive community, hosting engaging events, book clubs, and 
               author meet-ups. Additionally, our seamless online presence allows you to browse, explore, and order books from the 
               comfort of your home, ensuring secure transactions and timely deliveries. At The Bookshelf, customer satisfaction is 
               paramount. We are dedicated to delivering exceptional service, promptly addressing any queries or concerns. Join us in 
               celebrating the power of books to inspire, educate, and entertain. Let us be your trusted companion on your literary 
               adventures.</p>
            <button class="product_btn" onclick="window.location.href='${pageContext.request.contextPath}/PublicArea/shop.jsp'">Explore Our Collection</button>
        </div>
    </section>

    <section class="questions_cont">
        <div class="questions">
            <h2>Have Any Queries?</h2>
            <p>At The Bookshelf, we value your satisfaction and strive to provide exceptional customer service. If you have any 
               questions, concerns, or inquiries, our dedicated team is here to assist you every step of the way.</p>
            <button class="product_btn" onclick="window.location.href='${pageContext.request.contextPath}/PublicArea/contact.jsp'">Contact Us</button>
        </div>
    </section>

    <jsp:include page="footer.jsp" />
    
    <!-- JavaScript -->
    <script src="${pageContext.request.contextPath}/PublicArea/js/script.js"></script>
</body>
</html>