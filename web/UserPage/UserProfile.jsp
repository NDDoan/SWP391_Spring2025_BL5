<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ Sơ Người Dùng - Electro Mart</title>
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
    </style>
</head>
<body>

<!-- INCLUDE HEADER -->
<jsp:include page="/CommonPage/Header.jsp" />

<!-- PROFILE CONTENT -->
<div class="profile-container">

    <h1>Hồ Sơ Người Dùng</h1>

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
            <label>Cập nhật Avatar</label>
            <input type="file" name="avatar" accept="image/*" required>
        </div>
        <button type="submit" class="btn btn-orange">Cập nhật Avatar</button>
    </form>

    <!-- Change Password -->
    <button type="button" class="btn btn-green"
            onclick="window.location.href = '${pageContext.request.contextPath}/UserPage/ChangePassword.jsp'">
        Đổi mật khẩu
    </button>

    <!-- User Info -->
    <form action="${pageContext.request.contextPath}/userprofile" method="post">
        <div class="input-group">
            <label>Họ và tên</label>
            <input type="text" name="full_name" value="${user.full_name}" required>
        </div>
        <div class="input-group">
            <label>Giới tính</label>
            <select name="gender" required>
                <option value="Male" ${user.gender == "Male" ? "selected" : ""}>Nam</option>
                <option value="Female" ${user.gender == "Female" ? "selected" : ""}>Nữ</option>
                <option value="Other" ${user.gender == "Other" ? "selected" : ""}>Khác</option>
            </select>
        </div>
        <div class="input-group">
            <label>Email</label>
            <input type="email" name="email" value="${user.email}" readonly style="background-color: #e9ecef; cursor: not-allowed;">
        </div>
        <div class="input-group">
            <label>Số điện thoại</label>
            <input type="text" name="phone_number" value="${user.phone_number}" required>
        </div>
        <div class="input-group">
            <label>Địa chỉ</label>
            <input type="text" name="address" value="${user.address}" required>
        </div>
        <input type="submit" value="Lưu thay đổi">
    </form>
</div>

<!-- INCLUDE FOOTER -->
<jsp:include page="/CommonPage/Footer.jsp" />

</body>
</html>
