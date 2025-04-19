<%-- 
    Document   : MarketingDashBoard
    Created on : Apr 15, 2025, 3:06:12 PM
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Manager Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f4f6f9;
                margin: 0;
                padding: 0;
                min-height: 100vh;
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
                z-index: 1000;
            }

            .main-layout {
                display: flex;
                flex-wrap: nowrap;
                margin-top: 80px;
                min-height: calc(100vh - 80px);
            }

            .sidebar {
                position: fixed;
                top: 80px;
                left: 0;
                width: 20%; /* Changed to percentage */
                background-color: #ffffff;
                border-right: 1px solid #dee2e6;
                padding: 20px;
                height: calc(100vh - 80px);
                overflow-y: auto;
                z-index: 999;
            }

            .content-container {
                margin-left: 20%; /* Match sidebar width */
                padding: 20px;
                background-color: #f4f6f9;
                flex: 1;
                min-height: calc(100vh - 80px);
                margin-bottom: 20px;
            }

            .card:hover {
                box-shadow: 0 0 10px rgba(0,0,0,0.15);
                transition: all 0.3s ease;
            }

            @media (max-width: 768px) {
                .main-layout {
                    flex-direction: column;
                }

                .sidebar {
                    position: relative;
                    top: 0;
                    width: 100%;
                    border-right: none;
                    border-bottom: 1px solid #dee2e6;
                    height: auto;
                }

                .content-container {
                    margin-left: 0;
                    padding-top: 20px;
                    margin-bottom: 20px;
                }
            }
        </style>
    </head>
    <body>

        <!-- Header -->
        <div class="dashboard-header">
            <jsp:include page="Shipper-Header.jsp"/>
        </div>

        <!-- Sidebar + Content -->
        <div class="main-layout">
            <!-- Sidebar -->
            <div class="sidebar">
                <jsp:include page="Shipper-Sidebar.jsp"/>
            </div>

            <!-- Main Content -->
            <div class="content-container">
                <div class="container-fluid">
                    <h2 class="mb-4">Chào mừng bạn đến với trang đơn hàng</h2>

                    <div class="row g-4">
                        <div class="col-md-4">
                            <div class="card border-success">
                                <div class="card-body">
                                    <h5 class="card-title">Sản Phẩm</h5>
                                    <p class="card-text">Xem tất cả đơn hàng cần giao.</p>
                                    <a href="${pageContext.request.contextPath}/ShipperController" class="btn btn-success">Xem chi tiết</a>
                                </div>
                            </div>
                        </div>

                        <!-- More cards if needed -->
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>