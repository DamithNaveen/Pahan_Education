<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>The Bookshelf - Explore Our Collection</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/PublicArea/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/PublicArea/css/home.css">
    <style>
        /* Add this new style for the confirmation modal */
        .confirmation-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }
        
        .modal-content {
            background-color: white;
            padding: 2rem;
            border-radius: 8px;
            max-width: 500px;
            width: 90%;
            text-align: center;
        }
        
        .modal-buttons {
            margin-top: 1.5rem;
            display: flex;
            justify-content: center;
            gap: 1rem;
        }
        
        .modal-btn {
            padding: 0.5rem 1.5rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        
        .modal-btn-primary {
            background-color: #0d6efd;
            color: white;
        }
        
        .modal-btn-secondary {
            background-color: #6c757d;
            color: white;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp" />

<!-- Success/Error Messages -->
<c:if test="${not empty message}">
    <div class="alert alert-success">${message}</div>
    <c:remove var="message" scope="session"/>
</c:if>
<c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
    <c:remove var="error" scope="session"/>
</c:if>

<!-- Confirmation Modal -->
<div class="confirmation-modal" id="confirmationModal">
    <div class="modal-content">
        <h3>Save Your Selections</h3>
        <p>You have items in your cart that haven't been saved. Would you like to save them before continuing?</p>
        <div class="modal-buttons">
            <button class="modal-btn modal-btn-primary" id="saveAndContinue">Save and Continue</button>
            <button class="modal-btn modal-btn-secondary" id="continueWithoutSaving">Continue Without Saving</button>
            <button class="modal-btn modal-btn-secondary" id="cancelAction">Cancel</button>
        </div>
    </div>
</div>

<section id="billboard" class="position-relative" style="background-image: url('${pageContext.request.contextPath}/images/banner-image-bg.jpg'); background-size: cover; background-position: center;">
  <div class="swiper main-swiper">
    <div class="swiper-wrapper">
      <div class="swiper-slide">
        <div class="container h-100">
          <div class="row h-100">
            
            <!-- Text Column (Left) -->
            <div class="col-md-6 text-column">
              <div class="banner-content">
              <h2 class="banner-title">The Fine Print Book Collection</h2>
                <p class="lead">Best Offer Save 30%. Grab it now!</p>
                <a href="${pageContext.request.contextPath}/PublicArea/shop.jsp" class="btn">Shop Collection</a>
              </div>
            </div>
            
            <!-- Image Column (Right) -->
            <div class="col-md-6 image-column">
              <div class="image-holder">
                <img src="${pageContext.request.contextPath}/images/banner-image2.png" 
                     class="img-fluid banner-image" 
                     alt="The Fine Print Book Collection">
              </div>
            </div>
            
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Services Section - 4 Boxes Across Screen -->
<section class="services-section">
<h2 class="banner-title">Our Advantages</h2>
<div class="services-container">
    <!-- Free Delivery -->
    <div class="service-card">
      <div class="service-icon">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="#0d6efd">
          <path d="M19 7h-.82l-1.7-4.68A2.008 2.008 0 0 0 14.6 1H12v2h2.6l1.46 4h-4.81l-.36-1H12V4H7v2h1.75l1.82 5H9.9c-.44-2.23-2.31-3.88-4.65-3.99C2.45 6.87 0 9.2 0 12c0 2.8 2.2 5 5 5 2.46 0 4.45-1.69 4.9-4h4.2c.44 2.23 2.31 3.88 4.65 3.99 2.8.13 5.25-2.06 5.25-4.8V12h-2v-2h2V9h-2V7zm-7 7H9.4l-.73-2H12v2zm0-4H8.49l-.73-2H12v2zm5 7c-1.65 0-3-1.35-3-3s1.35-3 3-3 3 1.35 3 3-1.35 3-3 3zM5 15c-1.65 0-3-1.35-3-3s1.35-3 3-3 3 1.35 3 3-1.35 3-3 3z"/>
        </svg>
      </div>
      <h3>Free Delivery</h3>
      <p>On all orders over Rs. 2000</p>
      <span class="service-badge">Limited Time</span>
    </div>

    <!-- Daily Offers -->
    <div class="service-card">
      <div class="service-icon">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="#0d6efd">
          <path d="M21 4H3c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h18c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 14H3V6h18v12z"/>
          <path d="M15 11H9V8c0-.55-.45-1-1-1s-1 .45-1 1v8c0 .55.45 1 1 1s1-.45 1-1v-3h6v3c0 .55.45 1 1 1s1-.45 1-1V8c0-.55-.45-1-1-1s-1 .45-1 1v3z"/>
        </svg>
      </div>
      <h3>Daily Offers</h3>
      <p>Up to 50% off on selected items</p>
      <span class="service-badge offer-badge">HOT DEALS</span>
    </div>

    <!-- Quality Guarantee -->
    <div class="service-card">
      <div class="service-icon">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="#0d6efd">
          <path d="M12 2L4 5v6.09c0 5.05 3.41 9.76 8 10.91 4.59-1.15 8-5.86 8-10.91V5l-8-3zm-1.06 13.54L7.4 12l1.41-1.41 2.12 2.12 4.24-4.24 1.41 1.41-5.64 5.66z"/>
        </svg>
      </div>
      <h3>Quality Guarantee</h3>
      <p>100% authentic products with 30-day returns</p>
      <span class="service-badge quality-badge">Trusted</span>
    </div>

    <!-- Secure Payment -->
    <div class="service-card">
      <div class="service-icon">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="#0d6efd">
          <path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4zm0 10.99h7c-.53 4.12-3.28 7.79-7 8.94V12H5V6.3l7-3.11V11.99z"/>
          <path d="M12 7.99h-1v6h2v-2h3v-2h-4z"/>
        </svg>
      </div>
      <h3>Secure Payment</h3>
      <p>256-bit SSL encrypted checkout</p>
      <span class="service-badge secure-badge">Protected</span>
    </div>
  </div>
</section>

<section class="products_cont" id="products">
    <h2 class="banner-title">Featured Books</h2>
    <div class="pro_box_cont">
        <!-- Product 1 -->
        <div class="pro_box">
            <img src="${pageContext.request.contextPath}/images/book1.jpg" alt="Book Cover">
            <h3>The Great Gatsby</h3>
            <p>Rs. 1200/-</p>
            <form action="${pageContext.request.contextPath}/AddToCartServlet" method="post" class="product-form">
                <input type="number" name="quantity" min="1" value="1">
                <input type="hidden" name="book_id" value="1">
                <input type="hidden" name="book_name" value="The Great Gatsby">
                <input type="hidden" name="price" value="1200">
                <input type="hidden" name="image" value="book1.jpg">
                <button type="submit" class="product_btn">Add to Cart</button>
            </form>
        </div>
        
        <!-- Product 2 -->
        <div class="pro_box">
            <img src="${pageContext.request.contextPath}/images/book2.jpg" alt="Book Cover">
            <h3>To Kill a Mockingbird</h3>
            <p>Rs. 950/-</p>
            <form action="${pageContext.request.contextPath}/AddToCartServlet" method="post" class="product-form">
                <input type="number" name="quantity" min="1" value="1">
                <input type="hidden" name="book_id" value="2">
                <input type="hidden" name="book_name" value="To Kill a Mockingbird">
                <input type="hidden" name="price" value="950">
                <input type="hidden" name="image" value="book2.jpg">
                <button type="submit" class="product_btn">Add to Cart</button>
            </form>
        </div>
        
        <!-- Product 3 -->
        <div class="pro_box">
            <img src="${pageContext.request.contextPath}/images/book3.jpg" alt="Book Cover">
            <h3>The Psychology of Money</h3>
            <p>Rs. 1150/-</p>
            <form action="${pageContext.request.contextPath}/AddToCartServlet" method="post" class="product-form">
                <input type="number" name="quantity" min="1" value="1">
                <input type="hidden" name="book_id" value="3">
                <input type="hidden" name="book_name" value="The Psychology of Money">
                <input type="hidden" name="price" value="1150">
                <input type="hidden" name="image" value="book3.jpg">
                <button type="submit" class="product_btn">Add to Cart</button>
            </form>
        </div>
        
        <button class="see-more-btn product_btn" id="seeMoreBtn">See More</button>
    </div>
</section>

<section class="about_cont">
    <img src="${pageContext.request.contextPath}/images/about.jpg" alt="Bookstore Interior">
    <div class="about_descript">
        <h2>Discover Our Story</h2>
        <p>At Bookiee, we are passionate about connecting readers with captivating stories, inspiring ideas, and a world of knowledge. Our bookstore is more than just a place to buy books; it's a haven for book enthusiasts, where the love for literature thrives.</p>
        <button class="product_btn" onclick="window.location.href='about.jsp';">Read More</button>
    </div>
</section>

<section id="testimonials" style="background-image: url('${pageContext.request.contextPath}/images/Customer-review.jpg');">
  <div class="testimonial-overlay"></div>
  <div class="container">
    <div class="testimonial-card">
      <h2 class="banner-title">What Our Readers Say</h2>
      <div class="testimonial-slider">
        <div class="testimonial active">
          <p class="testimonial-text">"This bookstore has the best collection of classics I've ever seen. Fast delivery and perfect packaging!"</p>
          <p class="testimonial-author">- Sarah M.</p>
        </div>
        <div class="testimonial">
          <p class="testimonial-text">"I'm impressed with their daily deals. Saved over 40% on my favorite books this month!"</p>
          <p class="testimonial-author">- James K.</p>
        </div>
        <div class="testimonial">
          <p class="testimonial-text">"Customer service resolved my issue within hours. Will definitely shop here again!"</p>
          <p class="testimonial-author">- Priya R.</p>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Questions Section -->
<section class="questions_cont">
    <div class="questions">
        <h2>Have Any Queries?</h2>
        <p>At Bookiee, we value your satisfaction and strive to provide exceptional customer service. If you have any questions, concerns, or inquiries, our dedicated team is here to assist you every step of the way.</p>
        <button class="product_btn" onclick="window.location.href='${pageContext.request.contextPath}/contact.jsp';">Contact Us</button>
    </div>
</section>

<jsp:include page="footer.jsp" />

<!-- JavaScript at the bottom of the body -->
<script src="${pageContext.request.contextPath}/PublicArea/js/review.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    const seeMoreBtn = document.getElementById('seeMoreBtn');
    const productForms = document.querySelectorAll('.product-form');
    const modal = document.getElementById('confirmationModal');
    const saveAndContinueBtn = document.getElementById('saveAndContinue');
    const continueWithoutSavingBtn = document.getElementById('continueWithoutSaving');
    const cancelActionBtn = document.getElementById('cancelAction');
    
    // Track if any form has been modified
    let formsModified = false;
    
    // Add event listeners to all product forms
    productForms.forEach(form => {
        const quantityInput = form.querySelector('input[type="number"]');
        const originalValue = quantityInput.value;
        
        quantityInput.addEventListener('change', function() {
            if (this.value !== originalValue) {
                formsModified = true;
            }
        });
    });
    
    // See More button click handler
    seeMoreBtn.addEventListener('click', function(e) {
        if (formsModified) {
            e.preventDefault();
            modal.style.display = 'flex';
        } else {
            window.location.href = '${pageContext.request.contextPath}/PublicArea/shop.jsp';
        }
    });
    
    // Modal button handlers
    saveAndContinueBtn.addEventListener('click', function() {
        // Submit all modified forms
        productForms.forEach(form => {
            const quantityInput = form.querySelector('input[type="number"]');
            const originalValue = quantityInput.dataset.originalValue || quantityInput.defaultValue;
            
            if (quantityInput.value !== originalValue) {
                // Create a hidden input to indicate this is a save action
                const hiddenInput = document.createElement('input');
                hiddenInput.type = 'hidden';
                hiddenInput.name = 'save_and_continue';
                hiddenInput.value = 'true';
                form.appendChild(hiddenInput);
                
                // Submit the form via AJAX
                fetch(form.action, {
                    method: 'POST',
                    body: new FormData(form)
                }).then(response => {
                    if (response.ok) {
                        window.location.href = '${pageContext.request.contextPath}/PublicArea/shop.jsp';
                    }
                });
            }
        });
        
        // If no forms need submitting, just redirect
        window.location.href = '${pageContext.request.contextPath}/PublicArea/shop.jsp';
    });
    
    continueWithoutSavingBtn.addEventListener('click', function() {
        modal.style.display = 'none';
        window.location.href = '${pageContext.request.contextPath}/PublicArea/shop.jsp';
    });
    
    cancelActionBtn.addEventListener('click', function() {
        modal.style.display = 'none';
    });
});
</script>
</body>
</html>