<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<h2>Thông tin giao hàng</h2>

<table border="1" cellpadding="10">
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
                <td>${s.orderId}</td>
                <td>${s.shippingAddress}</td>
                <td>${s.shippingStatus}</td>
                <td>${s.trackingNumber}</td>
                <td>${s.shippingDate}</td>
                <td>${s.estimatedDelivery}</td>
                <td>${s.deliveryNotes}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
