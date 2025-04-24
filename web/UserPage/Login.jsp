<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/CommonPage/Header.jsp" />
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Đăng nhập</title>
        <style>
            /* Container chính */
            .login-page {
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 80px 0; /* cách header */
                background: #f4f6f9;
                min-height: calc(100vh - 160px); /* trừ header + footer */
            }
            .login-box {
                background: #fff;
                padding: 40px;
                border-radius: 8px;
                box-shadow: 0 8px 20px rgba(0,0,0,0.1);
                max-width: 400px;
                width: 100%;
            }
            .login-box h1 {
                text-align: center;
                margin-bottom: 24px;
                color: #1e3c72;
            }
            .login-box .input-group {
                position: relative;
                margin-bottom: 20px;
            }
            .login-box .input-group i {
                position: absolute;
                top: 50%;
                left: 12px;
                transform: translateY(-50%);
                color: #888;
            }
            .login-box .input-group input {
                width: 100%;
                padding: 12px 12px 12px 40px;
                border: 1px solid #ddd;
                border-radius: 4px;
                transition: border-color .2s;
            }
            .login-box .input-group input:focus {
                border-color: #1e3c72;
                outline: none;
            }
            .login-box .remember-me {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
            }
            .login-box .remember-me input {
                margin-right: 8px;
            }
            .login-box input[type="submit"] {
                width: 100%;
                padding: 12px;
                background: #1e3c72;
                border: none;
                color: #fff;
                font-size: 16px;
                border-radius: 4px;
                cursor: pointer;
                transition: background .2s;
            }
            .login-box input[type="submit"]:hover {
                background: #162d56;
            }
            .login-box .extras {
                text-align: center;
                margin-top: 16px;
            }
            .login-box .extras a {
                display: inline-block;
                margin: 6px 12px;
                color: #1e3c72;
                text-decoration: none;
                transition: color .2s;
            }
            .login-box .extras a:hover {
                color: #162d56;
            }
            /* Popup lỗi */
            #errorPopup {
                display: none;
                position: fixed;
                top:0;
                left:0;
                right:0;
                bottom:0;
                background: rgba(0,0,0,0.4);
                justify-content: center;
                align-items: center;
                z-index: 1050;
            }
            #errorPopup .popup {
                background: #fff;
                padding: 24px;
                border-radius: 6px;
                text-align: center;
                max-width: 300px;
                width: 90%;
                box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            }
            #errorPopup .popup button {
                margin-top: 16px;
                padding: 8px 16px;
                background: #dc3545;
                border: none;
                color: #fff;
                border-radius: 4px;
                cursor: pointer;
            }
            @media(max-width:576px) {
                .login-box {
                    padding: 24px;
                }
            }
        </style>
    </head>
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

    <!-- 🔔 POPUP THÔNG BÁO LỖI -->
    <div id="errorPopup" class="popup-container">
        <div class="popup">
            <p><%= errorMessage %></p>
            <button onclick="closePopup()">OK</button>
        </div>
    </div>

    <!-- 🔐 FORM ĐĂNG NHẬP -->
    <div class="login-page">
        <div class="login-box">
            <h1>Đăng nhập</h1>
            <form action="${pageContext.request.contextPath}/logincontroller" method="post">
                <div class="input-group">
                    <i class="fas fa-user"></i>
                    <input type="text" name="username" value="<%= rememberedEmail %>" placeholder="Email" required>
                </div>
                <div class="input-group">
                    <i class="fas fa-lock"></i>
                    <input type="password" name="password" value="<%= rememberedPassword %>" placeholder="Mật khẩu" required>
                </div>
                <div class="remember-me">
                    <input type="checkbox" name="rememberMe" <%= rememberMeChecked ? "checked" : "" %>>
                    <label>Ghi nhớ đăng nhập</label>
                </div>
                <input type="submit" value="Đăng nhập">
            </form>
            <div class="extras">
                <a href="${pageContext.request.contextPath}/UserPage/ResetPassword.jsp">Quên mật khẩu?</a>
                <a href="${pageContext.request.contextPath}/UserPage/Register.jsp">Đăng ký tài khoản mới</a>
            </div>
        </div>
    </div>

    <jsp:include page="/CommonPage/Footer.jsp" />

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
</html>