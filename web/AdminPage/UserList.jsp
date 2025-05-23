<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Danh Sách Người Dùng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            /* Sidebar Fixed to the left */
            .sidebar {
                margin-top: 70px;
                margin-bottom: 70px;
                position: fixed;
                top: 80px; /* Start below the header */
                left: 0;
                bottom: 0;
                width: 250px;
                background-color: #f8f9fa;
                box-shadow: 2px 0 5px rgba(0,0,0,0.1);
                z-index: 99; /* Below header */
                height: calc(100% - 80px); /* Adjust height to account for header */
                overflow-y: auto; /* Scroll if content overflows */
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
            /* Header Styling (fixed on top) */
            .dashboard-header {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 100; /* Above sidebar */
                background-color: #ffffff;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                padding: 20px;
                height: 80px; /* Fixed height for header */
            }

            /* Content container */
            .content-container {
                margin-left: 250px; /* Match sidebar width */
                padding-top: 70px; /* Clear the header */
                padding-bottom:  70px;
                min-height: calc(100vh - 80px); /* Full height minus header */
            }
        </style>
    </head>
    <body class="bg-light p-4">
        <!-- Sidebar -->
        <div class="sidebar py-4">
            <jsp:include page="dashboard-sidebar.jsp"/>
        </div>

        <div class="content-container">
            <!-- Header -->
            <div class="dashboard-header">
                <jsp:include page="dashboard-header.jsp"/>
            </div>

            <!-- Main Content -->
            <div class="container bg-white p-4 rounded shadow">
                <c:if test="${Useroke == 'manager'}">
                    <h2 class="text-center mb-4 text-primary"><i class="fas fa-users-cog me-2"></i>Danh Sách Nhân Viên</h2>
                </c:if>
                <c:if test="${Useroke == 'staff'}">
                    <h2 class="text-center mb-4 text-primary"><i class="fas fa-users-cog me-2"></i>Danh Sách Người Dùng</h2>
                </c:if>
                <form method="get" action="user" class="row g-2 mb-4">
                    <div class="col-md-3">
                        <input type="text" name="keyword" class="form-control" placeholder="Search by name..." value="${param.keyword}">
                    </div>
                    <c:if test="${Useroke == 'manager'}">
                        <div class="col-md-2">
                            <select name="roleFilter" class="form-select">
                                <option value="">All Roles</option>
                                <option value="5" ${param.roleFilter == '5' ? 'selected' : ''}>Staff</option>
                                <option value="3" ${param.roleFilter == '3' ? 'selected' : ''}>Marketing</option>
                                <option value="4" ${param.roleFilter == '4' ? 'selected' : ''}>Shipper</option>
                            </select>
                        </div>
                    </c:if>
                    <div class="col-md-2">
                        <select name="genderFilter" class="form-select">
                            <option value="">All Genders</option>
                            <option value="Male" ${param.genderFilter == 'Male' ? 'selected' : ''}>Male</option>
                            <option value="Female" ${param.genderFilter == 'Female' ? 'selected' : ''}>Female</option>
                        </select>
                    </div>

                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary w-100">Tìm kiếm</button>
                    </div>
                    <div class="col-md-2">
                        <a href="user" class="btn btn-secondary w-100">Đặt lại</a>
                    </div>
                </form>

                <c:if test="${not empty errorMsg}">
                    <div class="alert alert-danger">${errorMsg}</div>
                </c:if>
                <c:if test="${not empty successMsg}">
                    <div class="alert alert-success">${successMsg}</div>
                </c:if>

                <!-- Button to open Add Modal -->
                <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#userModal" onclick="openAddModal()">Thêm Người Dùng</button>

                <!-- User Table -->
                <table class="table table-bordered table-hover bg-white">
                    <thead class="table-dark">
                        <tr>
                            <th><a href="user?action=list&sortBy=user_id&sortOrder=${param.sortOrder == 'asc' ? 'desc' : 'asc'}&keyword=${param.keyword}&roleFilter=${param.roleFilter}&genderFilter=${param.genderFilter}&page=${currentPage}">ID</a></th>
                            <th><a href="user?action=list&sortBy=full_name&sortOrder=${param.sortOrder == 'asc' ? 'desc' : 'asc'}&keyword=${param.keyword}&roleFilter=${param.roleFilter}&genderFilter=${param.genderFilter}&page=${currentPage}">Họ và tên</a></th>
                            <th>Ảnh đại diện</th>
                            <th><a href="user?action=list&sortBy=email&sortOrder=${param.sortOrder == 'asc' ? 'desc' : 'asc'}&keyword=${param.keyword}&roleFilter=${param.roleFilter}&genderFilter=${param.genderFilter}&page=${currentPage}">Email</a></th>
                            <th>Giới tính</th>
                            <th>Số điện thoại</th>
                            <th>Vai trò</th>
                            <th>Kích Hoạt</th>
                            <th>Đã xác minh</th>
                            <th>Hoạt động</th>

                        </tr>

                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${userList}">
                            <tr>
                                <td>${user.user_id}</td>
                                <td>${user.full_name}</td>
                                <td>
                                    <img src="${user.avatar_url}" alt="Avatar" width="50" height="50" style="object-fit: cover; border-radius: 50%;">
                                </td>
                                <td>${user.email}</td>
                                <td>${user.gender}</td>
                                <td>${user.phone_number}</td>
                                <td>
                                    ${user.role_id == 1 ? 'Manager' :
                                      user.role_id == 2 ? 'Customer' :
                                      user.role_id == 3 ? 'Marketing' :
                                      user.role_id == 4 ? 'Shipper' :
                                      user.role_id == 5 ? 'Staff' :'Unknown' }
                                </td>

                                <td>
                                    <span class="status-badge ${user.is_active ? 'status-active':'status-inactive'}">
                                        ${user.is_active ? 'Active':'Inactive'}
                                    </span>
                                </td>
                                <td>${user.is_verified ? 'Yes' : 'No'}</td>
                                <td class="text-nowrap">
                                    <a href="${pageContext.request.contextPath}/UserController?action=view&id=${user.user_id}" class="btn btn-sm btn-info me-1"><i class="fas fa-eye"></i></a>
                                    <button type="button"
                                            class="btn btn-sm btn-warning"
                                            title="Chỉnh sửa"
                                            onclick='openEditModal(
                                            ${user.user_id},
                                                            "${fn:escapeXml(user.full_name)}",
                                                            "${fn:escapeXml(user.email)}",
                                                            "${user.gender}",
                                                            "${user.phone_number}",
                                                            "${fn:escapeXml(user.address)}",
                                            ${user.role_id},
                                            ${user.is_active},
                                            ${user.is_verified}
                                                    )'>
                                        <i class="fas fa-edit"></i>
                                    </button>

                                    <form action="${pageContext.request.contextPath}/UserController" method="get" class="d-inline">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${user.user_id}">
                                        <button type="submit" class="btn btn-sm ${user.is_active ? 'btn-danger' : 'btn-success'}" 
                                                title="${user.is_active ? 'Deactivate' : 'Activate'}">
                                            <i class="fas ${user.is_active ? 'fa-times' : 'fa-check'}"></i>
                                        </button>
                                    </form>


                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <!-- Pagination -->
            <nav>
                <ul class="pagination justify-content-center">
                    <!-- Previous Button -->
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="user?page=${currentPage - 1}&keyword=${param.keyword}&roleFilter=${param.roleFilter}">
                            Previous
                        </a>
                    </li>

                    <!-- Page Number Buttons -->
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="user?page=${i}&keyword=${param.keyword}&roleFilter=${param.roleFilter}">
                                ${i}
                            </a>
                        </li>
                    </c:forEach>

                    <!-- Next Button -->
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="user?page=${currentPage + 1}&keyword=${param.keyword}&roleFilter=${param.roleFilter}">
                            Next
                        </a>
                    </li>
                </ul>
            </nav>



            <!-- Bootstrap Modal -->
            <div class="modal fade" id="userModal" tabindex="-1" aria-labelledby="userModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <form method="post" action="user" class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="userModalLabel">Add/Edit User</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="user_id" id="user_id">

                            <div class="modal-body">
                                <input type="hidden" name="user_id" id="user_id">

                                <div class="mb-2">
                                    <label>Họ và tên</label>
                                    <input type="text" class="form-control" name="full_name" id="full_name" required>
                                </div>

                                <div class="mb-2">
                                    <label>Email</label>
                                    <input type="email" class="form-control" name="email" id="email" required>
                                </div>
                                <div class="mb-2" id="passwordField">
                                    <label>Mật khẩu</label>
                                    <input type="password" class="form-control" name="password" id="password">
                                </div>

                                <div class="mb-2">
                                    <label>Giới tính</label>
                                    <select class="form-control" name="gender" id="gender">
                                        <option value="Male">Nam</option>
                                        <option value="Female">Nữ</option>
                                    </select>
                                </div>

                                <div class="mb-2">
                                    <label>Số điện thoại</label>
                                    <input type="text" class="form-control" name="phone_number" id="phone_number">
                                </div>

                                <div class="mb-2">
                                    <label>Địa chỉ</label>
                                    <input type="text" class="form-control" name="address" id="address">
                                </div>
                                <c:if test="${Useroke == 'manager'}">
                                    <div class="mb-2">
                                        <label>Vai trò</label>
                                        <select class="form-control" name="role_id" id="role_id">

                                            <option value="3">Marketing</option>
                                            <option value="4">Nhân viên giao hàng</option>
                                            <option value="5">Nhân viên quản lí</option>
                                        </select>
                                    </div>
                                </c:if>
                                <c:if test="${Useroke == 'staff'}">
                                    <div class="mb-2">
                                        <label>Vai trò</label>
                                        <select class="form-control" name="role_id" id="role_id">

                                            <option value="2">Khách hàng</option>

                                        </select>
                                    </div>
                                </c:if>
                                <div class="mb-2">
                                    <label>Kích Hoạt</label>
                                    <select class="form-control" name="is_active" id="is_active">
                                        <option value="true">Có</option>
                                        <option value="false">Không</option>
                                    </select>
                                </div>

                                <div class="mb-2">
                                    <label>Đã xác minh</label>
                                    <select class="form-control" name="is_verified" id="is_verified">
                                        <option value="true">Có</option>
                                        <option value="false">Không</option>
                                    </select>
                                </div>
                            </div>

                            <div class="modal-footer">
                                <button type="submit" class="btn btn-success">Save User</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            </div>
                    </form>
                </div>
            </div>

        </div>
    </div>
    <div class="dashboard-footer">
        <jsp:include page="dashboard-footer.jsp"/>
    </div>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Custom JS to handle form population -->
    <script>
                                                function openAddModal() {
                                                    document.getElementById('userModalLabel').innerText = 'Add User';
                                                    document.getElementById('user_id').value = '';
                                                    document.getElementById('full_name').value = '';
                                                    document.getElementById('email').value = '';
                                                    document.getElementById('gender').value = 'Male';
                                                    document.getElementById('phone_number').value = '';
                                                    document.getElementById('address').value = '';
                                                    document.getElementById('role_id').value = '1';
                                                    document.getElementById('is_active').value = 'true';
                                                    document.getElementById('is_verified').value = 'false';
                                                    document.getElementById('passwordField').style.display = 'block';
                                                }

                                                function openEditModal(id, name, email, gender, phone, address, role, active, verified) {
                                                    document.getElementById('userModalLabel').innerText = 'Edit User';
                                                    document.getElementById('user_id').value = id;
                                                    document.getElementById('full_name').value = name;
                                                    document.getElementById('email').value = email;
                                                    document.getElementById('gender').value = gender;
                                                    document.getElementById('phone_number').value = phone;
                                                    document.getElementById('address').value = address;
                                                    document.getElementById('role_id').value = role;
                                                    document.getElementById('is_active').value = active ? 'true' : 'false';
                                                    document.getElementById('is_verified').value = verified ? 'true' : 'false';
                                                    document.getElementById('passwordField').style.display = 'none';

                                                    var modal = new bootstrap.Modal(document.getElementById('userModal'));
                                                    modal.show();
                                                }
    </script>
</body>
</html>
