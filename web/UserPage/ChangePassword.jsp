<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/CommonPage/Header.jsp" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đổi mật khẩu</title>

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <style>
        body {
            background: #f4f6f9;
            margin: 0;
            padding: 0;
            font-family: 'Roboto', sans-serif;
        }

        .change-password-page {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 80px 0;
            min-height: calc(100vh - 160px); /* trừ header + footer */
        }

        .change-password-box {
            background: #fff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            max-width: 400px;
            width: 100%;
            text-align: center;
        }

        .change-password-box h1 {
            color: #1e3c72;
            margin-bottom: 24px;
            font-size: 26px;
        }

        .input-group {
            position: relative;
            margin-bottom: 20px;
        }

        .input-group input {
            width: 100%;
            padding: 12px 12px 12px 40px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            box-sizing: border-box;
            transition: border-color 0.2s;
        }

        .input-group input:focus {
            border-color: #1e3c72;
            outline: none;
        }

        .input-group i {
            position: absolute;
            top: 50%;
            left: 12px;
            transform: translateY(-50%);
            color: #888;
        }

        input[type="submit"] {
            width: 100%;
            padding: 12px;
            background: #1e3c72;
            border: none;
            color: #fff;
            font-size: 16px;
            border-radius: 4px;
            cursor: pointer;
            transition: background 0.2s;
        }

        input[type="submit"]:hover {
            background: #162d56;
        }

        .change-password-box a {
            display: inline-block;
            margin-top: 16px;
            color: #1e3c72;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.2s;
        }

        .change-password-box a:hover {
            color: #162d56;
        }

        .message {
            margin-bottom: 20px;
            font-size: 14px;
            font-weight: bold;
        }

        .error-message {
            color: red;
        }

        .success-message {
            color: green;
        }

        @media(max-width:576px) {
            .change-password-box {
                padding: 24px;
            }
        }
    </style>
</head>

<body>

<div class="change-password-page">
    <div class="change-password-box">
        <h1>Đổi mật khẩu</h1>

        <% 
            String errorMessagePassChanging = (String) request.getAttribute("errorMessagePassChanging"); 
            String successMessageChanging = (String) request.getAttribute("successMessageChanging");
        %>

        <div class="message">
            <% if (errorMessagePassChanging != null) { %>
                <div class="error-message"><%= errorMessagePassChanging %></div>
            <% } %>
            <% if (successMessageChanging != null) { %>
                <div class="success-message"><%= successMessageChanging %></div>
            <% } %>
        </div>

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
            <input type="submit" value="Xác nhận đổi mật khẩu">
        </form>

        <a href="${pageContext.request.contextPath}/home.jsp">Quay lại trang chủ</a>
    </div>
</div>

<jsp:include page="/CommonPage/Footer.jsp" />

</body>
</html>
