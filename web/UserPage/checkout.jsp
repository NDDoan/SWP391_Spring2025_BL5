<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, Entity.CartItem" %>

<%
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
    double totalOrderPrice = (double) request.getAttribute("totalOrderPrice");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang Thanh Toán</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        html, body {
            height: 100%;
            margin: 0;
            display: flex;
            flex-direction: column;
            background-color: #f8f9fa;
        }
        .content-wrapper {
            flex: 1;
            padding: 30px 0;
        }
        .card {
            max-width: 700px;
            margin: 0 auto;
        }
        footer {
            margin-top: auto;
        }
    </style>
</head>
<body>
    <jsp:include page="/CommonPage/Header.jsp" />

    <div class="container content-wrapper">
        <div class="card shadow">
            <div class="card-header bg-primary text-white">
                <h3 class="mb-0">Xác nhận đơn hàng</h3>
            </div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/ordercontroller" method="post">
                    <input type="hidden" name="action" value="order">

                    <div class="mb-3">
                        <label for="shippingAddress" class="form-label">Địa chỉ giao hàng:</label>
                        <input type="text" class="form-control" id="shippingAddress" name="shippingAddress"
                               placeholder="Nhập địa chỉ giao hàng..." required>
                    </div>

                    <div class="mb-3">
                        <label for="paymentMethod" class="form-label">Phương thức thanh toán:</label>
                        <select class="form-select" id="paymentMethod" name="paymentMethod">
                            <option value="COD">Thanh toán khi nhận hàng (COD)</option>
                            <option value="BANK">Chuyển khoản ngân hàng</option>
                        </select>
                    </div>

                    <div class="mb-4">
                        <h5>Tổng tiền: <span class="text-danger fw-bold">
                            <%= String.format("%,.0f", totalOrderPrice) %> VND
                        </span></h5>
                    </div>

                    <div class="text-end">
                        <button type="submit" class="btn btn-success px-4">Xác nhận đặt hàng</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <jsp:include page="/CommonPage/Footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
