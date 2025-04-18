<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thông tin giao hàng</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f7f9;
            margin: 0;
            padding: 20px;
        }

        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        th, td {
            padding: 12px 15px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #3498db;
            color: white;
            text-transform: uppercase;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        @media screen and (max-width: 768px) {
            table, thead, tbody, th, td, tr {
                display: block;
            }

            thead tr {
                display: none;
            }

            tbody tr {
                margin-bottom: 15px;
                border: 1px solid #ddd;
                border-radius: 5px;
                background-color: #fff;
                padding: 10px;
            }

            td {
                text-align: left;
                padding-left: 50%;
                position: relative;
            }

            td::before {
                content: attr(data-label);
                position: absolute;
                left: 15px;
                width: 45%;
                padding-right: 10px;
                font-weight: bold;
                color: #333;
            }
        }
    </style>
</head>
<body>

<h2>Thông tin giao hàng</h2>

<table>
    <thead>
        <tr>
            <th>Mã đơn hàng</th>
            <th>Địa chỉ giao hàng</th>
            <th>Trạng thái</th>
            <th>Mã vận đơn</th>
            <th>Ngày giao</th>
            <th>Ngày dự kiến</th>
            <th>Ghi chú</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="s" items="${shippingList}">
            <tr>
                <td data-label="Mã đơn hàng">${s.orderId}</td>
                <td data-label="Địa chỉ giao hàng">${s.shippingAddress}</td>
                <td data-label="Trạng thái">${s.shippingStatus}</td>
                <td data-label="Mã vận đơn">${s.trackingNumber}</td>
                <td data-label="Ngày giao">${s.shippingDate}</td>
                <td data-label="Ngày dự kiến">${s.estimatedDelivery}</td>
                <td data-label="Ghi chú">${s.deliveryNotes}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>

</body>
</html>
