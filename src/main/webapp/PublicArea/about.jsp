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
</head>
<body>
  
  
    <jsp:include page="header.jsp" />
    
    <section class="about_cont">
        <img src="../images/about1.jpg" alt="Bookstore interior">
        <div class="about_descript">
            <h2>Why Choose Us?</h2>
            <p>With our extensive collection of books spanning various genres, you'll find the perfect read to satisfy your cravings. 
               Our knowledgeable staff of passionate book enthusiasts is always ready to offer personalized recommendations and guide 
               you toward hidden gems. We take pride in fostering an inclusive community, hosting engaging events, book clubs, and 
               author meet-ups. Additionally, our seamless online presence allows you to browse, explore, and order books from the 
               comfort of your home, ensuring secure transactions and timely deliveries. At The Bookshelf, customer satisfaction is 
               paramount. We are dedicated to delivering exceptional service, promptly addressing any queries or concerns. Join us in 
               celebrating the power of books to inspire, educate, and entertain. Let us be your trusted companion on your literary 
               adventures....</p>
        </div>
    </section>

    <section class="questions_cont">
        <div class="questions">
            <h2>Have Any Queries?</h2>
            <p>At The Bookshelf, we value your satisfaction and strive to provide exceptional customer service. If you have any 
               questions, concerns, or inquiries, our dedicated team is here to assist you every step of the way.</p>
            <button class="product_btn" onclick="window.location.href='contact.jsp'">Contact Us</button>
        </div>
    </section>

    <jsp:include page="footer.jsp" />
    
    <!-- Font Awesome Kit -->
    <script src="https://kit.fontawesome.com/eedbcd0c96.js" crossorigin="anonymous"></script>
    
    <!-- JavaScript -->
    <script src="${pageContext.request.contextPath}/PublicArea/js/script.js"></script>
</body>
</html>