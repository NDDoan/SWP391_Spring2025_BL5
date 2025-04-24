<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <jsp:include page="../CommonPage/Header.jsp"/>

        <div class="container bg-white rounded shadow-sm p-4">
            <h2 class="text-center mb-4">Quản Lý Đơn Hàng</h2>

            <!-- SEARCH & FILTER -->
            <form action="${pageContext.request.contextPath}/myordercontroller" method="get" class="row g-2 mb-3 align-items-end">
                <div class="col-md-3">
                    <label class="form-label">Mã đơn hàng</label>
                    <input type="text" name="orderId" class="form-control" placeholder="Nhập mã đơn" value="${param.orderId}">
                </div>
                <div class="col-md-3">
                    <label class="form-label">Trạng thái</label>
                    <select name="status" class="form-select" onchange="this.form.submit()">
                        <option value="">Tất cả</option>
                        <c:forEach var="status" items="${orderStatuses}">
                            <option value="${status}" ${param.status == status ? 'selected' : ''}>${status}</option>
                        </c:forEach>
                    </select>
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
                                        <td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy"/></td>
                                        <td>${order.productNames}</td>
                                        <td><fmt:formatNumber value="${order.totalCost}" type="currency"/></td>
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

            <!-- PAGINATION -->
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <li class="page-item"><a class="page-link" href="#">&laquo;</a></li>
                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><span class="page-link">…</span></li>
                    <li class="page-item"><a class="page-link" href="#">&raquo;</a></li>
                </ul>
            </nav>

            <!-- CUSTOMIZE BUTTON -->
            <button type="button" class="btn btn-outline-primary mt-3" data-bs-toggle="modal" data-bs-target="#customizeModal">
                Tùy chỉnh bảng
            </button>
        </div>

        <!-- BOOTSTRAP MODAL -->
        <div class="modal fade" id="customizeModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <form class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Tùy chỉnh bảng</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="rowsPerPage" class="form-label">Số dòng mỗi trang</label>
                            <input type="number" id="rowsPerPage" class="form-control" placeholder="VD: 10">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Chọn cột hiển thị</label>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="colId" checked>
                                <label class="form-check-label" for="colId">ID</label>
                            </div>
                            <!-- Thêm các checkbox khác tương tự -->
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="button" id="applySettings" class="btn btn-primary">Áp dụng</button>
                    </div>
                </form>
            </div>
        </div>

        <jsp:include page="../CommonPage/Footer.jsp"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                  // JS tuỳ chỉnh: đọc rowsPerPage và checkbox, lưu vào localStorage hoặc gọi API
                  document.getElementById('applySettings').addEventListener('click', () => {
                      // TODO: xử lý tuỳ chỉnh
                      const rows = document.getElementById('rowsPerPage').value;
                      console.log('Rows per page:', rows);
                      // Đóng modal
                      bootstrap.Modal.getInstance(document.getElementById('customizeModal')).hide();
                  });
        </script>
    </body>
</html>
