<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="entity.CartItem" %>

<%
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
    Double totalOrderPrice = (Double) request.getAttribute("totalOrderPrice");
%>

<!-- Header -->
<jsp:include page="../CommonPage/Header.jsp" />

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<main class="container my-5" style="padding-top: 100px; padding-bottom: 80px;">
    <h2 class="mb-4">Chi tiết giỏ hàng</h2>

    <form action="update-cart" method="post">
        <div class="table-responsive">
            <table class="table table-bordered table-striped align-middle">
                <thead class="table-dark text-center">
                    <tr>
                        <th>Sản phẩm</th>
                        <th>Giá</th>
                        <th>Số lượng</th>
                        <th>Thành tiền</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (cartItems != null && !cartItems.isEmpty()) {
                        for (CartItem item : cartItems) { %>
                    <tr>
                        <td><%= item.getProductName() %></td>
                        <td class="text-end"><%= String.format("%,.0f", item.getPrice()) %> đ</td>
                        <td class="text-center" style="width: 120px;">
                            <input type="number" min="1" name="quantity_<%= item.getCartItemId() %>" 
                                   value="<%= item.getQuantity() %>" class="form-control form-control-sm">
                        </td>
                        <td class="text-end"><%= String.format("%,.0f", item.getSubtotal()) %> đ</td>
                        <td class="text-center">
                            <a href="delete-cart-item?cartItemId=<%= item.getCartItemId() %>" 
                               class="btn btn-sm btn-danger">
                                Xóa
                            </a>
                        </td>
                    </tr>
                    <%  }
                      } else { %>
                    <tr>
                        <td colspan="5" class="text-center">Giỏ hàng trống</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <% if (cartItems != null && !cartItems.isEmpty()) { %>
        <div class="d-flex justify-content-between align-items-center mt-4">
            <h4>Tổng cộng: <%= String.format("%,.0f", totalOrderPrice) %> đ</h4>
            <div>
                <a href="home" class="btn btn-secondary me-2">Tiếp tục mua hàng</a>
                <button type="submit" class="btn btn-primary">Cập nhật giỏ hàng</button>
            </div>
        </div>
        <% } %>
    </form>
</main>

<!-- Footer -->
<jsp:include page="../CommonPage/Footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
