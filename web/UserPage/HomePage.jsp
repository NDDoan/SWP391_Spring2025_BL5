<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="Entity.Product" %>
<%@ page import="Entity.Category" %>
<%
    List<Product> newProducts = (List<Product>) request.getAttribute("newProducts");
    List<Category> categories = (List<Category>) request.getAttribute("categories");

    // Map<CategoryId, CategoryName>
    Map<Integer, String> categoryMap = new HashMap<>();
    for (Category cat : categories) {
        categoryMap.put(cat.getId(), cat.getName());
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Electro - Trang Chủ</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #fff;
            color: #333;
        }

        .top-bar, footer {
            background-color: #0c0c0c;
            color: #fff;
            padding: 10px 20px;
            font-size: 14px;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
        }

        header {
            background-color: #0c0c0c;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
        }

        header h1 {
            margin: 0;
            font-size: 28px;
        }

        header span {
            color: #e60023;
        }

        .search-bar {
            display: flex;
            width: 40%;
        }

        .search-bar input {
            width: 100%;
            padding: 8px;
            border: none;
        }

        .search-bar button {
            background-color: #e60023;
            color: white;
            border: none;
            padding: 8px 16px;
            cursor: pointer;
        }

        nav {
            display: flex;
            background-color: white;
            padding: 10px 20px;
            border-bottom: 1px solid #eee;
        }

        nav a {
            margin-right: 20px;
            text-decoration: none;
            color: #333;
            font-weight: bold;
        }

        .banner {
            display: flex;
            gap: 20px;
            padding: 20px;
            justify-content: center;
        }

        .banner img {
            width: 30%;
            border-radius: 6px;
        }

        .section-title {
            text-align: center;
            font-size: 26px;
            font-weight: bold;
            margin-top: 40px;
        }

        .products {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            padding: 20px;
        }

        .product-card {
            border: 1px solid #eee;
            border-radius: 6px;
            padding: 10px;
            text-align: center;
            transition: box-shadow 0.3s;
        }

        .product-card:hover {
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .product-card img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            border-radius: 6px;
        }

        .product-card h4 {
            margin: 10px 0 5px;
            font-size: 16px;
        }

        .price {
            color: #e60023;
            font-weight: bold;
        }

        .stars {
            color: gold;
        }

        .top-bar a {
            color: white;
            text-decoration: none;
            margin-left: 10px;
        }
    </style>
</head>
<body>

<!-- Top bar -->
<div class="top-bar">
    <div>
        <span>+021-95-51-84</span> | <span>email@email.com</span> | <span>1734 Đường Stonecoal</span>
    </div>
    <div>
        <a href="#" title="Đăng nhập"><i class="fas fa-user"></i> Đăng nhập</a>
        <a href="#" title="Giỏ hàng"><i class="fas fa-shopping-cart"></i> Giỏ hàng</a>
    </div>
</div>

<!-- Header -->
<header>
    <h1>Electro<span>.</span></h1>
    <div class="search-bar">
        <input type="text" placeholder="Tìm kiếm sản phẩm...">
        <button>Tìm</button>
    </div>
</header>

<!-- Navigation -->
<nav>
    <a href="#">Trang chủ</a>
    <a href="#">Khuyến mãi HOT</a>
    <a href="#">Tất cả sản phẩm</a>
    <% if (categories != null) {
        for (Category c : categories) { %>
            <a href="category?cid=<%=c.getId()%>"><%= c.getName() %></a>
    <% }
       } %>
</nav>

<!-- Banner -->
<div class="banner">
    <img src="https://images.unsplash.com/photo-1517336714731-489689fd1ca8" alt="Laptop">
    <img src="https://ares.shiftdelete.net/2023/10/iphone-16-pro-pro-max-buyuk-ekran.jpg" alt="iPhone">
    <img src="https://pngimg.com/uploads/photo_camera/photo_camera_PNG101601.png" alt="Máy ảnh">
</div>

<!-- New Products -->
<h2 class="section-title">SẢN PHẨM MỚI</h2>
<div class="products">
    <% if (newProducts != null && !newProducts.isEmpty()) {
        for (Product p : newProducts) { %>
            <div class="product-card">
                <img src="<%= p.getImage() %>" alt="<%= p.getName() %>">
                <p style="font-size: 13px;"><%= categoryMap.get(p.getCategoryId()) %></p>
                <h4><%= p.getName() %></h4>
                <p class="price">$<%= p.getPrice() %></p>
                <p class="stars">★★★★★</p>
            </div>
    <%  }
       } else { %>
        <p style="grid-column: 1 / -1; text-align: center;">Không có sản phẩm nào.</p>
    <% } %>
</div>

<!-- Footer -->
<footer>
    © 2025 Electro. Bản quyền đã được bảo hộ.
</footer>

</body>
</html>
