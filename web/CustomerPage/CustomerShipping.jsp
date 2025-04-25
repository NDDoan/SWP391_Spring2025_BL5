<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thông tin giao hàng</title>
        <style>
            html, body {
                height: 100%;
                margin: 0;
                padding: 0;
            }

            .wrapper {
                min-height: 100%;
                display: flex;
                flex-direction: column;
            }

            .container {
                flex: 1; /* chiếm hết chiều cao còn lại để đẩy footer xuống */
            }

            footer {
                background-color: #f1f1f1;
                text-align: center;
                padding: 15px 0;
                color: #555;
            }



            h2 {
                color: #333;
                text-align: center;
                margin-top: 30px;
                font-size: 28px;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }

            .search-form {
                display: flex;
                justify-content: center;
                align-items: center; /* <-- Thêm dòng này */
                gap: 10px; /* Khoảng cách giữa các phần tử */
                flex-wrap: wrap; /* Nếu màn hình nhỏ, các thành phần xuống dòng */
            }

            .search-form label {
                font-size: 16px;
                margin-right: 5px;
            }


            .search-form input[type="text"] {
                padding: 10px;
                width: 250px;
                margin-right: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 16px;
            }

            .search-form button {
                padding: 10px 15px;
                background-color: #3498db;
                color: white;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
            }

            .search-form button:hover {
                background-color: #2980b9;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                box-shadow: 0 2px 10px rgba(0,0,0,0.05);
                margin-top: 20px;
                border-radius: 8px;
                overflow: hidden;
            }

            th, td {
                padding: 15px;
                text-align: center;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: black;
                color: white;
                text-transform: uppercase;
            }

            tr:hover {
                background-color: #f1f1f1;
            }

            @media screen and (max-width: 768px) {
                table, thead, tbody, th, td, tr {
                    display: block;
                }

                thead tr {
                    display: none;
                }

                tbody tr {
                    margin-bottom: 15px;
                    border: 1px solid #ddd;
                    border-radius: 5px;
                    background-color: #fff;
                    padding: 10px;
                }

                td {
                    text-align: left;
                    padding-left: 50%;
                    position: relative;
                }

                td::before {
                    content: attr(data-label);
                    position: absolute;
                    left: 15px;
                    width: 45%;
                    padding-right: 10px;
                    font-weight: bold;
                    color: #333;
                }
            }
        </style>
    </head>
    <body>
        <div class="wrapper">
            <jsp:include page="../CommonPage/Header.jsp"/>
            <div class="container">
                <h2>Thông tin giao hàng</h2>

                <!-- Form tìm kiếm -->
                <form class="search-form" method="get" action="customershipping">
                    <label for="status">Trạng thái:</label>
                    <select name="status" id="status" class="form-select w-auto">
                        <option value="">-- Tất cả --</option>
                        <option value="Pending" ${statusFilter == 'Pending' ? 'selected' : ''}>Pending</option>
                        <option value="Shipped" ${statusFilter == 'Shipped' ? 'selected' : ''}>Shipped</option>
                        <option value="Delivered" ${statusFilter == 'Delivered' ? 'selected' : ''}>Delivered</option>
                        <option value="Canceled" ${statusFilter == 'Canceled' ? 'selected' : ''}>Canceled</option>
                        <option value="Returned" ${statusFilter == 'Returned' ? 'selected' : ''}>Returned</option>
                    </select>
                    <button type="submit">Tìm kiếm</button>
                </form>


                <!-- Bảng thông tin giao hàng -->
                <table>
                    <thead >
                        <tr>
                            <th>
                                Mã Đơn Hàng

                            </th>
                            <th>
                                <a href="customershipping?sortBy=shipping_address&sortDir=${ param.sortDir == 'asc' ? 'desc' : 'asc'}&page=${currentPage}&status=${param.status}">
                                    Địa chỉ giao hàng
                                    <c:choose>
                                        <c:when test="${param.sortBy == 'shipping_address' && param.sortDir == 'asc'}">
                                            <i class="fas fa-sort-up"></i>
                                        </c:when>
                                        <c:when test="${param.sortBy == 'shipping_address' && param.sortDir == 'desc'}">
                                            <i class="fas fa-sort-down"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-sort"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </a>
                            </th>
                            <th>Trạng thái</th>
                            <th>Mã vận đơn</th>
                            <th>
                                <a href="customershipping?sortBy=shipping_date&sortDir=${ param.sortDir == 'asc' ? 'desc' : 'asc'}&page=${currentPage}&status=${param.status}">
                                    Ngày giao
                                    <c:choose>
                                        <c:when test="${param.sortBy == 'shipping_date' && param.sortDir == 'asc'}">
                                            <i class="fas fa-sort-up"></i>
                                        </c:when>
                                        <c:when test="${param.sortBy == 'shipping_date' && param.sortDir == 'desc'}">
                                            <i class="fas fa-sort-down"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-sort"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </a>
                            </th>
                            <th>
                                <a href="customershipping?sortBy=estimated_delivery&sortDir=${param.sortDir == 'asc' ? 'desc' : 'asc'}&page=${currentPage}&status=${param.status}">
                                    Ngày dự kiến
                                    <c:choose>
                                        <c:when test="${param.sortBy == 'estimated_delivery' && param.sortDir == 'asc'}">
                                            <i class="fas fa-sort-up"></i>
                                        </c:when>
                                        <c:when test="${param.sortBy == 'estimated_delivery' && param.sortDir == 'desc'}">
                                            <i class="fas fa-sort-down"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-sort"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </a>
                            </th>
                            <th>Ghi chú</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="s" items="${shippingList}">
                            <tr>
                                <td data-label="Mã đơn hàng">${s.orderId}</td>
                                <td data-label="Địa chỉ giao hàng">${s.shippingAddress}</td>
                                <td data-label="Trạng thái">${s.shippingStatus}</td>
                                <td data-label="Mã vận đơn">${s.trackingNumber}</td>
                                <td data-label="Ngày giao">${s.shippingDate}</td>
                                <td data-label="Ngày dự kiến">${s.estimatedDelivery}</td>
                                <td data-label="Ghi chú">${s.deliveryNotes}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <!-- Phân trang -->
                <div style="text-align: center; margin-top: 20px;">
                    <c:if test="${totalPages > 1}">
                        <!-- Previous button -->
                        <c:choose>
                            <c:when test="${currentPage > 1}">
                                <a href="customershipping?page=${currentPage - 1}&status=${param.status}" style="margin: 0 5px;">Previous</a>
                            </c:when>
                            <c:otherwise>
                                <span style="margin: 0 5px; color: gray;">Previous</span>
                            </c:otherwise>
                        </c:choose>

                        <!-- Page number links -->
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <c:choose>
                                <c:when test="${i == currentPage}">
                                    <strong style="margin: 0 5px;">${i}</strong>
                                </c:when>
                                <c:otherwise>
                                    <a href="customershipping?page=${i}&status=${param.status}" style="margin: 0 5px;">${i}</a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                        <!-- Next button -->
                        <c:choose>
                            <c:when test="${currentPage < totalPages}">
                                <a href="customershipping?page=${currentPage + 1}&status=${param.status}" style="margin: 0 5px;">Next</a>
                            </c:when>
                            <c:otherwise>
                                <span style="margin: 0 5px; color: gray;">Next</span>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </div>
            </div>



            <jsp:include page="../CommonPage/Footer.jsp"/>
        </div>
    </body>
</html>
