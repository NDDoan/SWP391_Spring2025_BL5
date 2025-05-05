<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Trang Chủ – Electro Mart</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            /* CSS cho chuyển động carousel */
            .carousel-control-prev-icon,
            .carousel-control-next-icon {
                background-color: rgba(0, 0, 0, 0.5);
                border-radius: 50%;
                background-size: 2rem 2rem;
            }
            /* Đẩy icon ra xa một chút để nhìn rõ */
            .carousel-control-prev {
                left: 1%;
            }
            .carousel-control-next {
                right: 1%;
            }
            .partners-section {
                padding: 4rem 0;
                background: #f8f9fa;
            }
            .partner-logo {
                transition: transform .3s ease, box-shadow .3s ease;
                border-radius: .5rem;
                background: white;
                padding: 1rem;
            }
            .partner-logo img {
                max-width: 100%;
                height: auto;
                display: block;
                margin: 0 auto;
            }
            .partner-logo:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 16px rgba(0,0,0,0.2);
            }
            /* ----- Categories Section ----- */
            .categories-section {
                background-color: #ffffff;
            }
            .categories-section .section-header {
                border-bottom: 2px solid #e9ecef;
                padding-bottom: .5rem;
            }
            .categories-section .section-header h3 {
                font-size: 1.75rem;
                color: #343a40;
                margin: 0;
            }
            .categories-section .section-header .btn-outline-primary {
                font-size: .875rem;
            }

            .category-card {
                border: none;
                border-radius: .75rem;
                overflow: hidden;
                transition: transform .3s ease, box-shadow .3s ease;
            }
            .category-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 12px 24px rgba(0,0,0,0.1);
            }
            .category-card .card-img-top {
                height: 180px;
                object-fit: cover;
            }
            .category-card .card-title {
                font-size: 1rem;
                margin-bottom: .5rem;
            }
            .category-card .text-muted {
                font-size: .875rem;
            }
            .category-card .fw-bold {
                font-size: 1rem;
            }

            /* Responsive tweaks */
            @media (max-width: 576px) {
                .categories-section .section-header h3 {
                    font-size: 1.5rem;
                }
                .category-card .card-img-top {
                    height: 150px;
                }
            }

        </style>
    </head>
    <body>
        <!-- Header -->
        <jsp:include page="../CommonPage/Header.jsp"/>
        <div class="container my-5">
            <h2 class="mb-4">Sản phẩm nổi bật</h2>
            <div class="row g-4">
                <c:forEach var="p" items="${featuredList}">
                    <div class="col-md-3">
                        <div class="card h-100 shadow-sm">
                            <img src="${p.primaryMediaUrl}" class="card-img-top" alt="${p.productName}">
                            <div class="card-body">
                                <h5 class="card-title">${p.productName}</h5>
                                <p class="card-text">
                                    <small class="text-muted">${p.brandName} – ${p.categoryName}</small><br/>
                                    <strong>
                                        <fmt:formatNumber value="${p.price}"
                                                          type="number"
                                                          groupingUsed="true"
                                                          minFractionDigits="0"
                                                          maxFractionDigits="0"/>
                                        ₫
                                    </strong>
                                </p>
                                <a href="${pageContext.request.contextPath}/cartdetailcontroller?productId=${p.productId}&quantity=1"
                                   class="btn btn-sm btn-success">
                                    <i class="fas fa-cart-plus"></i> Thêm vào giỏ hàng
                                </a>
                                <a href="${pageContext.request.contextPath}/ProductDetailController?productId=${p.productId}"
                                   class="btn btn-primary btn-sm"><i class="fas fa-info-circle"></i> Xem chi tiết</a>
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
                                            <p class="card-text text-danger fw-bold">
                                                <fmt:formatNumber value="${p.price}"
                                                                  type="number"
                                                                  groupingUsed="true"
                                                                  minFractionDigits="0"
                                                                  maxFractionDigits="0"/>₫
                                            </p>
                                            <a href="${pageContext.request.contextPath}/cartdetailcontroller?productId=${p.productId}&quantity=1" 
                                               class="btn btn-success btn-sm me-2">
                                                <i class="fas fa-cart-plus"></i> Thêm vào giỏ hàng
                                            </a>
                                            <a href="${pageContext.request.contextPath}/ProductDetailController?productId=${p.productId}" 
                                               class="btn btn-primary btn-sm"><i class="fas fa-info-circle"></i> Xem chi tiết</a>
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

        <!-- Products by Category -->
        <c:forEach var="entry" items="${productsByCategory}">
            <c:set var="catName" value="${entry.key}" />
            <c:set var="prods" value="${entry.value}" />

            <section class="category-section py-4">
                <div class="container">
                    <h3 class="mb-3">${catName}</h3>
                    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                        <c:forEach var="p" items="${prods}">
                            <div class="col">
                                <div class="card h-100">
                                    <a href="${pageContext.request.contextPath}/ProductDetailController?productId=${p.productId}">
                                        <img src="${p.primaryMediaUrl}" class="card-img-top" alt="${p.productName}" style="height:auto; object-fit:cover;">
                                    </a>
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title">${p.productName}</h5>
                                        <p class="text-muted mb-2">${p.brandName}</p>
                                        <div class="mt-auto d-flex justify-content-between align-items-center">
                                            <span class="fw-bold">
                                                <fmt:formatNumber value="${p.price}"
                                                                  type="number"
                                                                  groupingUsed="true"
                                                                  minFractionDigits="0"
                                                                  maxFractionDigits="0"/>₫
                                            </span>
                                                <button class="btn btn-sm btn-success add-to-cart" data-product-id="${p.productId}">
                                                    <i class="fas fa-cart-plus"></i> Thêm vào giỏ hàng
                                                </button>
                                            <a href="${pageContext.request.contextPath}/ProductDetailController?productId=${p.productId}" 
                                               class="btn btn-primary btn-sm"><i class="fas fa-info-circle"></i> Xem chi tiết</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <c:if test="${empty prods}">
                            <p class="text-muted">Không có sản phẩm nào trong danh mục này.</p>
                        </c:if>
                    </div>
                </div>
            </section>
        </c:forEach>

        <!-- Partners Section -->
        <section class="partners-section">
            <div class="container">
                <h2 class="text-center mb-4">Đối tác của chúng tôi</h2>
                <div class="row row-cols-2 row-cols-md-4 row-cols-lg-6 g-4 justify-content-center">
                    <c:forEach var="b" items="${partners}">
                        <div class="col d-flex align-items-center justify-content-center">
                            <div class="partner-logo w-100 text-center">
                                <img src="${b.logoUrl}" alt="${b.brandName} logo">
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty partners}">
                        <p class="text-center text-muted">Chưa có đối tác nào để hiển thị.</p>
                    </c:if>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <jsp:include page="../CommonPage/Footer.jsp"/>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>