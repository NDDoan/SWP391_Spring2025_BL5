<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Shipper Dashboard</title>
        <!-- Bootstrap CSS & Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .sidebar {
                height: 100vh;
                background-color: #f8f9fa;
                border-right: 1px solid #dee2e6;
            }

            .sidebar .nav-link {
                color: #333;
                font-weight: 500;
                transition: background-color 0.2s ease, color 0.2s ease;
            }

            .sidebar .nav-link:hover,
            .sidebar .nav-link:focus {
                background-color: #e9ecef;
                color: #0d6efd;
            }

            .sidebar .nav-link i {
                font-size: 1.2rem;
            }

            .nav-link.active {
                color: #0d6efd !important;
                background-color: #e2e6ea;
                border-radius: 5px;
            }

            .logout-btn {
                color: #dc3545 !important;
            }

            .logout-btn:hover {
                color: #a71d2a !important;
                background-color: #f8d7da !important;
            }

            .main-content {
                margin-left: 17%;
                padding: 30px 20px;
            }
        </style>
    </head>
    <body>

        <!-- Sidebar -->
        <nav class="col-md-2 d-none d-md-block sidebar py-4 position-fixed shadow-sm">
            <div class="px-3">
                <h5 class="text-primary mb-4">Menu Chính</h5>
                <ul class="nav flex-column">
                    <li class="nav-item mb-2">
                        <a class="nav-link d-flex align-items-center" href="${pageContext.request.contextPath}/Shipper/ShipperDashBoard.jsp">
                            <i class="bi bi-speedometer2 me-2"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item mb-2">
                        <a class="nav-link d-flex align-items-center" href="${pageContext.request.contextPath}/ShipperController">
                            <i class="bi bi-truck me-2"></i> Đơn hàng cần giao
                        </a>
                    </li>
                    <li class="nav-item mb-2">
                        <a href="#" class="nav-link logout-btn d-flex align-items-center" onclick="document.getElementById('logoutForm').submit(); return false;">
                            <i class="bi bi-box-arrow-right me-2"></i> Đăng xuất
                        </a>
                        <form id="logoutForm" action="${pageContext.request.contextPath}/logoutcontroller" method="post" style="display: none;"></form>
                    </li>

                </ul>
            </div>
        </nav>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Nội dung chính sẽ được đặt ở đây -->
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
