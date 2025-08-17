<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%
    // Handle form submission
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        // Basic validation (you can improve this)
        if (fullName != null && email != null && message != null
            && !fullName.trim().isEmpty() && !email.trim().isEmpty() && !message.trim().isEmpty()) {

            // Format message for storage/display
            String fullMessage = "Name: " + fullName + ", Phone: " + (phone == null ? "" : phone)
                    + ", Email: " + email + ", Message: " + message;

            // Retrieve or create the messages list from application scope
            List<String> messages = (List<String>) application.getAttribute("messages");
            if (messages == null) {
                messages = new ArrayList<>();
                application.setAttribute("messages", messages);
            }

            // Add the new message
            messages.add(fullMessage);

            // Redirect to avoid form resubmission and show success
            response.sendRedirect(request.getRequestURI() + "?success=1");
            return; // Important to stop further processing
        } else {
            // You may want to handle validation errors here
        }
    }
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <link rel="icon" type="image/x-icon" href="images/MegacabLogo.png" />
    <title>Mega City Cab - Contact Us</title>
    <link rel="stylesheet" href="../PublicArea/css/contact-style.css" />
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>

<body>

    <!-- Header -->
    <jsp:include page="header.jsp" />

    <!-- Promo Section -->
    <section class="promo-sec" style="background: url(../images/post-item6.jpg) no-repeat center center / cover;">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center text-white">
                    <h2 class="fw-bold text-uppercase">Contact Us</h2>
                    <nav aria-label="breadcrumb" class="w-75 mx-auto">
                        <ol class="breadcrumb justify-content-center bg-transparent p-0 mb-0">
                            <li class="breadcrumb-item"><a href="#" class="text-white">Home</a></li>
                            <li class="breadcrumb-item active text-white" aria-current="page">Contact us</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <main class="main sec-padding my-account">
        <div class="container">
            <div class="row g-5 align-items-stretch">
                <div class="col-lg-6 col-12">
                    <div class="contact-us ct-bg p-sm-5 p-4 h-100">

                        <h2 class="sub-title mb-5 border-bottom pb-4">Get in touch</h2>

                        <!-- Success alert -->
                        <c:if test="${not empty param.success}">
                            <div class="alert alert-success" role="alert">
                                Your message has been sent successfully!
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/PublicArea/contact.jsp" method="post"
                            class="needs-validation" novalidate>
                            <div class="mb-3">
                                <input class="form-control" type="text" name="fullName" placeholder="Full Name" required />
                                <div class="invalid-feedback">Please enter your full name.</div>
                            </div>
                            <div class="mb-3">
                                <input class="form-control" type="text" name="phone" placeholder="Phone" />
                                <div class="invalid-feedback">Please enter your phone number.</div>
                            </div>
                            <div class="mb-3">
                                <input class="form-control" type="email" name="email" placeholder="Email *" required />
                                <div class="invalid-feedback">Please enter a valid email address.</div>
                            </div>
                            <div class="mb-3">
                                <textarea name="message" id="message" cols="30" rows="6" placeholder="Your Message *"
                                    required class="form-control"></textarea>
                                <div class="invalid-feedback">Please enter your message.</div>
                            </div>
                            <button class="btn btn-primary mt-3" type="submit">Send Message</button>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <jsp:include page="footer.jsp" />

    <!-- Bootstrap JS Bundle (includes Popper) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Bootstrap validation script -->
    <script>
        (() => {
            'use strict';
            const forms = document.querySelectorAll('.needs-validation');
            Array.from(forms).forEach(form => {
                form.addEventListener('submit', event => {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        })();
    </script>

</body>

</html>
