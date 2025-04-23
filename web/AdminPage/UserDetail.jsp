<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="Entity.User" %>
<%
    User user = (User) request.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết người dùng</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                margin: 0;
                padding-top: 60px; /* Space for fixed header */
                min-height: 100vh;
                display: flex;
                flex-direction: column;
            }
            .main-layout {
                display: flex;
                flex-grow: 1;
            }
            .dashboard-header {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 60px; /* Fixed height for header */
                background-color: #343a40;
                color: white;
                z-index: 1000; /* Ensure header is above other elements */
                border-bottom: none; /* Remove any border */
                box-shadow: none; /* Remove any shadow */
            }
            .dashboard-header > * {
                margin: 0; /* Remove margins from child elements */
                border: none; /* Ensure no borders on child elements */
            }
            .sidebar {
                width: 250px;
                background-color: #f8f9fa;
                padding: 20px;
                position: fixed;
                top: 60px; /* Start below header */
                bottom: 0;
                left: 0;
                z-index: 900; /* Below header but above content */
            }
            .container {
                margin-left: 270px; /* Space for sidebar */
                padding: 20px;
                flex-grow: 1;
                margin-top: 20px; /* Additional spacing */
            }
        </style>
    </head>
    <body>
        <div class="dashboard-header">
            <jsp:include page="dashboard-header.jsp"/>
        </div>

        <!-- Sidebar + Content -->
        <div class="main-layout">
            <!-- Sidebar -->
            <div class="sidebar">
                <jsp:include page="dashboard-sidebar.jsp"/>
            </div>

            <div class="container">
                <h2 class="mb-4">Chi tiết người dùng</h2>

                <div class="card shadow p-4">
                    <div class="row">
                        <div class="col-md-4 text-center">
                            <img src="${user.avatar_url != null ? user.avatar_url : 'images/default-avatar.png'}"
                                 alt="Avatar"
                                 class="img-thumbnail rounded-circle mb-3"
                                 style="width: 200px; height: 200px; object-fit: cover;">
                        </div>
                        <div class="col-md-8">
                            <table class="table table-borderless">
                                <tr>
                                    <th>Họ tên:</th>
                                    <td>${user.full_name}</td>
                                </tr>
                                <tr>
                                    <th>Email:</th>
                                    <td>${user.email}</td>
                                </tr>
                                <tr>
                                    <th>Giới tính:</th>
                                    <td>
                                        <c:choose>
                                            <c:when test="${user.gender eq 'M'}">Nam</c:when>
                                            <c:when test="${user.gender eq 'F'}">Nữ</c:when>
                                            <c:otherwise>Khác</c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Số điện thoại:</th>
                                    <td>${user.phone_number}</td>
                                </tr>
                                <tr>
                                    <th>Địa chỉ:</th>
                                    <td>${user.address}</td>
                                </tr>
                                <tr>
                                    <th>Vai trò:</th>
                                    <td>${roleName}</td> <!-- Gán từ controller -->
                                </tr>
                                <tr>
                                    <th>Kích hoạt:</th>
                                    <td>
                                        <span class="badge bg-${user.is_active ? 'success' : 'secondary'}">
                                            ${user.is_active ? 'Đã kích hoạt' : 'Chưa kích hoạt'}
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Xác minh:</th>
                                    <td>
                                        <span class="badge bg-${user.is_verified ? 'info' : 'warning'}">
                                            ${user.is_verified ? 'Đã xác minh' : 'Chưa xác minh'}
                                        </span>
                                    </td>
                                </tr>
                            </table>
                            <a href="UserController" class="btn btn-secondary mt-3"><i class="fas fa-arrow-left"></i> Quay lại danh sách</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>