<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm đơn giao hàng mới</title>
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
    <div class="container bg-white rounded shadow p-4">
        <h3 class="text-center mb-4">Thêm đơn giao hàng mới</h3>

        <form action="shipping" method="post">
            <div class="mb-3">
                <label for="orderId" class="form-label">Mã đơn hàng:</label>
                <input type="number" class="form-control" name="orderId" id="orderId" required>
            </div>

            <div class="mb-3">
                <label for="shippingAddress" class="form-label">Địa chỉ:</label>
                <input type="text" class="form-control" name="shippingAddress" id="shippingAddress" required>
            </div>

            <div class="mb-3">
                <label for="shippingStatus" class="form-label">Trạng thái:</label>
                <select class="form-select" name="shippingStatus" id="shippingStatus" required>
                    <option value="Pending">Pending</option>
                    <option value="Shipped">Shipped</option>
                    <option value="Delivered">Delivered</option>
                    <option value="Canceled">Canceled</option>
                    <option value="Returned">Returned</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="trackingNumber" class="form-label">Mã tracking:</label>
                <input type="text" class="form-control" name="trackingNumber" id="trackingNumber">
            </div>

            <div class="mb-3">
                <label for="shippingDate" class="form-label">Ngày giao:</label>
                <input type="date" class="form-control" name="shippingDate" id="shippingDate">
            </div>

            <div class="mb-3">
                <label for="estimatedDelivery" class="form-label">Ngày dự kiến:</label>
                <input type="date" class="form-control" name="estimatedDelivery" id="estimatedDelivery">
            </div>

            <div class="mb-3">
                <label for="deliveryNotes" class="form-label">Ghi chú:</label>
                <textarea class="form-control" name="deliveryNotes" id="deliveryNotes" rows="4"></textarea>
            </div>

            <div class="d-flex justify-content-between">
                <a href="shipping" class="btn btn-secondary">⬅ Quay lại</a>
                <input type="submit" class="btn btn-primary" value="Tạo mới">
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
