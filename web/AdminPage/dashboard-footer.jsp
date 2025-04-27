<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Footer</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <style>
        footer {
            background-color: #f8f9fa;
            padding: 15px 0;
            border-top: 1px solid #e1e1e1;
            font-size: 0.9rem;
            color: #6c757d;
        }
        .footer-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            align-items: center;
            gap: 20px;
        }
        .footer-container a {
            color: #007bff;
            text-decoration: none;
        }
        .footer-container a:hover {
            text-decoration: underline;
            color: #0056b3;
        }
    </style>
</head>
<body>

<!-- Footer -->
<footer>
    <div class="container">
        <div class="footer-container">
            <a href="${pageContext.request.contextPath}/about">Giới thiệu</a>
            <a href="${pageContext.request.contextPath}/contact">Liên hệ</a>
            <a href="${pageContext.request.contextPath}/privacy">Chính sách bảo mật</a>
            <a href="${pageContext.request.contextPath}/terms">Điều khoản sử dụng</a>
            <span>&copy; 2025 Công ty ABC. Tất cả quyền được bảo lưu.</span>
        </div>
    </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
