<%-- 
    Tài liệu   : PostList
    Tạo vào : Mar 25, 2025, 6:08:32 PM
    Tác giả     : Admin
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý Bài Viết</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            .featured-star {
                color: gold;
            }
            .status-badge {
                padding: 5px 10px;
                border-radius: 20px;
                font-size: 0.8rem;
            }
            .status-Published {
                background-color: #28a745;
                color: white;
            }
            .status-Draft {
                background-color: #ffc107;
                color: black;
            }
            .status-Archived {
                background-color: #6c757d;
                color: white;
            }
            .status-Featured {
                background-color: #007bff;
                color: white;
            }
            .table-thumbnail {
                width: 80px;
                height: 60px;
                object-fit: cover;
                border-radius: 4px;
            }
            .filter-section {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 5px;
                margin-bottom: 20px;
            }
            .action-buttons .btn {
                margin-right: 5px;
            }
            .sort-icon {
                font-size: 0.7rem;
                margin-left: 5px;
            }
            .pagination {
                justify-content: center;
            }
            .status-active {
                background-color: #28a745;
                color: white;
            }
            .status-inactive {
                background-color: #dc3545;
                color: white;
            }
            /* Custom styles for improved UI */
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f8;
            }
            .container-fluid {
                padding: 20px;
            }
            h2 {
                color: #333;
                margin-bottom: 20px;
                border-bottom: 2px solid #ddd;
                padding-bottom: 10px;
            }
            .filter-section {
                background-color: #fff;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .table-responsive {
                overflow-x: auto;
            }
            .table {
                background-color: #fff;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .table th,
            .table td {
                padding: 12px 15px;
                vertical-align: middle;
                border-color: #ddd;
            }
            .table thead th {
                background-color: #343a40;
                color: #fff;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }
            .table-striped tbody tr:nth-of-type(odd) {
                background-color: #f9f9f9;
            }
            .pagination .page-link {
                color: #007bff;
                background-color: #fff;
                border: 1px solid #ddd;
                margin: 0 2px;
            }
            .pagination .page-item.active .page-link {
                background-color: #007bff;
                color: #fff;
                border-color: #007bff;
            }
            .pagination .page-link:hover {
                background-color: #e9ecef;
            }
            .pagination .page-item.disabled .page-link {
                color: #6c757d;
                pointer-events: none;
                background-color: #fff;
            }
        </style>
    </head>
    <body>

        <div class="container-fluid mt-4">
            <div class="row">
                <!-- Sidebar -->

                <div class="col-md-12">
                    <h2>Quản lý Bài Viết</h2>

                    <!-- Thông Báo Thành Công/Lỗi -->
                    <c:if test="${not empty sessionScope.successMessage}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${sessionScope.successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <% session.removeAttribute("successMessage"); %>
                    </c:if>

                    <c:if test="${not empty sessionScope.errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${sessionScope.errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <% session.removeAttribute("errorMessage"); %>
                    </c:if>

                    <!-- Nút Điều Hướng Quản Trị -->
                    <div class="mb-3 d-flex gap-2">
                        <a href="${pageContext.request.contextPath}/PostDetailController?action=create" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Thêm Bài Viết Mới
                        </a>
                    </div>

                    <!-- Phần Bộ Lọc -->
                    <div class="filter-section">
                        <form action="${pageContext.request.contextPath}/PostListController" method="get" class="row g-3">
                            <div class="col-md-3">
                                <label for="categoryId" class="form-label">Danh Mục</label>
                                <select name="categoryId" id="categoryId" class="form-select">
                                    <option value="">Tất Cả Danh Mục</option>
                                    <c:forEach items="${categories}" var="category">
                                        <option value="${category.categoryId}" ${categoryId == category.categoryId ? 'selected' : ''}>
                                            ${category.categoryName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="col-md-3">
                                <label for="authorId" class="form-label">Tác Giả</label>
                                <select name="authorId" id="authorId" class="form-select">
                                    <option value="">Tất Cả Tác Giả</option>
                                    <c:forEach items="${authors}" var="author">
                                        <option value="${author.user_id}" ${authorId == author.user_id ? 'selected' : ''}>
                                            ${author.full_name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="col-md-3">
                                <label for="status" class="form-label">Trạng Thái</label>
                                <select name="status" id="status" class="form-select">
                                    <option value="">Tất Cả</option>
                                    <option value="True" ${status == 'true' ? 'selected' : ''}>Kích Hoạt</option>
                                    <option value="False" ${status == 'false' ? 'selected' : ''}>Vô Hiệu Hóa</option>
                                </select>
                            </div>

                            <div class="col-md-3">
                                <label for="searchTitle" class="form-label">Tìm Kiếm Theo Tiêu Đề</label>
                                <input type="text" class="form-control" id="searchTitle" name="searchTitle" value="${searchTitle}" placeholder="Nhập tiêu đề...">
                            </div>

                            <div class="col-12 mt-3">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-search"></i> Lọc
                                </button>
                                <a href="${pageContext.request.contextPath}/PostListController" class="btn btn-secondary">
                                    <i class="fas fa-redo"></i> Làm Mới
                                </a>
                            </div>
                        </form>
                    </div>
                    <!-- End of Filter Section -->
                </div>
            </div>
        </div>

    </body>
</html>


<!-- Bảng Bài Viết -->
<div class="table-responsive">
    <table class="table table-striped table-hover">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Ảnh Đại Diện</th>
                <c:if test="${columns == null or fn:contains(columns, 'title')}">
                    <th>
                        <a href="${pageContext.request.contextPath}/PostListController?sortBy=title&sortOrder=${sortBy == 'title' && sortOrder != 'desc' ? 'desc' : 'asc'}${not empty categoryId ? '&categoryId='.concat(categoryId) : ''}${not empty authorId ? '&authorId='.concat(authorId) : ''}${not empty status ? '&status='.concat(status) : ''}${not empty searchTitle ? '&searchTitle='.concat(searchTitle) : ''}">
                            Tiêu Đề
                            <c:if test="${sortBy == 'title'}">
                                <i class="fas fa-sort-${sortOrder == 'desc' ? 'down' : 'up'} sort-icon"></i>
                            </c:if>
                        </a>
                    </th>
                </c:if>
                <c:if test="${columns == null or fn:contains(columns, 'category')}">
                    <th>
                        <a href="${pageContext.request.contextPath}/PostListController?sortBy=category&sortOrder=${sortBy == 'category' && sortOrder != 'desc' ? 'desc' : 'asc'}${not empty categoryId ? '&categoryId='.concat(categoryId) : ''}${not empty authorId ? '&authorId='.concat(authorId) : ''}${not empty status ? '&status='.concat(status) : ''}${not empty searchTitle ? '&searchTitle='.concat(searchTitle) : ''}">
                            Danh Mục
                            <c:if test="${sortBy == 'category'}">
                                <i class="fas fa-sort-${sortOrder == 'desc' ? 'down' : 'up'} sort-icon"></i>
                            </c:if>
                        </a>
                    </th>
                </c:if>
                <c:if test="${columns == null or fn:contains(columns, 'author')}">
                    <th>
                        <a href="${pageContext.request.contextPath}/PostListController?sortBy=author&sortOrder=${sortBy == 'author' && sortOrder != 'desc' ? 'desc' : 'asc'}${not empty categoryId ? '&categoryId='.concat(categoryId) : ''}${not empty authorId ? '&authorId='.concat(authorId) : ''}${not empty status ? '&status='.concat(status) : ''}${not empty searchTitle ? '&searchTitle='.concat(searchTitle) : ''}">
                            Tác Giả
                            <c:if test="${sortBy == 'author'}">
                                <i class="fas fa-sort-${sortOrder == 'desc' ? 'down' : 'up'} sort-icon"></i>
                            </c:if>
                        </a>
                    </th>
                </c:if>
                <c:if test="${columns == null or fn:contains(columns, 'status')}">
                    <th>
                        <a href="${pageContext.request.contextPath}/PostListController?sortBy=status&sortOrder=${sortBy == 'status' && sortOrder != 'desc' ? 'desc' : 'asc'}${not empty categoryId ? '&categoryId='.concat(categoryId) : ''}${not empty authorId ? '&authorId='.concat(authorId) : ''}${not empty status ? '&status='.concat(status) : ''}${not empty searchTitle ? '&searchTitle='.concat(searchTitle) : ''}">
                            Trạng Thái
                            <c:if test="${sortBy == 'status'}">
                                <i class="fas fa-sort-${sortOrder == 'desc' ? 'down' : 'up'} sort-icon"></i>
                            </c:if>
                        </a>
                    </th>
                </c:if>
                <th>Ngày Tạo</th>
                <th>Hành Động</th>
            </tr>
        </thead>
        <tbody>
            <c:if test="${empty posts}">
                <tr>
                    <td colspan="9" class="text-center">Không có bài viết nào</td>
                </tr>
            </c:if>
            <c:forEach items="${posts}" var="post">
                <tr>
                    <td>${post.postId}</td>
                    <td>
                        <c:if test="${not empty post.thumbnailUrl}">
                            <img src="${pageContext.request.contextPath}/${post.thumbnailUrl}" 
                                 alt="Ảnh Đại Diện" class="table-thumbnail">
                        </c:if>
                        <c:if test="${empty post.thumbnailUrl}">
                            <span class="text-muted">Không có hình ảnh</span>
                        </c:if>
                    </td>
                    <c:if test="${columns == null or fn:contains(columns, 'title')}">
                        <td>${post.title}</td>
                    </c:if>
                    <c:if test="${columns == null or fn:contains(columns, 'category')}">
                        <td>${post.categoryName}</td>
                    </c:if>
                    <c:if test="${columns == null or fn:contains(columns, 'author')}">
                        <td>${post.authorName}</td>
                    </c:if>
                    <c:if test="${columns == null or fn:contains(columns, 'status')}">
                        <td>
                            <span class="status-badge ${post.status ? 'status-active' : 'status-inactive'}">
                                ${post.status ? 'Kích Hoạt' : 'Vô Hiệu Hóa'}
                            </span>
                        </td>
                    </c:if>
                    <td><fmt:formatDate value="${post.createdAt}" pattern="dd-MM-yyyy HH:mm" /></td>
                    <td class="action-buttons">
                        <!-- Xem bài viết -->
                        <a href="${pageContext.request.contextPath}/PostDetailController?action=view&id=${post.postId}" 
                           class="btn btn-sm btn-info" title="Xem">
                            <i class="fas fa-eye"></i>
                        </a>

                        <!-- Chỉnh sửa bài viết -->
                        <a href="${pageContext.request.contextPath}/PostDetailController?action=edit&id=${post.postId}"
                           class="btn btn-sm btn-warning" title="Chỉnh sửa">
                            <i class="fas fa-edit"></i>
                        </a>

                        <!-- Thay đổi trạng thái -->
                        <form action="${pageContext.request.contextPath}/PostListController" method="post" style="display: inline;">
                            <input type="hidden" name="action" value="updateStatus">
                            <input type="hidden" name="postId" value="${post.postId}">
                            <input type="hidden" name="status" value="${!post.status}">
                            <button type="submit" class="btn btn-sm ${post.status ? 'btn-danger' : 'btn-success'}" 
                                    title="${post.status ? 'Vô Hiệu Hóa' : 'Kích Hoạt'}">
                                <i class="fas ${post.status ? 'fa-times' : 'fa-check'}"></i>
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<!-- Phân trang -->
<c:if test="${totalPages > 1}">
    <nav aria-label="Page navigation">
        <div class="row align-items-center">
            <div class="col-md-12">
                <ul class="pagination">
                    <!-- Nút Previous -->
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/PostListController?page=${currentPage - 1}${not empty sortBy ? '&sortBy='.concat(sortBy) : ''}${not empty sortOrder ? '&sortOrder='.concat(sortOrder) : ''}${not empty categoryId ? '&categoryId='.concat(categoryId) : ''}${not empty authorId ? '&authorId='.concat(authorId) : ''}${not empty status ? '&status='.concat(status) : ''}${not empty searchTitle ? '&searchTitle='.concat(searchTitle) : ''}">
                            <i class="fas fa-chevron-left"></i>
                        </a>
                    </li>

                    <!-- Trang đầu -->
                    <li class="page-item ${currentPage == 1 ? 'active' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/PostListController?page=1${not empty sortBy ? '&sortBy='.concat(sortBy) : ''}${not empty sortOrder ? '&sortOrder='.concat(sortOrder) : ''}${not empty categoryId ? '&categoryId='.concat(categoryId) : ''}${not empty authorId ? '&authorId='.concat(authorId) : ''}${not empty status ? '&status='.concat(status) : ''}${not empty searchTitle ? '&searchTitle='.concat(searchTitle) : ''}">
                            1
                        </a>
                    </li>

                    <!-- Chấm lửng trái -->
                    <c:if test="${currentPage > 4}">
                        <li class="page-item disabled">
                            <span class="page-link">...</span>
                        </li>
                    </c:if>

                    <!-- Các trang xung quanh trang hiện tại -->
                    <c:forEach begin="${Math.max(2, currentPage - 1)}" end="${Math.min(totalPages - 1, currentPage + 1)}" var="i">
                        <c:if test="${i > 1 && i < totalPages}">
                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/PostListController?page=${i}${not empty sortBy ? '&sortBy='.concat(sortBy) : ''}${not empty sortOrder ? '&sortOrder='.concat(sortOrder) : ''}${not empty categoryId ? '&categoryId='.concat(categoryId) : ''}${not empty authorId ? '&authorId='.concat(authorId) : ''}${not empty status ? '&status='.concat(status) : ''}${not empty searchTitle ? '&searchTitle='.concat(searchTitle) : ''}">
                                    ${i}
                                </a>
                            </li>
                        </c:if>
                    </c:forEach>

                    <!-- Chấm lửng phải -->
                    <c:if test="${currentPage < totalPages - 3}">
                        <li class="page-item disabled">
                            <span class="page-link">...</span>
                        </li>
                    </c:if>

                    <!-- Trang cuối -->
                    <c:if test="${totalPages > 1}">
                        <li class="page-item ${currentPage == totalPages ? 'active' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/PostListController?page=${totalPages}${not empty sortBy ? '&sortBy='.concat(sortBy) : ''}${not empty sortOrder ? '&sortOrder='.concat(sortOrder) : ''}${not empty categoryId ? '&categoryId='.concat(categoryId) : ''}${not empty authorId ? '&authorId='.concat(authorId) : ''}${not empty status ? '&status='.concat(status) : ''}${not empty searchTitle ? '&searchTitle='.concat(searchTitle) : ''}">
                                ${totalPages}
                            </a>
                        </li>
                    </c:if>

                    <!-- Nút Next -->
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/PostListController?page=${currentPage + 1}${not empty sortBy ? '&sortBy='.concat(sortBy) : ''}${not empty sortOrder ? '&sortOrder='.concat(sortOrder) : ''}${not empty categoryId ? '&categoryId='.concat(categoryId) : ''}${not empty authorId ? '&authorId='.concat(authorId) : ''}${not empty status ? '&status='.concat(status) : ''}${not empty searchTitle ? '&searchTitle='.concat(searchTitle) : ''}">
                            <i class="fas fa-chevron-right"></i>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</c:if>

<!-- Nút để mở Popup -->
<button onclick="openPopup()">Tùy Chỉnh Bảng</button>

<!-- Overlay Popup -->
<div id="popupOverlay" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%;
     background-color: rgba(0,0,0,0.5); z-index:9999;">

    <!-- Popup Box -->
    <div style="background:white; width:400px; padding:20px; margin:100px auto; border-radius:8px;">
        <h3>Tùy Chỉnh Bảng</h3>

        <form action="customizetablecontroller" method="post">
            <label>Số Dòng Mỗi Bảng:</label><br>
            <input type="number" name="rowsPerPage" value="${sessionScope.rowsPerPage}" min="1"/><br><br>

            <label>Chọn Cột:</label><br>
            <input type="checkbox" name="columns" value="title"
                   <c:if test="${sessionScope.columns.contains('title')}">checked</c:if>> Tiêu Đề<br>
            <input type="checkbox" name="columns" value="category"
                   <c:if test="${sessionScope.columns.contains('category')}">checked</c:if>> Danh Mục<br>
            <input type="checkbox" name="columns" value="author"
                   <c:if test="${sessionScope.columns.contains('author')}">checked</c:if>> Tác Giả<br>
            <input type="checkbox" name="columns" value="status"
                   <c:if test="${sessionScope.columns.contains('status')}">checked</c:if>> Trạng Thái<br><br>

            <button type="submit">Áp Dụng Cài Đặt</button>
            <button type="button" onclick="closePopup()">Hủy</button>
        </form>
    </div>
</div>

<script>
    function openPopup() {
        document.getElementById("popupOverlay").style.display = "block";
    }

    function closePopup() {
        document.getElementById("popupOverlay").style.display = "none";
    }
</script>

<!-- Bootstrap JS with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

