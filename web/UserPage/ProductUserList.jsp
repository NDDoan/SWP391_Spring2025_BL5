<%-- 
    Document   : ProductUserList
    Created on : Apr 25, 2025, 4:54:37 PM
    Author     : LENOVO
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/CommonPage/Header.jsp"/>

<style>
    .sidebar {
        background: #f8f9fa;
        padding: 1rem;
        border-radius: .25rem;
    }
    .sidebar h5 {
        margin-top: 1.5rem;
    }
    .product-card img {
        height: 180px;
        object-fit: cover;
    }
</style>

<div class="container my-5">
    <div class="row">
        <!-- FILTER SIDEBAR -->
        <div class="col-md-3 sidebar">
            <h4>Tìm kiếm</h4>
            <form id="searchForm" action="${pageContext.request.contextPath}/ProductUserListController" method="get" class="mb-4">
                <div class="input-group">
                    <input id="searchInput"
                           name="search"
                           value="${fn:escapeXml(searchTerm)}"
                           type="text"
                           class="form-control"
                           placeholder="Tìm kiếm sản phẩm…"
                           onkeydown="if (event.key === 'Enter') {
                               event.preventDefault();
                               applyFilters();
                               }">
                </div>
            </form>
            <h5>Thương hiệu</h5>
            <c:forEach var="b" items="${brandList}">
                <div class="form-check">
                    <input class="form-check-input brand-filter" type="checkbox" value="${b}" id="brand_${b}">
                    <label class="form-check-label" for="brand_${b}">${b}</label>
                </div>
            </c:forEach>

            <c:set var="selCat" value="${selectedCategory}" />

            <h5>Danh mục</h5>
            <c:forEach var="categ" items="${categoryList}">
                <div class="form-check">
                    <input class="form-check-input cat-filter"
                           type="checkbox"
                           value="${categ}"
                           id="cat_${categ}"
                           <c:if test="${categ == selCat}">checked</c:if>
                               >
                           <label class="form-check-label" for="cat_${categ}">${categ}</label>
                </div>
            </c:forEach>

            <h5>CPU</h5>
            <c:forEach var="cpuName" items="${cpuList}">
                <div class="form-check">
                    <input class="form-check-input cpu-filter" type="checkbox" value="${cpuName}" id="cpu_${cpuName}">
                    <label class="form-check-label" for="cpu_${cpuName}">${cpuName}</label>
                </div>
            </c:forEach>

            <h5>RAM</h5>
            <c:forEach var="ramSize" items="${ramList}">
                <div class="form-check">
                    <input class="form-check-input ram-filter" type="checkbox" value="${ramSize}" id="ram_${ramSize}">
                    <label class="form-check-label" for="ram_${ramSize}">${ramSize}</label>
                </div>
            </c:forEach>

            <h5>Màn hình</h5>
            <c:forEach var="screenResolution" items="${screenList}">
                <div class="form-check">
                    <input class="form-check-input screen-filter" type="checkbox" value="${screenResolution}" id="screen_${screenResolution}">
                    <label class="form-check-label" for="screen_${screenResolution}">${screenResolution}</label>
                </div>
            </c:forEach>

            <h5>Dung lượng</h5>
            <c:forEach var="storageSize" items="${storageList}">
                <div class="form-check">
                    <input class="form-check-input storage-filter" type="checkbox" value="${storageSize}" id="storage_${storageSize}">
                    <label class="form-check-label" for="storage_${storageSize}">${storageSize}</label>
                </div>
            </c:forEach>

            <h5>Màu</h5>
            <c:forEach var="colorName" items="${colorList}">
                <div class="form-check">
                    <input class="form-check-input color-filter" type="checkbox" value="${colorName}" id="color_${colorName}">
                    <label class="form-check-label" for="color_${colorName}">${colorName}</label>
                </div>
            </c:forEach>

            <h5>Thành tiền (₫)</h5>
            <div class="d-flex gap-2 mb-3">
                <input id="priceMin" type="number" class="form-control" placeholder="Min" min="0">
                <input id="priceMax" type="number" class="form-control" placeholder="Max" min="0">
            </div>

            <button id="applyFilters" class="btn btn-primary">Áp dụng</button>
            <button id="clearFilters" class="btn btn-secondary">Dọn Dẹp</button>
        </div>

        <!-- PRODUCT GRID & PAGINATION -->
        <div class="col-md-9">
            <div id="productGrid" class="row g-4"></div>
            <nav>
                <ul id="pagination" class="pagination justify-content-center mt-4"></ul>
            </nav>
        </div>
    </div>
