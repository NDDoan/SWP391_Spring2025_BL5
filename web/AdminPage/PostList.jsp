<%--
    Document   : PostList
    Created on : Mar 25, 2025, 6:08:32 PM
    Author     : Admin
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Post Management</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #f4f4f8; font-family: Arial, sans-serif; }
        .sidebar { background: #343a40; min-height: 100vh; }
        .sidebar .nav-link { color: #ddd; }
        .sidebar .nav-link.active { color: #fff; background: #495057; }
        .header { background: #fff; padding: 15px; border-bottom: 1px solid #dee2e6; }
        .card { border-radius: 0.75rem; box-shadow: 0 0.5rem 1rem rgba(0,0,0,0.1); }
        .table-responsive { margin-top: 1rem; }
        .table th, .table td { vertical-align: middle; }
        .status-badge { padding: 0.25rem 0.75rem; border-radius: 1rem; font-size: 0.85rem; }
        .status-active { background-color: #28a745; color: white; }
        .status-inactive { background-color: #dc3545; color: white; }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <nav class="col-md-2 sidebar d-none d-md-block">
            <jsp:include page="dashboard-sidebar.jsp"/>
        </nav>
        <!-- Main Content -->
        <div class="col-md-10">
            <!-- Header -->
            <div class="header d-flex justify-content-between align-items-center">
                <h3>Post Management</h3>
                <div>
                    <a href="${pageContext.request.contextPath}/PostDetailController?action=create" class="btn btn-primary me-2">
                        <i class="fas fa-plus"></i> Add New
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/customers" class="btn btn-success me-2">
                        <i class="fas fa-users"></i>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/feedbacks" class="btn btn-info">
                        <i class="fas fa-comments"></i>
                    </a>
                </div>
            </div>

            <!-- Alerts -->
            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success alert-dismissible fade show mt-3" role="alert">
                    ${sessionScope.successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <% session.removeAttribute("successMessage"); %>
            </c:if>
            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show mt-3" role="alert">
                    ${sessionScope.errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <% session.removeAttribute("errorMessage"); %>
            </c:if>

            <!-- Filter Card -->
            <div class="card mt-4">
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/PostListController" method="get" class="row g-3">
                        <div class="col-sm-6 col-lg-3">
                            <label for="categoryId" class="form-label">Category</label>
                            <select id="categoryId" name="categoryId" class="form-select">
                                <option value="">All</option>
                                <c:forEach var="category" items="${categories}">
                                    <option value="${category.categoryId}" ${categoryId == category.categoryId ? 'selected' : ''}>
                                        ${category.categoryName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-sm-6 col-lg-3">
                            <label for="authorId" class="form-label">Author</label>
                            <select id="authorId" name="authorId" class="form-select">
                                <option value="">All</option>
                                <c:forEach var="author" items="${authors}">
                                    <option value="${author.user_id}" ${authorId == author.user_id ? 'selected' : ''}>
                                        ${author.full_name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-sm-6 col-lg-3">
                            <label for="status" class="form-label">Status</label>
                            <select id="status" name="status" class="form-select">
                                <option value="">All</option>
                                <option value="True" ${status == 'true' ? 'selected' : ''}>Active</option>
                                <option value="False" ${status == 'false' ? 'selected' : ''}>Inactive</option>
                            </select>
                        </div>
                        <div class="col-sm-6 col-lg-3">
                            <label for="searchTitle" class="form-label">Title</label>
                            <input id="searchTitle" name="searchTitle" type="text" class="form-control" value="${searchTitle}" placeholder="Search...">
                        </div>
                        <div class="col-12 text-end">
                            <button type="submit" class="btn btn-primary me-2">
                                <i class="fas fa-search"></i> Filter
                            </button>
                            <a href="${pageContext.request.contextPath}/PostListController" class="btn btn-secondary">
                                <i class="fas fa-redo"></i> Reset
                            </a>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Table Card -->
            <div class="card">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Thumbnail</th>
                                <th>
                                    <a href="?sortBy=title&sortOrder=${sortBy=='title'&&sortOrder!='desc'?'desc':'asc'}">Title
                                        <c:if test="${sortBy=='title'}">
                                            <i class="fas fa-sort-${sortOrder=='desc'?'down':'up'}"></i>
                                        </c:if>
                                    </a>
                                </th>
                                <th>Category</th>
                                <th>Author</th>
                                <th>Status</th>
                                <th>Created</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty posts}">
                                <tr><td colspan="8" class="text-center py-4">No posts found.</td></tr>
                            </c:if>
                            <c:forEach var="post" items="${posts}">
                                <tr>
                                    <td>${post.postId}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty post.thumbnailUrl}">
                                                <img src="${pageContext.request.contextPath}/${post.thumbnailUrl}" alt="Thumb" class="img-fluid rounded-2" style="max-width:80px;">
                                            </c:when>
                                            <c:otherwise><span class="text-muted">No image</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${post.title}</td>
                                    <td>${post.categoryName}</td>
                                    <td>${post.authorName}</td>
                                    <td>
                                        <span class="status-badge ${post.status ? 'status-active':'status-inactive'}">
                                            ${post.status ? 'Active':'Inactive'}
                                        </span>
                                    </td>
                                    <td><fmt:formatDate value="${post.createdAt}" pattern="dd-MM-yyyy HH:mm"/></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/PostDetailController?action=view&id=${post.postId}" class="btn btn-sm btn-info me-1"><i class="fas fa-eye"></i></a>
                                        <a href="${pageContext.request.contextPath}/PostDetailController?action=edit&id=${post.postId}" class="btn btn-sm btn-warning me-1"><i class="fas fa-edit"></i></a>
                                        <form action="${pageContext.request.contextPath}/PostListController" method="post" class="d-inline">
                                            <input type="hidden" name="action" value="updateStatus">
                                            <input type="hidden" name="postId" value="${post.postId}">
                                            <input type="hidden" name="status" value="${!post.status}">
                                            <button type="submit" class="btn btn-sm ${post.status? "btn-danger":"btn-success"}" title="${post.status? "Deactivate":"Activate"}"><i class="fas ${post.status? "fa-times":"fa-check"}"></i></button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <!-- Pagination -->
                <c:if test="${totalPages>1}">
                    <nav class="p-3">
                        <ul class="pagination justify-content-center mb-0">
                            <li class="page-item ${currentPage==1?'disabled':''}"><a class="page-link" href="?page=${currentPage-1}"><i class="fas fa-chevron-left"></i></a></li>
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${currentPage==i?'active':''}"><a class="page-link" href="?page=${i}">${i}</a></li>
                            </c:forEach>
                            <li class="page-item ${currentPage==totalPages?'disabled':''}"><a class="page-link" href="?page=${currentPage+1}"><i class="fas fa-chevron-right"></i></a></li>
                        </ul>
                    </nav>
                </c:if>
            </div>

            <!-- Customize Modal Trigger -->
            <div class="text-end mt-3">
                <button class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#customizeModal">
                    <i class="fas fa-cog"></i> Customize Table
                </button>
            </div>

            <!-- Customize Modal -->
            <div class="modal fade" id="customizeModal" tabindex="-1" aria-labelledby="customizeModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="customizeModalLabel">Customize Table</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <form action="customizetablecontroller" method="post">
                            <div class="modal-body">
                                <div class="mb-3">
                                    <label for="rowsPerPage" class="form-label">Rows per page</label>
                                    <input type="number" class="form-control" id="rowsPerPage" name="rowsPerPage" value="${sessionScope.rowsPerPage}" min="1">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Select Columns</label><br>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="checkbox" name="columns" value="title" id="colTitle" <c:if test="${sessionScope.columns.contains('title')}">checked</c:if>>
                                        <label class="form-check-label" for="colTitle">Title</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="checkbox" name="columns" value="category" id="colCategory" <c:if test="${sessionScope.columns.contains('category')}">checked</c:if>>
                                        <label class="form-check-label" for="colCategory">Category</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="checkbox" name="columns" value="author" id="colAuthor" <c:if test="${sessionScope.columns.contains('author')}">checked</c:if>>
                                        <label class="form-check-label" for="colAuthor">Author</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="checkbox" name="columns" value="status" id="colStatus" <c:if test="${sessionScope.columns.contains('status')}">checked</c:if>>
                                        <label class="form-check-label" for="colStatus">Status</label>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-primary">Apply</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Bootstrap Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản Lý Bài Viết</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #f4f4f8; font-family: Arial, sans-serif; }
        .sidebar { background: #343a40; min-height: 100vh; }
        .sidebar .nav-link { color: #ddd; }
        .sidebar .nav-link.active { color: #fff; background: #495057; }
        .header { background: #fff; padding: 15px; border-bottom: 1px solid #dee2e6; }
        .card { border-radius: 0.75rem; box-shadow: 0 0.5rem 1rem rgba(0,0,0,0.1); }
        .table-responsive { margin-top: 1rem; }
        .table th, .table td { vertical-align: middle; }
        .status-badge { padding: 0.25rem 0.75rem; border-radius: 1rem; font-size: 0.85rem; }
        .status-active { background-color: #28a745; color: white; }
        .status-inactive { background-color: #dc3545; color: white; }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <nav class="col-md-2 sidebar d-none d-md-block">
            <jsp:include page="dashboard-sidebar.jsp"/>
        </nav>
        <!-- Main Content -->
        <div class="col-md-10">
            <!-- Header -->
            <div class="header d-flex justify-content-between align-items-center">
                <h3>Quản Lý Bài Viết</h3>
                <div>
                    <a href="${pageContext.request.contextPath}/PostDetailController?action=create" class="btn btn-primary me-2">
                        <i class="fas fa-plus"></i> Thêm Mới
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/customers" class="btn btn-success me-2">
                        <i class="fas fa-users"></i>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/feedbacks" class="btn btn-info">
                        <i class="fas fa-comments"></i>
                    </a>
                </div>
            </div>

            <!-- Thông Báo -->
            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success alert-dismissible fade show mt-3" role="alert">
                    ${sessionScope.successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <% session.removeAttribute("successMessage"); %>
            </c:if>
            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show mt-3" role="alert">
                    ${sessionScope.errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <% session.removeAttribute("errorMessage"); %>
            </c:if>

            <!-- Bộ Lọc -->
            <div class="card mt-4">
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/PostListController" method="get" class="row g-3">
                        <div class="col-sm-6 col-lg-3">
                            <label for="categoryId" class="form-label">Danh mục</label>
                            <select id="categoryId" name="categoryId" class="form-select">
                                <option value="">Tất cả</option>
                                <c:forEach var="category" items="${categories}">
                                    <option value="${category.categoryId}" ${categoryId == category.categoryId ? 'selected' : ''}>
                                        ${category.categoryName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-sm-6 col-lg-3">
                            <label for="authorId" class="form-label">Tác giả</label>
                            <select id="authorId" name="authorId" class="form-select">
                                <option value="">Tất cả</option>
                                <c:forEach var="author" items="${authors}">
                                    <option value="${author.user_id}" ${authorId == author.user_id ? 'selected' : ''}>
                                        ${author.full_name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-sm-6 col-lg-3">
                            <label for="status" class="form-label">Trạng thái</label>
                            <select id="status" name="status" class="form-select">
                                <option value="">Tất cả</option>
                                <option value="True" ${status == 'true' ? 'selected' : ''}>Hoạt động</option>
                                <option value="False" ${status == 'false' ? 'selected' : ''}>Không hoạt động</option>
                            </select>
                        </div>
                        <div class="col-sm-6 col-lg-3">
                            <label for="searchTitle" class="form-label">Tiêu đề</label>
                            <input id="searchTitle" name="searchTitle" type="text" class="form-control" value="${searchTitle}" placeholder="Tìm kiếm...">
                        </div>
                        <div class="col-12 text-end">
                            <button type="submit" class="btn btn-primary me-2">
                                <i class="fas fa-search"></i> Lọc
                            </button>
                            <a href="${pageContext.request.contextPath}/PostListController" class="btn btn-secondary">
                                <i class="fas fa-redo"></i> Đặt lại
                            </a>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Bảng Danh Sách Bài Viết -->
            <div class="card">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Ảnh</th>
                                <th>
                                    <a href="?sortBy=title&sortOrder=${sortBy=='title'&&sortOrder!='desc'?'desc':'asc'}">Tiêu đề
                                        <c:if test="${sortBy=='title'}">
                                            <i class="fas fa-sort-${sortOrder=='desc'?'down':'up'}"></i>
                                        </c:if>
                                    </a>
                                </th>
                                <th>Danh mục</th>
                                <th>Tác giả</th>
                                <th>Trạng thái</th>
                                <th>Ngày tạo</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty posts}">
                                <tr><td colspan="8" class="text-center py-4">Không có bài viết nào.</td></tr>
                            </c:if>
                            <c:forEach var="post" items="${posts}">
                                <tr>
                                    <td>${post.postId}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty post.thumbnailUrl}">
                                                <img src="${pageContext.request.contextPath}/${post.thumbnailUrl}" alt="Thumb" class="img-fluid rounded-2" style="max-width:80px;">
                                            </c:when>
                                            <c:otherwise><span class="text-muted">Không có ảnh</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${post.title}</td>
                                    <td>${post.categoryName}</td>
                                    <td>${post.authorName}</td>
                                    <td>
                                        <span class="status-badge ${post.status ? 'status-active':'status-inactive'}">
                                            ${post.status ? 'Hoạt động':'Không hoạt động'}
                                        </span>
                                    </td>
                                    <td><fmt:formatDate value="${post.createdAt}" pattern="dd-MM-yyyy HH:mm"/></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/PostDetailController?action=view&id=${post.postId}" class="btn btn-sm btn-info me-1"><i class="fas fa-eye"></i></a>
                                        <a href="${pageContext.request.contextPath}/PostDetailController?action=edit&id=${post.postId}" class="btn btn-sm btn-warning me-1"><i class="fas fa-edit"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <!-- Phân trang -->
                <c:if test="${totalPages>1}">
                    <nav class="p-3">
                        <ul class="pagination justify-content-center mb-0">
                            <li class="page-item ${currentPage==1?'disabled':''}"><a class="page-link" href="?page=${currentPage-1}"><i class="fas fa-chevron-left"></i></a></li>
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${currentPage==i?'active':''}"><a class="page-link" href="?page=${i}">${i}</a></li>
                            </c:forEach>
                            <li class="page-item ${currentPage==totalPages?'disabled':''}"><a class="page-link" href="?page=${currentPage+1}"><i class="fas fa-chevron-right"></i></a></li>
                        </ul>
                    </nav>
                </c:if>
            </div>

        </div>
    </div>
</div>
<!-- Bootstrap Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
