<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Change Password - Electro Mart</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Google Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <!-- CSS Tổng -->
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #1e3c72, #2a5298);
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            color: #333;
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

        /* FORM ĐỔI MẬT KHẨU */
        .container {
            background-color: #ffffff;
            padding: 40px 30px;
            border-radius: 16px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 420px;
            margin: 60px auto 30px auto;
        }

        .container h1 {
            font-size: 26px;
            color: #1e3c72;
            font-weight: 600;
            margin-bottom: 25px;
            text-align: center;
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
            font-size: 16px;
            transition: 0.3s ease;
        }

        .input-group input:focus {
            border-color: #1e3c72;
            outline: none;
            box-shadow: 0 0 5px rgba(30, 60, 114, 0.3);
        }

        .input-group i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #888;
        }

        .container input[type="submit"] {
            background-color: #1e3c72;
            color: #fff;
            border: none;
            padding: 14px;
            border-radius: 8px;
            width: 100%;
            font-size: 17px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .container input[type="submit"]:hover {
            background-color: #163062;
        }

        .container a {
            display: block;
            margin-top: 18px;
            color: #1e3c72;
            text-decoration: none;
            font-weight: 500;
            text-align: center;
            transition: color 0.3s ease;
        }

        .container a:hover {
            color: #2a5298;
        }

        .message {
            margin-bottom: 15px;
            font-weight: bold;
            text-align: center;
        }

        .message.error { color: #d62828; }
        .message.success { color: #2a9d8f; }

        /* FOOTER */
        .footer {
            background-color: #1e3c72;
            color: #fff;
            padding: 40px 20px;
            font-size: 14px;
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
            <a href="profile.jsp"><i class="fas fa-user-circle"></i> Profile</a>
            <a href="cart.jsp"><i class="fas fa-shopping-cart"></i> Cart</a>
            <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </div>
</header>

<!-- NỘI DUNG CHÍNH -->
<div class="container">
    <h1>Change Your Password</h1>
    <%
        String errorMessagePassChanging = (String) request.getAttribute("errorMessagePassChanging");
        String successMessageChanging = (String) request.getAttribute("successMessageChanging");
    %>
    <% if (errorMessagePassChanging != null) { %>
        <div class="message error"><%= errorMessagePassChanging %></div>
    <% } %>
    <% if (successMessageChanging != null) { %>
        <div class="message success"><%= successMessageChanging %></div>
    <% } %>

    <form action="${pageContext.request.contextPath}/changepasswordcontroller" method="post">
        <div class="input-group">
            <i class="fas fa-lock"></i>
            <input type="password" name="currentPassword" placeholder="Current Password" required>
        </div>
        <div class="input-group">
            <i class="fas fa-key"></i>
            <input type="password" name="newPassword" placeholder="New Password" required>
        </div>
        <div class="input-group">
            <i class="fas fa-key"></i>
            <input type="password" name="confirmPassword" placeholder="Confirm New Password" required>
        </div>
        <input type="submit" value="Change Password">
    </form>

    <a href="home.jsp"><i class="fas fa-arrow-left"></i> Back to Home</a>
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
