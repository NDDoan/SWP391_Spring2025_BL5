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

    </style>
</head>
<body>

<!-- INCLUDE HEADER -->
<jsp:include page="/CommonPage/Header.jsp" />

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
    <h1>Đăng ký</h1>
    <form action="${pageContext.request.contextPath}/registercontroller" method="post">
        <div class="input-group">
            <i class="fas fa-user"></i>
            <input type="text" name="fullname" placeholder="Họ và tên" required>
        </div>
        <div class="input-group">
            <i class="fas fa-envelope"></i>
            <input type="email" name="email" placeholder="Địa chỉ email" required>
        </div>
        <div class="input-group">
            <i class="fas fa-phone"></i>
            <input type="text" name="phone" placeholder="Số điện thoại" required>
        </div>
        <div class="input-group">
            <i class="fas fa-map-marker-alt"></i>
            <input type="text" name="address" placeholder="Địa chỉ" required>
        </div>
        <div class="input-group">
            <i class="fas fa-venus-mars"></i>
            <select name="gender" required>
                <option value="" disabled selected>Chọn giới tính</option>
                <option value="Male">Nam</option>
                <option value="Female">Nữ</option>
                <option value="Other">Khác</option>
            </select>
        </div>
        <div class="input-group">
            <i class="fas fa-lock"></i>
            <input type="password" name="password" placeholder="Mật khẩu" required>
        </div>
        <div class="input-group">
            <i class="fas fa-lock"></i>
            <input type="password" name="confirm_password" placeholder="Xác nhận mật khẩu" required>
        </div>
        <input type="submit" value="Đăng Ký">
    </form>
    <a href="Login.jsp">Đã có tài khoản? Đăng nhập ngay</a>
</div>

<!-- INCLUDE FOOTER -->
<jsp:include page="/CommonPage/Footer.jsp" />

</body>
</html>
