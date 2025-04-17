<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Entity.Shipping" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>${shipping != null ? "Cập nhật thông tin giao hàng" : "Thêm giao hàng mới"}</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f4f6f9;
            }

            .sidebar {
                position: fixed;
                top: 80px;
                left: 0;
                bottom: 0;
                width: 250px;
                background-color: #ffffff;
                border-right: 1px solid #dee2e6;
                padding: 20px;
                overflow-y: auto;
                z-index: 100;
            }

            .dashboard-header {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                height: 80px;
                background-color: #ffffff;
                border-bottom: 1px solid #dee2e6;
                display: flex;
                align-items: center;
                padding: 0 20px;
                z-index: 101;
            }

            .content-container {
                margin-left: 250px;
                padding: 100px 20px 40px 20px;
            }

            form {
                max-width: 600px;
                margin: 0 auto;
                background-color: #fff;
                padding: 25px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }

            label {
                font-weight: 500;
                margin-top: 10px;
            }

            input[type="text"],
            input[type="date"],
            select,
            textarea {
                width: 100%;
                padding: 8px;
                margin-top: 5px;
                border-radius: 5px;
                border: 1px solid #ccc;
            }

            input[type="submit"] {
                margin-top: 20px;
                padding: 10px;
                background-color: #3498db;
                color: white;
                border: none;
                border-radius: 6px;
                font-weight: bold;
                font-size: 16px;
                cursor: pointer;
            }

            input[type="submit"]:hover {
                background-color: #2980b9;
            }

            a.back-link {
                display: inline-block;
                margin-top: 15px;
                text-decoration: none;
                color: #2c3e50;
            }

            a.back-link:hover {
                text-decoration: underline;
            }

            @media (max-width: 768px) {
                .sidebar {
                    position: static;
                    width: 100%;
                    height: auto;
                    border-right: none;
                }

                .dashboard-header {
                    position: static;
                    height: auto;
                }

                .content-container {
                    margin-left: 0;
                    padding-top: 20px;
                }
            }
        </style>
    </head>
    <body>

        <!-- Sidebar -->
        <div class="sidebar">
            <jsp:include page="/AdminPage/dashboard-sidebar.jsp"/>
        </div>

        <!-- Header -->
        <div class="dashboard-header">
            <jsp:include page="/AdminPage/dashboard-header.jsp"/>
        </div>

        <!-- Main Content -->
        <div class="content-container">
            <form action="shipping" method="post">
                <h2 class="text-center mb-4">${shipping != null ? "Cập nhật thông tin giao hàng" : "Thêm giao hàng mới"}</h2>

                <c:if test="${shipping != null}">
                    <input type="hidden" name="id" value="${shipping.id}" />
                </c:if>

                <label for="orderId">Order ID:</label>
                <input type="text" name="orderId" id="orderId" value="${shipping != null ? shipping.orderId : ''}" required />

                <label for="shippingAddress">Địa chỉ giao hàng:</label>
                <input type="text" name="shippingAddress" id="shippingAddress" value="${shipping != null ? shipping.shippingAddress : ''}" required />

                <label for="shippingStatus">Trạng thái giao hàng:</label>
                <select name="shippingStatus" id="shippingStatus" required>
                    <option value="">-- Chọn trạng thái --</option>
                    <option value="Pending" ${shipping != null && shipping.shippingStatus == 'Pending' ? 'selected' : ''}>Pending</option>
                    <option value="Shipped" ${shipping != null && shipping.shippingStatus == 'Shipped' ? 'selected' : ''}>Shipped</option>
                    <option value="Delivered" ${shipping != null && shipping.shippingStatus == 'Delivered' ? 'selected' : ''}>Delivered</option>
                    <option value="Canceled" ${shipping != null && shipping.shippingStatus == 'Canceled' ? 'selected' : ''}>Canceled</option>
                    <option value="Returned" ${shipping != null && shipping.shippingStatus == 'Returned' ? 'selected' : ''}>Returned</option>
                </select>

                <label for="trackingNumber">Tracking Number:</label>
                <input type="text" name="trackingNumber" id="trackingNumber" value="${shipping != null ? shipping.trackingNumber : ''}" />

                <label for="shippingDate">Ngày giao hàng:</label>
                <input type="date" name="shippingDate" id="shippingDate" value="${shipping != null ? shipping.shippingDate : ''}" required />

                <label for="estimatedDelivery">Ngày dự kiến giao:</label>
                <input type="date" name="estimatedDelivery" id="estimatedDelivery" value="${shipping != null ? shipping.estimatedDelivery : ''}" required />

                <label for="deliveryNotes">Ghi chú:</label>
                <textarea name="deliveryNotes" id="deliveryNotes" rows="3">${shipping != null ? shipping.deliveryNotes : ''}</textarea>

                <input type="submit" value="Lưu" />
                <a href="shipping" class="back-link">← Quay lại danh sách</a>
            </form>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
