<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="Entity.Shipping" %>
<%@ page import="Entity.User" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết giao hàng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            body {
                background-color: #f4f6f9;
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
                z-index: 101; /* <-- GOOD */
            }


            .content-container {
                margin-left: 250px;
                padding: 100px 20px 40px 20px;
            }

            .btn-back {
                background-color: #28a745;
                color: white;
            }

            .btn-back:hover {
                background-color: #218838;
            }

            .table th, .table td {
                vertical-align: middle;
            }
            .sidebar {
                margin-top: 75px;
                position: fixed;
                top: 80px; /* Start below the header */
                left: 0;
                bottom: 0;
                width: 250px;
                background-color: #f8f9fa;
                box-shadow: 2px 0 5px rgba(0,0,0,0.1);
                z-index: 99; /* Below header */
                height: calc(100% - 80px); /* Adjust height to account for header */
                overflow-y: auto; /* Scroll if content overflows */
            }
            @media (max-width: 768px) {
                .sidebar {
                    width: 100%;
                    height: auto;
                    position: relative;
                }

                .content-container {
                    margin-left: 0;
                    padding: 100px 10px 40px 10px;
                }
            }

        </style>
    </head>
    <body>

        <!-- Header -->
        <!-- Header -->
        <div class="dashboard-header">
            <jsp:include page="/AdminPage/dashboard-header.jsp"/>
        </div>

        <!-- Sidebar -->
        <div class="sidebar">
            <jsp:include page="/AdminPage/dashboard-sidebar.jsp"/>
        </div>

        <!-- Main Content -->
        <div class="content-container">
            <div class="container bg-white rounded shadow p-4">
                <h3 class="mb-4">Chi tiết giao hàng</h3>

                <!-- Shipping Details -->
                <c:if test="${not empty shippingDetail}">
                    <table class="table table-bordered">
                        <tr>
                            <th>ID</th>
                            <td>${shippingDetail.id}</td>
                        </tr>
                        <tr>
                            <th>Order ID</th>
                            <td>${shippingDetail.orderId}</td>
                        </tr>
                        <tr>
                            <th>Địa chỉ giao hàng</th>
                            <td>${shippingDetail.shippingAddress}</td>
                        </tr>
                        <tr>
                            <th>Trạng thái</th>
                            <td>${shippingDetail.shippingStatus}</td>
                        </tr>
                        <tr>
                            <th>Tracking</th>
                            <td>${shippingDetail.trackingNumber}</td>
                        </tr>
                        <tr>
                            <th>Ngày giao</th>
                            <td>${shippingDetail.shippingDate}</td>
                        </tr>
                        <tr>
                            <th>Ngày dự kiến</th>
                            <td>${shippingDetail.estimatedDelivery}</td>
                        </tr>
                        <tr>
                            <th>Ghi chú</th>
                            <td>${shippingDetail.deliveryNotes}</td>
                        </tr>
                        <tr>
                            <th>Cập nhật</th>
                            <td>${shippingDetail.updatedAt}</td>
                        </tr>
                        <tr>
                            <th>Tên shipper</th>
                            <td>${shipper.full_name}</td>
                        </tr>
                    </table>
                </c:if>

                <!-- Back Button -->
                <a href="shipping" class="btn btn-back">
                    <i class="fas fa-arrow-left"></i> Quay lại danh sách
                </a>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
