<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Trang Chủ – Electro Mart</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            /* CSS cho chuyển động carousel */
            .carousel-item img {
                transition: transform 0.5s ease;
            }
            .carousel-item:hover img {
                transform: scale(1.05);
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <jsp:include page="../CommonPage/Header.jsp"/>
        <div class="container my-5">
            <h2 class="mb-4">Featured Products</h2>
            <div class="row g-4">
                <c:forEach var="p" items="${featuredList}">
                    <div class="col-md-3">
                        <div class="card h-100 shadow-sm">
                            <img src="${p.primaryMediaUrl}" class="card-img-top" alt="${p.productName}">
                            <div class="card-body">
                                <h5 class="card-title">${p.productName}</h5>
                                <p class="card-text">
                                    <small class="text-muted">${p.brandName} – ${p.categoryName}</small><br/>
                                    <strong>${p.price}₫</strong>
                                </p>
                                <a href="${pageContext.request.contextPath}/ProductDetail?productId=${p.productId}"
                                   class="btn btn-primary btn-sm">Xem chi tiết</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        
        <div class="container my-5">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h2>Sản phẩm giá tốt</h2>
            </div>

            <!-- Carousel hiển thị product -->
            <div id="featuredCarousel" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <c:forEach var="p" items="${featuredList}" varStatus="st">
                        <div class="carousel-item ${st.index == 0 ? 'active' : ''}">
                            <div class="row justify-content-center">
                                <div class="col-md-4">
                                    <div class="card">
                                        <img src="${p.primaryMediaUrl}" class="card-img-top" alt="${p.productName}">
                                        <div class="card-body text-center">
                                            <h5 class="card-title">${p.productName}</h5>
                                            <p class="card-text text-muted">${p.brandName} – ${p.categoryName}</p>
                                            <p class="card-text text-danger fw-bold">${p.price}₫</p>
                                            <a href="${pageContext.request.contextPath}/cart/add?productId=${p.productId}" 
                                               class="btn btn-success btn-sm me-2">
                                                <i class="fas fa-cart-plus"></i> Add to Cart
                                            </a>
                                            <a href="${pageContext.request.contextPath}/ProductDetail?productId=${p.productId}" 
                                               class="btn btn-primary btn-sm">Chi tiết</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#featuredCarousel" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#featuredCarousel" data-bs-slide="next">
                    <span class="carousel-control-next-icon"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>
        </div>

        <!-- Footer -->
        <jsp:include page="../CommonPage/Footer.jsp"/>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>