<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>User Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            /* Sidebar Fixed to the left */
            .sidebar {
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
                padding-top: 80px; /* Clear the header */
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
                <h2 class="text-center mb-4 text-primary"><i class="fas fa-users-cog me-2"></i>User Management</h2>

                <form method="get" action="user" class="row g-2 mb-4">
                    <div class="col-md-4">
                        <input type="text" name="keyword" class="form-control" placeholder="Search by name..." value="${param.keyword}">
                    </div>
                    <div class="col-md-3">
                        <select name="roleFilter" class="form-select">
                            <option value="">All Roles</option>
                            <option value="1" ${param.roleFilter == '1' ? 'selected' : ''}>Admin</option>
                            <option value="2" ${param.roleFilter == '2' ? 'selected' : ''}>Customer</option>
                            <option value="3" ${param.roleFilter == '3' ? 'selected' : ''}>Manager</option>
                            <option value="4" ${param.roleFilter == '4' ? 'selected' : ''}>Shipper</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary w-100">Search</button>
                    </div>
                    <div class="col-md-2">
                        <a href="user" class="btn btn-secondary w-100">Reset</a>
                    </div>
                </form>

                <c:if test="${not empty errorMsg}">
                    <div class="alert alert-danger">${errorMsg}</div>
                </c:if>
                <c:if test="${not empty successMsg}">
                    <div class="alert alert-success">${successMsg}</div>
                </c:if>

                <!-- Button to open Add Modal -->
                <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#userModal" onclick="openAddModal()">Add User</button>

                <!-- User Table -->
                <table class="table table-bordered table-hover bg-white">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th><th>Full Name</th><th>Avatar</th><th>Email</th><th>Gender</th><th>Phone</th>
                            <th>Role</th><th>Active</th><th>Verified</th><th>Edit</th><th>Delete</th>
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
                                    ${user.role_id == 1 ? 'Admin' :
                                      user.role_id == 2 ? 'Customer' :
                                      user.role_id == 3 ? 'Manager' :
                                      user.role_id == 4 ? 'Shipper' : 'Unknown' }
                                </td>

                                <td>${user.is_active ? 'Yes' : 'No'}</td>
                                <td>${user.is_verified ? 'Yes' : 'No'}</td>
                                <td>
                                    <button class="btn btn-sm btn-warning" 
                                            onclick='openEditModal(${user.user_id}, "${user.full_name}", "${user.email}", "${user.gender}", "${user.phone_number}", "${user.address}", ${user.role_id}, ${user.is_active}, ${user.is_verified})'>
                                        Edit
                                    </button>
                                </td>
                                <td>
                                    <a class="btn btn-sm btn-danger" href="user?action=delete&id=${user.user_id}" onclick="return confirm('Are you sure?')">Delete</a>
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

                            <div class="mb-2">
                                <label>Full Name</label>
                                <input type="text" class="form-control" name="full_name" id="full_name" required>
                            </div>

                            <div class="mb-2">
                                <label>Email</label>
                                <input type="email" class="form-control" name="email" id="email" required>
                            </div>

                            <div class="mb-2">
                                <label>Gender</label>
                                <select class="form-control" name="gender" id="gender">
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                </select>
                            </div>

                            <div class="mb-2">
                                <label>Phone</label>
                                <input type="text" class="form-control" name="phone_number" id="phone_number">
                            </div>

                            <div class="mb-2">
                                <label>Address</label>
                                <input type="text" class="form-control" name="address" id="address">
                            </div>

                            <div class="mb-2">
                                <label>Role</label>
                                <select class="form-control" name="role_id" id="role_id">
                                    <option value="1">Admin</option>
                                    <option value="2">Customer</option>
                                    <option value="3">Manager</option>
                                    <option value="4">Shipper</option>
                                </select>
                            </div>

                            <div class="mb-2">
                                <label>Active</label>
                                <select class="form-control" name="is_active" id="is_active">
                                    <option value="true">Yes</option>
                                    <option value="false">No</option>
                                </select>
                            </div>

                            <div class="mb-2">
                                <label>Verified</label>
                                <select class="form-control" name="is_verified" id="is_verified">
                                    <option value="true">Yes</option>
                                    <option value="false">No</option>
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

                                            var modal = new bootstrap.Modal(document.getElementById('userModal'));
                                            modal.show();
                                        }
        </script>
    </body>
</html>
