<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <link rel="icon" type="image/x-icon" href="images/MegacabLogo.png">
    <title>Pahan Edu - Sign Up</title>
    <style>
        /* General Styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f4f8;
            margin: 0;
            padding: 0;
        }

        /* Alert Styles */
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
            position: relative;
            animation: fadeIn 0.5s;
            max-width: 800px;
            margin-left: auto;
            margin-right: auto;
        }

        .alert-success {
            color: #155724;
            background-color: #d4edda;
            border-color: #c3e6cb;
        }

        .alert-danger {
            background-color: #f8d7da !important;
            border-color: #f5c6cb;
        }

        /* Header Section */
        .promo-sec {
            background: url('images/promo-bg.jpg') no-repeat center center / cover;
            padding: 80px 0;
            text-align: center;
        }

        .promo-wrap h2 {
            font-weight: 700;
            color: white;
            text-transform: uppercase;
        }

        /* Main Content */
        .main {
            padding: 50px 0;
        }

        .signup-form {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 0 auto;
        }

        .sub-title {
            font-size: 24px;
            font-weight: bold;
            border-bottom: 2px solid #f1f1f1;
            padding-bottom: 20px;
            margin-bottom: 20px;
            text-align: center;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }

        input:focus,
        textarea:focus {
            border-color: #66afe9;
            outline: none;
            box-shadow: 0 0 5px rgba(102, 175, 233, 0.5);
        }

        button {
            background-color: #4CAF50;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #45a049;
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
        }

        .login-link a {
            color: #007bff;
            text-decoration: none;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .signup-form {
                padding: 20px;
            }
            
            .promo-sec {
                padding: 50px 0;
            }
        }
    </style>
</head>

<body>

    <!-- Header Start -->
    <section class="promo-sec">
        <div class="container">
            <div class="promo-wrap text-center">
                <h2>Create Account</h2>
            </div>
        </div>
    </section>
    <!-- Header End -->

    <!-- Main Content Start -->
    <main class="main">
        <div class="container">
            <div class="signup-form">
                <h2 class="sub-title">Sign Up</h2>
                <form action="/register" method="post">
                    <div class="form-group">
                        <label for="full_name">Full Name:</label>
                        <input type="text" id="full_name" name="full_name" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    
                    
                     <div class="form-group">
                        <label for="username">UserNmae:</label>
                        <input type="username" id="emailusername" name="username" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input type="password" id="password" name="password" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="address">Address:</label>
                        <textarea id="address" name="address" rows="3" required></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label for="phone">Phone Number:</label>
                        <input type="text" id="phone" name="phone" required>
                    </div>
                    
                    <button type="submit">Register</button>
                    
                    <div class="login-link">
                        Already have an account? <a href="./signIn.jsp">Sign In</a>
                    </div>
                </form>
            </div>
        </div>
    </main>
    <!-- Main Content End -->

</body>

</html>