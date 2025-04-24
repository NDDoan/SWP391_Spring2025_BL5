<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt lại mật khẩu - Electro Mart</title>
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

        /* FORM ĐẶT LẠI MẬT KHẨU */
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
    </style>
</head>
<body>

<!-- INCLUDE HEADER -->
<jsp:include page="/CommonPage/Header.jsp" />

<!-- RESET FORM -->
<%
    String errorMessage = (String) request.getAttribute("errorMessage");
    String successMessage = (String) request.getAttribute("successMessage");
%>

<div class="forgot-password-container">
    <h1>Đặt lại mật khẩu</h1>
    <p>Vui lòng nhập email của bạn để khôi phục mật khẩu</p>

    <% if (errorMessage != null) { %>
        <div class="message error"><%= errorMessage %></div>
    <% } %>
    <% if (successMessage != null) { %>
        <div class="message success"><%= successMessage %></div>
    <% } %>

    <form action="ForgotPasswordServlet" method="post">
        <div class="input-group">
            <i class="fas fa-envelope"></i>
            <input type="email" name="email" placeholder="Nhập email của bạn" required>
        </div>
        <input type="submit" value="Khôi phục mật khẩu">
    </form>
    <a href="login.jsp">Quay lại đăng nhập</a>
</div>

<!-- INCLUDE FOOTER -->
<jsp:include page="/CommonPage/Footer.jsp" />

</body>
</html>
