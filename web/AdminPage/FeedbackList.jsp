<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en" style="height: 100%;">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Feedback Management</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            /* Cài đặt font chữ */
            body {
                font-family: 'Poppins', sans-serif;
                background-color: #f4f6f9;
            }
            .container-fluid {
                padding: 20px;
            }

            /* Tối ưu bảng */
            .table {
                background-color: #fff;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
                overflow: hidden;
            }

            .table th,
            .table td {
                padding: 15px;
                text-align: center;
                border-color: #ddd;
            }

            
            /* Tối ưu màu cho các trạng thái */
            .status-active {
                background-color: #28a745;
                color: white;
                padding: 5px 10px;
                border-radius: 20px;
            }

            .status-inactive {
                background-color: #dc3545;
                color: white;
                padding: 5px 10px;
                border-radius: 20px;
            }

            /* Nút và biểu tượng */
            .btn-custom {
                font-size: 16px;
                font-weight: 500;
                border-radius: 5px;
            }

            /* Modal */
            .modal-content {
                background-color: #ffffff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            }

            /* Bộ lọc */
            .filter-section {
                background-color: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .filter-section label {
                font-weight: 500;
            }

            .pagination .page-link {
                background-color: #fff;
                color: #007bff;
                border: 1px solid #ddd;
                padding: 8px 12px;
            }

            .pagination .page-item.active .page-link {
                background-color: #007bff;
                color: white;
                border-color: #007bff;
            }

            .pagination .page-link:hover {
                background-color: #e9ecef;
            }

            /* Các nút */
            .btn-custom {
                font-weight: bold;
                color: white;
                background-color: #007bff;
                border-radius: 5px;
                padding: 10px 15px;
            }

            .btn-custom:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body class="bg-light" style="height: 100%;">
        <div class="row" style="height: 95%;">
            <!-- Sidebar -->
            <jsp:include page="dashboard-sidebar.jsp"/>

            <div class="content-container col-10">
                <!-- Header -->
                <div class="dashboard-header">
                    <jsp:include page="dashboard-header.jsp"/>
                </div>



                <div class="container-fluid py-4">
                    <div class="row justify-content-center">
                        <div class="col-lg-11">
                            <!-- Tiêu đề với icon và kiểu dáng đẹp hơn -->
                            <div class="section-header d-flex align-items-center mb-4">
                                <i class="fas fa-comment-dots fa-2x me-3 text-primary"></i>
                                <h2 class="m-0">Quản Lý Phản Hồi</h2>
                            </div>


                            <c:if test="${param.statusChanged eq 'true'}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <i class="fas fa-check-circle me-2"></i> Feedback status updated successfully!
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            </c:if>

                            <!-- Filters Section -->
                            <div class="filter-section">
                                <form id="filterForm" action="${pageContext.request.contextPath}/FeedbackList" method="GET" class="row g-3">
                                    <div class="col-md-3">
                                        <label for="search" class="form-label"><i class="fas fa-search me-2"></i>Search:</label>
                                        <input type="text" class="form-control" id="search" name="search" 
                                               placeholder="Search by name or content" value="${searchKeyword}">
                                    </div>
                                    <div class="col-md-3">
                                        <label for="productId" class="form-label"><i class="fas fa-box me-2"></i>Product:</label>
                                        <select class="form-select" id="productId" name="productId">
                                            <option value="">All Products</option>
                                            <c:forEach items="${productList}" var="product">
                                                <option value="${product.productId}" ${product.productId eq selectedProductId ? 'selected' : ''}>
                                                    ${product.productName}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <label for="rating" class="form-label"><i class="fas fa-star me-2"></i>Rating:</label>
                                        <select class="form-select" id="rating" name="rating">
                                            <option value="">All Ratings</option>
                                            <option value="5" ${selectedRating eq 5 ? 'selected' : ''}>5 Stars</option>
                                            <option value="4" ${selectedRating eq 4 ? 'selected' : ''}>4 Stars</option>
                                            <option value="3" ${selectedRating eq 3 ? 'selected' : ''}>3 Stars</option>
                                            <option value="2" ${selectedRating eq 2 ? 'selected' : ''}>2 Stars</option>
                                            <option value="1" ${selectedRating eq 1 ? 'selected' : ''}>1 Star</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <label for="status" class="form-label"><i class="fas fa-toggle-on me-2"></i>Status:</label>
                                        <select class="form-select" id="status" name="status">
                                            <option value="">All Status</option>
                                            <option value="true" ${selectedStatus eq true ? 'selected' : ''}>Active</option>
                                            <option value="false" ${selectedStatus eq false ? 'selected' : ''}>Inactive</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2 d-flex align-items-end">
                                        <button type="submit" class="btn btn-primary me-2"><i class="fas fa-filter me-2"></i>Filter</button>
                                        <a href="${pageContext.request.contextPath}FeedbackList" class="btn btn-secondary"><i class="fas fa-undo me-2"></i>Reset</a>
                                    </div>
                                </form>
                            </div>

                            <!-- Feedback List Table -->
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>#</th>
                                            <th>
                                                <a href="${pageContext.request.contextPath}/FeedbackList?sortBy=fullName&sortOrder=${sortBy eq 'fullName' && sortOrder eq 'asc' ? 'desc' : 'asc'}&search=${searchKeyword}&productId=${selectedProductId}&rating=${selectedRating}&status=${selectedStatus}" class="text-decoration-none text-blue">
                                                    <i class="fas fa-user me-1"></i> Customer Name
                                                    <span class="sort-icon">
                                                        <c:choose>
                                                            <c:when test="${sortBy eq 'fullName' && sortOrder eq 'asc'}">
                                                                <i class="fas fa-sort-up"></i>
                                                            </c:when>
                                                            <c:when test="${sortBy eq 'fullName' && sortOrder eq 'desc'}">
                                                                <i class="fas fa-sort-down"></i>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <i class="fas fa-sort"></i>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </a>
                                            </th>
                                            <th>
                                                <a href="${pageContext.request.contextPath}/FeedbackList?sortBy=productName&sortOrder=${sortBy eq 'productName' && sortOrder eq 'asc' ? 'desc' : 'asc'}&search=${searchKeyword}&productId=${selectedProductId}&rating=${selectedRating}&status=${selectedStatus}" class="text-decoration-none text-blue">
                                                    <i class="fas fa-box me-1"></i> Product
                                                    <span class="sort-icon">
                                                        <c:choose>
                                                            <c:when test="${sortBy eq 'productName' && sortOrder eq 'asc'}">
                                                                <i class="fas fa-sort-up"></i>
                                                            </c:when>
                                                            <c:when test="${sortBy eq 'productName' && sortOrder eq 'desc'}">
                                                                <i class="fas fa-sort-down"></i>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <i class="fas fa-sort"></i>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </a>
                                            </th>
                                            <th>
                                                <a href="${pageContext.request.contextPath}/FeedbackList?sortBy=rating&sortOrder=${sortBy eq 'rating' && sortOrder eq 'asc' ? 'desc' : 'asc'}&search=${searchKeyword}&productId=${selectedProductId}&rating=${selectedRating}&status=${selectedStatus}" class="text-decoration-none text-blue">
                                                    <i class="fas fa-star me-1"></i> Rating
                                                    <span class="sort-icon">
                                                        <c:choose>
                                                            <c:when test="${sortBy eq 'rating' && sortOrder eq 'asc'}">
                                                                <i class="fas fa-sort-up"></i>
                                                            </c:when>
                                                            <c:when test="${sortBy eq 'rating' && sortOrder eq 'desc'}">
                                                                <i class="fas fa-sort-down"></i>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <i class="fas fa-sort"></i>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </a>
                                            </th>
                                            <th><i class="fas fa-comment me-1"></i> Comment</th>
                                            <th><i class="fas fa-calendar me-1"></i> Date</th>
                                            <th>
                                                <a href="${pageContext.request.contextPath}/FeedbackList?sortBy=status&sortOrder=${sortBy eq 'status' && sortOrder eq 'asc' ? 'desc' : 'asc'}&search=${searchKeyword}&productId=${selectedProductId}&rating=${selectedRating}&status=${selectedStatus}" class="text-decoration-none text-blue">
                                                    <i class="fas fa-toggle-on me-1"></i> Status
                                                    <span class="sort-icon">
                                                        <c:choose>
                                                            <c:when test="${sortBy eq 'status' && sortOrder eq 'asc'}">
                                                                <i class="fas fa-sort-up"></i>
                                                            </c:when>
                                                            <c:when test="${sortBy eq 'status' && sortOrder eq 'desc'}">
                                                                <i class="fas fa-sort-down"></i>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <i class="fas fa-sort"></i>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </a>
                                            </th>
                                            <th><i class="fas fa-cog me-1"></i> Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${empty feedbackList}">
                                                <tr>
                                                    <td colspan="8" class="text-center py-4">
                                                        <i class="fas fa-search fa-3x text-muted mb-3"></i>
                                                        <p class="lead">No feedback found</p>
                                                    </td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach items="${feedbackList}" var="feedback" varStatus="status">
                                                    <tr>
                                                        <td>${(currentPage - 1) * 10 + status.index + 1}</td>
                                                        <td>${feedback.userFullName}</td>
                                                        <td>${feedback.productName}</td>
                                                        <td>
                                                            <div class="rating">
                                                                <c:forEach begin="1" end="${feedback.rating}">
                                                                    <i class="fas fa-star text-warning"></i>
                                                                </c:forEach>
                                                                <c:forEach begin="${feedback.rating + 1}" end="5">
                                                                    <i class="far fa-star text-warning"></i>
                                                                </c:forEach>
                                                            </div>
                                                        </td>
                                                        <td class="feedback-comment">${feedback.comment}</td>
                                                        <td><fmt:formatDate value="${feedback.createdAt}" pattern="MM/dd/yyyy HH:mm" /></td>
                                                        <td>
                                                            <span class="badge ${feedback.status ? 'bg-success' : 'bg-danger'} status-badge">
                                                                ${feedback.status ? 'Active' : 'Inactive'}
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <a href="${pageContext.request.contextPath}/admin/feedback?action=view&id=${feedback.reviewId}" 
                                                               class="btn btn-sm btn-info me-1" data-bs-toggle="tooltip" title="View Details">
                                                                <i class="fas fa-eye"></i>
                                                            </a>
                                                            <a href="${pageContext.request.contextPath}/FeedbackList?action=changeStatus&id=${feedback.reviewId}&status=${!feedback.status}&page=${currentPage}" 
                                                               class="btn btn-sm ${feedback.status ? 'btn-danger' : 'btn-success'}" 
                                                               onclick="return confirm('Are you sure you want to ${feedback.status ? 'deactivate' : 'activate'} this feedback?')"
                                                               data-bs-toggle="tooltip" title="${feedback.status ? 'Deactivate' : 'Activate'}">
                                                                <i class="fas ${feedback.status ? 'fa-ban' : 'fa-check'}"></i>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Pagination -->
                            <c:if test="${totalPages > 1}">
                                <nav aria-label="Page navigation">
                                    <ul class="pagination justify-content-center">
                                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                            <a class="page-link" href="${pageContext.request.contextPath}/FeedbackList?page=${currentPage - 1}&search=${searchKeyword}&productId=${selectedProductId}&rating=${selectedRating}&status=${selectedStatus}&sortBy=${sortBy}&sortOrder=${sortOrder}">
                                                <i class="fas fa-chevron-left"></i> Previous
                                            </a>
                                        </li>

                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                <a class="page-link" href="${pageContext.request.contextPath}/FeedbackList?page=${i}&search=${searchKeyword}&productId=${selectedProductId}&rating=${selectedRating}&status=${selectedStatus}&sortBy=${sortBy}&sortOrder=${sortOrder}">
                                                    ${i}
                                                </a>
                                            </li>
                                        </c:forEach>

                                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                            <a class="page-link" href="${pageContext.request.contextPath}/FeedbackList?page=${currentPage + 1}&search=${searchKeyword}&productId=${selectedProductId}&rating=${selectedRating}&status=${selectedStatus}&sortBy=${sortBy}&sortOrder=${sortOrder}">
                                                Next <i class="fas fa-chevron-right"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
                                                    
        </div>
        <jsp:include page="dashboard-footer.jsp"/>
            <!-- Bootstrap JS Bundle with Popper -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                                                                   // Initialize tooltips
                                                                   var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
                                                                   var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                                                                       return new bootstrap.Tooltip(tooltipTriggerEl)
                                                                   });

                                                                   // Auto dismiss alerts after 5 seconds
                                                                   window.setTimeout(function () {
                                                                       $('.alert').fadeTo(500, 0).slideUp(500, function () {
                                                                           $(this).remove();
                                                                       });
                                                                   }, 5000);
            </script>
    </body>
</html>
