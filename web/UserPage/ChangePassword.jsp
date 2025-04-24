<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đổi Mật Khẩu - Electro Mart</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Google Fonts & Icons -->
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
            color: #333;
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
    </style>
</head>
<body>

<!-- INCLUDE HEADER -->
<jsp:include page="/CommonPage/Header.jsp" />

<!-- NỘI DUNG CHÍNH -->
<div class="container">
    <h1>Đổi Mật Khẩu</h1>
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
            <input type="password" name="currentPassword" placeholder="Mật khẩu hiện tại" required>
        </div>
        <div class="input-group">
            <i class="fas fa-key"></i>
            <input type="password" name="newPassword" placeholder="Mật khẩu mới" required>
        </div>
        <div class="input-group">
            <i class="fas fa-key"></i>
            <input type="password" name="confirmPassword" placeholder="Xác nhận mật khẩu mới" required>
        </div>
        <input type="submit" value="Đổi mật khẩu">
    </form>

    <a href="home.jsp"><i class="fas fa-arrow-left"></i> Quay lại trang chủ</a>
</div>

<!-- INCLUDE FOOTER -->
<jsp:include page="/CommonPage/Footer.jsp" />

</body>
</html>
