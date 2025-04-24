<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Đơn Hàng</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #f8f9fc;
            --accent-color: #2e59d9;
            --text-color: #5a5c69;
            --card-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            --hover-shadow: 0 0.5rem 2rem 0 rgba(58, 59, 69, 0.25);
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f4f4f8;
            color: var(--text-color);
            min-height: 100vh;
            padding: 30px 0;
        }

        .container {
            background-color: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            animation: fadeIn 0.6s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 25px;
            text-align: center;
            border-bottom: 2px solid var(--primary-color);
        }

        .search-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding: 10px;
            background: #f8f8f8;
            border-radius: 5px;
        }

        .search-section input, .search-section select {
            padding: 8px;
            width: 20%;
        }

        .search-btn {
            background-color: #28a745;
            color: white;
            padding: 10px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .pagination {
            margin-top: 20px;
        }

        .pagination button {
            padding: 10px;
            background-color: orange;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }

        .detail-btn {
            background-color: #ff9800;
            color: white;
            padding: 8px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }

        button#applySettings {
            background: #28a745;
            color: white;
            border: none;
            padding: 10px;
            width: 100%;
            margin-top: 15px;
            border-radius: 5px;
            cursor: pointer;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
            width: 400px;
            text-align: center;
        }

        .customize-container {
            background: #286090;
            padding: 15px;
            border-radius: 5px;
            color: white;
        }

        .columns-container {
            margin-top: 10px;
        }

        .checkbox-group {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Quản Lý Đơn Hàng</h2>

        <!-- Search & Filter Section -->
        <form action="${pageContext.request.contextPath}/myordercontroller" method="GET" class="search-form">
            <div class="search-container">
                <!-- Search by Order ID -->
                <input type="text" name="orderId" placeholder="Nhập mã đơn hàng" value="${param.orderId}">
                <button type="submit" class="search-btn">Tìm kiếm theo mã</button>

                <!-- Filter by Order Status (Auto Submit) -->
                <select name="status" onchange="this.form.submit()">
                    <option value="">Trạng thái đơn hàng</option>
                    <c:forEach var="status" items="${orderStatuses}">
                        <option value="${status}" ${param.status == status ? 'selected' : ''}>${status}</option>
                    </c:forEach>
                </select>

                <!-- Search by Date Range -->
                <input type="date" name="startDate" value="${param.startDate}">
                <input type="date" name="endDate" value="${param.endDate}">
                <button type="submit" class="search-btn">Tìm kiếm theo ngày</button>
            </div>
        </form>

        <!-- Orders Table -->
        <table>
            <tr>
                <th>Id</th>
                <th>Ngày Đặt</th>
                <th>Tên Sản Phẩm</th>
                <th>Tổng Chi Phí</th>
                <th>Trạng Thái</th>
                <th>Hành Động</th>
            </tr>

            <c:choose>
                <c:when test="${empty orders}">
                    <tr>
                        <td colspan="6">Không tìm thấy đơn hàng</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td>${order.orderId}</td>
                            <td>${order.orderDate}</td>
                            <td>${order.productNames}</td>
                            <td>${order.totalCost}</td>
                            <td>${order.status}</td>
                            <td>
                                <a href="OrderDetailsServlet?orderId=${order.orderId}">
                                    <button class="detail-btn">Xem chi tiết</button>
                                </a>
                                <c:if test="${order.status eq 'Completed'}">
                                    <a href="CustomerSendFeedback?orderId=${order.orderId}">
                                        <button class="detail-btn" style="background-color: #4CAF50;">Phản hồi</button>
                                    </a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </table>

        <!-- Pagination -->
        <div class="pagination">
            <button>&lt;</button>
            <button>1</button>
            <button>2</button>
            <button>...</button>
            <button>&gt;</button>
        </div>

        <!-- Customize Button -->
        <button id="customizeTableBtn">Tùy chỉnh bảng</button>
    </div>

    <!-- Popup Customize Table -->
    <div id="customizeTableModal" class="modal">
        <div class="modal-content">
            <h2>Tùy chỉnh bảng</h2>
            <div class="customize-container">
                <label>Số dòng mỗi trang:</label>
                <input type="number" id="rowsPerTable" placeholder="Nhập số dòng mỗi trang">

                <div class="columns-container">
                    <label>Chọn cột:</label>
                    <div class="checkbox-group">
                        <label><input type="checkbox" checked> Cột A</label>
                        <label><input type="checkbox"> Cột B</label>
                        <label><input type="checkbox"> Cột C</label>
                        <label><input type="checkbox"> Cột ...</label>
                    </div>
                </div>

                <button id="applySettings">Áp dụng cài đặt</button>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const customizeBtn = document.getElementById("customizeTableBtn");
            const popup = document.getElementById("customizeTableModal");

            popup.style.display = "none";

            customizeBtn.addEventListener("click", function () {
                popup.style.display = "flex"; 
            });

            window.addEventListener("click", function (event) {
                if (event.target === popup) {
                    popup.style.display = "none";
                }
            });
        });
    </script>
</body>
</html>
