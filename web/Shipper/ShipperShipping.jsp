<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, Entity.Shipping" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Quản lý giao hàng</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        .main-layout {
            display: flex;
        }

        .dashboard-header, .sidebar {
            background-color: #fff;
        }
        

        table {
            width: 95%;
            margin: 30px auto;
            border-collapse: collapse;
            background-color: #ffffff;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        th {
            background-color: #007bff;
            color: white;
            font-weight: bold;
            padding: 12px;
        }

        td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            vertical-align: middle;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        select {
            padding: 6px 10px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }

        input[type="submit"] {
            padding: 6px 12px;
            margin-left: 10px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s ease;
        }

        input[type="submit"]:hover {
            background-color: #218838;
        }

        form {
            display: flex;
            justify-content: center;
            align-items: center;
        }
    </style>
</head>
<body>
    <div class="dashboard-header">
        <jsp:include page="Shipper-Header.jsp" />
    </div>

    <div class="main-layout">
        <!-- Sidebar -->
        <div class="sidebar">
            <jsp:include page="Shipper-Sidebar.jsp" />
        </div>

        <!-- Table content -->
        <div style="width: 100%; padding: 20px;">
            <h2 style="text-align: center;">Danh sách đơn hàng giao hàng</h2>
            <table>
                <thead>
                    <tr>
                        <th>Mã đơn hàng</th>
                        <th>Địa chỉ giao</th>
                        <th>Trạng thái</th>
                        <th>Ngày giao</th>
                        <th>Ngày dự kiến</th>
                        <th>Cập nhật trạng thái</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="s" items="${shipList}">
                        <tr>
                            <td>${s.orderId}</td>
                            <td>${s.shippingAddress}</td>
                            <td>${s.shippingStatus}</td>
                            <td>${s.shippingDate}</td>
                            <td>${s.estimatedDelivery}</td>
                            <td>
                                <form action="shipper" method="post">
                                    <input type="hidden" name="action" value="updateShippingStatus" />
                                    <input type="hidden" name="id" value="${s.id}" />
                                    <select name="status">
                                        <option value="Shipped" ${s.shippingStatus == 'Shipped' ? 'selected' : ''}>Shipped</option>
                                        <option value="Delivered" ${s.shippingStatus == 'Delivered' ? 'selected' : ''}>Delivered</option>
                                        <option value="Returned" ${s.shippingStatus == 'Returned' ? 'selected' : ''}>Returned</option>
                                    </select>
                                    <input type="submit" value="Cập nhật" />
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
