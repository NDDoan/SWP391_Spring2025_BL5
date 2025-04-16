<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, Entity.Shipping" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
    <head>
        <title>Shipping Management</title>
        <style>
            table {
                border-collapse: collapse;
                width: 100%;
                margin-top: 20px;
            }

            th, td {
                border: 1px solid #ccc;
                padding: 10px;
            }

            th {
                background-color: #f2f2f2;
            }

            a.button {
                padding: 5px 10px;
                background-color: #4CAF50;
                color: white;
                text-decoration: none;
                border-radius: 4px;
            }

            a.button:hover {
                background-color: #45a049;
            }

            .delete-btn {
                background-color: #e74c3c;
            }

            .delete-btn:hover {
                background-color: #c0392b;
            }

            .add-btn {
                margin-bottom: 15px;
                display: inline-block;
                background-color: #3498db;
            }

            .add-btn:hover {
                background-color: #2980b9;
            }
        </style>
    </head>
    <body>

        <h2>Danh sách đơn hàng đang giao</h2>

        <a href="shipping?action=create" class="button add-btn">+ Thêm giao hàng mới</a>
        <form method="get" action="shipping">
            <label for="status">Lọc theo trạng thái:</label>
            <select name="status" id="status">
                <option value="">-- Tất cả --</option>
                <option value="Pending" ${statusFilter == 'Pending' ? 'selected' : ''}>Pending</option>
                <option value="Shipped" ${statusFilter == 'Shipped' ? 'selected' : ''}>Shipped</option>
                <option value="Delivered" ${statusFilter == 'Delivered' ? 'selected' : ''}>Delivered</option>
                <option value="Canceled" ${statusFilter == 'Canceled' ? 'selected' : ''}>Canceled</option>
                <option value="Returned" ${statusFilter == 'Returned' ? 'selected' : ''}>Returned</option>
            </select>
            <input type="submit" value="Tìm kiếm" />
            <a href="shipping">Reset</a>
        </form>


        <table>
            <tr>
                <th>ID</th>
                <th>Order ID</th>
                <th>Địa chỉ giao hàng</th>
                <th>Trạng thái</th>
                <th>Tracking</th>
                <th>Ngày giao</th>
                <th>Ngày dự kiến</th>
                <th>Ghi chú</th>
                <th>Cập nhật</th>
                <th>Hành động</th>
            </tr>

            <c:forEach var="s" items="${shippingList}">
                <tr>
                    <td>${s.id}</td>
                    <td>${s.orderId}</td>
                    <td>${s.shippingAddress}</td>
                    <td>${s.shippingStatus}</td>
                    <td>${s.trackingNumber}</td>
                    <td>${s.shippingDate}</td>
                    <td>${s.estimatedDelivery}</td>
                    <td>${s.deliveryNotes}</td>
                    <td>${s.updatedAt}</td>
                    <td>
                        <a href="shipping?action=edit&id=${s.id}" class="button">Sửa</a>
                        <a href="shipping?action=delete&id=${s.id}" class="button delete-btn"
                           onclick="return confirm('Bạn có chắc chắn muốn xoá đơn này?');">Xoá</a>
                    </td>
                </tr>
            </c:forEach>
        </table>

    </body>
</html>
