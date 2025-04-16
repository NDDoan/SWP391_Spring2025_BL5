<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>User Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light p-4">

        <div class="container">
            <h2 class="mb-4">User Management</h2>

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
                        <th>ID</th><th>Full Name</th><th>Email</th><th>Gender</th><th>Phone</th>
                        <th>Role</th><th>Active</th><th>Verified</th><th>Edit</th><th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${userList}">
                        <tr>
                            <td>${user.user_id}</td>
                            <td>${user.full_name}</td>
                            <td>${user.email}</td>
                            <td>${user.gender}</td>
                            <td>${user.phone_number}</td>
                            <td>${user.role_id == 1 ? 'Admin' : 'Staff'}</td>
                            <td>${user.is_active ? 'Yes' : 'No'}</td>
                            <td>${user.is_verified ? 'Yes' : 'No'}</td>
                            <td>
                                <button class="btn btn-sm btn-warning" 
                                        onclick='openEditModal(${user.user_id}, "${user.full_name}", "${user.email}", "${user.gender}", "${user.phone_number}", "${user.address}", ${user.role_id}, ${user.is_active}, ${user.is_verified})'>
                                    Edit
                                </button>
                            </td>
                            <td>
                                <a class="btn btn-sm btn-danger" href="deleteUser?user_id=${user.user_id}" onclick="return confirm('Are you sure?')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

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
                                <option value="3">Shipper</option>
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
