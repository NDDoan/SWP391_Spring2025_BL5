<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Quản Lý Đơn Hàng</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-color: #4e73df;
                --accent-color: #2e59d9;
            }
            h2 {
                color: var(--primary-color);
                border-bottom: 3px solid var(--primary-color);
            }
        </style>
    </head>
    <body class="bg-light py-4">
        <jsp:include page="../AdminPage/dashboard-header.jsp"/>

        <div class="container bg-white rounded shadow-sm p-4">
            <h2 class="text-center mb-4">Quản Lý Đơn Hàng</h2>

            <!-- SEARCH & FILTER -->
            <form action="${pageContext.request.contextPath}/OrderList" method="get" class="row g-2 mb-3 align-items-end">
                <div class="col-md-3">
                    <label class="form-label">Mã đơn hàng</label>
                    <input type="text" name="orderId" class="form-control" placeholder="Nhập mã đơn" value="${param.orderId}">
                </div>

                <div class="col-md-2">
                    <label class="form-label">Từ ngày</label>
                    <input type="date" name="startDate" class="form-control" value="${param.startDate}">
                </div>
                <div class="col-md-2">
                    <label class="form-label">Đến ngày</label>
                    <input type="date" name="endDate" class="form-control" value="${param.endDate}">
                </div>
                <div class="col-md-2 d-grid">
                    <button type="submit" class="btn btn-success">Tìm kiếm</button>
                </div>
            </form>

            <!-- ORDERS TABLE -->
            <div class="table-responsive">
                <table class="table table-striped table-hover text-center">
                    <thead class="table-primary">
                        <tr>
                            <th>Id</th>
                            <th>Ngày Đặt</th>
                            <th>Sản Phẩm</th>
                            <th>Tổng Chi Phí</th>
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
                                            <a href="OrderDetailsServlet?orderId=${order.orderId}" class="btn btn-sm btn-warning">Chi tiết</a>
                                            <c:if test="${order.status eq 'Completed'}">
                                                <a href="CustomerSendFeedback?orderId=${order.orderId}" class="btn btn-sm btn-success">Phản hồi</a>
                                            </c:if>
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
                        <a class="page-link" href="?page=${i}">${i}</a>
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



            <jsp:include page="../CommonPage/Footer.jsp"/>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
