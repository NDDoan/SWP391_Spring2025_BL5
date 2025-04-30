<%-- 
    Document   : Report
    Created on : Apr 30, 2025, 7:53:13 AM
    Author     : LENOVO
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Báo cáo Thống kê</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Chart.js -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            .sidebar {
                margin-top: 75px;
                position: fixed;
                top: 80px;
                left: 0;
                bottom: 0;
                width: 250px;
                background: #f8f9fa;
                box-shadow:2px 0 5px rgba(0,0,0,.1);
                z-index:99;
                overflow-y:auto;
            }
            .dashboard-header {
                position:fixed;
                top:0;
                left:0;
                right:0;
                background:#fff;
                box-shadow:0 2px 5px rgba(0,0,0,.1);
                height:80px;
                padding:20px;
                z-index:100;
            }
            .content-container {
                margin-left:250px;
                padding-top:100px;
                padding-bottom:40px;
            }
            .chart-card {
                margin-bottom:2rem;
            }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <jsp:include page="dashboard-sidebar.jsp"/>
        </div>
        <div class="content-container">
            <div class="dashboard-header">
                <jsp:include page="dashboard-header.jsp"/>
            </div>
            <div class="container-fluid">
                <h2 class="mb-4">Báo cáo Thống kê</h2>

                <!-- Summary Cards -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="card text-white bg-primary">
                            <div class="card-body">
                                <h5 class="card-title">Tổng số sản phẩm</h5>
                                <p class="card-text display-6">${totalProducts}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card text-white bg-success">
                            <div class="card-body">
                                <h5 class="card-title">Tổng số khách hàng</h5>
                                <p class="card-text display-6">${totalCustomers}</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Chọn thống kê theo ngày/tuần/tháng -->
                <div class="row mb-4">
                    <div class="col-md-4">
                        <label for="periodSelect" class="form-label">Thống kê sản phẩm theo</label>
                        <select id="periodSelect" class="form-select" onchange="onPeriodChange()">
                            <option value="day"   ${period=='day'   ? 'selected':''}>Ngày</option>
                            <option value="week"  ${period=='week'  ? 'selected':''}>Tuần</option>
                            <option value="month" ${period=='month' ? 'selected':''}>Tháng</option>
                        </select>
                    </div>
                </div>

                <!-- Product Trend Chart -->
                <div class="row">
                    <div class="col-md-6 chart-card">
                        <div class="card">
                            <div class="card-header">
                                Sản phẩm tạo theo 
                                <c:choose>
                                    <c:when test="${period=='day'}">Ngày</c:when>
                                    <c:when test="${period=='week'}">Tuần</c:when>
                                    <c:otherwise>Tháng</c:otherwise>
                                </c:choose>
                            </div>
                            <div class="card-body">
                                <canvas id="productChart"></canvas>
                            </div>
                        </div>
                    </div>

                    <!-- User Registrations Chart -->
                    <div class="col-md-6 chart-card">
                        <div class="card">
                            <div class="card-header">Đăng ký người dùng theo ngày</div>
                            <div class="card-body"><canvas id="userChart"></canvas></div>
                        </div>
                    </div>
                </div>

                <!-- Role Distribution Chart -->
                <div class="row">
                    <div class="col-md-6 chart-card">
                        <div class="card">
                            <div class="card-header">Phân bố người dùng theo vai trò</div>
                            <div class="card-body"><canvas id="roleChart"></canvas></div>
                        </div>
                    </div>
                </div>

                <!-- Inventory Ratio -->
                <h4 class="mt-5">Tỉ lệ tồn kho theo sản phẩm</h4>
                <div class="row mb-4">
                    <div class="col-md-4">
                        <select id="productSelect" class="form-select">
                            <option value="">-- Chọn sản phẩm --</option>
                            <c:forEach var="ps" items="${productStocks}">
                                <option value="${ps.productId}" data-total="${ps.totalStock}">
                                    ${fn:escapeXml(ps.productName)}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-8">
                        <canvas id="ratioChart"></canvas>
                    </div>
                </div>

                <!-- Top 5 Products by Stock -->
                <h4 class="mt-5">Top 5 sản phẩm tồn kho cao nhất</h4>
                <div class="row mb-5">
                    <div class="col-md-8">
                        <canvas id="top5Chart"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="dashboard-footer.jsp"/>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                            function onPeriodChange() {
                            const p = document.getElementById('periodSelect').value;
                            const qs = new URLSearchParams(window.location.search);
                            qs.set('period', p);
                            window.location.search = qs.toString();
                            }

                            // Prepare data
                            const prodLabels = [
            <c:forEach var="tc" items="${productTrend}" varStatus="st">
                            '${tc.date}'<c:if test="${!st.last}">,</c:if>
            </c:forEach>
                            ];
                            const prodCounts = [
            <c:forEach var="tc" items="${productTrend}" varStatus="st">
                ${tc.count}<c:if test="${!st.last}">,</c:if>
            </c:forEach>
                            ];
                            const userLabels = [
            <c:forEach var="tc" items="${userTrend}" varStatus="st">
                            '${tc.date}'<c:if test="${!st.last}">,</c:if>
            </c:forEach>
                            ];
                            const userCounts = [
            <c:forEach var="tc" items="${userTrend}" varStatus="st">
                ${tc.count}<c:if test="${!st.last}">,</c:if>
            </c:forEach>
                            ];
                            const roleLabels = [
            <c:forEach var="rc" items="${usersByRole}" varStatus="st">
                            '${fn:escapeXml(rc.role)}'<c:if test="${!st.last}">,</c:if>
            </c:forEach>
                            ];
                            const roleCounts = [
            <c:forEach var="rc" items="${usersByRole}" varStatus="st">
                ${rc.count}<c:if test="${!st.last}">,</c:if>
            </c:forEach>
                            ];
                            const topLabels = [
            <c:forEach var="tp" items="${top5Stocks}" varStatus="st">
                            '${fn:escapeXml(tp.productName)}'<c:if test="${!st.last}">,</c:if>
            </c:forEach>
                            ];
                            const topStocks = [
            <c:forEach var="tp" items="${top5Stocks}" varStatus="st">
                ${tp.totalStock}<c:if test="${!st.last}">,</c:if>
            </c:forEach>
                            ];
                            const variantData = {
            <c:forEach var="entry" items="${variantStockMap}" varStatus="st">
                            '${entry.key}': [
                <c:forEach var="vs" items="${entry.value}" varStatus="vsst">
                            { name: '${fn:escapeXml(vs.variantName)}', stock: ${vs.stock} }<c:if test="${!vsst.last}">,</c:if>
                </c:forEach>
                            ]<c:if test="${!st.last}">,</c:if>
            </c:forEach>
                            };
                            // Charts
                            new Chart(document.getElementById('productChart'), {
                            type: 'line',
                                    data: { labels: prodLabels, datasets: [{ label: 'Sản phẩm', data: prodCounts, tension: 0.3 }] },
                                    options: {
                                    responsive: true,
                                            scales: {
                                            x: { title: { display: true, text: '${period=="day"?"Ngày":(period=="week"?"Tuần":"Tháng")}' } },
                                                    y: { title: { display: true, text: 'Số lượng' } }
                                            }
                                    }
                            });
                            new Chart(document.getElementById('userChart'), {
                            type: 'line',
                                    data: { labels: userLabels, datasets: [{ label: 'Đăng ký', data: userCounts, tension: 0.3 }] },
                                    options: { responsive: true }
                            });
                            new Chart(document.getElementById('roleChart'), {
                            type: 'pie',
                                    data: { labels: roleLabels, datasets: [{ data: roleCounts }] },
                                    options: { responsive: true }
                            });
                            new Chart(document.getElementById('top5Chart'), {
                            type: 'bar',
                                    data: { labels: topLabels, datasets: [{ label: 'Tồn kho', data: topStocks, backgroundColor: 'rgba(54,162,235,0.6)' }] },
                                    options: { responsive: true, plugins: { legend: { display: false } } }
                            });
                            const ctx = document.getElementById('ratioChart');
                            let ratioChart;
                            document.getElementById('productSelect').addEventListener('change', e => {
                            const pid = e.target.value;
                            if (!pid) { ratioChart?.destroy(); return; }
                            const total = + e.target.selectedOptions[0].dataset.total;
                            const vs = variantData[pid] || [];
                            const labels = vs.map(v => v.name), stocks = vs.map(v => v.stock);
                            const ratios = stocks.map(s => + ((s / total * 100).toFixed(1)));
                            const COLORS = ['#007bff', '#28a745', '#ffc107', '#17a2b8', '#6f42c1', '#fd7e14', '#20c997', '#e83e8c'];
                            ratioChart?.destroy();
                            ratioChart = new Chart(ctx, {
                            type: 'pie',
                                    data: {
                                    labels, datasets: [{
                                    data: ratios,
                                            backgroundColor: labels.map((_, i) => COLORS[i % COLORS.length])
                                    }]
                                    },
                                    options: {
                                    responsive: true,
                                            plugins: {
                                            tooltip: {
                                            callbacks: {
                                            label: c => `${c.label}: ${c.parsed}% (${stocks[c.dataIndex]} đơn vị)`
                                            }
                                            }
                                            }
                                    }
                            });
                            });
        </script>
    </body>
</html>