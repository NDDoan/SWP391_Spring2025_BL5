<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Footer</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .footer {
            background-color: #1e3c72;
            color: #fff;
            padding: 40px 20px;
            font-size: 14px;
            margin-top: auto;
        }

        .footer-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            max-width: 1100px;
            margin: 0 auto;
            gap: 30px;
        }

        .footer-section {
            flex: 1;
            min-width: 220px;
        }

        .footer-section h3 {
            font-size: 18px;
            margin-bottom: 15px;
            color: #a9d6ff;
        }

        .footer-section p {
            margin: 8px 0;
            line-height: 1.6;
        }

        .footer-section i {
            margin-right: 8px;
            color: #a9d6ff;
        }

        .footer-section a {
            color: #f8d210;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer-section a:hover {
            color: #fff;
        }

        .footer-bottom {
            text-align: center;
            margin-top: 30px;
            font-size: 13px;
            color: #ccc;
        }

        @media screen and (max-width: 768px) {
            .footer-container {
                flex-direction: column;
                align-items: center;
                text-align: center;
            }

            .footer-section {
                margin-bottom: 20px;
            }
        }
    </style>
</head>
<body>
    <footer class="footer">
        <div class="footer-container">
            <div class="footer-section">
                <h3>Liên hệ với chúng tôi</h3>
                <p><i class="fas fa-envelope"></i> contact@electromart.com</p>
                <p><i class="fas fa-phone-alt"></i> +84 123 456 789</p>
                <p><i class="fas fa-map-marker-alt"></i> 123 Tech Street, Hanoi</p>
            </div>
            <div class="footer-section">
                <h3>Hỗ trợ khách hàng</h3>
                <p><a href="#">FAQs</a></p>
                <p><a href="#">Chính sách trả hàng</a></p>
                <p><a href="#">Thông tin vận chuyển</a></p>
            </div>
            <div class="footer-section">
                <h3>About Us</h3>
                <p><a href="#">Chính sách bảo mật</a></p>
                <p><a href="#">Điều khoản dịch vụ</a></p>
                <p><strong>Nhóm 2 - SWP391.BL5</strong></p>
            </div>
            <div class="footer-section">
                <h3>Kết nối với chúng tôi</h3>
                <p><a href="https://facebook.com" target="_blank"><i class="fab fa-facebook-f"></i> Facebook</a></p>
                <p><a href="https://twitter.com" target="_blank"><i class="fab fa-twitter"></i> Twitter</a></p>
                <p><a href="https://instagram.com" target="_blank"><i class="fab fa-instagram"></i> Instagram</a></p>
            </div>
        </div>
        <div class="footer-bottom">
            &copy; 2025 Electro Mart. All Rights Reserved.
        </div>
    </footer>
</body>
</html>
