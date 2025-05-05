<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <title>Checkout - Customer Information</title>
    <!-- FontAwesome -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
    />
    <style>
      /* Global styles */
      body {
        font-family: Arial, sans-serif;
        background: #f4f4f4;
        margin: 0;
        padding: 0;
      }
      .cart-container {
        width: 80%;
        background: #fff;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        margin: 40px auto;
      }

      .btn {
        background: #007bff;
        color: white;
        padding: 8px 15px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s;
      }

      .btn:hover {
        background: #0056b3;
      }

      .btn-back {
        background-color: #28a745;
      }

      .btn-back:hover {
        background-color: #218838;
      }

      .search-box {
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 5px;
        margin: 0 10px;
      }

      .cart-wrapper {
        display: flex;
        flex-direction: column;
        gap: 20px;
        margin-top: 20px;
      }

      @media (min-width: 992px) {
        .cart-wrapper {
          flex-direction: row;
        }
      }

      .cart-content,
      .customer-info {
        padding: 15px;
        border-radius: 8px;
      }

      .cart-content {
        flex: 6;
        background: #f9f9f9;
      }

      .customer-info {
        flex: 4;
        background: #f0f8ff;
      }

      .cart-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
      }

      .cart-table th,
      .cart-table td {
        padding: 10px;
        border-bottom: 1px solid #ddd;
        text-align: center;
      }

      .cart-table th {
        background: #007bff;
        color: #fff;
      }

      .form-group {
        margin-bottom: 15px;
      }

      .form-group label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
        color: #333;
      }

      .form-control {
        width: 100%;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
      }

      .form-control:focus {
        border-color: #0056b3;
        outline: none;
        box-shadow: 0 0 5px rgba(0, 86, 179, 0.5);
      }

      .error-message {
        color: #dc3545;
        font-size: 14px;
        margin-top: 5px;
      }

      .price-summary {
        background: #f0f0f0;
        padding: 10px 15px;
        border-radius: 5px;
        margin: 15px 0;
        line-height: 1.6;
      }

      .required {
        color: red;
      }

      .submit-order-btn {
        background: #28a745;
        color: white;
        font-size: 18px;
        padding: 12px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        width: 100%;
        margin-top: 15px;
        transition: background-color 0.3s;
      }

      .submit-order-btn:hover {
        background: #218838;
      }

      .product-thumbnail {
        width: 50px;
        height: 50px;
        object-fit: cover;
        border-radius: 4px;
      }
    </style>
  </head>

  <body>
    <jsp:include page="/CommonPage/Header.jsp"/>

    <div class="cart-container">
      <!-- Error Alert -->
      <c:if test="${not empty error}">
        <div
          id="errorAlert"
          class="alert alert-danger"
          style="position: fixed; top: 20px; left: 50%; transform: translateX(-50%);"
        >
          <strong>Error:</strong> ${error}
          <button
            type="button"
            onclick="this.parentElement.style.display='none'"
            style="background: none; border: none; color: white; font-size: 18px; margin-left: 10px;"
          >
            ✖
          </button>
        </div>
        <script>
          setTimeout(function () {
            var alertBox = document.getElementById('errorAlert');
            if (alertBox) alertBox.style.display = 'none';
          }, 3000);
        </script>
      </c:if>

      <div class="cart-wrapper">
        <!-- Cart Content -->
        <div class="cart-content">
          <div class="d-flex justify-content-between align-items-center mb-3">
            <button
              onclick="window.location.href='cartdetailcontroller'"
              class="btn btn-back"
            >
              ⬅ Back to Cart
            </button>
            <div class="d-flex align-items-center">
              <input
                type="text"
                class="search-box"
                placeholder="Search..."
              />
              <button class="btn ms-2">
                <i class="fas fa-search"></i>
              </button>
            </div>
          </div>

          <h3>Selected Products</h3>
          <table class="cart-table">
            <thead>
              <tr>
                <th>ID</th>
                <th>Image</th>
                <th>Name</th>
                <th>Price</th>
                <th>Discount</th>
                <th>Qty</th>
                <th>Total</th>
              </tr>
            </thead>
            <tbody>
              <c:choose>
                <c:when test="${empty cartDetails}">
                  <tr>
                    <td colspan="7" style="color: red; text-align: center;">
                      No products selected!
                    </td>
                  </tr>
                </c:when>
                <c:otherwise>
                  <c:forEach var="item" items="${cartDetails}">
                    <tr>
                      <td>${item.productId}</td>
                      <td>
                        <c:if test="${not empty item.imageUrl}">
                          <img
                            src="${item.imageUrl}"
                            alt="${item.productName}"
                            class="product-thumbnail"
                          />
                        </c:if>
                        <c:if test="${empty item.imageUrl}">
                          <div
                            style="width:50px; height:50px; background:#eee; display:flex; align-items:center; justify-content:center; border-radius:4px;"
                          >
                            <i class="fas fa-image"></i>
                          </div>
                        </c:if>
                      </td>
                      <td>${item.productName}</td>
                      <td>
                        <fmt:formatNumber value="${item.price}" type="number" groupingUsed="true" />
                        VND
                      </td>
                      <td>
                        <c:choose>
                          <c:when test="${item.discountPrice == 0.0}">
                            <span style="color:#999;">No discount</span>
                          </c:when>
                          <c:otherwise>
                            <fmt:formatNumber
                              value="${item.discountPrice}"
                              type="number"
                              groupingUsed="true"
                            />
                            VND
                          </c:otherwise>
                        </c:choose>
                      </td>
                      <td>${item.quantity}</td>
                      <td>
                        <fmt:formatNumber
                          value="${item.totalPrice}"
                          type="number"
                          groupingUsed="true"
                        />
                        VND
                      </td>
                    </tr>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
            </tbody>
          </table>

          <div class="price-summary">
            <c:if test="${discountRate > 0}">
              🎯 <b>You have a discount!</b> You've crossed
              <fmt:formatNumber
                value="${beforePrice}"
                type="number"
                groupingUsed="true"
              />
              VND → <b>${discountRate}%</b>
              <br />💰 -<fmt:formatNumber
                value="${discountAmount}"
                type="number"
                groupingUsed="true"
              />
              VND
            </c:if>
          </div>
        </div>

        <!-- Customer Form -->
        <div class="customer-info">
          <h3>Customer Information</h3>
          <form
            action="cartcontactcontroller"
            method="post"
            id="checkoutForm"
            onsubmit="return validateForm()"
          >
            <div class="form-group">
    <label for="fullName">Full Name <span class="required">*</span></label>
    <input type="text" id="fullName" name="fullName" class="form-control" required value="${contactInfo.fullName}" placeholder="Enter your full name">
    <div id="fullNameError" class="error-message"></div>
