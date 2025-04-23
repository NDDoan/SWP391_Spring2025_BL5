<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/UserPage/Header.jsp" />
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
<div class="main-content">
    <div class="login-container">
        <h1>Đăng nhập tài khoản</h1>
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
                <input type="checkbox" name="rememberMe" <%= rememberMeChecked ? "checked" : "" %>> Ghi nhớ đăng nhập
            </div>
            <input type="submit" value="Đăng nhập">
        </form>
        <a href="${pageContext.request.contextPath}/UserPage/ResetPassword.jsp">Quên mật khẩu?</a>
        <a href="${pageContext.request.contextPath}/UserPage/Register.jsp">Đăng ký tài khoản mới</a>
    </div>
</div>

<jsp:include page="/UserPage/Footer.jsp" />

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
