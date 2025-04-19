<%-- 
    Document   : ProductList
    Created on : Apr 16, 2025, 1:36:53 PM
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Danh sách Sản phẩm Product</title>
        <!-- Bootstrap CSS CDN (phiên bản 5) -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- CSS Tùy chỉnh -->
        <style>
            body {
                background-color: #f4f6f9;
                margin: 0;
                padding: 0;
                min-height: 100vh;
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
                z-index: 1000;
            }
            .main-layout {
                display: flex;
                flex-wrap: nowrap;
                margin-top: 80px;
                min-height: calc(100vh - 80px);
            }

            .sidebar {
                position: fixed;
                top: 80px;
                left: 0;
                width: 20%; /* Changed to percentage */
                background-color: #ffffff;
                border-right: 1px solid #dee2e6;
                padding: 20px;
                height: calc(100vh - 80px);
                overflow-y: auto;
                z-index: 999;
            }
            .content-container {
                margin-left: 20%; /* Match sidebar width */
                padding: 20px;
                background-color: #f4f6f9;
                flex: 1;
                min-height: calc(100vh - 80px);
                margin-bottom: 20px;
            }
            .table-responsive {
                margin-top: 20px;
            }
            .search-form {
                margin-bottom: 20px;
            }
            .pagination {
                justify-content: center;
            }
            .page-header {
                margin-bottom: 30px;
            }
            .table th {
                cursor: pointer;
            }
            .table th:hover {
                background-color: #e9ecef;
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <div class="dashboard-header">
            <jsp:include page="Manager-header.jsp" />
        </div>

        <div class="main-layout">
            <!-- Sidebar -->
            <div class="sidebar">
                <jsp:include page="Manager-sidebar.jsp" />
            </div>

            <!-- Content -->
            <div class="content-container">
                <div class="container-fluid">
                    <!-- Page Title and Add Button -->
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h2>Danh sách Sản phẩm</h2>
                        <a href="${pageContext.request.contextPath}/ProductForManagerDetailController?mode=add" class="btn btn-success">
                            <i class="bi bi-plus-lg"></i> Thêm sản phẩm
                        </a>
                    </div>

                    <!-- Form Tìm kiếm & Sắp xếp -->
                    <div class="row">
                        <div class="col-md-12">
                            <form class="search-form row g-2" action="${pageContext.request.contextPath}/ProductForManagerListController" method="get">
                                <div class="col-md-4">
                                    <input type="text" name="search" class="form-control" placeholder="Tìm kiếm sản phẩm..." value="${param.search}">
                                </div>
                                <div class="col-md-3">
                                    <select class="form-select" name="sortField">
                                        <option value="p.product_id" ${param.sortField == 'p.product_id' ? 'selected' : ''}>Id</option>
                                        <option value="p.product_name" ${param.sortField == 'p.product_name' ? 'selected' : ''}>Tên sản phẩm</option>
                                        <option value="b.brand_name" ${param.sortField == 'b.brand_name' ? 'selected' : ''}>Thương hiệu</option>
                                        <option value="c.category_name" ${param.sortField == 'c.category_name' ? 'selected' : ''}>Danh mục</option>
                                        <option value="totalStockQuantity" ${param.sortField == 'totalStockQuantity' ? 'selected' : ''}>Tồn kho</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <select class="form-select" name="sortDir">
                                        <option value="ASC" ${param.sortDir == 'ASC' ? 'selected' : ''}>Tăng dần</option>
                                        <option value="DESC" ${param.sortDir == 'DESC' ? 'selected' : ''}>Giảm dần</option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <button type="submit" class="btn btn-primary w-100">Tìm kiếm</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Bảng hiển thị dữ liệu -->
                    <div class="row">
                        <div class="col-md-12">
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover align-middle">
                                    <thead class="table-light">
                                        <tr>
                                            <th>ID</th>
                                            <th>Tên sản phẩm</th>
                                            <th>Thương hiệu</th>
                                            <th>Danh mục</th>
                                            <th>Tổng tồn kho</th>
                                            <th>Media chính</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="product" items="${productList}">
                                            <tr>
                                                <td>${product.productId}</td>
                                                <td>${product.productName}</td>
                                                <td>${product.brandName}</td>
                                                <td>${product.categoryName}</td>
                                                <td>${product.totalStockQuantity}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty product.primaryMediaUrl}">
                                                            <img src="${product.primaryMediaUrl}" alt="Ảnh sản phẩm" class="img-thumbnail" style="max-width:100px;">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">Không có ảnh</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <!-- Các nút hành động -->
                                                    <!-- View: Hiển thị thông tin chi tiết, chuyển sang chế độ xem -->
                                                    <a href="${pageContext.request.contextPath}/ProductForManagerDetailController?productId=${product.productId}&mode=view" class="btn btn-info btn-sm">Xem</a>

                                                    <!-- Edit: Chuyển sang trang chi tiết, nhưng chuyển sang chế độ edit thông qua tham số -->
                                                    <a href="${pageContext.request.contextPath}/ProductForManagerDetailController?productId=${product.productId}&mode=edit" class="btn btn-warning btn-sm">Sửa</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty productList}">
                                            <tr>
                                                <td colspan="6" class="text-center">Không có sản phẩm nào</td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- Phân trang: Ví dụ hiển thị nút Previous & Next -->
                    <div class="row">
                        <div class="col">
                            <nav aria-label="Page navigation example">
                                <ul class="pagination">
                                    <c:set var="currentPage" value="${param.page != null ? param.page : 1}" />
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/ProductForManagerListController?page=${currentPage-1}&search=${param.search}&sortField=${param.sortField}&sortDir=${param.sortDir}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo; Previous</span>
                                        </a>
                                    </li>

                                    <!-- Hiển thị hiện tại trang -->
                                    <li class="page-item active">
                                        <a class="page-link" href="#">Trang ${currentPage}</a>
                                    </li>

                                    <li class="page-item">
                                        <a class="page-link" href="${pageContext.request.contextPath}/ProductForManagerListController?page=${currentPage+1}&search=${param.search}&sortField=${param.sortField}&sortDir=${param.sortDir}" aria-label="Next">
                                            <span aria-hidden="true">Next &raquo;</span>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Bootstrap JS Bundle CDN (bao gồm Popper) -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
