<!DOCTYPE html>
<html lang="zxx">

<head>
   <meta charset="utf-8">
   <meta http-equiv="x-ua-compatible" content="ie=edge">
    <link rel="icon" type="image/x-icon" href="images/MegacabLogo.png">
   <title>Mega City Cab - Contact Us</title>
   <link rel="stylesheet" href="../PublicArea/css/contact-style.css">
   
</head>

<body>

   <!-- Header Start -->
   <jsp:include page="header.jsp" />
   
   <!-- Header End -->

   <!-- Promo Start -->
  	<section class="promo-sec" style="background: url('images/promo-bg.jpg')no-repeat center center / cover;">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="promo-wrap text-center">
						<h2 class="fw-bold text-white text-uppercase">Contact Us</h2>
						<nav aria-label="breadcrumb w-75 mx-auto">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="#">Home</a></li>
								<li class="breadcrumb-item active" aria-current="page">Contact us</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Promo End -->

	<!-- Main Start -->
	<main class="main sec-padding my-account">
		<div class="container">
			<div class="row g-5 align-self-stretch">
				<div class="col-lg-6 col-12">
					<div class="contact-us ct-bg p-sm-5 p-4 h-100">
						<h2 class="sub-title mb-5 border-bottom pb-4">Get in touch</h2>
					<form action="${pageContext.request.contextPath}/contact" method="post" class="needs-validation" novalidate>
    <div class="mb-3">
        <input class="form-control" type="text" name="fullName" placeholder="Full Name" required>
        <div class="invalid-feedback">Please enter your full name.</div>
    </div>
    <div class="mb-3">
        <input class="form-control" type="text" name="phone" placeholder="Phone" required>
        <div class="invalid-feedback">Please enter your phone number.</div>
    </div>
    <div class="mb-3">
        <input class="form-control" type="email" name="email" placeholder="Email *" required>
        <div class="invalid-feedback">Please enter a valid email address.</div>
    </div>
    <div class="mb-3">
        <textarea name="message" id="message" cols="30" rows="6" placeholder="Your Message *" required></textarea>
        <div class="invalid-feedback">Please enter your message.</div>
    </div>
    <button class="btn btn-primary mt-3" type="submit">Send Message</button>
</form>
						
					</div>
				</div>
				<div class="col-lg-6 col-12">
					<div class="google-map h-100">
					<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d31686.935910965352!2d79.82220378327033!3d6.906504600741854!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x27f960a55105e731%3A0x6121cab6b3bc6334!2sSri%20Lankan%20Cab%20Service!5e0!3m2!1sen!2slk!4v1740774348614!5m2!1sen!2slk" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
					</div>

				</div>

			</div>
		</div>
	</main>
   
   <!-- Footer Start -->
   <jsp:include page="footer.jsp" />
   <!-- Footer End -->

</body>
</html>
