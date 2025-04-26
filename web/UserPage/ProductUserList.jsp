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
            <h4>Filters</h4>
            <div class="mb-3">
                <input id="searchInput" type="text" class="form-control" placeholder="Search…">
            </div>

            <h5>Brands</h5>
            <c:forEach var="b" items="${brandList}">
                <div class="form-check">
                    <input class="form-check-input brand-filter" type="checkbox" value="${b}" id="brand_${b}">
                    <label class="form-check-label" for="brand_${b}">${b}</label>
                </div>
            </c:forEach>

            <c:set var="selCat" value="${selectedCategory}" />

            <h5>Categories</h5>
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


            <h5>Price (₫)</h5>
            <div class="d-flex gap-2 mb-3">
                <input id="priceMin" type="number" class="form-control" placeholder="Min" min="0">
                <input id="priceMax" type="number" class="form-control" placeholder="Max" min="0">
            </div>

            <button id="applyFilters" class="btn btn-primary mb-2">Apply</button>
            <button id="clearFilters" class="btn btn-secondary">Clear</button>
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
                media: "${p.primaryMediaUrl}"
        }<c:if test="${!st.last}">,</c:if>
    </c:forEach>
        ];

        const pageSize = 9;
        let filtered = allProducts;

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
                selCat = "${fn:escapeXml(selectedCategory)}";

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

            // pagination
            const totalPages = Math.ceil(filtered.length / pageSize);
            pagEl.innerHTML = '';
            for (let i = 1; i <= totalPages; i++) {
                const li = document.createElement('li');
                li.className = 'page-item' + (i === page ? ' active' : '');
                li.innerHTML = `<a class="page-link" href="#">${i}</a>`;
                li.addEventListener('click', e => {
                    e.preventDefault();
                    renderPage(i);
                });
                pagEl.appendChild(li);
            }
        }

        // 4) apply filters
        function applyFilters() {
            const q = searchInput.value.trim().toLowerCase();
            const brands = Array.from(brandChecks).filter(c => c.checked).map(c => c.value);
            const cats = Array.from(catChecks).filter(c => c.checked).map(c => c.value);
            const min = parseFloat(priceMin.value) || 0;
            const max = parseFloat(priceMax.value) || Infinity;

            filtered = allProducts.filter(p => {
                if (q && !p.name.toLowerCase().includes(q))
                    return false;
                if (brands.length && !brands.includes(p.brand))
                    return false;
                if (cats.length && !cats.includes(p.category))
                    return false;
                if (p.price < min || p.price > max)
                    return false;
                return true;
            });
            renderPage(1);
        }

        // 5) clear filters
        function clearFilters() {
            searchInput.value = '';
            brandChecks.forEach(c => c.checked = false);
            catChecks.forEach(c => c.checked = false);
            priceMin.value = '';
            priceMax.value = '';
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

        // initial
        renderPage(1);
    })();
</script>
