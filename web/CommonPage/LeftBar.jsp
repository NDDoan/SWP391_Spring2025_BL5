<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sidebar Filter</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .left-bar {
            width: 100%;
            max-width: 320px;
            background-color: #ffffff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            font-family: 'Poppins', sans-serif;
        }

        .left-bar h3 {
            font-size: 17px;
            font-weight: 600;
            color: #1e3c72;
            margin: 20px 0 10px;
            border-bottom: 1px solid #eee;
            padding-bottom: 5px;
        }

        .left-bar input[type="text"],
        .left-bar input[type="number"] {
            width: 100%;
            padding: 10px;
            margin: 5px 0 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
        }

        .left-bar input[type="checkbox"],
        .left-bar input[type="radio"] {
            margin-right: 8px;
        }

        .left-bar label {
            display: block;
            margin: 5px 0;
            font-size: 14px;
            color: #444;
        }

        .left-bar button {
            width: 100%;
            margin-top: 20px;
            padding: 12px;
            background-color: #1e3c72;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s;
        }

        .left-bar button:hover {
            background-color: #163062;
        }

        .star {
            color: #f8d210;
            margin-right: 4px;
        }

        @media screen and (max-width: 768px) {
            .left-bar {
                max-width: 100%;
                margin-bottom: 20px;
            }
        }
    </style>
</head>
<body>
<div class="left-bar">
    <form action="${pageContext.request.contextPath}/filterproduct" method="GET">

        <h3><i class="fas fa-search"></i> Tìm kiếm</h3>
        <input type="text" name="keyword" placeholder="Nhập tên sản phẩm...">

        <h3><i class="fas fa-tags"></i> Danh mục</h3>
        <c:forEach var="category" items="${listCate}">
            <label><input type="checkbox" name="category" value="${category.categoryId}"> ${category.categoryName}</label>
        </c:forEach>

        <h3><i class="fas fa-dollar-sign"></i> Giá</h3>
        <input type="text" name="minPrice" placeholder="Từ...">
        <input type="text" name="maxPrice" placeholder="Đến...">

        <h3><i class="fas fa-star"></i> Đánh giá</h3>
        <label><input type="radio" name="rating" value="5"> ⭐⭐⭐⭐⭐</label>
        <label><input type="radio" name="rating" value="4"> ⭐⭐⭐⭐</label>
        <label><input type="radio" name="rating" value="3"> ⭐⭐⭐</label>
        <label><input type="radio" name="rating" value="2"> ⭐⭐</label>
        <label><input type="radio" name="rating" value="1"> ⭐</label>

        <h3><i class="fas fa-box-open"></i> Trạng thái</h3>
        <label><input type="checkbox" name="status" value="available"> Còn hàng</label>
        <label><input type="checkbox" name="status" value="preorder"> Đặt trước</label>

        <h3><i class="fas fa-percent"></i> Giảm giá</h3>
        <label><input type="checkbox" name="discount" value="onsale"> Đang giảm giá</label>
        <label><input type="checkbox" name="discount" value="flashsale"> Flash Sale</label>

        <button type="submit"><i class="fas fa-filter"></i> Áp dụng bộ lọc</button>
    </form>
</div>
</body>
</html>
