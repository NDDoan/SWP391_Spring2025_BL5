<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Chợ Điện Tử</title>
        <meta charset="UTF-8">

        <!-- Bootstrap & FontAwesome -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

        <!-- Custom Style -->
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f8f9fa;
                margin: 0;
                padding: 0;
            }

            header {
                background-color: #1e1e2f;
                color: white;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
            }

            .logo {
                font-size: 1.75rem;
                font-weight: bold;
                color: #ffc107;
                text-decoration: none;
            }

            .nav-links a {
                color: white;
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .nav-links a:hover {
                color: #ffc107;
            }

            .btn-warning {
                background-color: #ffc107;
                border-color: #ffc107;
                font-weight: 500;
            }

            .btn-warning:hover {
                background-color: #e0a800;
                border-color: #d39e00;
            }

            .btn-outline-light:hover {
                background-color: #fff;
                color: #1e1e2f;
            }

            .user-dropdown.show .dropdown-menu {
                display: block;
            }

            .dropdown-item:hover {
                background-color: #f8f9fa;
            }

            .badge {
                font-size: 0.75rem;
                padding: 4px 6px;
            }
        </style>
    </head>
    <body>

        <header class="py-3 shadow-sm">
            <div class="container d-flex flex-wrap align-items-center justify-content-between">
                <!-- Logo -->
                <a href="${pageContext.request.contextPath}/HomePageController" class="logo">
                    <i class="fas fa-bolt"></i> Chợ Điện Tử
                </a>

                <!-- Search -->
                <form action="${pageContext.request.contextPath}/ProductForManagerListController" method="get" class="d-flex flex-grow-1 mx-4" style="max-width: 500px;">
                    <input name="search" class="form-control rounded-start" placeholder="Tìm kiếm sản phẩm…" />
                    <button class="btn btn-warning rounded-end" type="submit">
                        <i class="fas fa-search"></i>
                    </button>
                </form>

                <!-- Navigation Links -->
                <nav class="d-flex align-items-center gap-3 nav-links">
                    <a href="${pageContext.request.contextPath}/#">Sản phẩm</a>
                    <a href="${pageContext.request.contextPath}/BlogListController">Bài viết</a>
                    <a href="${pageContext.request.contextPath}/myordercontroller">Đơn Hàng</a>
                    <a href="${pageContext.request.contextPath}/contact">Liên hệ</a>
                </nav>

                <!-- Cart + User -->
                <div class="d-flex align-items-center ms-3 gap-3">
                    <!-- Cart -->
                    <a href="${pageContext.request.contextPath}/cartdetailcontroller" class="btn btn-success position-relative">
                        <i class="fas fa-shopping-cart"></i>
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">0</span>
                    </a>

                    <!-- Login/User -->
                    <c:choose>
                        <c:when test="${sessionScope.user == null}">
                            <a href="${pageContext.request.contextPath}/logincontroller" class="btn btn-outline-light">
                                <i class="fas fa-sign-in-alt me-1"></i> Đăng nhập
                            </a>
                        </c:when>
                        <c:otherwise>
                            <div class="dropdown user-dropdown" 
                                 onmouseover="this.classList.add('show')" 
                                 onmouseout="this.classList.remove('show')">
                                <a href="#" 
                                   class="btn btn-outline-light dropdown-toggle d-flex align-items-center" 
                                   id="userMenu" 
                                   data-bs-toggle="dropdown" 
                                   aria-expanded="false">
                                    <img src="${sessionScope.user.avatar_url != null ? sessionScope.user.avatar_url : 'default-avatar.png'}"
                                         alt="avatar" width="24" height="24" class="rounded-circle me-1">
                                    ${sessionScope.user.full_name}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="userMenu">
                                    <li class="px-3 py-2 d-flex align-items-center border-bottom">
                                        <img src="${sessionScope.user.avatar_url != null ? sessionScope.user.avatar_url : 'default-avatar.png'}"
                                             alt="avatar" width="50" height="50" class="rounded-circle me-2">
                                        <div>
                                            <div class="fw-bold">${sessionScope.user.full_name}</div>
                                            <small class="text-muted">${sessionScope.user.email}</small>
                                        </div>
                                    </li>
                                    <li>
                                        <a class="dropdown-item d-flex align-items-center" 
                                           href="${pageContext.request.contextPath}/UserProfile">
                                            <i class="fas fa-id-card me-2"></i> Thông tin cá nhân
                                        </a>
                                    </li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li>
                                        <a class="dropdown-item text-danger d-flex align-items-center" 
                                           href="${pageContext.request.contextPath}/logoutcontroller">
                                            <i class="fas fa-sign-out-alt me-2"></i> Đăng xuất
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </header>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
