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
        /* Footer Styles */
        footer {
            background-color: #f8f9fa;
            padding: 30px 0;
            border-top: 1px solid #e1e1e1;
        }

        footer .footer-links {
            display: flex;
            justify-content: center;
            gap: 30px;
        }

        footer .footer-links a {
            color: #007bff;
            text-decoration: none;
            font-size: 1rem;
        }

        footer .footer-links a:hover {
            text-decoration: underline;
            color: #0056b3;
        }

        footer .footer-copy {
            text-align: center;
            color: #6c757d;
            font-size: 0.875rem;
            margin-top: 20px;
        }

        /* Responsive Footer */
        @media (max-width: 768px) {
            footer .footer-links {
                flex-direction: column;
                align-items: center;
            }
        }
    </style>
</head>
<body>

    <!-- Footer -->
    <footer>
        <div class="container">
            <!-- Footer Links -->
            <div class="footer-links">
                <a href="${pageContext.request.contextPath}/about">Giới thiệu</a>
                <a href="${pageContext.request.contextPath}/contact">Liên hệ</a>
                <a href="${pageContext.request.contextPath}/privacy">Chính sách bảo mật</a>
                <a href="${pageContext.request.contextPath}/terms">Điều khoản sử dụng</a>
            </div>

            <!-- Footer Copy -->
            <div class="footer-copy">
                <p>&copy; 2025 Công ty ABC. Tất cả quyền được bảo lưu.</p>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS & Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