</div>
<div class="form-group">
    <label>Gender <span class="required">*</span></label>
    <div class="radio-group">
        <label><input type="radio" name="gender" value="Male" ${contactInfo.gender eq 'Male' ? 'checked' : ''} required> Male</label>
        <label><input type="radio" name="gender" value="Female" ${contactInfo.gender eq 'Female' ? 'checked' : ''}> Female</label>
        <label><input type="radio" name="gender" value="Other" ${contactInfo.gender eq 'Other' ? 'checked' : ''}> Other</label>
    </div>
    <div id="genderError" class="error-message"></div>
</div>
<div class="form-group">
    <label for="email">Email <span class="required">*</span></label>
    <input type="email" id="email" name="email" class="form-control" required value="${contactInfo.email}" placeholder="example@email.com">
    <div id="emailError" class="error-message"></div>
</div>
<div class="form-group">
    <label for="phone">Phone Number <span class="required">*</span></label>
    <input type="tel" id="phone" name="phone" class="form-control" required value="${contactInfo.phone}" placeholder="Enter your phone number">
    <div id="phoneError" class="error-message"></div>
</div>
<div class="form-group">
    <label for="address">Shipping Address <span class="required">*</span></label>
    <textarea id="address" name="address" class="form-control" required placeholder="Enter your complete shipping address">${contactInfo.address}</textarea>
    <div id="addressError" class="error-message"></div>
</div>
<div class="form-group">
    <label for="notes">Order Notes</label>
    <textarea id="notes" name="notes" class="form-control" placeholder="Special instructions for delivery (optional)">${contactInfo.notes}</textarea>
</div>
<!-- Hidden fields to pass selected products and price information -->
<c:forEach var="prodId" items="${selectedProducts}">
    <input type="hidden" name="selectedProducts" value="${prodId}">
</c:forEach>
<input type="hidden" name="beforePrice" value="${beforePrice}">
<input type="hidden" name="discountRate" value="${discountRate}">
<input type="hidden" name="discountAmount" value="${discountAmount}">
<input type="hidden" name="finalPrice" value="${finalPrice}"> <!-- Thêm lại chỗ này đi -->
            <button type="submit" class="submit-order-btn">
              ✅ Place Order
            </button>
          </form>
        </div>
      </div>
    </div>

    <jsp:include page="/CommonPage/Footer.jsp"/>

    <script>
      function validateForm() {
        let valid = true;
        document.querySelectorAll('.error-message').forEach(el => (el.textContent = ''));
        // validation logic...
        return valid;
      }
    </script>
  </body>
</html>
