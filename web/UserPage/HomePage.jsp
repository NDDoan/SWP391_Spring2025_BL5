<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, Entity.Product, Entity.Category"%>

<%
    List<Product> newProducts = (List<Product>) request.getAttribute("newProducts");
    List<Category> categories = (List<Category>) request.getAttribute("categories");

    Map<Integer, String> categoryMap = new HashMap<>();
    if (categories != null) {
        for (Category cat : categories) {
            categoryMap.put(cat.getCategoryId(), cat.getCategoryName());
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #333;
            color: white;
            padding: 15px;
            text-align: center;
        }

        nav {
            background-color: #fff;
            padding: 15px;
        }

        nav a {
            margin-right: 10px;
            text-decoration: none;
            color: #333;
        }

        .container {
            display: flex;
            margin: 20px;
        }

        .sidebar {
            width: 20%;
            background-color: white;
            padding: 15px;
            box-shadow: 0 0 5px #ccc;
        }

        .main-content {
            width: 80%;
            padding: 15px;
        }

        .product-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

        .product-card {
            background-color: white;
            padding: 10px;
            width: 200px;
            border-radius: 8px;
            box-shadow: 0 0 5px #ccc;
            text-align: center;
        }

        .product-card img {
            width: 100%;
            height: 150px;
            object-fit: cover;
            background-color: #eee;
        }

        .category-label {
            font-size: 13px;
            color: #888;
        }

        .product-name {
            font-weight: bold;
            margin: 8px 0;
        }

        .price {
            color: #FF6B6B;
            font-weight: bold;
        }
    </style>
</head>
<body>

<header>
    <h1>Trang chủ cửa hàng điện tử</h1>
</header>

<nav>
    <a href="#">Tất cả sản phẩm</a>
    <% if (categories != null) {
        for (Category c : categories) { %>
            <a href="category?cid=<%= c.getCategoryId() %>"><%= c.getCategoryName() %></a>
    <%  }
       } %>
</nav>

<div class="container">
    <div class="sidebar">
        <h3>Danh mục</h3>
        <ul>
            <% if (categories != null) {
                for (Category c : categories) { %>
                    <li><a href="category?cid=<%= c.getCategoryId() %>"><%= c.getCategoryName() %></a></li>
            <%  }
               } %>
        </ul>
    </div>

    <div class="main-content">
        <h2>Sản phẩm mới</h2>
        <div class="product-grid">
            <% if (newProducts != null && !newProducts.isEmpty()) {
                for (Product p : newProducts) { %>
                    <div class="product-card">
                        <img src="assets/images/default-product.jpg" alt="<%= p.getProductName() %>">
                        <p class="category-label"><%= categoryMap.get(p.getCategoryId()) %></p>
                        <p class="product-name"><%= p.getProductName() %></p>
                        <p class="price">Giá: đang cập nhật</p>
                    </div>
            <%  }
               } else { %>
                <p>Không có sản phẩm mới.</p>
            <% } %>
        </div>
    </div>
</div>

</body>
</html>
