<%-- 
    Document   : ProductDetail
    Created on : Apr 16, 2025, 2:43:36 PM
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết Sản phẩm</title>
        <!-- Bootstrap CSS CDN (phiên bản 5) -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- CSS Tùy chỉnh -->
        <style>
            body {
                background-color: #f8f9fa;
                padding-top: 20px;
            }
            .container {
                max-width: 1100px;
            }
            .section-header {
                margin-top: 30px;
                margin-bottom: 15px;
            }
            .variant-actions button {
                margin-right: 5px;
            }
            .media-preview img,
            .media-preview video {
                max-width: 150px;
                margin-right: 10px;
            }
            .add-media-section {
                margin-top: 20px;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <!-- Header -->
            <div class="row mb-3">
                <div class="col">
                    <h1 class="text-center">
                        <c:choose>
                            <c:when test="${mode == 'view'}">Thông tin Sản phẩm</c:when>
                            <c:when test="${mode == 'edit'}">Chỉnh sửa Sản phẩm</c:when>
                            <c:when test="${mode == 'add'}">Thêm Sản phẩm mới</c:when>
                        </c:choose>
                    </h1>
                </div>
            </div>

            <!-- Hiển thị thông báo (nếu có) -->
            <c:if test="${not empty message}">
                <div class="alert alert-info">${message}</div>
            </c:if>

            <!-- Form Product: Nếu ở chế độ view thì hiển thị thông tin, nếu ở chế độ edit hoặc add thì cho phép chỉnh sửa -->
            <form action="${pageContext.request.contextPath}/ProductForManagerDetailController" method="post">
                <!-- Chuyển mode tới controller -->
                <input type="hidden" name="mode" value="${mode}" />
                <c:if test="${mode != 'add'}">
                    <input type="hidden" name="productId" value="${product.productId}" />
                </c:if>

                <div class="card mb-4">
                    <div class="card-header">Thông tin Sản phẩm</div>
                    <div class="card-body">
                        <!-- Tên sản phẩm -->
                        <div class="mb-3 row">
                            <label for="productName" class="col-sm-2 col-form-label">Tên sản phẩm</label>
                            <div class="col-sm-10">
                                <c:choose>
                                    <c:when test="${mode == 'view'}">
                                        <p class="form-control-plaintext">${product.productName}</p>
                                    </c:when>
                                    <c:otherwise>
                                        <input type="text" class="form-control" id="productName" name="productName" value="${product.productName}" required />
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- Thương hiệu: Hiển thị tên thay vì Id -->
                        <div class="mb-3 row">
                            <label for="brandName" class="col-sm-2 col-form-label">Thương hiệu</label>
                            <div class="col-sm-10">
                                <c:choose>
                                    <c:when test="${mode == 'view'}">
                                        <p class="form-control-plaintext">${product.brandName}</p>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Nếu có danh sách thương hiệu, bạn có thể dùng select để lựa chọn -->
                                        <input type="text" class="form-control" id="brandName" name="brandName" value="${product.brandName}" required />
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- Danh mục: Hiển thị tên danh mục -->
                        <div class="mb-3 row">
                            <label for="categoryName" class="col-sm-2 col-form-label">Danh mục</label>
                            <div class="col-sm-10">
                                <c:choose>
                                    <c:when test="${mode == 'view'}">
                                        <p class="form-control-plaintext">${product.categoryName}</p>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Nếu có danh sách danh mục, bạn có thể chuyển sang select dropdown -->
                                        <input type="text" class="form-control" id="categoryName" name="categoryName" value="${product.categoryName}" required />
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- Mô tả -->
                        <div class="mb-3 row">
                            <label for="description" class="col-sm-2 col-form-label">Mô tả</label>
                            <div class="col-sm-10">
                                <c:choose>
                                    <c:when test="${mode == 'view'}">
                                        <p class="form-control-plaintext">${product.description}</p>
                                    </c:when>
                                    <c:otherwise>
                                        <textarea class="form-control" id="description" name="description" rows="4" required>${product.description}</textarea>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Nút Lưu / Hủy: chỉ hiển thị nếu ở chế độ edit hoặc add -->
                <c:if test="${mode != 'view'}">
                    <div class="mb-4 text-end">
                        <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                        <a href="${pageContext.request.contextPath}/ProductForManagerDetailController?productId=${product.productId}&mode=view" class="btn btn-secondary">Hủy</a>
                    </div>
                </c:if>
            </form>

            <!-- Phần Variant & Media (giữ nguyên phần trước) -->

            <!-- Danh sách Variant -->
            <div class="card mb-4">
                <div class="card-header">
                    Danh sách Variant 
                    <c:if test="${mode == 'view'}">
                        <button class="btn btn-success btn-sm float-end" data-bs-toggle="modal" data-bs-target="#addVariantModal">Thêm Variant</button>
                    </c:if>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>CPU</th>
                                    <th>RAM</th>
                                    <th>Screen</th>
                                    <th>Storage</th>
                                    <th>Color</th>
                                    <th>Price</th>
                                    <th>Stock</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="variant" items="${product.variants}">
                                    <tr>
                                        <td>${variant.variantId}</td>
                                        <td>${variant.cpu}</td>
                                        <td>${variant.ram}</td>
                                        <td>${variant.screen}</td>
                                        <td>${variant.storage}</td>
                                        <td>${variant.color}</td>
                                        <td>${variant.price}</td>
                                        <td>${variant.stockQuantity}</td>
                                        <td class="variant-actions">
                                            <a href="${pageContext.request.contextPath}/VariantActionController?action=view&variantId=${variant.variantId}" class="btn btn-info btn-sm">Xem</a>
                                            <a href="${pageContext.request.contextPath}/VariantActionController?action=edit&variantId=${variant.variantId}" class="btn btn-warning btn-sm">Sửa</a>
                                            <a href="${pageContext.request.contextPath}/VariantActionController?action=delete&variantId=${variant.variantId}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa Variant này?');">Xóa</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty product.variants}">
                                    <tr>
                                        <td colspan="9" class="text-center">Chưa có Variant nào</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Quản lý Media -->
            <div class="card mb-4">
                <div class="card-header">Quản lý Media</div>
                <div class="card-body">
                    <div class="media-preview mb-3">
                        <c:forEach var="media" items="${product.mediaList}">
                            <c:choose>
                                <c:when test="${media.mediaType eq 'image'}">
                                    <img src="${media.mediaUrl}" alt="Image" class="img-thumbnail">
                                </c:when>
                                <c:when test="${media.mediaType eq 'video'}">
                                    <video controls class="img-thumbnail">
                                        <source src="${media.mediaUrl}" type="video/mp4">
                                        Trình duyệt không hỗ trợ video.
                                    </video>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                        <c:if test="${empty product.mediaList}">
                            <p class="text-muted">Chưa có Media nào</p>
                        </c:if>
                    </div>

                    <!-- Form thêm Media -->
                    <div class="add-media-section">
                        <h5>Thêm Media</h5>
                        <form action="${pageContext.request.contextPath}/MediaUploadController" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="productId" value="${product.productId}" />
                            <div class="mb-3">
                                <label class="form-label">Loại Media</label>
                                <select class="form-select" name="mediaType" required>
                                    <option value="image">Ảnh</option>
                                    <option value="video">Video</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Tải file từ máy</label>
                                <input type="file" class="form-control" name="mediaFile">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Hoặc nhập URL</label>
                                <input type="url" class="form-control" name="mediaUrl" placeholder="http://">
                            </div>

                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" name="isPrimary" id="isPrimary">
                                <label class="form-check-label" for="isPrimary">Đánh dấu là Media chính</label>
                            </div>

                            <button type="submit" class="btn btn-primary">Thêm Media</button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Modal cho Variant: dùng để Thêm Variant -->
            <div class="modal fade" id="addVariantModal" tabindex="-1" aria-labelledby="addVariantModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <form action="${pageContext.request.contextPath}/VariantActionController" method="post">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addVariantModalLabel">Thêm Variant</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                            </div>
                            <div class="modal-body">
                                <input type="hidden" name="productId" value="${product.productId}">
                                <div class="mb-3">
                                    <label class="form-label">CPU</label>
                                    <input type="text" class="form-control" name="cpu" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">RAM</label>
                                    <input type="text" class="form-control" name="ram" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Screen</label>
                                    <input type="text" class="form-control" name="screen" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Storage</label>
                                    <input type="text" class="form-control" name="storage" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Color</label>
                                    <input type="text" class="form-control" name="color" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Price</label>
                                    <input type="number" step="0.01" class="form-control" name="price" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Stock</label>
                                    <input type="number" class="form-control" name="stockQuantity" required>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                <button type="submit" class="btn btn-primary">Lưu Variant</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

        </div>

        <!-- Bootstrap JS Bundle CDN (bao gồm Popper) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                function editVariant(variantId) {
                                                    alert("Chức năng sửa Variant ID: " + variantId);
                                                }

                                                function deleteVariant(variantId) {
                                                    if (confirm("Bạn có chắc chắn muốn xóa Variant này?")) {
                                                        window.location.href = "${pageContext.request.contextPath}/VariantActionController?action=delete&variantId=" + variantId;
                                                    }
                                                }
        </script>
    </body>
</html>
