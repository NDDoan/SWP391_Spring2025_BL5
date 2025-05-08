<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
    .thumbnail-item {
        border: 2px solid transparent;
        transition: border-color .2s;
    }
    .thumbnail-item.border-primary {
        border-color: #0d6efd;
    }

</style>
<jsp:include page="/CommonPage/Header.jsp"/>

<div class="container my-5">
    <c:set var="p" value="${product}"/>

    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb bg-light shadow-sm">
            <li class="breadcrumb-item">
                <a href="${pageContext.request.contextPath}/HomePageController">Trang chủ</a>
            </li>
            <li class="breadcrumb-item">
                <a href="${pageContext.request.contextPath}/ProductUserListController?category=${fn:escapeXml(p.categoryName)}">
                    ${p.categoryName}
                </a>
            </li>
            <li class="breadcrumb-item active" aria-current="page">${p.productName}</li>
        </ol>
    </nav>

    <div class="row gx-5">
        <!-- Left: Media Carousel -->
        <div class="col-lg-6 mb-4">
            <div id="mediaCarousel" class="carousel slide shadow-sm" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <c:forEach var="m" items="${p.mediaList}" varStatus="st">
                        <div class="carousel-item ${st.first?'active':''}">
                            <c:choose>
                                <c:when test="${m.mediaType=='image'}">
                                    <img src="${m.mediaUrl}"
                                         class="d-block w-100 rounded"
                                         alt="Media">
                                </c:when>
                                <c:otherwise>
                                    <div class="ratio ratio-16x9 rounded overflow-hidden">
                                        <c:choose>
                                            <c:when test="${fn:contains(m.mediaUrl,'youtu')}">
                                                <iframe src="https://www.youtube.com/embed/${fn:split(m.mediaUrl,'/')[fn:length(fn:split(m.mediaUrl,'/'))-1]}"
                                                        frameborder="0" allowfullscreen class="w-100 h-100"></iframe>
                                                </c:when>
                                                <c:otherwise>
                                                <video controls class="w-100 h-100">
                                                    <source src="${m.mediaUrl}" type="video/mp4"/>
                                                </video>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:forEach>
                </div>
                <!-- <<< Chèn phần thumbnails ở đây >>> -->
                <div class="d-flex mt-3 justify-content-center flex-wrap gap-2">
                    <c:forEach var="m" items="${p.mediaList}" varStatus="st">
                        <c:set var="thumbUrl">
                            <c:choose>
                                <c:when test="${m.mediaType=='image'}">
                                    ${m.mediaUrl}
                                </c:when>
                                <c:otherwise>
                                    https://img.youtube.com/vi/${fn:split(m.mediaUrl,'/')[fn:length(fn:split(m.mediaUrl,'/'))-1]}/mqdefault.jpg
                                </c:otherwise>
                            </c:choose>
                        </c:set>
                        <img src="${thumbUrl}"
                             class="thumbnail-item rounded ${st.first ? 'border-primary' : 'border'}"
                             style="width:60px; height:60px; object-fit:cover; cursor:pointer;"
                             data-bs-target="#mediaCarousel"
                             data-bs-slide-to="${st.index}"/>
                    </c:forEach>
                </div>
                <button class="carousel-control-prev" type="button"
                        data-bs-target="#mediaCarousel" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon bg-dark rounded-circle p-2"></span>
                </button>
                <button class="carousel-control-next" type="button"
                        data-bs-target="#mediaCarousel" data-bs-slide="next">
                    <span class="carousel-control-next-icon bg-dark rounded-circle p-2"></span>
                </button>
            </div>
        </div>

        <!-- Right: Info & Purchase -->
        <div class="col-lg-6">
            <h2 class="fw-bold mb-3">${p.productName}</h2>
            <p class="text-muted mb-4">
                <i class="fas fa-tag me-1"></i>${p.brandName}
                &nbsp;|&nbsp;
                <i class="fas fa-list-ul me-1"></i>${p.categoryName}
            </p>

            <div class="card mb-4 shadow-sm">
                <div class="card-body">
                    <!-- Variant Controls -->
                    <c:if test="${fn:length(p.variants) > 1}">
                        <div class="mb-4">
                            <div class="row gy-2">
                                <!-- CPU -->
                                <div class="col-12 col-md-6">
                                    <label class="form-label fw-semibold">Bộ vi xử lý (CPU)</label>
                                    <div id="cpuGroup" class="btn-group w-100" role="group"></div>
                                </div>
                                <!-- RAM -->
                                <div class="col-12 col-md-6">
                                    <label class="form-label fw-semibold">RAM</label>
                                    <div id="ramGroup" class="btn-group w-100" role="group"></div>
                                </div>
                                <!-- Màn hình -->
                                <div class="col-12 col-md-6">
                                    <label class="form-label fw-semibold">Màn hình</label>
                                    <div id="screenGroup" class="btn-group w-100" role="group"></div>
                                </div>
                                <!-- Dung lượng lưu trữ -->
                                <div class="col-12 col-md-6">
                                    <label class="form-label fw-semibold">Dung lượng</label>
                                    <div id="storageGroup" class="btn-group w-100" role="group"></div>
                                </div>
                                <!-- Màu sắc -->
                                <div class="col-12 col-md-6">
                                    <label class="form-label fw-semibold">Màu sắc</label>
                                    <div id="colorGroup" class="btn-group w-100" role="group"></div>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Price & Stock -->
                    <div class="d-flex align-items-center mb-3">
                        <h4 class="text-danger mb-0 me-4">
                            Giá: 
                            <span id="priceDisplay" data-unit="" class="fw-bold"></span>₫
                        </h4>
                        <div>Tồn kho: <span id="stockDisplay"></span></div>
                    </div>

                    <!-- Form Thêm vào giỏ -->
                    <form id="addCartForm" action="${pageContext.request.contextPath}/AddToCartController" method="POST" class="d-flex align-items-center mb-5 gap-3">
                        <input type="hidden" name="productId" value="${p.productId}"/>
                        <div class="d-flex flex-column">
                            <input type="number" name="quantity" id="qtyInput" class="form-control" value="1" min="1" style="width:100px;"/>
                            <!-- Nơi hiển thị lỗi -->
                            <div id="qtyError" class="text-danger small mt-1" style="display:none;">
                                Số lượng không được vượt quá tồn kho!
                            </div>
                        </div>
                        <button type="submit" class="btn btn-lg btn-primary">
                            <i class="fas fa-cart-plus me-2"></i>Thêm vào giỏ
                        </button>
                    </form>
                </div>
            </div>

            <!-- Description -->
            <div class="mt-4">
                <h5>Mô tả sản phẩm</h5>
                <p>${p.description}</p>
            </div>
        </div>
    </div>

    <!-- Related Products -->
    <c:if test="${not empty relatedProducts}">
        <div class="mt-5">
            <h5 class="mb-4">Sản phẩm liên quan</h5>
            <div class="row row-cols-2 row-cols-md-4 g-4">
                <c:forEach var="rp" items="${relatedProducts}">
                    <div class="col">
                        <div class="card h-100 shadow-sm">
                            <a href="${pageContext.request.contextPath}/ProductDetailController?productId=${rp.productId}">
                                <img src="${rp.primaryMediaUrl}"
                                     class="card-img-xtop"
                                     alt="${rp.productName}"
                                     style="height:150px; object-fit:cover;">
                            </a>
                            <div class="card-body d-flex flex-column">
                                <h6 class="card-title mb-1">${rp.productName}</h6>
                                <small class="text-muted mb-2">${rp.brandName}</small>
                                <div class="mt-auto">
                                    <span class="fw-bold text-danger">
                                        <fmt:formatNumber value="${rp.price}"
                                                          type="number"
                                                          groupingUsed="true"
                                                          minFractionDigits="0"
                                                          maxFractionDigits="0"/>₫
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </c:if>
</div>

