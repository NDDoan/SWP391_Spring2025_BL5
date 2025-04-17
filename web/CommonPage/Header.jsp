<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Header</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        .header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background-color: #1e3c72;
            color: white;
            padding: 12px 25px;
            flex-wrap: wrap;
            box-shadow: 0 3px 6px rgba(0, 0, 0, 0.15);
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
            color: #f8d210;
        }

        .search-bar {
            flex: 1;
            margin: 10px 20px;
            display: flex;
        }

        .search-bar input {
            flex: 1;
            padding: 10px;
            border: none;
            border-radius: 5px 0 0 5px;
            font-size: 15px;
        }

        .search-bar button {
            background-color: #f8d210;
            border: none;
            padding: 10px 16px;
            border-radius: 0 5px 5px 0;
            cursor: pointer;
            font-weight: bold;
            transition: 0.3s;
        }

        .search-bar button:hover {
            background-color: #ffd100;
        }

        .nav-links {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            padding: 8px 12px;
            border-radius: 5px;
            transition: 0.3s;
            background-color: transparent;
        }

        .nav-links a:hover {
            background-color: rgba(255, 255, 255, 0.2);
        }

        .cart-btn {
            position: relative;
            display: inline-block;
            background-color: #28a745;
            padding: 8px 14px;
            border-radius: 6px;
            text-decoration: none;
            color: white;
            font-weight: 600;
        }

        .cart-btn:hover {
            background-color: #218838;
        }

        .cart-count {
            background: red;
            color: white;
            font-size: 13px;
            font-weight: bold;
            padding: 2px 7px;
            border-radius: 50%;
            position: absolute;
            top: -6px;
            right: -8px;
        }

        @media screen and (max-width: 768px) {
            .header {
                flex-direction: column;
                align-items: flex-start;
            }

            .search-bar {
                margin: 10px 0;
                width: 100%;
            }

            .nav-links {
                width: 100%;
                justify-content: space-between;
                flex-wrap: wrap;
            }
        }
    </style>
</head>
<body>
<div class="header">
    <!-- LOGO -->
    <div class="logo">Electro Mart</div>

    <!-- SEARCH -->
    <div class="search-bar">
        <input type="text" placeholder="Search for products...">
        <button><i class="fas fa-search"></i></button>
    </div>

    <!-- NAVIGATION -->
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/cartdetailcontroller" class="cart-btn">
            <i class="fas fa-shopping-cart"></i> Cart
            <span class="cart-count">
                <%= session.getAttribute("cartCount") != null ? session.getAttribute("cartCount") : 0 %>
            </span>
        </a>
        <a href="${pageContext.request.contextPath}/login.jsp"><i class="fas fa-user"></i> Login</a>
        <a href="#"><i class="fas fa-headset"></i> Hotline: 1900 9999</a>
    </div>
</div>
</body>
</html>
