<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Quản Lý Đơn Hàng</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            /* Đảm bảo Sidebar và Header không bị chồng lên nhau */
            body {
                display: flex;
                min-height: 100vh;
                flex-direction: column;
            }

            .container {
                flex: 1;
                margin-left: 220px;  /* Chiều rộng của sidebar */
            }

            /* Định dạng sidebar */
            .sidebar {
                margin-top: 70px;
                position: fixed;
                top: 0;
                left: 0;
                width: 220px;
                height: 100%;
                background-color: #343a40;
                padding-top: 20px;
            }
            .qt{
               
                padding-top: 70px; /* né header */
                padding-left: 60px; /* né sidebar */
            }
            /* Định dạng header */
            #header {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                background-color: #fff;
                z-index: 9999;
                padding: 10px 0;
            }

            /* Đảm bảo nội dung không bị che khuất bởi sidebar */
            body {
                margin: 0;
                padding-top: 70px; /* Né header */
                padding-left: 220px; /* Né sidebar */
                background-color: #f8f9fa;
                min-height: 100vh;
            }
            .container {
                padding: 20px;
            }
            .thead-black {
                background-color: #000;
                color: #fff;
            }
        </style>
    </head>
    <body class="bg-light py-4">
        <div  class="sidebar">
            <jsp:include page="../AdminPage/dashboard-sidebar.jsp"/>
        </div>
        <div id="header">
            <jsp:include page="../AdminPage/dashboard-header.jsp"/>
        </div>
        <div class="qt">
            <div class="container bg-white rounded shadow-sm p-4">
                <h2 class="text-center mb-4">Quản Lý Đơn Hàng</h2>

                <!-- SEARCH & FILTER -->
                <form action="${pageContext.request.contextPath}/OrderList" method="get" class="row g-3 mb-4 align-items-end">
                    <div class="col-md-3">
                        <label for="orderId" class="form-label">Mã đơn hàng</label>
                        <input type="text" id="orderId" name="orderId" class="form-control" placeholder="Nhập mã đơn" value="${param.orderId}">
                    </div>
                    <div class="col-md-3">
                        <label for="status" class="form-label">Trạng thái</label>
                        <select id="status" name="status" class="form-select">
                            <option value="">-- Tất cả --</option>
                            <option value="Pending" ${param.status == 'Pending' ? 'selected' : ''}>Chờ xử lý</option>
                            <option value="Shipping" ${param.status == 'Shipping' ? 'selected' : ''}>Đang giao</option>
                            <option value="Completed" ${param.status == 'Completed' ? 'selected' : ''}>Hoàn thành</option>
                            <option value="Cancelled" ${param.status == 'Cancelled' ? 'selected' : ''}>Đã huỷ</option>
                        </select>
                    </div>

                    <div class="col-md-3">
                        <label for="startDate" class="form-label">Từ ngày</label>
                        <input type="date" id="startDate" name="startDate" class="form-control" value="${param.startDate}">
                    </div>

                    <div class="col-md-3">
                        <label for="endDate" class="form-label">Đến ngày</label>
                        <input type="date" id="endDate" name="endDate" class="form-control" value="${param.endDate}">
                    </div>

                    <div class="col-md-3 d-grid">
                        <button type="submit" class="btn btn-success">Tìm kiếm</button>
                    </div>
                </form>

                <!-- ORDERS TABLE -->
                <div class="table-responsive">
                    <table class="table table-striped table-hover text-center">
                        <thead class="thead-black">
                            <tr>
                                <th>
                                    <a href="orderlist?sortBy=order_id&sortDir=${param.sortDir == 'asc' ? 'desc' : 'asc'}&page=${currentPage}&status=${param.status}">
                                        ID
                                        <c:choose>
                                            <c:when test="${param.sortBy == 'order_id' && param.sortDir == 'asc'}">
                                                <i class="fas fa-sort-up"></i>
                                            </c:when>
                                            <c:when test="${param.sortBy == 'order_id' && param.sortDir == 'desc'}">
                                                <i class="fas fa-sort-down"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-sort"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                </th>
                                <th>
                                    <a href="orderlist?sortBy=created_at&sortDir=${param.sortDir == 'asc' ? 'desc' : 'asc'}&page=${currentPage}&status=${param.status}">
                                        Ngày Đặt
                                        <c:choose>
                                            <c:when test="${param.sortBy == 'created_at' && param.sortDir == 'asc'}">
                                                <i class="fas fa-sort-up"></i>
                                            </c:when>
                                            <c:when test="${param.sortBy == 'created_at' && param.sortDir == 'desc'}">
                                                <i class="fas fa-sort-down"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-sort"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                </th>
                                <th>Sản Phẩm</th>
                                <th>
                                    <a href="orderlist?sortBy=total_amount&sortDir=${param.sortDir == 'asc' ? 'desc' : 'asc'}&page=${currentPage}&status=${param.status}">
                                        Tổng Chi Phí
                                        <c:choose>
                                            <c:when test="${param.sortBy == 'total_amount' && param.sortDir == 'asc'}">
                                                <i class="fas fa-sort-up"></i>
                                            </c:when>
                                            <c:when test="${param.sortBy == 'total_amount' && param.sortDir == 'desc'}">
                                                <i class="fas fa-sort-down"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-sort"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                </th>
                                <th>Trạng Thái</th>
                                <th>Hành Động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty orders}">
                                    <tr><td colspan="6">Không tìm thấy đơn hàng</td></tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="order" items="${orders}">
                                        <tr>
                                            <td>${order.orderId}</td>
                                            <td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy" /></td>
                                            <td>${order.productNames}</td>
                                            <td>${order.totalCost}</td>
                                            <td>${order.status}</td>
                                            <td class="d-flex justify-content-center gap-1">
                                                <a href="orderlist?action=detail&orderId=${order.orderId}" class="btn btn-sm btn-primary text-dark"> <i class="fas fa-eye"></i> </a>

                                                <button type="button" class="btn btn-sm btn-warning" 
                                                        data-bs-toggle="modal" 
                                                        data-bs-target="#updateStatusModal"
                                                        data-order-id="${order.orderId}"
                                                        data-order-status="${order.status}">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                            </td>

                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <!-- CUSTOMIZE BUTTON -->
                <ul class="pagination justify-content-center">
                    <!-- Nút Previous -->
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="?page=1">First</a>
                        </li>
                        <li class="page-item">
                            <a class="page-link" href="?page=${currentPage - 1}">Previous</a>
                        </li>
                    </c:if>

                    <!-- Các số trang -->
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="?page=${i}
                               &orderId=${param.orderId}
                               &startDate=${param.startDate}
                               &endDate=${param.endDate}
                               &sortBy=${param.sortBy}
                               &sortDir=${param.sortDir}">
                                ${i}
                            </a>
                        </li>
                    </c:forEach>

                    <!-- Nút Next -->
                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="?page=${currentPage + 1}">Next</a>
                        </li>
                        <li class="page-item">
                            <a class="page-link" href="?page=${totalPages}">Last</a>
                        </li>
                    </c:if>
                </ul>

                <!-- Update Status Modal -->
                <div class="modal fade" id="updateStatusModal" tabindex="-1" aria-labelledby="updateStatusModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <form action="orderlist" method="post" class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="updateStatusModalLabel">Cập nhật trạng thái đơn hàng</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                            </div>
                            <div class="modal-body">
                                <input type="hidden" name="orderId" id="modalOrderId">
                                <div class="mb-3">
                                    <label for="modalOrderStatus" class="form-label">Trạng thái mới</label>
                                    <select name="status" id="modalOrderStatus" class="form-select" required>
                                        <option value="Pending">Chờ xử lý</option>
                                        <option value="Shipping">Đang giao</option>
                                        <option value="Completed">Hoàn thành</option>
                                        <option value="Cancelled">Đã huỷ</option>
                                    </select>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            </div>
                        </form>
                    </div>
                </div>


            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            var updateStatusModal = document.getElementById('updateStatusModal');
            updateStatusModal.addEventListener('show.bs.modal', function (event) {
                var button = event.relatedTarget; // Button mà user click
                var orderId = button.getAttribute('data-order-id');
                var status = button.getAttribute('data-order-status');

                var modalOrderIdInput = updateStatusModal.querySelector('#modalOrderId');
                var modalStatusSelect = updateStatusModal.querySelector('#modalOrderStatus');

                // Gán giá trị vào form trong modal
                modalOrderIdInput.value = orderId;
                modalStatusSelect.value = status;
            });
        </script>

    </body>
</html>