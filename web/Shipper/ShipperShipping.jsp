<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, Entity.Shipping" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <style>
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                font-family: Arial, sans-serif;
            }

            th, td {
                border: 1px solid #ccc;
                padding: 10px;
                text-align: center;
            }

            th {
                background-color: #f4f4f4;
            }

            form {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 8px;
            }

            select, input[type="submit"] {
                padding: 5px;
                border-radius: 5px;
                border: 1px solid #999;
            }

            input[type="submit"] {
                background-color: #28a745;
                color: white;
                cursor: pointer;
            }

            input[type="submit"]:hover {
                background-color: #218838;
            }
        </style>
    </head>
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
                        <form action="updateShippingStatus" method="post">
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
</html>