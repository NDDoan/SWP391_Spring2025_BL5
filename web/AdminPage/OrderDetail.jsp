<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết đơn hàng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            /* Reset */
            * {
                box-sizing: border-box;
            }

            /* Sidebar */
            .sidebar {
                position: fixed;
                margin-top: 70px; /* né header */
                margin-bottom: 70px;
                left: 0;
                width: 220px;
                height: calc(100% - 70px); /* tính trừ header */
                background-color: #343a40;
                padding-top: 20px;
                overflow-y: auto;
            }

            /* Header */
            #header {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 70px;
                background-color: #fff;
                z-index: 9999;
                display: flex;
                align-items: center;
                padding: 0 20px;
                box-shadow: 0px 2px 5px rgba(0,0,0,0.1);
            }
            .dashboard-footer {
                position: fixed;
                bottom: 0;
                left: 0;
                width: 100%; /* Quan trọng */
                height: 80px;
                background-color: #ffffff;
                border-top: 1px solid #dee2e6;
                z-index: 1000;
            }

            /* Body padding để né sidebar và header */
            body {
                margin: 0;
                padding-top: 70px; /* Né header */
                padding-bottom:  70px;
                padding-left: 250px; /* Né sidebar */
                background-color: #f8f9fa;
                min-height: 100vh;
            }

            /* Container nội dung */
            .main-content {
                padding: 20px;
            }

            /* Table header đen */
            .thead-black {
                background-color: #000;
                color: #fff;
            }
        </style>
    </head>
    <body>

        <div class="sidebar">
            <jsp:include page="../AdminPage/dashboard-sidebar.jsp"/>
        </div>

        <div id="header">
            <jsp:include page="../AdminPage/dashboard-header.jsp"/>
        </div>

        <div class="main-content">
            <div class="container bg-white p-4 shadow-sm rounded">
                <h2 class="text-center mb-4">Chi Tiết Đơn Hàng</h2>

                <div class="mb-4">
                    <h5>Thông tin đơn:</h5>
                    <p><strong>Mã đơn:</strong> ${order.orderId}</p>
                    <p><strong>Ngày đặt:</strong> <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy" /></p>
                    <p><strong>Trạng thái:</strong> ${order.status}</p>
                    <p><strong>Tổng tiền:</strong> <fmt:formatNumber value="${order.totalCost}" type="currency" currencySymbol="₫"/></p>
                </div>

                <div class="table-responsive">
                    <h5>Sản phẩm trong đơn:</h5>
                    <table class="table table-bordered">
                        <thead class="table-dark">
                            <tr>
                                <th>#</th>
                                <th>Tên sản phẩm</th>
                                <th>Số lượng</th>
                                <th>Giá đơn vị</th>
                                <th>Thành tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${orderItems}" varStatus="loop">
                                <tr>
                                    <td>${loop.index + 1}</td>
                                    <td>${item.productName}</td>
                                    <td>${item.quantity}</td>
                                    <td><fmt:formatNumber value="${item.price}" type="currency" currencySymbol="₫"/></td>
                                    <td><fmt:formatNumber value="${item.price * item.quantity}" type="currency" currencySymbol="₫"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="mt-4">
                    <a href="${pageContext.request.contextPath}/OrderList" class="btn btn-secondary">Quay lại</a>
                </div>
            </div>
        </div>
        <div class="dashboard-footer">
            <jsp:include page="dashboard-footer.jsp"/>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
