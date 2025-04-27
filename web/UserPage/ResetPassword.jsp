<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/CommonPage/Header.jsp" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Khôi phục mật khẩu</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            background: #f4f6f9;
            margin: 0;
            padding: 0;
            font-family: 'Roboto', sans-serif;
        }

        .reset-page {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 80px 0;
            min-height: calc(100vh - 160px); /* trừ header + footer */
        }

        .reset-box {
            background: #fff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            max-width: 400px;
            width: 100%;
            text-align: center;
        }

        .reset-box h1 {
            color: #1e3c72;
            margin-bottom: 16px;
            font-size: 26px;
        }

        .reset-box p {
            color: #555;
            margin-bottom: 24px;
            font-size: 15px;
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

        .reset-box a {
            display: inline-block;
            margin-top: 16px;
            color: #1e3c72;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.2s;
        }

        .reset-box a:hover {
            color: #162d56;
        }

        @media(max-width:576px) {
            .reset-box {
                padding: 24px;
            }
        }
    </style>
</head>

<body>

<div class="reset-page">
    <div class="reset-box">
        <h1>Khôi phục mật khẩu</h1>
        <p>Nhập email đã đăng ký để lấy lại mật khẩu của bạn</p>
        <form action="ForgotPasswordServlet" method="post">
            <div class="input-group">
                <i class="fas fa-envelope"></i>
                <input type="email" name="email" placeholder="Email của bạn" required>
            </div>
            <input type="submit" value="Gửi yêu cầu">
        </form>
        <a href="${pageContext.request.contextPath}/UserPage/Login.jsp">Quay lại đăng nhập</a>
    </div>
</div>

<jsp:include page="/CommonPage/Footer.jsp" />

</body>
</html>
