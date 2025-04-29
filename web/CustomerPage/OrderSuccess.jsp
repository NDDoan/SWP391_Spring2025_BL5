<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Entity.CartItem" %> <%-- nhớ chữ Entity viết hoa giống package --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết giỏ hàng</title>
        <!-- Bootstrap CSS -->
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
        <!-- Header -->
        <jsp:include page="/CommonPage/Header.jsp" />

        <!-- Main Content -->
        <div class="main-content container my-5" style="min-height: 500px;">
            <h2 class="text-center mb-4">Đặt hàng</h2>


            <form action="${pageContext.request.contextPath}/OrderController" method="post">
                <div class="alert alert-info mt-4">
                    <strong>Địa chỉ giao hàng:</strong>
                    <input type="text" class="form-control mt-2" name="shippingAddress" value="${shippingAddress}" placeholder="Nhập địa chỉ giao hàng">
                </div>
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
                                            <td><fmt:formatNumber value="${item.price}" type="number" groupingUsed="true"/> đ</td>
                                            <td>
                                                <input type="number" name="quantity_${item.cartItemId}" value="${item.quantity}" min="1" class="form-control w-50 mx-auto">
                                            </td>
                                            <td><fmt:formatNumber value="${item.subtotal}" type="number" groupingUsed="true"/> đ</td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/delete-cart-item?cartItemId=${item.cartItemId}" class="btn btn-danger btn-sm">Xóa</a>
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
                        <fmt:formatNumber value="${totalOrderPrice}" type="number" groupingUsed="true"/> đ
                    </h4>
                    <div>
                        <button type="submit" name="action" value="update" class="btn btn-success">Cập nhật giỏ hàng</button>
                        <c:if test="${not empty cartItems}">
                            <button type="submit" name="action" value="order" class="btn btn-primary btn-lg">Đặt hàng</button>
                        </c:if>
                        
                    </div>
                  
                </div>
            </form>



            <!-- Footer -->
            <jsp:include page="/CommonPage/Footer.jsp" />

            <!-- Bootstrap Bundle JS -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
