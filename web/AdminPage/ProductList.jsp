<%-- 
    Document   : ProductList
    Created on : Apr 16, 2025, 1:36:53 PM
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Danh sách Sản phẩm Product</title>
        <!-- Bootstrap CSS CDN (phiên bản 5) -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <!-- CSS Tùy chỉnh -->
        <style>
            /* Sidebar Fixed to the left */
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
    <body>
        <!-- Sidebar -->
        <div class="sidebar">
            <jsp:include page="dashboard-sidebar.jsp" />
        </div>

        <!-- Content -->
        <div class="content-container">
            <!-- Header -->
            <div class="dashboard-header">
                <jsp:include page="dashboard-header.jsp" />
            </div>

            <div class="container bg-white p-4 rounded shadow">
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
                        <form action="${pageContext.request.contextPath}/ProductForManagerListController" method="get">
                            <div class="row mb-4">
                                <!-- Bộ lọc -->
                                <div class="col-md-8">
                                    <div class="card border-primary mb-0">
                                        <div class="card-header bg-primary text-white">Bộ lọc</div>
                                        <div class="card-body">
                                            <div class="row g-2">
                                                <div class="col-md-4">
                                                    <input type="text" name="search" class="form-control" placeholder="Tìm kiếm..." value="${param.search}">
                                                </div>
                                                <div class="col-md-4">
                                                    <select name="brand" class="form-select">
                                                        <option value="">Tất cả thương hiệu</option>
                                                        <c:forEach var="b" items="${brand}">
                                                            <option value="${b}" ${param.brand==b?'selected':''}>${b}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <div class="col-md-4">
                                                    <select name="category" class="form-select">
                                                        <option value="">Tất cả danh mục</option>
                                                        <c:forEach var="c" items="${category}">
                                                            <option value="${c}" ${param.category==c?'selected':''}>${c}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Sắp xếp -->
                                <div class="col-md-4">
                                    <div class="card border-secondary mb-0">
                                        <div class="card-header bg-secondary text-white">Sắp xếp</div>
                                        <div class="card-body">
                                            <div class="row g-2">
                                                <div class="col-md-6">
                                                    <select name="sortField" class="form-select">
                                                        <option value="p.product_id" ${param.sortField=='p.product_id'?'selected':''}>ID</option>
                                                        <option value="p.product_name" ${param.sortField=='p.product_name'?'selected':''}>Tên</option>
                                                        <option value="b.brand_name" ${param.sortField=='b.brand_name'?'selected':''}>Thương hiệu</option>
                                                        <option value="c.category_name" ${param.sortField=='c.category_name'?'selected':''}>Danh mục</option>
                                                        <option value="totalStockQuantity" ${param.sortField=='totalStockQuantity'?'selected':''}>Tồn kho</option>
                                                    </select>
                                                </div>
                                                <div class="col-md-6">
                                                    <select name="sortDir" class="form-select">
                                                        <option value="ASC" ${param.sortDir=='ASC'?'selected':''}>Tăng dần</option>
                                                        <option value="DESC" ${param.sortDir=='DESC'?'selected':''}>Giảm dần</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="text-end mb-4">
                                <button type="submit" class="btn btn-primary">Áp dụng</button>
                                <a href="${pageContext.request.contextPath}/ProductForManagerListController"
                                   class="btn btn-secondary ms-2">Đặt lại</a>
                            </div>
                        </form>


                        <!-- Bảng hiển thị dữ liệu -->
                        <div class="row">
                            <div class="col-md-12">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover align-middle">
                                        <thead class="table-dark">
                                            <tr>
                                                <th><c:url var="urlIdSort" value="ProductForManagerListController">
                                                        <c:param name="search"    value="${param.search}" />
                                                        <c:param name="brand"     value="${param.brand}" />
                                                        <c:param name="category"  value="${param.category}" />
                                                        <c:param name="page"      value="${param.page}" />
                                                        <c:param name="sortField" value="p.product_id" />
                                                        <c:param name="sortDir"
                                                                 value="${param.sortField=='p.product_id' && param.sortDir=='ASC' ? 'DESC' : 'ASC'}" />
                                                    </c:url>
                                                    <a href="${urlIdSort}">
                                                        ID
                                                        <c:if test="${param.sortField=='p.product_id'}">
                                                            <i class="fas fa-sort-${param.sortDir=='ASC'?'up':'down'} fa-sm text-white ms-1"></i>
                                                    </c:if></th>
                                                <th><c:url var="urlNameSort" value="ProductForManagerListController">
                                                        <c:param name="search"    value="${param.search}" />
                                                        <c:param name="brand"     value="${param.brand}" />
                                                        <c:param name="category"  value="${param.category}" />
                                                        <c:param name="page"      value="${param.page}" />
                                                        <c:param name="sortField" value="p.product_name" />
                                                        <c:param name="sortDir"
                                                                 value="${param.sortField=='p.product_name' && param.sortDir=='ASC' ? 'DESC' : 'ASC'}" />
                                                    </c:url>
                                                    <a href="${urlNameSort}">
                                                        Tên sản phẩm
                                                        <c:if test="${param.sortField=='p.product_name'}">
                                                            <i class="fas fa-sort-${param.sortDir=='ASC'?'up':'down'} fa-sm text-white ms-1"></i>
                                                        </c:if>
                                                    </a></th>
                                                <th><c:url var="urlBrandSort" value="ProductForManagerListController">
                                                        <c:param name="search"    value="${param.search}" />
                                                        <c:param name="brand"     value="${param.brand}" />
                                                        <c:param name="category"  value="${param.category}" />
                                                        <c:param name="page"      value="${param.page}" />
                                                        <c:param name="sortField" value="b.brand_name" />
                                                        <c:param name="sortDir"
                                                                 value="${param.sortField=='b.brand_name' && param.sortDir=='ASC' ? 'DESC' : 'ASC'}" />
                                                    </c:url>
                                                    <a href="${urlBrandSort}">
                                                        Thương hiệu
                                                        <c:if test="${param.sortField=='b.brand_name'}">
                                                            <i class="fas fa-sort-${param.sortDir=='ASC'?'up':'down'} fa-sm text-white ms-1"></i>
                                                        </c:if>
                                                    </a></th>
                                                <th><c:url var="urlCatSort" value="ProductForManagerListController">
                                                        <c:param name="search"    value="${param.search}" />
                                                        <c:param name="brand"     value="${param.brand}" />
                                                        <c:param name="category"  value="${param.category}" />
                                                        <c:param name="page"      value="${param.page}" />
                                                        <c:param name="sortField" value="c.category_name" />
                                                        <c:param name="sortDir"
                                                                 value="${param.sortField=='c.category_name' && param.sortDir=='ASC' ? 'DESC' : 'ASC'}" />
                                                    </c:url>
                                                    <a href="${urlCatSort}">
                                                        Danh mục
                                                        <c:if test="${param.sortField=='c.category_name'}">
                                                            <i class="fas fa-sort-${param.sortDir=='ASC'?'up':'down'} fa-sm text-white ms-1"></i>
                                                        </c:if>
                                                    </a></th>
                                                <th><c:url var="urlStockSort" value="ProductForManagerListController">
                                                        <c:param name="search"    value="${param.search}" />
                                                        <c:param name="brand"     value="${param.brand}" />
                                                        <c:param name="category"  value="${param.category}" />
                                                        <c:param name="page"      value="${param.page}" />
                                                        <c:param name="sortField" value="totalStockQuantity" />
                                                        <c:param name="sortDir"
                                                                 value="${param.sortField=='totalStockQuantity' && param.sortDir=='ASC' ? 'DESC' : 'ASC'}" />
                                                    </c:url>
                                                    <a href="${urlStockSort}">
                                                        Tồn kho
                                                        <c:if test="${param.sortField=='totalStockQuantity'}">
                                                            <i class="fas fa-sort-${param.sortDir=='ASC'?'up':'down'} fa-sm text-white ms-1"></i>
                                                        </c:if>
                                                    </a></th>
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
                                                        <a href="${pageContext.request.contextPath}/ProductForManagerDetailController?productId=${product.productId}&mode=view" class="btn btn-info btn-sm"><i class="fas fa-eye"></i></a>

                                                        <!-- Edit: Chuyển sang trang chi tiết, nhưng chuyển sang chế độ edit thông qua tham số -->
                                                        <a href="${pageContext.request.contextPath}/ProductForManagerDetailController?productId=${product.productId}&mode=edit" class="btn btn-warning btn-sm"><i class="fas fa-edit"></i></a>
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
            </div>
        </div>

        <!-- Bootstrap JS Bundle CDN (bao gồm Popper) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
