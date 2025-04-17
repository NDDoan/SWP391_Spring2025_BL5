<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Electro Mart</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #1e3c72, #2a5298);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        header.simple-header {
            background-color: #ffffff;
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        header.simple-header h1 {
            color: #1e3c72;
            font-size: 26px;
            font-weight: 700;
        }
        .main-content {
            display: flex;
            flex: 1;
            justify-content: center;
            align-items: flex-start;
            padding: 40px 20px;
        }
        .login-container {
            background-color: #ffffff;
            padding: 40px 30px;
            border-radius: 16px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 420px;
            text-align: center;
        }
        .login-container h1 {
            font-size: 28px;
            color: #1e3c72;
            font-weight: 600;
            margin-bottom: 25px;
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
        }
        .input-group i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #888;
        }
        .remember-me {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            font-size: 14px;
            color: #444;
            justify-content: start;
        }
        .remember-me input {
            margin-right: 10px;
            width: 18px;
            height: 18px;
        }
        .login-container input[type="submit"] {
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
        .login-container input[type="submit"]:hover {
            background-color: #163062;
        }
        .login-container a {
            display: block;
            margin-top: 12px;
            color: #1e3c72;
            text-decoration: none;
            font-weight: 500;
        }
        .login-container a:hover {
            color: #2a5298;
        }
        .popup-container {
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }
        .popup {
            background-color: #fff;
            padding: 25px 30px;
            border-radius: 12px;
            text-align: center;
            max-width: 400px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.3);
        }
        .popup p {
            color: #d62828;
            font-size: 16px;
            margin-bottom: 15px;
        }
        .popup button {
            background-color: #1e3c72;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
        }
        .popup button:hover {
            background-color: #0f2a5f;
        }
        .footer {
            background-color: #1e3c72;
            color: #fff;
            padding: 30px 20px;
            text-align: center;
            width: 100%;
        }
        .footer h2 {
            font-size: 20px;
            margin-bottom: 10px;
        }
        .footer p {
            margin: 5px 0;
        }
        .footer i {
            margin-right: 8px;
            color: #a9d6ff;
        }
        .footer .team-info {
            margin-top: 15px;
            font-size: 14px;
            opacity: 0.85;
        }
    </style>
</head>
<body>
<%
    Cookie[] cookies = request.getCookies();
    String rememberedEmail = "";
    String rememberedPassword = "";
    boolean rememberMeChecked = false;
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("rememberedEmail".equals(cookie.getName())) rememberedEmail = cookie.getValue();
            if ("rememberedPassword".equals(cookie.getName())) rememberedPassword = cookie.getValue();
            if ("rememberMe".equals(cookie.getName()) && "true".equals(cookie.getValue())) rememberMeChecked = true;
        }
    }
    String errorMessage = (String) request.getAttribute("errorMessage");
%>

<!-- ✅ SIMPLE HEADER -->
<header class="simple-header">
    <h1>Welcome to Electro Mart</h1>
</header>

<!-- 🔔 POPUP ERROR -->
<div id="errorPopup" class="popup-container">
    <div class="popup">
        <p><%= errorMessage %></p>
        <button onclick="closePopup()">OK</button>
    </div>
</div>

<!-- 🔐 LOGIN FORM -->
<div class="main-content">
    <div class="login-container">
        <h1>Login to Your Account</h1>
        <form action="${pageContext.request.contextPath}/logincontroller" method="post">
            <div class="input-group">
                <i class="fas fa-user"></i>
                <input type="text" name="username" value="<%= rememberedEmail %>" placeholder="Email" required>
            </div>
            <div class="input-group">
                <i class="fas fa-lock"></i>
                <input type="password" name="password" value="<%= rememberedPassword %>" placeholder="Password" required>
            </div>
            <div class="remember-me">
                <input type="checkbox" name="rememberMe" <%= rememberMeChecked ? "checked" : "" %>> Remember Me
            </div>
            <input type="submit" value="Login">
        </form>
        <a href="${pageContext.request.contextPath}/UserPage/ResetPassword.jsp">Forgot password?</a>
        <a href="${pageContext.request.contextPath}/UserPage/Register.jsp">Register a new account</a>
    </div>
</div>

<!-- 👣 FOOTER -->
<footer class="footer">
    <h2>Contact With Us</h2>
    <p><i class="fas fa-envelope"></i> contact@electromart.com</p>
    <p><i class="fas fa-phone-alt"></i> +84 123 456 789</p>
    <p><i class="fas fa-map-marker-alt"></i> 123 Tech Street, Hanoi, Vietnam</p>
    <div class="team-info">
        Developed by <strong>Nhóm 2 - SWP391.BL5</strong><br>
        &copy; 2025 Electro Mart. All rights reserved.
    </div>
</footer>

<!-- 🧠 POPUP JS -->
<script>
    window.onload = function () {
        var errorMessage = "<%= errorMessage != null ? errorMessage : "" %>";
        if (errorMessage) {
            document.getElementById("errorPopup").style.display = "flex";
        }
    };
    function closePopup() {
        document.getElementById("errorPopup").style.display = "none";
    }
</script>
</body>
</html>
