<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
        <a href="${pageContext.request.contextPath}/CategoryController?name=${p.categoryName}">
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
          <!-- Variant Selector -->
          <c:if test="${not empty p.variants}">
            <div class="mb-3">
              <label class="form-label fw-semibold">Phiên bản</label>
              <select id="variantSelect" class="form-select">
                <c:forEach var="v" items="${p.variants}">
                  <option value="${v.variantId}"
                          data-price="${v.price}"
                          data-stock="${v.stockQuantity}">
                    ${v.cpu} / ${v.ram} / ${v.screen} / ${v.storage} / ${v.color}
                  </option>
                </c:forEach>
              </select>
            </div>
          </c:if>

          <!-- Price & Stock -->
          <div class="d-flex align-items-center mb-3">
            <h4 class="text-danger mb-0 me-4">
              Giá: 
              <span id="priceDisplay" class="fw-bold"></span>₫
            </h4>
            <div>Tồn kho: <span id="stockDisplay"></span></div>
          </div>

          <div class="d-flex align-items-center mb-5 gap-3">
            <input type="number" id="qtyInput" class="form-control" 
                   value="1" min="1" style="width:100px;"/>
            <button class="btn btn-lg btn-primary">
              <i class="fas fa-cart-plus me-2"></i>Thêm vào giỏ
            </button>
          </div>
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
  (function(){
    const sel    = document.getElementById('variantSelect'),
          priceE = document.getElementById('priceDisplay'),
          stockE = document.getElementById('stockDisplay');

    function updateInfo(){
      if(!sel) return;
      const o = sel.selectedOptions[0];
      priceE.textContent = Number(o.dataset.price||0).toLocaleString();
      stockE.textContent = o.dataset.stock||0;
    }
    if(sel){
      sel.addEventListener('change', updateInfo);
      updateInfo();
    }
  })();
</script>