</div>

<jsp:include page="/CommonPage/Footer.jsp"/>


<script>
    const constCTX = '${pageContext.request.contextPath}';
    (function () {
    // 1) load all products into JS array
    const allProducts = [
    <c:forEach var="p" items="${productList}" varStatus="st">
    {
    id: ${p.productId},
            name: "${fn:escapeXml(p.productName)}",
            brand: "${fn:escapeXml(p.brandName)}",
            category: "${fn:escapeXml(p.categoryName)}",
            price: ${p.price},
            media: "${p.primaryMediaUrl}",
            variants: [
        <c:forEach var="v" items="${p.variants}" varStatus="vs">
            {
            cpu:    "${v.cpu}",
                    ram:    "${v.ram}",
                    screen: "${v.screen}",
                    storage:"${v.storage}",
                    color:  "${v.color}"
            }<c:if test="${!vs.last}">,</c:if>
        </c:forEach>
            ]
    }<c:if test="${!st.last}">,</c:if>
    </c:forEach>
    ];
    const pageSize = 9;
    let filtered = allProducts.slice();
    // 2) DOM refs
    const gridEl = document.getElementById('productGrid'),
            pagEl = document.getElementById('pagination'),
            searchInput = document.getElementById('searchInput'),
            brandChecks = document.querySelectorAll('.brand-filter'),
            catChecks = document.querySelectorAll('.cat-filter'),
            priceMin = document.getElementById('priceMin'),
            priceMax = document.getElementById('priceMax'),
            applyBtn = document.getElementById('applyFilters'),
            clearBtn = document.getElementById('clearFilters'),
            selCat = "${fn:escapeXml(selectedCategory)}",
            cpuChecks = document.querySelectorAll('.cpu-filter'),
            ramChecks = document.querySelectorAll('.ram-filter'),
            screenChecks = document.querySelectorAll('.screen-filter'),
            storageChecks = document.querySelectorAll('.storage-filter'),
            colorChecks = document.querySelectorAll('.color-filter');
    // 3) render one page
    function renderPage(page) {
    gridEl.innerHTML = '';
    const start = (page - 1) * pageSize,
            pageItems = filtered.slice(start, start + pageSize);
    pageItems.forEach(p => {
    const col = document.createElement('div');
    col.className = 'col-6 col-md-4';
    col.innerHTML =
            '<div class="card product-card h-100 shadow-sm">' +
            '<a href="' + constCTX + '/ProductDetailController?productId=' + p.id + '">' +
            '<img src="' + p.media + '" class="card-img-top" alt="' + p.name + '">' +
            '</a>' +
            '<div class="card-body d-flex flex-column">' +
            '<h6 class="card-title">' + p.name + '</h6>' +
            '<small class="text-muted">' + p.brand + '</small>' +
            '<div class="mt-auto fw-bold text-danger">' +
            p.price.toLocaleString() + '₫' +
            '</div>' +
            '</div>' +
            '</div>';
    gridEl.appendChild(col);
    });
    const totalPages = Math.ceil(filtered.length / pageSize);
    pagEl.innerHTML = '';
    // Prev button
    const prevLi = document.createElement('li');
    prevLi.className = 'page-item' + (page === 1 ? ' disabled' : '');
    prevLi.innerHTML = `<a class="page-link" href="#" aria-label="Previous">&lsaquo;</a>`;
    prevLi.addEventListener('click', e => {
    e.preventDefault();
    if (page > 1)
            renderPage(page - 1);
    });
    pagEl.appendChild(prevLi);
    // Numbered buttons
    for (let i = 1; i <= totalPages; i++) {
    const li = document.createElement('li');
    li.className = 'page-item' + (i === page ? ' active' : '');
    li.innerHTML = '<a class="page-link" href="#">' + i + '</a>';
    li.addEventListener('click', e => {
    e.preventDefault();
    renderPage(i);
    });
    pagEl.appendChild(li);
    }

    // Next button
    const nextLi = document.createElement('li');
    nextLi.className = 'page-item' + (page === totalPages ? ' disabled' : '');
    nextLi.innerHTML = `<a class="page-link" href="#" aria-label="Next">&rsaquo;</a>`;
    nextLi.addEventListener('click', e => {
    e.preventDefault();
    if (page < totalPages)
            renderPage(page + 1);
    });
    pagEl.appendChild(nextLi);
    }

    // 4) apply filters
    function applyFilters() {
    const q = searchInput.value.trim().toLowerCase();
    const brands = Array.from(brandChecks).filter(c => c.checked).map(c => c.value);
    const cats = Array.from(catChecks).filter(c => c.checked).map(c => c.value);
    const min = parseFloat(priceMin.value) || 0;
    const max = parseFloat(priceMax.value) || Infinity;
    const cpus = Array.from(cpuChecks).filter(c => c.checked).map(c => c.value);
    const rams = Array.from(ramChecks).filter(c => c.checked).map(c => c.value);
    const scrs = Array.from(screenChecks).filter(c => c.checked).map(c => c.value);
    const stors = Array.from(storageChecks).filter(c => c.checked).map(c => c.value);
    const cols = Array.from(colorChecks).filter(c => c.checked).map(c => c.value);
    filtered = allProducts.filter(p => {
    if (q && !p.name.toLowerCase().includes(q))
            return false;
    if (brands.length && !brands.includes(p.brand))
            return false;
    if (cats.length && !cats.includes(p.category))
            return false;
    if (p.price < min || p.price > max)
            return false;
    return p.variants.some(v =>
            (cpus.length   ? cpus.includes(v.cpu)       : true) &&
            (rams.length   ? rams.includes(v.ram)       : true) &&
            (scrs.length   ? scrs.includes(v.screen)    : true) &&
            (stors.length  ? stors.includes(v.storage)  : true) &&
            (cols.length   ? cols.includes(v.color)     : true)
            );
    });
    renderPage(1);
    // cập nhật URL cho `search` (history API)
    const params = new URLSearchParams(window.location.search);
    if (q)
            params.set('search', q);
    else
            params.delete('search');
    history.replaceState(null, '', '?' + params.toString());
    }

    // 5) clear filters
    function clearFilters() {
    searchInput.value = '';
    brandChecks.forEach(c => c.checked = false);
    catChecks.forEach(c => c.checked = false);
    priceMin.value = '';
    priceMax.value = '';
    cpuChecks.forEach(c => c.checked = false);
    ramChecks.forEach(c => c.checked = false);
    screenChecks.forEach(c => c.checked = false);
    storageChecks.forEach(c => c.checked = false);
    colorChecks.forEach(c => c.checked = false);
    filtered = allProducts;
    renderPage(1);
    }

    applyBtn.addEventListener('click', applyFilters);
    clearBtn.addEventListener('click', clearFilters);
    if (selCat) {
    // find and check the matching box (redundant with JSP but safe)
    const box = document.querySelector(`.cat-filter[value="${selCat}"]`);
    if (box)
            box.checked = true;
    applyFilters();
    }

    // Khi load trang, nếu đã có searchTerm, tự apply
    if (searchInput.value) {
    applyFilters();
    } else {
    renderPage(1);
    }
    // initial
    renderPage(1);
    })();
</script>
