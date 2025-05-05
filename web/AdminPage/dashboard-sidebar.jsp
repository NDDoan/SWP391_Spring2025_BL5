<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <style>
            /* Tùy chỉnh sidebar */
            .sidebar {
                top: 0;
                bottom: 0;
                left: 0;
                width: 250px;
                background-color: #f8f9fa;
                padding-top: 20px;
                box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            }
            .sidebar .nav-link {
                font-size: 1rem;
                padding: 10px 20px;
                color: #495057;
            }
            .sidebar .nav-link:hover {
                background-color: #e9ecef;
                color: #007bff;
            }
            .sidebar .nav-link.active {
                background-color: #007bff;
                color: #fff;
            }
            .sidebar h5 {
                font-weight: bold;
            }

            /* Main content */
            .content-wrapper {
                margin-left: 250px;
                padding-top: 20px;
            }

            /* Tối ưu cho các màn hình nhỏ */
            @media (max-width: 768px) {
                .sidebar {
                    width: 100%;
                    height: auto;
                }
                .content-wrapper {
                    margin-left: 0;
                }
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->

        <!-- Sidebar -->
        <nav class="sidebar col-2">
            <div class="px-3">
                <h5 class="text-primary mb-4">Menu Chính</h5>
                <ul class="nav flex-column">

                    <!-- Nếu là Manager -->
                    <c:if test="${sessionScope.user.role_id == 1}">
                        <li class="nav-item mb-2">
                            <a class="nav-link d-flex align-items-center" href="${pageContext.request.contextPath}/AdminPage/AdminDashBoard.jsp">
                                <i class="bi bi-speedometer2 me-2"></i> Admin Dashboard
                            </a>
                        </li>
                        
                        <li class="nav-item mb-2">
                            <a class="nav-link d-flex align-items-center" href="/Swp391_Spring2025_BL5/UserController">
                                <i class="bi bi-people me-2"></i> Quản lý người dùng
                            </a>
                        </li>
                       
                        <li class="nav-item mb-2">
                            <a class="nav-link d-flex align-items-center" href="/Swp391_Spring2025_BL5/ProductForManagerListController">
                                <i class="bi bi-box-seam me-2"></i> Quản lý sản phẩm
                            </a>
                        </li>
                        <li class="nav-item mb-2">
                            <a class="nav-link d-flex align-items-center" href="/Swp391_Spring2025_BL5/PostListController">
                                <i class="bi bi-bar-chart-line me-2"></i> Quản lý bài đăng
                            </a>
                        </li>
                        <li class="nav-item mb-2">
                            <a class="nav-link d-flex align-items-center" href="/Swp391_Spring2025_BL5/FeedbackList">
                                <i class="bi bi-bar-chart-line me-2"></i> Quản lý phản hồi
                            </a>
                        </li>
                        <li class="nav-item mb-2">
                            <a class="nav-link d-flex align-items-center" href="/Swp391_Spring2025_BL5/ReportController">
                                <i class="bi bi-bar-chart-line me-2"></i> Báo cáo thống kê
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${sessionScope.user.role_id == 5}">
                        <li class="nav-item mb-2">
                            <a class="nav-link d-flex align-items-center" href="${pageContext.request.contextPath}/AdminPage/AdminDashBoard.jsp">
                                <i class="bi bi-speedometer2 me-2"></i> Admin Dashboard
                            </a>
                        </li>
                        <li class="nav-item mb-2">
                            <a class="nav-link d-flex align-items-center" href="/Swp391_Spring2025_BL5/OrderList">
                                <i class="bi bi-cart-check me-2"></i> Quản lý đơn hàng
                            </a>
                        </li>
                        <li class="nav-item mb-2">
                            <a class="nav-link d-flex align-items-center" href="/Swp391_Spring2025_BL5/UserController">
                                <i class="bi bi-people me-2"></i> Quản lý người dùng
                            </a>
                        </li>
                        <li class="nav-item mb-2">
                            <a class="nav-link d-flex align-items-center" href="/Swp391_Spring2025_BL5/ShippingController">
                                <i class="bi bi-truck me-2"></i> Quản lý giao hàng
                            </a>
                        </li>
                      
                    </c:if>
                    <!-- Nếu là Shipper -->
                    <c:if test="${sessionScope.user.role_id == 4}">
                        <li class="nav-item mb-2">
                            <a class="nav-link d-flex align-items-center" href="/Swp391_Spring2025_BL5/ShippingController">
                                <i class="bi bi-truck me-2"></i> Quản lý giao hàng
                            </a>
                        </li>
                    </c:if>

                    <!-- Đăng xuất (chung cho mọi vai trò) -->
                    <li class="nav-item mt-4">
                        <form id="logoutForm" action="${pageContext.request.contextPath}/logoutcontroller" method="post">
                            <button type="submit" class="btn btn-link nav-link text-danger d-flex align-items-center" style="padding: 0; border: none; background: none;">
                                <i class="bi bi-box-arrow-right me-2"></i> Đăng xuất
                            </button>
                        </form>
                    </li>
                </ul>
            </div>
        </nav>

    </body>
</html>
