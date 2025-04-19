<%-- 
    Document   : ProductDetail
    Created on : Apr 16, 2025, 2:43:36 PM
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Chi Tiết Sản Phẩm – Quản Lí</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
                padding-top: 20px;
            }
            .container {
                max-width: 1100px;
            }
            .modal-backdrop.show {
                opacity: .1;
            }
            .media-preview img, .media-preview video {
                max-width: 150px;
                margin: .5rem;
            }
            /* Wrapper cho mỗi media */
            .media-item {
                position: relative;
                margin-bottom: 1rem;
            }
            /* Thẻ video/iframe nằm phía sau */
            .media-item .media-content {
                z-index: 1;
            }
            /* Nút hành động luôn nổi lên trên */
            .media-item .actions {
                position: absolute;
                top: 0.5rem;
                right: 0.5rem;
                z-index: 10;
            }
            .actions .btn {
                font-size: 0.75rem;
                margin-left: 0.25rem;
            }
        </style>
    </head>
    <body>

        <div class="container">

            <!-- HEADER -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1>
                    <c:choose>
                        <c:when test="${mode == 'view'}">Xem Sản Phẩm</c:when>
                        <c:when test="${mode == 'edit'}">Chỉnh Sửa Sản Phẩm</c:when>
                        <c:when test="${mode == 'add'}">Thêm 1 Sản Phẩm Mới</c:when>
                    </c:choose>
                </h1>
                <div>
                    <!-- Nút chuyển từ view → edit -->
                    <c:if test="${mode == 'view'}">
                        <a href="${pageContext.request.contextPath}/ProductForManagerDetailController?productId=${product.productId}&mode=edit"
                           class="btn btn-warning me-2">Chỉnh Sửa Sản Phẩm</a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/ProductForManagerListController" class="btn btn-secondary">
                        &larr; Trở về danh sách
                    </a>
                </div>
            </div>

            <!-- ALERT MESSAGE -->
            <c:if test="${not empty message}">
                <div class="alert alert-info">${message}</div>
            </c:if>
            <!-- Nếu có lỗi tên Product -->
            <c:if test="${not empty errorName}">
                <div class="alert alert-warning">
                    <strong>Warning:</strong> ${errorName}
                </div>
            </c:if>

            <!-- Nếu có lỗi Variant -->
            <c:if test="${not empty errorVariant}">
                <div class="alert alert-warning">
                    <strong>Warning:</strong> ${errorVariant}
                </div>
            </c:if>


            <!-- PRODUCT FORM -->
            <form action="${pageContext.request.contextPath}/ProductForManagerDetailController" method="post">
                <input type="hidden" name="mode" value="${mode}" />
                <c:if test="${mode != 'add'}">
                    <input type="hidden" name="productId" value="${product.productId}" />
                </c:if>

                <div class="card mb-4">
                    <div class="card-header">Thông tin sản phẩm</div>
                    <div class="card-body">
                        <!-- Name -->
                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Tên</label>
                            <div class="col-sm-10">
                                <c:choose>
                                    <c:when test="${mode == 'view'}">
                                        <p class="form-control-plaintext">${product.productName}</p>
                                    </c:when>
                                    <c:otherwise>
                                        <input type="text" name="productName" class="form-control" value="${product.productName}" required>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <!-- Brand -->
                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Thương hiệu</label>
                            <div class="col-sm-10">
                                <c:choose>
                                    <c:when test="${mode == 'view'}">
                                        <p class="form-control-plaintext">${product.brandName}</p>
                                    </c:when>
                                    <c:otherwise>
                                        <select name="brandName" class="form-select" required>
                                            <c:forEach var="b" items="${brandList}">
                                                <option value="${b}" ${b == product.brandName ? 'selected' : ''}>${b}</option>
                                            </c:forEach>
                                        </select>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <!-- Category -->
                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Danh mục</label>
                            <div class="col-sm-10">
                                <c:choose>
                                    <c:when test="${mode == 'view'}">
                                        <p class="form-control-plaintext">${product.categoryName}</p>
                                    </c:when>
                                    <c:otherwise>
                                        <select name="categoryName" class="form-select" required>
                                            <c:forEach var="c" items="${categoryList}">
                                                <option value="${c}" ${c == product.categoryName ? 'selected' : ''}>${c}</option>
                                            </c:forEach>
                                        </select>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <!-- Description -->
                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Mô tả</label>
                            <div class="col-sm-10">
                                <c:choose>
                                    <c:when test="${mode == 'view'}">
                                        <p class="form-control-plaintext">${product.description}</p>
                                    </c:when>
                                    <c:otherwise>
                                        <textarea name="description" class="form-control" rows="4" required>${product.description}</textarea>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- SAVE / CANCEL -->
                <c:if test="${mode != 'view'}">
                    <div class="mb-4 text-end">
                        <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                        <a href="${pageContext.request.contextPath}/ProductForManagerDetailController?productId=${product.productId}&mode=view" class="btn btn-secondary">Hủy</a>
                    </div>
                </c:if>
            </form>

            <!-- VARIANT SECTION -->
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <span>Variants</span>
                    <!-- Chỉ hiện nút Add Variant khi đang ở edit hoặc add mode -->
                    <c:if test="${mode != 'view'}">
                        <button class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#variantModal">Thêm Phiên bản</button>
                    </c:if>
                </div>
                <div class="card-body p-0">
                    <table class="table align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>ID</th><th>CPU</th><th>RAM</th><th>Màn hình</th><th>Dung lượng</th>
                                <th>Màu</th><th>Giá</th><th>Tồn kho</th>
                                <th>Khác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="v" items="${product.variants}">
                                <tr>
                                    <td>${v.variantId}</td>
                                    <td>${v.cpu}</td>
                                    <td>${v.ram}</td>
                                    <td>${v.screen}</td>
                                    <td>${v.storage}</td>
                                    <td>${v.color}</td>
                                    <td>${v.price}</td>
                                    <td>${v.stockQuantity}</td>
                                    <td>
                                        <!-- Chỉ show Edit/Delete khi mode != view -->
                                        <c:if test="${mode != 'view'}">
                                            <a href="?productId=${product.productId}&editVariantId=${v.variantId}&mode=${mode}"
                                               class="btn btn-warning btn-sm">Sửa</a>
                                            <a href="?productId=${product.productId}&deleteVariantId=${v.variantId}&mode=${mode}"
                                               class="btn btn-danger btn-sm"
                                               onclick="return confirm('Delete this variant?');">Xóa</a>
                                        </c:if>
                                        <!-- Khi đang ở view, chỉ show nothing -->
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty product.variants}">
                                <tr><td colspan="9" class="text-center">Hiện không có phiên bản</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- MEDIA SECTION -->
            <div class="card mb-4">
                <div class="card-header">Media</div>
                <div class="card-body">
                    <div class="row g-3">
                        <!-- Loop through each media item -->
                        <c:forEach var="m" items="${product.mediaList}">
                            <div class="col-md-3 media-item">
                                <div class="media-content">
                                    <c:choose>
                                        <c:when test="${m.mediaType == 'image'}">
                                            <img src="${m.mediaUrl}" class="img-fluid img-thumbnail" alt="">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="ratio ratio-16x9">
                                                <c:choose>
                                                    <c:when test="${fn:contains(m.mediaUrl,'youtu')}">
                                                        <iframe src="https://www.youtube.com/embed/${fn:split(m.mediaUrl,'/')[fn:length(fn:split(m.mediaUrl,'/'))-1]}" allowfullscreen class="w-100 h-100"></iframe>
                                                        </c:when>
                                                        <c:otherwise>
                                                        <video controls class="w-100 h-auto">
                                                            <source src="${m.mediaUrl}" type="video/mp4">
                                                            Browser của bạn không hỗ trợ video tag này.
                                                        </video>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <!-- Only show actions in edit/add mode -->
                                <c:if test="${mode != 'view'}">
                                    <div class="actions position-absolute top-0 end-0 p-2">
                                        <a href="${pageContext.request.contextPath}/MediaUploadController?productId=${product.productId}&mediaId=${m.mediaId}&action=setPrimary"
                                           class="btn btn-sm ${m.primary ? 'btn-outline-secondary' : 'btn-outline-primary'} me-1">
                                            <c:choose>
                                                <c:when test="${m.primary}">Đã ưu tiên</c:when>
                                                <c:otherwise>Chọn ưu tiên</c:otherwise>
                                            </c:choose>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/MediaUploadController?productId=${product.productId}&mediaId=${m.mediaId}&action=delete"
                                           class="btn btn-sm btn-outline-danger"
                                           onclick="return confirm('Xóa media này bạn chắc chứ?');">×</a>
                                    </div>
                                </c:if>
                            </div>
                        </c:forEach>
                        <c:if test="${empty product.mediaList}">
                            <p class="text-muted text-center w-100">Không có media uploaded.</p>
                        </c:if>
                    </div>

                    <!-- Only show upload form in edit/add mode -->
                    <c:if test="${mode != 'view'}">
                        <div class="add-media-section mt-4">
                            <h5>Add Media</h5>
                            <form action="${pageContext.request.contextPath}/MediaUploadController" method="post" enctype="multipart/form-data" class="row g-3">
                                <input type="hidden" name="productId" value="${product.productId}">
                                <div class="col-md-2">
                                    <select name="mediaType" class="form-select" required>
                                        <option value="image">Ảnh</option>
                                        <option value="video">Video</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <input type="file" name="mediaFile" class="form-control">
                                </div>
                                <div class="col-md-4">
                                    <input type="url" name="mediaUrl" class="form-control" placeholder="Hoặc Nhập URL (YouTube/Image)">
                                </div>
                                <div class="col-md-2 form-check">
                                    <input type="checkbox" name="isPrimary" id="isPrimary" class="form-check-input">
                                    <label for="isPrimary" class="form-check-label">Ưu tiên?</label>
                                </div>
                                <div class="col-md-1 text-end">
                                    <button type="submit" class="btn btn-primary">Tải Lên</button>
                                </div>
                            </form>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- VARIANT MODAL -->
            <div class="modal fade" id="variantModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                    <form action="${pageContext.request.contextPath}/ProductForManagerDetailController" method="post">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">
                                    <c:choose>
                                        <c:when test="${not empty variantToEdit}">Edit Variant</c:when>
                                        <c:otherwise>Add Variant</c:otherwise>
                                    </c:choose>
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <input type="hidden" name="productId" value="${product.productId}">
                                <c:if test="${not empty variantToEdit}">
                                    <input type="hidden" name="variantId" value="${variantToEdit.variantId}">
                                    <input type="hidden" name="variantAction" value="update">
                                </c:if>
                                <c:if test="${empty variantToEdit}">
                                    <input type="hidden" name="variantAction" value="add">
                                </c:if>
                                <div class="mb-3"><label>CPU</label>
                                    <input type="text" name="cpu" class="form-control" value="${variantToEdit.cpu}" required></div>
                                <div class="mb-3"><label>RAM</label>
                                    <input type="text" name="ram" class="form-control" value="${variantToEdit.ram}" required></div>
                                <div class="mb-3"><label>Screen</label>
                                    <input type="text" name="screen" class="form-control" value="${variantToEdit.screen}" required></div>
                                <div class="mb-3"><label>Storage</label>
                                    <input type="text" name="storage" class="form-control" value="${variantToEdit.storage}" required></div>
                                <div class="mb-3"><label>Color</label>
                                    <input type="text" name="color" class="form-control" value="${variantToEdit.color}" required></div>
                                <div class="mb-3"><label>Price</label>
                                    <input type="number" step="0.01" name="price" class="form-control" value="${variantToEdit.price}" required></div>
                                <div class="mb-3"><label>Stock</label>
                                    <input type="number" name="stockQuantity" class="form-control" value="${variantToEdit.stockQuantity}" required></div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary">Save</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Bootstrap JS bundle -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                               window.addEventListener('DOMContentLoaded', () => {
            <c:if test="${not empty variantToEdit}">
                                                   const modal = new bootstrap.Modal(document.getElementById('variantModal'));
                                                   modal.show();
            </c:if>
                                               });
        </script>
    </body>
</html>