<jsp:include page="/CommonPage/Footer.jsp"/>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        // Build variants array
        const variants = [
        <c:forEach var="v" items="${p.variants}" varStatus="st">
        {
            cpu:    "${v.cpu}",
            ram:    "${v.ram}",
            screen: "${v.screen}",
            storage:"${v.storage}",
            color:  "${v.color}",
            price:  ${v.price},
            stock:  ${v.stockQuantity}
        }<c:if test="${!st.last}">,</c:if>
        </c:forEach>
        ];
        const attrs = ['cpu', 'ram', 'screen', 'storage', 'color'];
        const containers = {
            cpu: document.getElementById('cpuGroup'),
            ram: document.getElementById('ramGroup'),
            screen: document.getElementById('screenGroup'),
            storage: document.getElementById('storageGroup'),
            color: document.getElementById('colorGroup')
        };
        const userSelected = {};
        const priceEl = document.getElementById('priceDisplay');
        const stockEl = document.getElementById('stockDisplay');
        const qtyIn = document.getElementById('qtyInput');
        const form = document.getElementById('addCartForm');
        const errDiv = document.getElementById('qtyError');

        function allowed(attr) {
            return [...new Set(
                variants
                    .filter(v => attrs.every(a => a === attr || !userSelected[a] || v[a] === userSelected[a]))
                    .map(v => v[attr])
            )];
        }

        function build(attr) {
            let vals = allowed(attr);
            vals.sort((a, b) => {
                const na = parseFloat(a.replace(/[^\d.]/g, ''));
                const nb = parseFloat(b.replace(/[^\d.]/g, ''));
                if (!isNaN(na) && !isNaN(nb)) return na - nb;
                return a.localeCompare(b, undefined, {numeric: true, sensitivity: 'base'});
            });
            const div = containers[attr];
            div.innerHTML = '';
            vals.forEach(v => {
                const btn = document.createElement('button');
                btn.type = 'button';
                btn.className = 'btn btn-outline-primary';
                btn.textContent = v;
                btn.addEventListener('click', () => {
                    userSelected[attr] = v;
                    updateAll();
                });
                div.appendChild(btn);
            });
        }

        function updateAll() {
            attrs.forEach(a => build(a));
            attrs.forEach(a => {
                Array.from(containers[a].children)
                    .forEach(b => b.classList.toggle('active', b.textContent === userSelected[a]));
            });
            if (attrs.every(a => userSelected[a])) {
                const found = variants.find(v => attrs.every(a => v[a] === userSelected[a]));
                if (found) {
                    const unitPrice = found.price;
                    priceEl.dataset.unit = unitPrice;
                    const qty = parseInt(qtyIn.value, 10) || 1;
                    priceEl.textContent = (unitPrice * qty).toLocaleString();
                    stockEl.textContent = found.stock;
                }
            }
        }

        // Initialize default selections
        attrs.forEach(a => { userSelected[a] = allowed(a)[0]; });
        updateAll();

        // Thumbnail highlight
        document.querySelectorAll('.thumbnail-item').forEach(el => el.addEventListener('click', () => {
            document.querySelectorAll('.thumbnail-item').forEach(x => x.classList.remove('border-primary'));
            el.classList.add('border-primary');
        }));
        document.querySelector('.thumbnail-item[data-bs-slide-to="0"]').classList.add('border-primary');

        // Quantity change: recalculate price
        qtyIn.addEventListener('input', () => {
            errDiv.style.display = 'none';
            qtyIn.classList.remove('is-invalid');
            const unitPrice = parseInt(priceEl.dataset.unit, 10) || 0;
            const qty = parseInt(qtyIn.value, 10) || 1;
            priceEl.textContent = (unitPrice * qty).toLocaleString();
        });

        // Validate before submit
        form.addEventListener('submit', e => {
            const req = parseInt(qtyIn.value, 10);
            const ava = parseInt(stockEl.textContent, 10) || 0;
            if (req > ava) {
                e.preventDefault();
                errDiv.style.display = 'block';
                qtyIn.classList.add('is-invalid');
            }
        });
    });
</script>
