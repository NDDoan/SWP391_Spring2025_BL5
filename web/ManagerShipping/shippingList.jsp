<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, Entity.Shipping" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Quản lý giao hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f6f9;
        }

        .sidebar {
            position: fixed;
            top: 80px;
            left: 0;
            bottom: 0;
            width: 250px;
            background-color: #ffffff;
            border-right: 1px solid #dee2e6;
            padding: 20px;
            overflow-y: auto;
            z-index: 100;
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
            z-index: 101;
        }

        .content-container {
            margin-left: 250px;
            padding: 100px 20px 40px 20px;
        }

        .table th, .table td {
            vertical-align: middle;
        }

        .btn {
            padding: 6px 12px;
        }

        .btn-edit {
            background-color: #17a2b8;
            color: white;
        }

        .btn-edit:hover {
            background-color: #138496;
        }

        .btn-delete {
            background-color: #dc3545;
            color: white;
        }

        .btn-delete:hover {
            background-color: #bd2130;
        }

        .btn-add {
            background-color: #28a745;
            color: white;
        }

        .btn-add:hover {
            background-color: #218838;
        }

        .filter-form {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 20px;
        }

        @media (max-width: 768px) {
            .sidebar {
                position: static;
                width: 100%;
                height: auto;
                border-right: none;
            }

            .dashboard-header {
                position: static;
                height: auto;
            }

            .content-container {
                margin-left: 0;
                padding-top: 20px;
            }
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <%-- Include or fallback --%>
    <jsp:include page="/AdminPage/dashboard-sidebar.jsp"/>
    <%-- 
    <ul class="list-unstyled">
        <li><strong>Menu</strong></li>
        <li>Shipping Management</li>
        <li>Users</li>
    </ul> 
    --%>
</div>

<!-- Header -->
<div class="dashboard-header">
    <%-- Include or fallback --%>
    <jsp:include page="/AdminPage/dashboard-header.jsp"/>
    <%-- <h4 class="mb-0">Admin Dashboard</h4> --%>
</div>

<!-- Main Content -->
<div class="content-container">
    <div class="container bg-white rounded shadow p-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h3>Danh sách đơn hàng đang giao</h3>
            <a href="shipping?action=create" class="btn btn-add">+ Thêm giao hàng</a>
        </div>

        <form method="get" action="shipping" class="filter-form">
            <label for="status">Trạng thái:</label>
            <select name="status" id="status" class="form-select w-auto">
                <option value="">-- Tất cả --</option>
                <option value="Pending" ${statusFilter == 'Pending' ? 'selected' : ''}>Pending</option>
                <option value="Shipped" ${statusFilter == 'Shipped' ? 'selected' : ''}>Shipped</option>
                <option value="Delivered" ${statusFilter == 'Delivered' ? 'selected' : ''}>Delivered</option>
                <option value="Canceled" ${statusFilter == 'Canceled' ? 'selected' : ''}>Canceled</option>
                <option value="Returned" ${statusFilter == 'Returned' ? 'selected' : ''}>Returned</option>
            </select>
            <input type="submit" value="Lọc" class="btn btn-primary"/>
            <a href="shipping" class="btn btn-secondary">Reset</a>
        </form>

        <div class="table-responsive">
            <table class="table table-bordered table-striped table-hover">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Order ID</th>
                        <th>Địa chỉ giao hàng</th>
                        <th>Trạng thái</th>
                        <th>Tracking</th>
                        <th>Ngày giao</th>
                        <th>Ngày dự kiến</th>
                        <th>Ghi chú</th>
                        <th>Cập nhật</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="s" items="${shippingList}">
                        <tr>
                            <td>${s.id}</td>
                            <td>${s.orderId}</td>
                            <td>${s.shippingAddress}</td>
                            <td>${s.shippingStatus}</td>
                            <td>${s.trackingNumber}</td>
                            <td>${s.shippingDate}</td>
                            <td>${s.estimatedDelivery}</td>
                            <td>${s.deliveryNotes}</td>
                            <td>${s.updatedAt}</td>
                            <td>
                                <a href="shipping?action=edit&id=${s.id}" class="btn btn-sm btn-edit">Sửa</a>
                                <a href="shipping?action=delete&id=${s.id}" class="btn btn-sm btn-delete"
                                   onclick="return confirm('Bạn có chắc chắn muốn xoá đơn này?');">Xoá</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty shippingList}">
                        <tr>
                            <td colspan="10" class="text-center text-muted">Không có đơn hàng nào.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
