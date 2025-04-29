<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f4f6f9;
                margin: 0;
                padding: 0;
                min-height: 100vh;
            }

            .dashboard-header {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                height: 80px;
                background-color: #ffffff;
                border-bottom: 1px solid #dee2e6;
                display: flex;
                align-items: center;
                padding: 0 20px;
                z-index: 1000;
            }
            .dashboard-footer {
                position: fixed;
                bottom: 0;
                left: 0;
                width: 100%; /* Quan trọng */
                height: 80px;
                background-color: #ffffff;
                border-top: 1px solid #dee2e6;
                z-index: 1000;
            }


            .main-layout {
                display: flex;
                flex-wrap: nowrap;
                margin-top: 80px;
                min-height: calc(100vh - 160px);
            }

            .sidebar {
                position: fixed;
                margin-top: 70px;
                margin-bottom: 80px;
                top: 80px;
                left: 0;
                width: 20%; /* Changed to percentage */
                background-color: #ffffff;
                border-right: 1px solid #dee2e6;
                padding: 20px;

                overflow-y: auto;
                z-index: 999;
            }

            .content-container {
                margin-left: 20%;
                padding: 20px;
                background-color: #f4f6f9;
                flex: 1;
                min-height: calc(100vh - 160px); /* 80px header + 80px footer */
            }


            .card:hover {
                box-shadow: 0 0 10px rgba(0,0,0,0.15);
                transition: all 0.3s ease;
            }

            @media (max-width: 768px) {
                .main-layout {
                    flex-direction: column;
                }

                .sidebar {
                    position: relative;
                    top: 0;
                    width: 100%;
                    border-right: none;
                    border-bottom: 1px solid #dee2e6;
                    height: auto;
                }

                .content-container {
                    margin-left: 0;
                    padding-top: 20px;
                    margin-bottom: 20px;
                }
            }
        </style>
    </head>
    <body>

        <!-- Header -->
        <div class="dashboard-header">
            <jsp:include page="dashboard-header.jsp"/>
        </div>

        <!-- Sidebar + Content -->
        <div class="main-layout">
            <!-- Sidebar -->
            <div class="sidebar">
                <jsp:include page="dashboard-sidebar.jsp"/>
            </div>

            <!-- Main Content -->
            <div class="content-container">
                <div class="container-fluid">
                    <h2 class="mb-4">Chào mừng bạn đến với trang quản trị</h2>

                    <div class="row g-4">
                        <div class="col-md-4">
                            <div class="card border-success">
                                <div class="card-body">
                                    <h5 class="card-title">Đơn hàng</h5>
                                    <p class="card-text">Xem và quản lý tất cả đơn hàng.</p>
                                    <a href="order" class="btn btn-success">Xem chi tiết</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card border-info">
                                <div class="card-body">
                                    <h5 class="card-title">Người dùng</h5>
                                    <p class="card-text">Quản lý danh sách tài khoản người dùng.</p>
                                    <a href="/Swp391_Spring2025_BL5/UserController" class="btn btn-info">Xem chi tiết</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card border-primary">
                                <div class="card-body">
                                    <h5 class="card-title">Giao hàng</h5>
                                    <p class="card-text">Theo dõi trạng thái đơn hàng đang giao.</p>
                                    <a href="/Swp391_Spring2025_BL5/ShippingController" class="btn btn-primary">Xem chi tiết</a>
                                </div>
                            </div>
                        </div>
                        <!-- More cards if needed -->
                    </div>
                </div>
            </div>
        </div>
        <div class="dashboard-footer">
            <jsp:include page="dashboard-footer.jsp"/>
        </div>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>