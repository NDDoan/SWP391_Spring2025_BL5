<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <!-- Bootstrap & FontAwesome -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            header {
                background:#1e3c72;
                padding:.75rem 1.5rem;
                color:#fff;
            }
            .logo {
                font-size:1.5rem;
                font-weight:bold;
                color:#f8d210;
            }
            .search-bar .form-control {
                border-radius:.25rem 0 0 .25rem;
            }
            .search-bar .btn {
                border-radius:0 .25rem .25rem 0;
                background:#f8d210;
                font-weight:bold;
            }
            .cart-btn {
                position:relative;
                background:#28a745;
                padding:.5rem .75rem;
                border-radius:.25rem;
                color:#fff;
            }
            .cart-count {
                position:absolute;
                top:-5px;
                right:-8px;
                background:red;
                color:#fff;
                border-radius:50%;
                font-size:.75rem;
                padding:2px 6px;
            }
            /* show dropdown on hover */
            .user-dropdown:hover .dropdown-menu {
                display:block;
            }
            .nav-links {
                display: flex;
                gap: 15px;
                align-items: center;
            }

            .nav-links a {
                color: white;
                text-decoration: none;
                font-weight: 500;
                padding: 8px 12px;
                border-radius: 5px;
                transition: 0.3s;
                background-color: transparent;
            }

            .nav-links a:hover {
                background-color: rgba(255, 255, 255, 0.2);
            }

        </style>
    </head>
    <body>
        <header class="d-flex flex-wrap align-items-center justify-content-between">
            <!-- Logo -->
            <a href="${pageContext.request.contextPath}/HomePageController" class="logo text-decoration-none">Electro Mart</a>

            <!-- Search -->
            <form action="${pageContext.request.contextPath}/ProductForManagerListController" 
                  method="get" class="search-bar d-flex flex-fill mx-3">
                <input name="search" class="form-control" placeholder="Search products…" />
                <button class="btn" type="submit"><i class="fas fa-search"></i></button>
            </form>

            <!-- Right nav -->
            <nav class="d-flex align-items-center">
                <!-- Cart -->
                <a href="${pageContext.request.contextPath}/cartdetailcontroller" class="cart-btn me-3">
                    <i class="fas fa-shopping-cart"></i>
                    <span class="cart-count">0</span>
                </a>

                <!-- Login or User dropdown -->
                <c:choose>
                    <c:when test="${sessionScope.user == null}">
                        <a href="${pageContext.request.contextPath}/logincontroller" class="text-white text-decoration-none">
                            <i class="fas fa-user"></i> Đăng nhập
                        </a>
                    </c:when>
                    <c:otherwise>
                        <div class="dropdown user-dropdown">
                            <a href="#" 
                               class="d-flex align-items-center text-white text-decoration-none dropdown-toggle"
                               id="userMenu" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-user-circle fa-lg me-1"></i>
                                ${sessionScope.user.full_name}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="userMenu">
                                <li class="d-flex align-items-center px-3 py-2 border-bottom">
                                    <img src="${sessionScope.user.avatar_url != null ? sessionScope.user.avatar_url : 'default-avatar.png'}"
                                         alt="avatar" width="50" height="50" class="rounded-circle me-2">
                                    <div>
                                        <div class="fw-bold">${sessionScope.user.full_name}</div>
                                        <small class="text-muted">${sessionScope.user.email}</small>
                                    </div>
                                </li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/UserProfile">
                                        <i class="fas fa-id-card me-1"></i> Thông tin cá nhân
                                    </a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logoutcontroller">
                                        <i class="fas fa-sign-out-alt me-1"></i> Đăng xuất
                                    </a></li>
                            </ul>
                        </div>
                    </c:otherwise>
                </c:choose>
            </nav>
            <div class="nav-links">
                <a href="#"><i class="fas fa-headset"></i> Hotline: 1900 9999</a>
            </div>
        </header>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
