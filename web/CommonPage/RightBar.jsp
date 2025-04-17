<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Right Sidebar</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .right-bar {
            width: 100%;
            max-width: 330px;
            padding: 20px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            font-family: 'Poppins', sans-serif;
        }

        .right-bar h3 {
            font-size: 18px;
            margin: 20px 0 10px;
            padding-bottom: 5px;
            color: #1e3c72;
            border-bottom: 2px solid #eee;
        }

        .product-card {
            background: #f9f9f9;
            padding: 12px;
            border-radius: 10px;
            margin-bottom: 18px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease;
        }

        .product-card:hover {
            transform: translateY(-3px);
        }

        .product-card img {
            width: 100%;
            height: auto;
            border-radius: 8px;
            margin-bottom: 10px;
            transition: 0.3s ease;
        }

        .product-title {
            font-size: 15px;
            font-weight: 600;
            color: #007bff;
            margin-bottom: 6px;
        }

        .product-info {
            font-size: 13px;
            color: #555;
            margin-bottom: 10px;
        }

        .product-price {
            font-size: 18px;
            font-weight: bold;
            color: #d9534f;
        }

        .discount-price {
            font-size: 13px;
            color: #28a745;
            font-weight: 500;
        }

        .add-to-cart {
            background: #28a745;
            color: white;
            padding: 8px 12px;
            border: none;
            border-radius: 6px;
            font-size: 13px;
            cursor: pointer;
            font-weight: 500;
            transition: 0.3s ease;
        }

        .add-to-cart:hover {
            background: #218838;
        }

        @media screen and (max-width: 768px) {
            .right-bar {
                max-width: 100%;
                margin-top: 20px;
            }
        }
    </style>
</head>
<body>
<div class="right-bar">
    <!-- Mới nhất -->
    <h3><i class="fas fa-clock"></i> Sản phẩm mới nhất</h3>
    <c:if test="${not empty newestProduct}">
        <div class="product-card">
            <img src="${newestProduct.imageUrl}" alt="${newestProduct.description}">
            <div class="product-title">${newestProduct.productName}</div>
            <div class="product-info">
                Giá: <span class="product-price">
                    <fmt:formatNumber value="${newestProduct.price}" type="number" groupingUsed="true"/> VND
                </span>
            </div>
            <button class="add-to-cart">Thêm vào giỏ</button>
        </div>
    </c:if>

    <!-- Giảm giá tốt nhất -->
    <h3><i class="fas fa-tags"></i> Giảm giá sâu nhất</h3>
    <c:if test="${not empty bestDiscountedProduct}">
        <div class="product-card">
            <img src="${bestDiscountedProduct.imageUrl}" alt="${bestDiscountedProduct.description}">
            <div class="product-title">${bestDiscountedProduct.productName}</div>
            <div class="product-info">
                Giá gốc: <span class="product-price">
                    <fmt:formatNumber value="${bestDiscountedProduct.price}" type="number" groupingUsed="true"/> VND
                </span><br>
                Giá giảm: <span class="discount-price">
                    <fmt:formatNumber value="${bestDiscountedProduct.discountPrice}" type="number" groupingUsed="true"/> VND
                </span>
            </div>
            <button class="add-to-cart">Thêm vào giỏ</button>
        </div>
    </c:if>

    <!-- Bán chạy nhất -->
    <h3><i class="fas fa-fire"></i> Bán chạy nhất</h3>
    <c:if test="${not empty bestSellingProduct}">
        <div class="product-card">
            <img src="${bestSellingProduct.imageUrl}" alt="${bestSellingProduct.description}">
            <div class="product-title">${bestSellingProduct.productName}</div>
            <div class="product-info">
                Đã bán: <strong>${bestSellingProduct.soldQuantity}</strong> sản phẩm
            </div>
            <button class="add-to-cart">Thêm vào giỏ</button>
        </div>
    </c:if>

    <!-- Đánh giá cao nhất -->
    <h3><i class="fas fa-star"></i> Được đánh giá cao nhất</h3>
    <c:if test="${not empty topRatedProduct}">
        <div class="product-card">
            <img src="${topRatedProduct.imageUrl}" alt="${topRatedProduct.description}">
            <div class="product-title">${topRatedProduct.productName}</div>
            <div class="product-info">
                Đánh giá: ⭐ <strong>${topRatedProduct.averageRating}</strong> / 5
            </div>
            <button class="add-to-cart">Thêm vào giỏ</button>
        </div>
    </c:if>
</div>
</body>
</html>
