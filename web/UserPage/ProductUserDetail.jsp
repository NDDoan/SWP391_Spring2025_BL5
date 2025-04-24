<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/CommonPage/Header.jsp"/>

<div class="container py-5">
  <c:set var="p" value="${product}"/>

  <div class="row gx-5">
    <!-- Left: Gallery -->
    <div class="col-lg-6 mb-4">
      <div id="mediaCarousel" class="carousel slide shadow-sm rounded" data-bs-ride="carousel">
        <div class="carousel-inner">
          <c:forEach var="m" items="${p.mediaList}" varStatus="st">
            <div class="carousel-item ${st.first?'active':''}">
              <c:choose>
                <c:when test="${m.mediaType=='image'}">
                  <img src="${m.mediaUrl}" class="d-block w-100 rounded" alt="Media">
                </c:when>
                <c:otherwise>
                  <div class="ratio ratio-16x9">
                    <c:choose>
                      <c:when test="${fn:contains(m.mediaUrl,'youtu')}">
                        <iframe src="https://www.youtube.com/embed/${fn:split(m.mediaUrl,'/')[fn:length(fn:split(m.mediaUrl,'/'))-1]}"
                                frameborder="0" allowfullscreen class="w-100 h-100"></iframe>
                      </c:when>
                      <c:otherwise>
                        <video controls class="w-100 h-100">
                          <source src="${m.mediaUrl}" type="video/mp4">
                        </video>
                      </c:otherwise>
                    </c:choose>
                  </div>
                </c:otherwise>
              </c:choose>
            </div>
          </c:forEach>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#mediaCarousel" data-bs-slide="prev">
          <span class="carousel-control-prev-icon bg-dark rounded-circle p-2"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#mediaCarousel" data-bs-slide="next">
          <span class="carousel-control-next-icon bg-dark rounded-circle p-2"></span>
        </button>
      </div>

      <!-- Thumbnails -->
      <div class="d-flex flex-wrap justify-content-center gap-2 mt-3">
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
               class="thumbnail-item rounded border ${st.first?'border-primary':''}"
               style="width:60px;height:60px;object-fit:cover;cursor:pointer;"
               data-bs-target="#mediaCarousel"
               data-bs-slide-to="${st.index}">
        </c:forEach>
      </div>
    </div>

    <!-- Right: Info & Purchase -->
    <div class="col-lg-6">
      <h2 class="fw-bold mb-3">${p.productName}</h2>
      <p class="text-muted mb-4">
        <i class="fas fa-tag me-1"></i> ${p.brandName}
        &nbsp;|&nbsp;
        <i class="fas fa-list-ul me-1"></i> ${p.categoryName}
      </p>

      <div class="card mb-4 shadow-sm">
        <div class="card-body">
          <!-- Variant selector -->
          <c:if test="${not empty p.variants}">
            <div class="mb-3">
              <label class="form-label fw-semibold">Phiên bản</label>
              <select id="variantSelect" class="form-select">
                <c:forEach var="v" items="${p.variants}">
                  <option value="${v.variantId}" data-price="${v.price}" data-stock="${v.stockQuantity}">
                    ${v.cpu} / ${v.ram} / ${v.screen} / ${v.storage} / ${v.color}
                  </option>
                </c:forEach>
              </select>
            </div>
          </c:if>

          <!-- Price & Stock -->
          <div class="d-flex align-items-center mb-3">
            <h4 class="text-danger mb-0 me-4">Giá: <span id="priceDisplay" class="fw-bold"></span>₫</h4>
            <div>Tồn kho: <span id="stockDisplay"></span></div>
          </div>

          <!-- Add to Cart -->
          <button class="btn btn-lg btn-primary w-100">
            <i class="fas fa-cart-plus me-2"></i> Thêm vào giỏ
          </button>
        </div>
      </div>

      <!-- Description -->
      <div class="mt-5">
        <h5 class="mb-3">Mô tả sản phẩm</h5>
        <p>${p.description}</p>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/CommonPage/Footer.jsp"/>

<script>
  (function(){
    const sel = document.getElementById('variantSelect'),
          priceEl = document.getElementById('priceDisplay'),
          stockEl = document.getElementById('stockDisplay'),
          thumbs = document.querySelectorAll('.thumbnail-item');

    function updateInfo(){
      if(!sel) return;
      const o = sel.selectedOptions[0];
      priceEl.textContent = Number(o.dataset.price||0).toLocaleString();
      stockEl.textContent = o.dataset.stock||0;
    }
    if(sel){
      sel.addEventListener('change', updateInfo);
      updateInfo();
    }
    thumbs.forEach(t=>{
      t.addEventListener('click',()=>{
        thumbs.forEach(x=>x.classList.remove('border-primary'));
        t.classList.add('border-primary');
      });
    });
  })();
</script>
