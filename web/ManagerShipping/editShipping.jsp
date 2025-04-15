<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Entity.Shipping" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
    <head>
        <title>Thông tin giao hàng</title>
        <style>
            form {
                width: 500px;
                margin: 20px auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 6px;
                background-color: #f9f9f9;
            }

            label {
                display: block;
                margin-top: 10px;
            }

            input[type="text"],
            input[type="date"],
            textarea {
                width: 100%;
                padding: 8px;
                margin-top: 5px;
            }

            input[type="submit"] {
                margin-top: 15px;
                padding: 8px 16px;
                background-color: #3498db;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            input[type="submit"]:hover {
                background-color: #2980b9;
            }

            a.back-link {
                display: block;
                text-align: center;
                margin-top: 10px;
                color: #333;
                text-decoration: none;
            }

            a.back-link:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>

        <form action="shipping" method="post">
            <h2>${shipping != null ? "Cập nhật thông tin giao hàng" : "Thêm giao hàng mới"}</h2>

            <c:if test="${shipping != null}">
                <input type="hidden" name="id" value="${shipping.id}" />
            </c:if>

            <label>Order ID:</label>
            <input type="text" name="orderId" value="${shipping != null ? shipping.orderId : ''}" required />

            <label>Địa chỉ giao hàng:</label>
            <input type="text" name="shippingAddress" value="${shipping != null ? shipping.shippingAddress : ''}" required />

            <label>Trạng thái giao hàng:</label>
            <select name="shippingStatus" required>
                <option value="">-- Chọn trạng thái --</option>
                <option value="Pending" ${shipping != null && shipping.shippingStatus == 'Pending' ? 'selected' : ''}>Pending</option>
                <option value="Shipped" ${shipping != null && shipping.shippingStatus == 'Shipped' ? 'selected' : ''}>Shipped</option>
                <option value="Delivered" ${shipping != null && shipping.shippingStatus == 'Delivered' ? 'selected' : ''}>Delivered</option>
                <option value="Canceled" ${shipping != null && shipping.shippingStatus == 'Canceled' ? 'selected' : ''}>Canceled</option>
                <option value="Returned" ${shipping != null && shipping.shippingStatus == 'Returned' ? 'selected' : ''}>Returned</option>
            </select>


            <label>Tracking Number:</label>
            <input type="text" name="trackingNumber" value="${shipping != null ? shipping.trackingNumber : ''}" />

            <label>Ngày giao hàng:</label>
            <input type="date" name="shippingDate" value="${shipping != null ? shipping.shippingDate : ''}" required />

            <label>Ngày dự kiến giao:</label>
            <input type="date" name="estimatedDelivery" value="${shipping != null ? shipping.estimatedDelivery : ''}" required />

            <label>Ghi chú:</label>
            <textarea name="deliveryNotes" rows="3">${shipping != null ? shipping.deliveryNotes : ''}</textarea>

            <input type="submit" value="Lưu" />
            <a href="shipping" class="back-link">← Quay lại danh sách</a>
        </form>

    </body>
</html>
