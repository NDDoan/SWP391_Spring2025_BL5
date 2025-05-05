<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Entity.CartItem" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết giỏ hàng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            html, body {
                height: 100%;
                margin: 0;
                display: flex;
                flex-direction: column;
            }
            .main-content {
                flex: 1;
                overflow-y: auto;
                padding: 20px;
                background-color: #f9f9f9;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/CommonPage/Header.jsp" />
        <div class="main-content container my-5" style="min-height: 500px;">
            <h2 class="text-center mb-4">Chi tiết giỏ hàng</h2>
            <form action="${pageContext.request.contextPath}/update-cart" method="post">
                <div class="table-responsive">
                    <table class="table table-bordered align-middle text-center">
                        <thead class="table-dark">
                            <tr>
                                <th>Sản phẩm</th>
                                <th>Giá</th>
                                <th>Số lượng</th>
                                <th>Thành tiền</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty cartItems}">
                                    <c:forEach var="item" items="${cartItems}">
                                        <tr>
                                            <td>${item.productName}</td>
                                            <td>
                                                <fmt:formatNumber value="${item.price}"
                                                                  type="number"
                                                                  groupingUsed="true"/> đ
                                            </td>
                                            <td>
                                                <input type="number"
                                                       name="quantity_${item.cartItemId}"
                                                       value="${item.quantity}"
                                                       min="1"
                                                       class="form-control w-50 mx-auto"/>
                                            </td>
                                            <td>
                                                <fmt:formatNumber value="${item.subtotal}"
                                                                  type="number"
                                                                  groupingUsed="true"/> đ
                                            </td>
                                            <td>
                                                <!-- XÓA dùng <a> để gọi DeleteCartItemController -->
                                                <a href="${pageContext.request.contextPath}/delete-cart-item?cartItemId=${item.cartItemId}"
                                                   class="btn btn-danger btn-sm"
                                                   onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?');">
                                                    Xóa
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="5" class="text-center">Giỏ hàng trống</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
                <div class="d-flex justify-content-between align-items-center my-4">
                    <h4 class="text-primary">
                        Tổng cộng:
                        <fmt:formatNumber value="${totalOrderPrice}"
                                          type="number"
                                          groupingUsed="true"/> đ
                    </h4>
                    <button type="submit" class="btn btn-success">
                        Cập nhật giỏ hàng
                    </button>
                </div>
            </form>

            <c:if test="${not empty cartItems}">
                <div class="text-end">
                    <a href="${pageContext.request.contextPath}/HomePageController"
                       class="btn btn-secondary btn-lg me-2">
                        Tiếp tục mua hàng
                    </a>
<!--                    <form action="${pageContext.request.contextPath}/OrderController"
                          method="get" style="display:inline;">
                        <button type="submit" class="btn btn-primary btn-lg">
                            Đặt hàng
                        </button>
                    </form>-->
                    <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary btn-lg">
                        Thanh toán
                    </a>

                </div>
            </c:if>
        </div>
        <jsp:include page="/CommonPage/Footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>