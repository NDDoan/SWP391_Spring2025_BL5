<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reset Password - Electro Mart</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Google Fonts + Font Awesome -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #1e3c72, #2a5298);
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* HEADER */
        .header {
            background-color: #1e3c72;
            color: white;
            padding: 15px 25px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .header-container {
            max-width: 1200px;
            margin: auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
        }

        .logo {
            font-size: 24px;
            font-weight: 600;
            color: #a9d6ff;
        }

        .nav-links, .user-actions {
            display: flex;
            gap: 20px;
            align-items: center;
        }

        .nav-links a, .user-actions a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s;
        }

        .nav-links a:hover, .user-actions a:hover {
            color: #a9d6ff;
        }

        @media screen and (max-width: 768px) {
            .header-container {
                flex-direction: column;
                align-items: flex-start;
            }

            .nav-links, .user-actions {
                margin-top: 10px;
                flex-direction: column;
                width: 100%;
            }

            .nav-links a, .user-actions a {
                padding: 8px 0;
            }
        }

        /* FORM RESET PASSWORD */
        .forgot-password-container {
            background-color: #fff;
            padding: 35px 30px;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 420px;
            margin: 60px auto 30px auto;
            text-align: center;
            animation: fadeIn 0.7s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-15px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .forgot-password-container h1 {
            color: #1e3c72;
            font-size: 26px;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .forgot-password-container p {
            font-size: 14px;
            color: #444;
            margin-bottom: 20px;
        }

        .input-group {
            position: relative;
            margin-bottom: 20px;
        }

        .input-group input {
            width: 100%;
            padding: 14px 15px 14px 45px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
        }

        .input-group i {
            position: absolute;
            top: 50%;
            left: 15px;
            transform: translateY(-50%);
            color: #777;
        }

        .forgot-password-container input[type="submit"] {
            background-color: #1e3c72;
            color: #fff;
            border: none;
            padding: 14px;
            width: 100%;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .forgot-password-container input[type="submit"]:hover {
            background-color: #163062;
        }

        .forgot-password-container a {
            display: block;
            margin-top: 15px;
            color: #1e3c72;
            text-decoration: none;
            font-size: 14px;
        }

        .forgot-password-container a:hover {
            color: #2a5298;
        }

        .message {
            margin-bottom: 15px;
            padding: 10px 15px;
            border-radius: 8px;
            font-size: 14px;
        }

        .message.error {
            background-color: #ff4d4d;
            color: #fff;
        }

        .message.success {
            background-color: #2ecc71;
            color: #fff;
        }

        /* FOOTER */
        .footer {
            background-color: #1e3c72;
            color: #fff;
            padding: 40px 20px;
            font-size: 14px;
            margin-top: auto;
        }

        .footer-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            max-width: 1100px;
            margin: 0 auto;
            gap: 30px;
        }

        .footer-section {
            flex: 1;
            min-width: 250px;
        }

        .footer-section h3 {
            font-size: 18px;
            margin-bottom: 15px;
            color: #a9d6ff;
        }

        .footer-section p {
            margin: 8px 0;
            line-height: 1.5;
        }

        .footer-section i {
            margin-right: 8px;
            color: #a9d6ff;
        }

        .footer-section a {
            color: #fff;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer-section a:hover {
            color: #a9d6ff;
        }
    </style>
</head>
<body>

<!-- HEADER -->
<header class="header">
    <div class="header-container">
        <div class="logo">Electro Mart</div>
        <nav class="nav-links">
            <a href="home.jsp">Home</a>
            <a href="products.jsp">Products</a>
            <a href="about.jsp">About</a>
            <a href="contact.jsp">Contact</a>
        </nav>
        <div class="user-actions">
            <a href="login.jsp"><i class="fas fa-sign-in-alt"></i> Login</a>
            <a href="register.jsp"><i class="fas fa-user-plus"></i> Register</a>
        </div>
    </div>
</header>

<!-- RESET FORM -->
<%
    String errorMessage = (String) request.getAttribute("errorMessage");
    String successMessage = (String) request.getAttribute("successMessage");
%>

<div class="forgot-password-container">
    <h1>Forgot Password</h1>
    <p>Please enter your email to recover your password</p>

    <% if (errorMessage != null) { %>
        <div class="message error"><%= errorMessage %></div>
    <% } %>
    <% if (successMessage != null) { %>
        <div class="message success"><%= successMessage %></div>
    <% } %>

    <form action="ForgotPasswordServlet" method="post">
        <div class="input-group">
            <i class="fas fa-envelope"></i>
            <input type="email" name="email" placeholder="Enter your email" required>
        </div>
        <input type="submit" value="Recover Password">
    </form>
    <a href="login.jsp">Back to login</a>
</div>

<!-- FOOTER -->
<footer class="footer">
    <div class="footer-container">
        <div class="footer-section">
            <h3>Contact</h3>
            <p><i class="fas fa-envelope"></i> contact@electromart.com</p>
            <p><i class="fas fa-phone-alt"></i> +84 123 456 789</p>
            <p><i class="fas fa-map-marker-alt"></i> 123 Tech Street, Hanoi</p>
        </div>
        <div class="footer-section">
            <h3>Customer Support</h3>
            <p><a href="#">FAQs</a></p>
            <p><a href="#">Return Policy</a></p>
            <p><a href="#">Shipping Info</a></p>
        </div>
        <div class="footer-section">
            <h3>About Us</h3>
            <p><strong>Nhóm 2 - SWP391.BL5</strong></p>
            <p>&copy; 2025 Electro Mart.</p>
        </div>
    </div>
</footer>

</body>
</html>
