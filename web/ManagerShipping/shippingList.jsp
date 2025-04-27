<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*, Entity.Shipping" %>
<%@ page import="Entity.User" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Quản lý giao hàng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            body {
                background-color: #f4f6f9;
            }

            .sidebar {
                margin-top: 75px;
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
                <c:if test="${ShipOke == 'manager'}">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h3>Danh sách giao hàng cho Manager</h3>
                        <a href="shipping?action=create" class="btn btn-add">+ Thêm giao hàng</a>
                    </div>
                </c:if>
                <c:if test="${ShipOke == 'shipper'}">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h3>Danh sách đơn hàng cho Shipper</h3>

                    </div>
                </c:if>
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
                    <table class="table table-bordered table-hover bg-white">
                        <thead class="table-dark">
                            <tr>
                                <th>
                                    <a href="shipping?sortBy=shipping_id&sortDir=${param.sortDir == 'asc' ? 'desc' : 'asc'}&page=${currentPage}&status=${param.status}">
                                        ID
                                        <c:choose>
                                            <c:when test="${param.sortBy == 'shipping_id' && param.sortDir == 'asc'}">
                                                <i class="fas fa-sort-up"></i>
                                            </c:when>
                                            <c:when test="${param.sortBy == 'shipping_id' && param.sortDir == 'desc'}">
                                                <i class="fas fa-sort-down"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-sort"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                </th>
                                <th>Order ID</th>
                                <th>
                                    <a href="shipping?sortBy=shipping_address&sortDir=${ param.sortDir == 'asc' ? 'desc' : 'asc'}&page=${currentPage}&status=${param.status}">
                                        Địa chỉ giao hàng
                                        <c:choose>
                                            <c:when test="${param.sortBy == 'shipping_address' && param.sortDir == 'asc'}">
                                                <i class="fas fa-sort-up"></i>
                                            </c:when>
                                            <c:when test="${param.sortBy == 'shipping_address' && param.sortDir == 'desc'}">
                                                <i class="fas fa-sort-down"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-sort"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                </th>
                                <th>Trạng thái</th>
                                <th>Tracking</th>
                                <th>
                                    <a href="shipping?sortBy=shipping_date&sortDir=${ param.sortDir == 'asc' ? 'desc' : 'asc'}&page=${currentPage}&status=${param.status}">
                                        Ngày giao
                                        <c:choose>
                                            <c:when test="${param.sortBy == 'shipping_date' && param.sortDir == 'asc'}">
                                                <i class="fas fa-sort-up"></i>
                                            </c:when>
                                            <c:when test="${param.sortBy == 'shipping_date' && param.sortDir == 'desc'}">
                                                <i class="fas fa-sort-down"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-sort"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                </th>
                                <th>
                                    <a href="shipping?sortBy=estimated_delivery&sortDir=${param.sortDir == 'asc' ? 'desc' : 'asc'}&page=${currentPage}&status=${param.status}">
                                        Ngày dự kiến
                                        <c:choose>
                                            <c:when test="${param.sortBy == 'estimated_delivery' && param.sortDir == 'asc'}">
                                                <i class="fas fa-sort-up"></i>
                                            </c:when>
                                            <c:when test="${param.sortBy == 'estimated_delivery' && param.sortDir == 'desc'}">
                                                <i class="fas fa-sort-down"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-sort"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                </th>
                                <th>Ghi chú</th>
                                <th>Cập nhật</th>
                                    <c:if test="${ShipOke == 'manager'}">
                                    <th>Shipper Name</th>
                                    </c:if>
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
                                    <c:if test="${ShipOke == 'manager'}">
                                        <td>
                                            <c:choose>
                                                <c:when test="${s.shipperId != null}">
                                                    <c:forEach var="shipper" items="${shipperList}">
                                                        <c:if test="${s.shipperId == shipper.user_id}">
                                                            ${shipper.full_name}
                                                        </c:if>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color: red;">Chưa có người giao hàng</span> <!-- Added style for visibility -->
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </c:if>
                                    <td class="text-nowrap">
                                        <c:choose>
                                            <c:when test="${ShipOke == 'manager'}">

                                                <a href="shipping?action=detail&id=${s.id}" class="btn btn-sm btn-info">
                                                    <i class="fas fa-eye"></i> 
                                                </a>
                                                <a href="shipping?action=edit&id=${s.id}" class="btn btn-sm btn-warning">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <a href="shipping?action=delete&id=${s.id}" class="btn btn-sm btn-danger"
                                                   onclick="return confirm('Bạn có chắc chắn muốn xoá đơn này?');">
                                                    <i class="fas fa-trash-alt"></i>
                                                </a>
                                            </c:when>
                                            <c:when test="${ShipOke == 'shipper'}">
                                                <c:choose>
                                                    <c:when test="${s.shippingStatus == 'Delivered'}">
                                                        <span>Đã giao hàng</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <form action="shipper" method="post" style="display:inline-block;">
                                                            <input type="hidden" name="action" value="updateShippingStatus" />
                                                            <input type="hidden" name="id" value="${s.id}" />
                                                            <select name="status" class="form-select form-select-sm d-inline w-auto">
                                                                <option value="Shipped" ${s.shippingStatus == 'Shipped' ? 'selected' : ''}>Shipped</option>
                                                                <option value="Delivered" ${s.shippingStatus == 'Delivered' ? 'selected' : ''}>Delivered</option>
                                                                <option value="Returned" ${s.shippingStatus == 'Returned' ? 'selected' : ''}>Returned</option>
                                                            </select>
                                                            <button type="submit" class="btn btn-sm btn-success">Cập nhật</button>
                                                        </form>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                        </c:choose>
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
        <c:if test="${totalPages > 1}">
            <nav aria-label="Pagination">
                <ul class="pagination justify-content-center mt-4">

                    <!-- Nút Previous -->
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link"
                           href="shipping?page=${currentPage - 1}&status=${param.status}&sortBy=${param.sortBy}&sortDir=${param.sortDir}">
                            Previous
                        </a>
                    </li>

                    <!-- Các số trang -->
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link"
                               href="shipping?page=${i}&status=${param.status}&sortBy=${param.sortBy}&sortDir=${param.sortDir}">
                                ${i}
                            </a>
                        </li>
                    </c:forEach>

                    <!-- Nút Next -->
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link"
                           href="shipping?page=${currentPage + 1}&status=${param.status}&sortBy=${param.sortBy}&sortDir=${param.sortDir}">
                            Next
                        </a>
                    </li>

                </ul>
            </nav>
        </c:if>


        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
