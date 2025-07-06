<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>The Bookshelf - Explore Our Collection</title>
    <link rel="stylesheet" href="../PublicArea/css/styles.css">
        <link rel="stylesheet" href="../PublicArea/css/home.css">
    
    
</head>
<body>
<jsp:include page="header.jsp" />

<section class="hero">
    <div class="content">
        <h1>THE BOOKSHELF<span class="dot"></span></h1>
        <p>Explore, Discover, and Buy Your Favorite Books</p>
        <a href="#products" class="btn">Discover More</a>
    </div>
</section>

<section class="products_cont" id="products">
    <h2 class="section-title">Featured Books</h2>
    <div class="pro_box_cont">
        <!-- Products will be dynamically inserted here -->
        <div class="pro_box">
            <img src="${pageContext.request.contextPath}/images/book1.jpg" alt="Book Cover">
            <h3>The Great Gatsby</h3>
            <p>Rs. 1200/-</p>
            <form action="" method="post">
                <input type="number" name="product_quantity" min="1" value="1">
                <input type="hidden" name="product_name" value="The Great Gatsby">
                <input type="hidden" name="product_price" value="1200">
                <input type="hidden" name="product_image" value="book1.jpg">
                <input type="submit" value="Add to Cart" name="add_to_cart" class="product_btn">
            </form>
        </div>
        
        <div class="pro_box">
            <img src="${pageContext.request.contextPath}/images/book2.jpg" alt="Book Cover">
            <h3>To Kill a Mockingbird</h3>
            <p>Rs. 950/-</p>
            <form action="" method="post">
                <input type="number" name="product_quantity" min="1" value="1">
                <input type="hidden" name="product_name" value="To Kill a Mockingbird">
                <input type="hidden" name="product_price" value="950">
                <input type="hidden" name="product_image" value="book2.jpg">
                <input type="submit" value="Add to Cart" name="add_to_cart" class="product_btn">
            </form>
        </div>
        
        <!-- Add more books as needed -->
    </div>
</section>

<section class="about_cont">
    <img src="../images/about.png" alt="Bookstore Interior">
    <div class="about_descript">
        <h2>Discover Our Story</h2>
        <p>At Bookiee, we are passionate about connecting readers with captivating stories, inspiring ideas, and a world of knowledge. Our bookstore is more than just a place to buy books; it's a haven for book enthusiasts, where the love for literature thrives.</p>
        <button class="product_btn" onclick="window.location.href='about.jsp';">Read More</button>
    </div>
</section>

<section class="questions_cont">
    <div class="questions">
        <h2>Have Any Queries?</h2>
        <p>At Bookiee, we value your satisfaction and strive to provide exceptional customer service. If you have any questions, concerns, or inquiries, our dedicated team is here to assist you every step of the way.</p>
        <button class="product_btn" onclick="window.location.href='contact.jsp';">Contact Us</button>
    </div>
</section>

<jsp:include page="footer.jsp" />

<script>
// FAQ functionality from original code
document.addEventListener('DOMContentLoaded', function() {
    const faqItems = document.querySelectorAll('.faq-item');
    
    faqItems.forEach(item => {
        const question = item.querySelector('.faq-question');
        question.addEventListener('click', () => {
            item.classList.toggle('active');
        });
    });
});
</script>
</body>
</html>