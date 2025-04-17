<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng Ký - Electro Mart</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Font + Icon -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
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

        /* ĐĂNG KÝ */
        .register-container {
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            max-width: 480px;
            margin: 60px auto 30px auto;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }

        .register-container h1 {
            color: #1e3c72;
            font-size: 26px;
            margin-bottom: 20px;
            text-align: center;
        }

        .input-group {
            position: relative;
            margin-bottom: 15px;
        }

        .input-group input, .input-group select {
            width: 100%;
            padding: 12px 15px 12px 45px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
        }

        .input-group i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #777;
        }

        .register-container input[type="submit"] {
            background: #1e3c72;
            color: #fff;
            border: none;
            padding: 14px;
            border-radius: 8px;
            width: 100%;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
        }

        .register-container input[type="submit"]:hover {
            background: #163062;
        }

        .register-container a {
            display: block;
            margin-top: 15px;
            color: #1e3c72;
            font-size: 14px;
            text-align: center;
        }

        .register-container a:hover {
            color: #2a5298;
        }

        .error-message {
            background: #ff4d4d;
            color: white;
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            animation: fadeIn 0.5s ease-in-out;
        }

        .error-message ul {
            list-style: disc;
            padding-left: 20px;
            margin: 0;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
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

<!-- HIỂN THỊ LỖI -->
<%
    List<String> errors = (List<String>) request.getAttribute("errors");
    if (errors != null && !errors.isEmpty()) {
%>
<div class="error-message" style="max-width: 480px; margin: 20px auto;">
    <ul>
        <% for (String error : errors) { %>
            <li><%= error %></li>
        <% } %>
    </ul>
</div>
<% } %>

<!-- FORM ĐĂNG KÝ -->
<div class="register-container">
    <h1>Register</h1>
    <form action="${pageContext.request.contextPath}/registercontroller" method="post">
        <div class="input-group">
            <i class="fas fa-user"></i>
            <input type="text" name="fullname" placeholder="Full Name" required>
        </div>
        <div class="input-group">
            <i class="fas fa-envelope"></i>
            <input type="email" name="email" placeholder="Email Address" required>
        </div>
        <div class="input-group">
            <i class="fas fa-phone"></i>
            <input type="text" name="phone" placeholder="Phone Number" required>
        </div>
        <div class="input-group">
            <i class="fas fa-map-marker-alt"></i>
            <input type="text" name="address" placeholder="Address" required>
        </div>
        <div class="input-group">
            <i class="fas fa-venus-mars"></i>
            <select name="gender" required>
                <option value="" disabled selected>Choose a gender</option>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
                <option value="Other">Other</option>
            </select>
        </div>
        <div class="input-group">
            <i class="fas fa-lock"></i>
            <input type="password" name="password" placeholder="Password" required>
        </div>
        <div class="input-group">
            <i class="fas fa-lock"></i>
            <input type="password" name="confirm_password" placeholder="Confirm Password" required>
        </div>
        <input type="submit" value="Đăng Ký">
    </form>
    <a href="Login.jsp">Already have an account? Login now</a>
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
