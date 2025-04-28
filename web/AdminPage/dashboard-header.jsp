<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <style>
        /* Navbar styles */
        .navbar {
            background-color: #007bff;
            border-bottom: 2px solid #0069d9;
        }
        .navbar-brand {
            color: #000000;
            font-weight: bold;
        }
        .navbar-nav .nav-link {
            color: #fff;
            font-size: 1rem;
        }

        /* Thông báo */
        .navbar-nav .nav-link.notifications {
            color: #ffc107; /* Màu vàng cam cho thông báo */
        }
        .navbar-nav .nav-link.notifications:hover {
            color: #fff;
            background-color: #e0a800; /* Thay đổi màu khi hover */
            border-radius: 0.25rem;
        }

        /* Hồ sơ */
        .navbar-nav .nav-link.profile {
            color: #28a745; /* Màu xanh lá cây cho hồ sơ */
        }
        .navbar-nav .nav-link.profile:hover {
            color: #fff;
            background-color: #218838; /* Thay đổi màu khi hover */
            border-radius: 0.25rem;
        }

        .navbar-nav .nav-link i {
            margin-right: 5px;
        }

        .navbar-toggler {
            border-color: #fff;
        }

        /* Mobile Responsive: Make sure nav items are properly aligned in small screens */
        @media (max-width: 768px) {
            .navbar {
                background-color: #0056b3;
            }
            .navbar-brand {
                font-size: 1.2rem;
            }
            .navbar-nav .nav-link {
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">ADMIN PAGE</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" 
                    aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                    <!-- Thông báo -->
                    <li class="nav-item">
                        <a class="nav-link notifications d-flex align-items-center" href="#">
                            <i class="bi bi-bell"></i> Thông báo
                        </a>
                    </li>
                    <!-- Hồ sơ -->
                    <li class="nav-item">
                        <a class="nav-link profile d-flex align-items-center" href="${pageContext.request.contextPath}/UserProfile">
                            <i class="bi bi-person-circle"></i> Hồ sơ
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Bootstrap JS & Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
