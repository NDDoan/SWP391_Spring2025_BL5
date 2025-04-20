<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Entity.Product" %>
<%
    List<Product> newProducts = (List<Product>) request.getAttribute("newProducts");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Electro - Home</title>
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
    </style>
</head>
<body>

<!-- Top bar -->
<div class="top-bar">
    <div>
        <span>+021-95-51-84</span> | <span>email@email.com</span> | <span>1734 Stonecoal Road</span>
    </div>
    <div>
        USD | <a href="#" style="color: white;">My Account</a>
    </div>
</div>

<!-- Header -->
<header>
    <h1>Electro<span>.</span></h1>
    <div class="search-bar">
        <input type="text" placeholder="Search here...">
        <button>Search</button>
    </div>
</header>

<!-- Navigation -->
<nav>
    <a href="#">Home</a>
    <a href="#">Hot Deals</a>
    <a href="#">Categories</a>
    <a href="#">Laptops</a>
    <a href="#">Smartphones</a>
    <a href="#">Cameras</a>
    <a href="#">Accessories</a>
</nav>

<!-- Banner -->
<div class="banner">
    <img src="https://images.unsplash.com/photo-1517336714731-489689fd1ca8" alt="Laptop Collection">
    <img src="https://ares.shiftdelete.net/2023/10/iphone-16-pro-pro-max-buyuk-ekran.jpg" alt="Iphone">
    <img src="https://pngimg.com/uploads/photo_camera/photo_camera_PNG101601.png" alt="Cameras Collection">
</div>

<!-- New Products -->
<h2 class="section-title">NEW PRODUCTS</h2>
<div class="products">
    <% if (newProducts != null && !newProducts.isEmpty()) {
        for (Product p : newProducts) { %>
            <div class="product-card">
                <img src="<%= p.getImage() %>" alt="<%= p.getName() %>">
                <p style="font-size: 13px;">Category</p>
                <h4><%= p.getName() %></h4>
                <p class="price">$<%= p.getPrice() %></p>
                <p class="stars">★★★★★</p>
            </div>
    <%  }
       } else { %>
        <p style="grid-column: 1 / -1; text-align: center;">No products found.</p>
    <% } %>
</div>

<!-- Footer -->
<footer>
    © 2025 Electro. All rights reserved.
</footer>

</body>
</html>
