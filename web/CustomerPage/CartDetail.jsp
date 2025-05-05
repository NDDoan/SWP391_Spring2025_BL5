<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Cart Detail</title>
  <!-- FontAwesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
  <style>
    /* Global & Layout */
    body { font-family: Arial, sans-serif; background: #f4f4f4; margin: 0; padding: 0; }
    .cart-container { width: 80%; background: #fff; margin: 40px auto; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
    .btn { background: #007bff; color: #fff; padding: 8px 15px; border: none; border-radius: 5px; cursor: pointer; transition: background 0.3s; }
    .btn:hover { background: #0056b3; }
    .btn-back { background: #28a745; }
    .btn-back:hover { background: #218838; }
    .search-box { padding: 6px 10px; border: 1px solid #ccc; border-radius: 5px; }
    .cart-wrapper { display: flex; flex-direction: column; gap: 20px; }
    @media (min-width: 992px) { .cart-wrapper { flex-direction: row; } }
    .cart-content, .discount-info { padding: 15px; border-radius: 8px; }
    .cart-content { flex: 6; background: #f9f9f9; }
    .discount-info { flex: 4; background: #fffae6; }

    /* Table */
    .cart-table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
    .cart-table th, .cart-table td { padding: 10px; border-bottom: 1px solid #ddd; text-align: center; }
    .cart-table th { background: #007bff; color: #fff; }
    .remove-btn { background: none; border: none; font-size: 18px; cursor: pointer; }

    /* Update button */
    .update-cart-container { text-align: center; margin-top: 10px; }
    .update-cart-reminder { font-size: 14px; color: #666; margin-bottom: 8px; font-style: italic; }
    .update-cart-btn { background: #ff6600; color: #fff; padding: 12px 20px; border: none; border-radius: 8px; font-size: 18px; font-weight: bold; cursor: pointer; box-shadow: 0 4px 8px rgba(0,0,0,0.2); transition: background 0.3s, transform 0.2s; }
    .update-cart-btn:hover { background: #e65c00; transform: scale(1.05); }
    .update-cart-btn:active { transform: scale(0.98); }

    /* Discounts */
    .discount-info h3 { color: #ff9800; margin-bottom: 10px; }
    .discount-info ul { list-style: none; padding: 0; }
    .discount-info li { margin: 5px 0; padding: 8px; border-radius: 5px; }
    .green { background: #c8e6c9; }
    .blue { background: #bbdefb; }
    .red { background: #ffcdd2; }

    /* Price Summary */
    .price-summary { background: #f0f0f0; padding: 15px; border-radius: 5px; margin: 20px 0; line-height: 1.6; }

    /* Pagination */
    .pagination { display: flex; justify-content: center; gap: 5px; margin-top: 15px; }
    .pagination button { background: #ddd; border: none; padding: 5px 10px; cursor: pointer; }
    .pagination .active { background: #007bff; color: #fff; }

    /* Promo */
    .promo-section { margin-top: 20px; text-align: center; }
    .promo-section input { padding: 6px 10px; border: 1px solid #ccc; border-radius: 5px; margin-right: 5px; }

    /* Checkout btn */
    .checkout-btn { background: #28a745; color: #fff; padding: 12px 25px; font-size: 18px; border: none; border-radius: 5px; cursor: pointer; width: 100%; max-width: 300px; margin: 20px auto; display: block; }
  </style>
</head>
<body>
  <jsp:include page="../CommonPage/Header.jsp"/>

  <div class="cart-container">
    <!-- Success Message -->
    <c:if test="${not empty sessionScope.message}">
      <div id="deleteAlert" class="alert alert-success" style="position:fixed; top:20px; left:50%; transform:translateX(-50%); z-index:1000;">
        <strong>Thông báo:</strong> ${sessionScope.message}
        <button onclick="this.parentElement.style.display='none'" style="background:none; border:none; color:white; font-size:18px;">✖</button>
      </div>
      <script>setTimeout(()=>document.getElementById('deleteAlert').style.display='none',3000);</script>
    </c:if>

    <div class="cart-wrapper">
      <div class="cart-content">
        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-3">
          <button onclick="location.href='homecontroller'" class="btn btn-back">⬅ Back to Home</button>
          <div class="d-flex align-items-center">
            <input type="text" class="search-box" placeholder="Search...">
            <button class="btn ms-2"><i class="fas fa-search"></i></button>
          </div>
        </div>

        <!-- Cart Form -->
        <form action="cartdetailcontroller" method="post" id="cartUpdateForm">
          <table class="cart-table">
            <thead>
              <tr>
                <th><input type="checkbox" id="selectAll" onclick="toggleCheckboxes(this)"><label for="selectAll"> Choose All</label></th>
                <th>ID</th><th>Name</th><th>Price</th><th>Discount</th><th>Qty</th><th>Total</th><th>Action</th>
              </tr>
            </thead>
            <tbody>
              <c:choose>
                <c:when test="${empty cartDetails}">
                  <tr><td colspan="8" style="color:red; text-align:center;">Your cart is empty!</td></tr>
                </c:when>
                <c:otherwise>
                  <c:forEach var="item" items="${cartDetails}">
                    <tr>
                      <td><input type="checkbox" name="selectedProducts" value="${item.productId}" ${selectedProducts.contains(item.productId)?'checked':''}></td>
                      <td>${item.productId}</td>
                      <td>${item.productName}</td>
                      <td><fmt:formatNumber value="${item.price}" type="number" groupingUsed="true"/> VND</td>
                      <td><c:choose><c:when test="${item.discountPrice==0.0}">❌</c:when><c:otherwise><fmt:formatNumber value="${item.discountPrice}" type="number" groupingUsed="true"/> VND</c:otherwise></c:choose></td>
                      <td>
                        <div style="display:flex; align-items:center; gap:5px;">
                          <form action="cartdetailcontroller" method="post"><input type="hidden" name="productId" value="${item.productId}"><button name="action" value="decrease">-</button></form>
                          <span>${item.quantity}</span>
                          <form action="cartdetailcontroller" method="post"><input type="hidden" name="productId" value="${item.productId}"><button name="action" value="increase">+</button></form>
                        </div>
                      </td>
                      <td><fmt:formatNumber value="${item.totalPrice}" type="number" groupingUsed="true"/> VND</td>
                      <td>
                        <form action="cartdetailcontroller" method="post">
                          <input type="hidden" name="action" value="remove"><input type="hidden" name="productId" value="${item.productId}">
                          <button type="submit" class="remove-btn">❌</button>
                        </form>
                      </td>
                    </tr>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
            </tbody>
          </table>
          <div class="update-cart-container">
            <p class="update-cart-reminder">⚠️ Remember to update your cart to apply latest discounts!</p>
            <button type="submit" class="update-cart-btn">Refresh Cart Prices</button>
          </div>
        </form>

        <!-- Pagination -->
        <div class="pagination">
          <button>&lt;</button><button class="active">1</button><button>2</button><button>...</button><button>&gt;</button>
        </div>

        <!-- Promo -->
        <div class="promo-section">
          🎁 Promo Code: <input type="text" id="promo-code" placeholder="Enter code"> <button class="btn">Apply</button>
        </div>

        <!-- Price Summary -->
        <div class="price-summary">
          💰 <b>Total Before Discount:</b> <fmt:formatNumber value="${beforePrice}" type="number" groupingUsed="true"/> VND<br>
          <c:if test="${discountRate>0}">🎯 <b>Discount:</b> <fmt:formatNumber value="${discountAmount}" type="number" groupingUsed="true"/> VND (<fmt:formatNumber value="${discountRate}" type="number"/>%)<br></c:if>
          🏷️ <b>Final Total:</b> <fmt:formatNumber value="${finalPrice}" type="number" groupingUsed="true"/> VND
        </div>

        <!-- More Products -->
        <button class="btn" onclick="location.href='homecontroller'">➕ Choose More Products</button>
      </div>

      <div class="discount-info">
        <h3>DISCOUNTS FOR PURCHASES</h3>
        <ul>
          <li class="green">🟢 From 10M VND → 5% <c:if test="${beforePrice>=10000000 && beforePrice<50000000}">✅</c:if><c:if test="${beforePrice<10000000}">(Add <fmt:formatNumber value="${10000000-beforePrice}" type="number" groupingUsed="true"/> more)</c:if></li>
          <li class="blue">🔵 From 50M VND → 7% <c:if test="${beforePrice>=50000000 && beforePrice<100000000}">✅</c:if><c:if test="${beforePrice<50000000}">(Add <fmt:formatNumber value="${50000000-beforePrice}" type="number" groupingUsed="true"/> more)</c:if></li>
          <li class="red">🔴 From 100M VND → 10% <c:if test="${beforePrice>=100000000}">✅</c:if><c:if test="${beforePrice<100000000}">(Add <fmt:formatNumber value="${100000000-beforePrice}" type="number" groupingUsed="true"/> more)</c:if></li>
        </ul>
      </div>

      <!-- Checkout Button -->
      <form id="checkoutForm" action="cartcontactcontroller" method="get" onsubmit="return prepareCheckout()">
        <input type="hidden" name="beforePrice" value="${beforePrice}">
        <input type="hidden" name="discountRate" value="${discountRate}">
        <input type="hidden" name="discountAmount" value="${discountAmount}">
        <input type="hidden" name="finalPrice" value="${finalPrice}">
        <button type="submit" class="checkout-btn">✅ Proceed to Checkout</button>
      </form>
    </div>
  </div>

  <jsp:include page="../CommonPage/Footer.jsp"/>

  <script>
    function toggleCheckboxes(src){ document.getElementsByName('selectedProducts').forEach(cb=>cb.checked=src.checked); }
    function prepareCheckout(){ const sel=document.querySelectorAll('input[name="selectedProducts"]:checked'); if(sel.length===0){alert('Select at least one product');return false;} sel.forEach(cb=>{const i=document.createElement('input');i.type='hidden';i.name='selectedProducts';i.value=cb.value;document.getElementById('checkoutForm').append(i);});return true; }
  </script>
</body>
</html>
