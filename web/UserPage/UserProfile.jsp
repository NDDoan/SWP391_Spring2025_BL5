<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile - Electro Mart</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Font + Icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #1e3c72, #2a5298);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* HEADER */
        .header {
            background-color: #1e3c72;
            color: white;
            padding: 15px 25px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .header-container {
            max-width: 1200px;
            margin: auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
        }

        .logo {
            font-size: 24px;
            font-weight: 600;
            color: #a9d6ff;
        }

        .nav-links, .user-actions {
            display: flex;
            gap: 20px;
            align-items: center;
        }

        .nav-links a, .user-actions a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s;
        }

        .nav-links a:hover, .user-actions a:hover {
            color: #a9d6ff;
        }

        @media screen and (max-width: 768px) {
            .header-container {
                flex-direction: column;
                align-items: flex-start;
            }

            .nav-links, .user-actions {
                margin-top: 10px;
                flex-direction: column;
                width: 100%;
            }

            .nav-links a, .user-actions a {
                padding: 8px 0;
            }
        }

        /* PROFILE CONTENT */
        .profile-container {
            background-color: #ffffff;
            padding: 40px 30px;
            border-radius: 16px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
            max-width: 500px;
            width: 100%;
            margin: 60px auto;
            animation: fadeIn 0.6s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .profile-container h1 {
            color: #1e3c72;
            font-size: 26px;
            font-weight: 600;
            margin-bottom: 20px;
            text-align: center;
        }

        .profile-container img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #1e3c72;
            margin: 10px auto 20px auto;
            display: block;
        }

        .input-group {
            margin-bottom: 20px;
        }

        .input-group label {
            font-weight: 600;
            color: #333;
            margin-bottom: 6px;
            display: block;
        }

        .input-group input, .input-group select {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
            background-color: #f9f9f9;
            transition: border-color 0.3s ease;
        }

        .input-group input:focus, .input-group select:focus {
            border-color: #1e3c72;
            outline: none;
        }

        input[type="submit"], .btn {
            background-color: #1e3c72;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            width: 100%;
            cursor: pointer;
            margin-top: 10px;
            transition: background-color 0.3s ease;
        }

        .btn:hover, input[type="submit"]:hover {
            background-color: #0f2a5f;
        }

        .btn-orange { background-color: #ff6600; }
        .btn-orange:hover { background-color: #e65c00; }

        .btn-green { background-color: #28a745; }
        .btn-green:hover { background-color: #218838; }

        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
            font-size: 14px;
            display: flex;
            align-items: center;
        }

        .alert-info {
            background-color: #d1ecf1;
            color: #0c5460;
            border-left: 6px solid #17a2b8;
        }

        .alert i {
            margin-right: 10px;
        }

        /* FOOTER */
        .footer {
            background-color: #1e3c72;
            color: #fff;
            padding: 40px 20px;
            font-size: 14px;
            margin-top: auto;
        }

        .footer-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            max-width: 1100px;
            margin: 0 auto;
            gap: 30px;
        }

        .footer-section {
            flex: 1;
            min-width: 250px;
        }

        .footer-section h3 {
            font-size: 18px;
            margin-bottom: 15px;
            color: #a9d6ff;
        }

        .footer-section p {
            margin: 8px 0;
            line-height: 1.5;
        }

        .footer-section i {
            margin-right: 8px;
            color: #a9d6ff;
        }

        .footer-section a {
            color: #fff;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer-section a:hover {
            color: #a9d6ff;
        }
    </style>
</head>
<body>

<!-- HEADER -->
<header class="header">
    <div class="header-container">
        <div class="logo">Electro Mart</div>
        <nav class="nav-links">
            <a href="home.jsp">Home</a>
            <a href="products.jsp">Products</a>
            <a href="about.jsp">About</a>
            <a href="contact.jsp">Contact</a>
        </nav>
        <div class="user-actions">
            <a href="profile.jsp"><i class="fas fa-user-circle"></i> Profile</a>
            <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </div>
</header>

<!-- PROFILE CONTENT -->
<div class="profile-container">

    <h1>User Profile</h1>

    <!-- Avatar -->
    <img src="${user.avatar_url != null ? user.avatar_url : 'default-avatar.png'}" alt="Avatar">

    <!-- Alert -->
    <%
        String updateMessage = (String) session.getAttribute("updateMessage");
        if (updateMessage != null) {
    %>
    <div class="alert alert-info">
        <i class="fas fa-info-circle"></i>
        <%= updateMessage %>
        <button onclick="this.parentElement.style.display='none'" style="margin-left:auto;background:none;border:none;color:#0c5460;cursor:pointer;">
            <i class="fas fa-times-circle"></i>
        </button>
    </div>
    <script>
        setTimeout(() => {
            document.querySelector('.alert').style.display = 'none';
        }, 4000);
    </script>
    <%
        session.removeAttribute("updateMessage");
        }
    %>

    <!-- Update Avatar -->
    <form action="${pageContext.request.contextPath}/uploadavatarcontroller" method="post" enctype="multipart/form-data">
        <div class="input-group">
            <label>Update Avatar</label>
            <input type="file" name="avatar" accept="image/*" required>
        </div>
        <button type="submit" class="btn btn-orange">Update Avatar</button>
    </form>

    <!-- Change Password -->
    <button type="button" class="btn btn-green"
            onclick="window.location.href = '${pageContext.request.contextPath}/UserPage/ChangePassword.jsp'">
        Change Password
    </button>

    <!-- User Info -->
    <form action="${pageContext.request.contextPath}/userprofile" method="post">
        <div class="input-group">
            <label>Full Name</label>
            <input type="text" name="full_name" value="${user.full_name}" required>
        </div>
        <div class="input-group">
            <label>Gender</label>
            <select name="gender" required>
                <option value="Male" ${user.gender == "Male" ? "selected" : ""}>Male</option>
                <option value="Female" ${user.gender == "Female" ? "selected" : ""}>Female</option>
                <option value="Other" ${user.gender == "Other" ? "selected" : ""}>Other</option>
            </select>
        </div>
        <div class="input-group">
            <label>Email</label>
            <input type="email" name="email" value="${user.email}" readonly style="background-color: #e9ecef; cursor: not-allowed;">
        </div>
        <div class="input-group">
            <label>Phone Number</label>
            <input type="text" name="phone_number" value="${user.phone_number}" required>
        </div>
        <div class="input-group">
            <label>Address</label>
            <input type="text" name="address" value="${user.address}" required>
        </div>
        <input type="submit" value="Save Changes">
    </form>
</div>

<!-- FOOTER -->
<footer class="footer">
    <div class="footer-container">
        <div class="footer-section">
            <h3>Contact</h3>
            <p><i class="fas fa-envelope"></i> contact@electromart.com</p>
            <p><i class="fas fa-phone-alt"></i> +84 123 456 789</p>
            <p><i class="fas fa-map-marker-alt"></i> 123 Tech Street, Hanoi</p>
        </div>
        <div class="footer-section">
            <h3>Customer Support</h3>
            <p><a href="#">FAQs</a></p>
            <p><a href="#">Return Policy</a></p>
            <p><a href="#">Shipping Info</a></p>
        </div>
        <div class="footer-section">
            <h3>About Us</h3>
            <p><strong>Nhóm 2 - SWP391.BL5</strong></p>
            <p>&copy; 2025 Electro Mart.</p>
        </div>
    </div>
</footer>

</body>
</html>
