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

                    <c:if test="${fn:length(p.variants) == 1}">
                        <!-- Nếu chỉ có 1 phiên bản, hiển thị giá & tồn kho ngay -->
                        <script>
                            document.addEventListener('DOMContentLoaded', () => {
                                const v = ${p.variants[0].price}, s = ${p.variants[0].stockQuantity};
                                document.getElementById('priceDisplay').textContent = Number(v).toLocaleString();
                                document.getElementById('stockDisplay').textContent = s;
                            });
                        </script>
                    </c:if>

                    <!-- Price & Stock -->
                    <div class="d-flex align-items-center mb-3">
                        <h4 class="text-danger mb-0 me-4">
                            Giá: 
                            <span id="priceDisplay" class="fw-bold"></span>₫
                        </h4>
                        <div>Tồn kho: <span id="stockDisplay"></span></div>
                    </div>

                    <!-- Form Thêm vào giỏ -->
                    <form action="${pageContext.request.contextPath}/AddToCartController" method="POST" class="d-flex align-items-center mb-5 gap-3">
                        <input type="hidden" name="productId" value="${p.productId}"/>
                        <input type="number" name="quantity" id="qtyInput" class="form-control" value="1" min="1" style="width:100px;"/>
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
                                     class="card-img-top"
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
        // 1) Build array variants từ JSP
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

        // 2) Danh sách thuộc tính và containers
        const attrs = ['cpu', 'ram', 'screen', 'storage', 'color'];
        const containers = {
            cpu: document.getElementById('cpuGroup'),
            ram: document.getElementById('ramGroup'),
            screen: document.getElementById('screenGroup'),
            storage: document.getElementById('storageGroup'),
            color: document.getElementById('colorGroup')
        };

        // 3) State lưu mỗi attr đã chọn
        const state = {};

        // 4) Giá và tồn kho
        const priceEl = document.getElementById('priceDisplay');
        const stockEl = document.getElementById('stockDisplay');

        // 5) Hàm tính tập giá trị hợp lệ của attr dựa vào state các attr khác
        function allowedValues(attr) {
            return [...new Set(
                        variants
                        .filter(v =>
                            attrs.every(a => a === attr || !state[a] || v[a] === state[a])
                        )
                        .map(v => v[attr])
                        )];
        }

        // 6) Tạo nút cho mỗi attr
        function build(attr) {
            const vals = allowedValues(attr);
            const div = containers[attr];
            div.innerHTML = '';
            vals.forEach(val => {
                const btn = document.createElement('button');
                btn.type = 'button';
                btn.className = 'btn btn-outline-primary';
                btn.textContent = val;
                btn.addEventListener('click', () => {
                    state[attr] = val;
                    updateAll();
                });
                div.appendChild(btn);
            });
            // Nếu state[attr] không còn hợp lệ thì reset về đầu
            if (!state[attr] || !vals.includes(state[attr])) {
                state[attr] = vals[0];
            }
        }

        // 7) Cập nhật giao diện sau mỗi thay đổi
        function updateAll() {
            // Re-build tất cả nhóm
            attrs.forEach(attr => build(attr));
            // Highlight
            attrs.forEach(attr => {
                Array.from(containers[attr].children).forEach(btn =>
                    btn.classList.toggle('active', btn.textContent === state[attr])
                );
            });
            // Khi đã đủ 5 attr (với >1 variant), tìm variant và show giá/tồn kho
            if (attrs.every(a => state[a])) {
                const found = variants.find(v =>
                    attrs.every(a => v[a] === state[a])
                );
                if (found) {
                    priceEl.textContent = Number(found.price).toLocaleString();
                    stockEl.textContent = found.stock;
                }
            }
        }

        // 8) Khởi tạo: build & chọn mặc định
        attrs.forEach(attr => build(attr));
        updateAll();
        // highlight
        document.querySelectorAll('.thumbnail-item').forEach(el => {
            el.addEventListener('click', () => {
                document.querySelectorAll('.thumbnail-item').forEach(x => x.classList.remove('border-primary'));
                el.classList.add('border-primary');
            });
        });
        // khởi tạo highlight lần đầu
        document.querySelector('.thumbnail-item[data-bs-slide-to="0"]')
        .classList.add('border-primary');
    });
</script>
