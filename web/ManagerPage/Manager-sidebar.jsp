<%-- 
    Document   : Manager-sidebar
    Created on : Apr 19, 2025, 10:53:26 AM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manager Dashboard</title>
        <!-- Bootstrap CSS & Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    </head>
    <body>

        <!-- Sidebar -->
        <nav class="col-md-2 d-none d-md-block bg-light sidebar py-4 position-fixed shadow-sm" style="height: 100vh;">
            <div class="position-sticky px-3">
                <h5 class="text-primary mb-4">Menu chính</h5>
                <ul class="nav flex-column">
                    <li class="nav-item mb-2">
                        <a class="nav-link d-flex align-items-center" href="${pageContext.request.contextPath}/ManagerPage/ManagerDashBoard.jsp">
                            <i class="bi bi-speedometer2 me-2"></i> Manager Dashboard
                        </a>
                    <li class="nav-item mb-2">
                        <a class="nav-link d-flex align-items-center" href="/Swp391_Spring2025_BL5/ProductForManagerListController">
                            <i class="bi bi-box-seam me-2"></i> Quản lý sản phẩm
                        </a>
                    </li>
                    <li class="nav-item mb-2">
                        <a class="nav-link d-flex align-items-center" href="report">
                            <i class="bi bi-bar-chart-line me-2"></i> Báo cáo & Thống kê
                        </a>
                    </li>
                    <li class="nav-item mt-4">
                        <a class="nav-link text-danger d-flex align-items-center" href="logout">
                            <i class="bi bi-box-arrow-right me-2"></i> Đăng xuất
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
