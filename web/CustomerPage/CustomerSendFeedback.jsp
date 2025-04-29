<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Product Feedback</title>
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            :root {
                --primary-color: #4CAF50;
                --primary-hover: #45a049;
                --secondary-color: #f8f9fa;
                --text-color: #333;
                --border-color: #ddd;
                --shadow: 0 2px 10px rgba(0,0,0,0.1);
                --border-radius: 8px;
                --star-color: #ffcc00;
                --star-size: 28px;
            }
            
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }
            
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f4f4f4;
                color: var(--text-color);
                line-height: 1.6;
                margin: 0;
                padding: 0;
            }
            
            h2 {
                color: var(--text-color);
                text-align: center;
                margin-bottom: 20px;
                border-bottom: 2px solid var(--secondary-color);
                padding-bottom: 15px;
                font-size: 28px;
            }
            
            .message-container {
                margin-bottom: 20px;
            }
            
            .error-message {
                color: #d9534f;
                background-color: #f9e2e2;
                padding: 10px 15px;
                border-radius: var(--border-radius);
                margin-bottom: 15px;
            }
            
            .success-message {
                color: #5cb85c;
                background-color: #e7f4e7;
                padding: 10px 15px;
                border-radius: var(--border-radius);
                margin-bottom: 15px;
            }
            
            .warning-message {
                color: #856404;
                background-color: #fff3cd;
                padding: 10px 15px;
                border-radius: var(--border-radius);
                margin-bottom: 15px;
            }
            
            /* Horizontal Layout */
            .feedback-panel {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                margin-bottom: 30px;
            }
            
            .product-section {
                flex: 1;
                min-width: 300px;
                background-color: var(--secondary-color);
                border-radius: var(--border-radius);
                padding: 20px;
                box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            }
            
            .form-section {
                flex: 2;
                min-width: 450px;
            }
            
            .product-container {
                display: flex;
                align-items: center;
                gap: 20px;
                margin-bottom: 20px;
            }
            
            .product-image {
                width: 120px;
                height: 120px;
                object-fit: cover;
                border-radius: var(--border-radius);
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }
            
            .product-info {
                flex-grow: 1;
            }
            
            .product-name {
                font-weight: bold;
                font-size: 20px;
                margin-bottom: 8px;
                color: #0066cc;
            }
            
            .product-description {
                margin-bottom: 15px;
                color: #555;
            }
            
            .product-details {
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
            }
            
            .product-price, .product-quantity {
                background: white;
                padding: 4px 12px;
                border-radius: 30px;
                box-shadow: 0 1px 3px rgba(0,0,0,0.1);
                font-size: 14px;
            }
            
            /* Form Layout */
            .feedback-form {
                display: flex;
                flex-direction: column;
                gap: 20px;
                background: white;
                padding: 25px;
                border-radius: var(--border-radius);
                box-shadow: var(--shadow);
            }
            
            .form-row {
                display: flex;
                gap: 20px;
                margin-bottom: 15px;
            }
            
            .form-col {
                flex: 1;
                min-width: 200px;
            }
            
            .section-title {
                font-size: 18px;
                font-weight: 600;
                margin-bottom: 15px;
                color: #333;
                display: flex;
                align-items: center;
            }
            
            .section-title i {
                margin-right: 8px;
                color: var(--primary-color);
            }
            
            /* Rating Stars */
            .rating {
                margin-bottom: 15px;
            }
            
            .stars {
                display: flex;
                flex-direction: row-reverse;
                justify-content: flex-start;
            }
            
            .stars input {
                display: none;
            }
            
            .stars label {
                cursor: pointer;
                font-size: var(--star-size);
                color: #ddd;
                margin-right: 5px;
                transition: color 0.2s ease-in-out;
            }
            
            .stars label:before {
                content: "★";
            }
            
            .stars input:checked ~ label {
                color: var(--star-color);
                text-shadow: 0 0 5px rgba(255, 204, 0, 0.5);
            }
            
            .stars:not(:checked) > label:hover,
            .stars:not(:checked) > label:hover ~ label {
                color: var(--star-color);
            }
            
            .stars-text {
                margin-top: 10px;
                font-size: 14px;
                color: #555;
                min-height: 20px;
            }
            
            /* Comment Section */
            textarea {
                width: 100%;
                height: 120px;
                padding: 15px;
                border: 1px solid var(--border-color);
                border-radius: var(--border-radius);
                resize: vertical;
                font-family: inherit;
                font-size: 15px;
                transition: border-color 0.3s;
            }
            
            textarea:focus {
                outline: none;
                border-color: var(--primary-color);
                box-shadow: 0 0 0 2px rgba(76, 175, 80, 0.25);
            }
            
            /* Image and Video Upload */
            .image-preview {
                width: 110px;
                position: relative;
                margin-bottom: 8px;
                background: white;
                padding: 5px;
                border-radius: 5px;
                box-shadow: 0 1px 3px rgba(0,0,0,0.2);
            }
            
            .image-preview img, 
            .image-preview video {
                width: 100%;
                height: 90px;
                object-fit: cover;
                border-radius: 3px;
            }
            
            .video-preview {
                width: 150px;
                position: relative;
                margin-bottom: 8px;
                background: white;
                padding: 5px;
                border-radius: 5px;
                box-shadow: 0 1px 3px rgba(0,0,0,0.2);
            }
            
            .video-preview video {
                width: 100%;
                height: 100px;
                object-fit: cover;
                border-radius: 3px;
            }
            
            .play-icon {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                color: white;
                font-size: 24px;
                text-shadow: 0 0 5px rgba(0,0,0,0.7);
                pointer-events: none;
            }
            
            .media-type-badge {
                position: absolute;
                bottom: 25px;
                right: 5px;
                background: rgba(0,0,0,0.6);
                color: white;
                font-size: 10px;
                padding: 2px 5px;
                border-radius: 3px;
            }
            
            /* Image Upload */
            .image-upload {
                border: 2px dashed var(--border-color);
                padding: 20px;
                border-radius: var(--border-radius);
                background-color: #f9f9f9;
            }
            
            .upload-title {
                display: flex;
                align-items: center;
                margin-bottom: 15px;
            }
            
            .upload-title i {
                font-size: 22px;
                margin-right: 10px;
                color: #6c757d;
            }
            
            .file-upload-container {
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            
            .file-upload-btn {
                background-color: #e9ecef;
                color: #495057;
                border: 1px solid #ced4da;
                padding: 10px 20px;
                border-radius: var(--border-radius);
                cursor: pointer;
                display: inline-flex;
                align-items: center;
                transition: all 0.3s;
                margin-bottom: 10px;
            }
            
            .file-upload-btn:hover {
                background-color: #dde2e6;
            }
            
            .file-upload-btn i {
                margin-right: 8px;
            }
            
            .file-upload-input {
                opacity: 0;
                position: absolute;
                z-index: -1;
            }
            
            .file-info {
                font-size: 13px;
                color: #6c757d;
                margin: 5px 0;
                text-align: center;
            }
            
            .image-preview-container {
                display: flex;
                flex-wrap: wrap;
                gap: 15px;
                margin-top: 15px;
                justify-content: flex-start;
            }
            
            .file-name {
                font-size: 11px;
                text-align: center;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
                margin-top: 5px;
                color: #555;
            }
            
            .image-preview .remove-btn {
                position: absolute;
                top: -8px;
                right: -8px;
                background: #ff5252;
                color: white;
                border-radius: 50%;
                width: 20px;
                height: 20px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                font-size: 10px;
                box-shadow: 0 1px 3px rgba(0,0,0,0.3);
            }
            
            /* Submit Button */
            button[type="submit"] {
                background-color: var(--primary-color);
                color: white;
                border: none;
                padding: 12px 24px;
                border-radius: var(--border-radius);
                cursor: pointer;
                font-size: 16px;
                font-weight: 600;
                transition: background-color 0.3s, transform 0.2s;
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 20px;
                align-self: flex-end;
                min-width: 150px;
            }
            
            button[type="submit"] i {
                margin-right: 10px;
            }
            
            button[type="submit"]:hover {
                background-color: var(--primary-hover);
                transform: translateY(-2px);
            }
            
            button[type="submit"]:active {
                transform: translateY(0);
            }
            
            /* Back Link */
            .back-link {
                margin-top: 20px;
                display: block;
                text-align: center;
                color: #6c757d;
                text-decoration: none;
                font-weight: 500;
                transition: color 0.3s;
            }
            
            .back-link:hover {
                color: #007bff;
            }
            
            .back-link i {
                margin-right: 5px;
            }
            
            /* Edit Mode Header */
            .edit-mode-header {
                background-color: #e9ecef;
                padding: 10px 15px;
                border-radius: var(--border-radius);
                margin-bottom: 15px;
                font-weight: bold;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
            
            .edit-mode-header i {
                margin-right: 8px;
                color: #0066cc;
            }
            
            /* Action Buttons */
            .action-buttons {
                display: flex;
                gap: 10px;
                margin-top: 20px;
                justify-content: flex-end;
            }
            
            .edit-btn, .delete-btn {
                padding: 10px 20px;
                border-radius: var(--border-radius);
                cursor: pointer;
                font-size: 14px;
                font-weight: 600;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.3s;
            }
            
            .edit-btn {
                background-color: #0066cc;
                color: white;
                border: none;
            }
            
            .edit-btn:hover {
                background-color: #0056b3;
            }
            
            .delete-btn {
                background-color: #dc3545;
                color: white;
                border: none;
            }
            
            .delete-btn:hover {
                background-color: #c82333;
            }
            
            .edit-btn i, .delete-btn i {
                margin-right: 8px;
            }
            
            /* Existing Image Preview */
            .existing-image-preview {
                display: flex;
                flex-wrap: wrap;
                gap: 15px;
                margin-top: 15px;
            }
            
            /* Confirm Delete Modal */
            .modal {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.5);
                z-index: 1000;
                justify-content: center;
                align-items: center;
            }
            
            .modal-content {
                background-color: white;
                padding: 25px;
                border-radius: var(--border-radius);
                width: 400px;
                max-width: 90%;
                box-shadow: 0 5px 15px rgba(0,0,0,0.3);
            }
            
            .modal-title {
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 15px;
            }
            
            .modal-buttons {
                display: flex;
                justify-content: flex-end;
                gap: 10px;
                margin-top: 20px;
            }
            
            .modal-btn {
                padding: 8px 15px;
                border-radius: var(--border-radius);
                cursor: pointer;
                font-size: 14px;
                font-weight: 600;
            }
            
            .confirm-btn {
                background-color: #dc3545;
                color: white;
                border: none;
            }
            
            .cancel-btn {
                background-color: #6c757d;
                color: white;
                border: none;
            }
            
            /* Responsiveness */
            @media (max-width: 992px) {
                .feedback-panel {
                    flex-direction: column;
                }
                
                .product-section, .form-section {
                    width: 100%;
                }
                
                .form-row {
                    flex-direction: column;
                }
            }
            
            @media (max-width: 768px) {
                .container {
                    width: 95%;
                    padding: 15px;
                }
                
                .product-container {
                    flex-direction: column;
                    text-align: center;
                }
                
                .product-image {
                    margin: 0 auto 15px;
                }
                
                .product-details {
                    justify-content: center;
                }
                
                .stars label {
                    font-size: 24px;
                }
            }
        </style>
    </head>
    <body>
        
        <!-- Header -->
        <jsp:include page="../CommonPage/Header.jsp"/>
        
        <div class="container">
            <h2>Đánh giá sản phẩm</h2>
            
            <div class="message-container">
                <c:if test="${not empty errorMessage}">
                    <div class="error-message">
                        <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                    </div>
                </c:if>
                
                <c:if test="${not empty successMessage}">
                    <div class="success-message">
                        <i class="fas fa-check-circle"></i> ${successMessage}
                    </div>
                </c:if>
                
                <c:if test="${not empty warningMessage}">
                    <div class="warning-message">
                        <i class="fas fa-exclamation-triangle"></i> ${warningMessage}
                    </div>
                </c:if>
            </div>
            
            <c:forEach var="product" items="${products}">
                <c:set var="existingReview" value="${requestScope['existingReview_'.concat(product.id)]}" />
                <c:set var="reviewImages" value="${requestScope['reviewImages_'.concat(product.id)]}" />
                
                <div class="feedback-panel">
                    <!-- Product Information Section -->
                    <div class="product-section">
                        <div class="product-container">
                            <img src="${product.imageUrl}" alt="${product.name}" class="product-image">
                            <div class="product-info">
                                <div class="product-name">${product.name}</div>
                                <p class="product-description">Chúng tôi rất muốn nghe suy nghĩ của bạn về sản phẩm này!</p>
                                <div class="product-details">
                                    <span class="product-price"><i class="fas fa-tag"></i> $${product.price}</span>
                                    <span class="product-quantity"><i class="fas fa-box"></i> Qty: ${product.quantity}</span>
                                </div>
                            </div>
                        </div>
                        
                        <div class="instructions">
                            <div class="section-title">
                                <i class="fas fa-info-circle"></i> Hướng dẫn gửi phản hồi
                            </div>
                            <ol style="padding-left: 20px;">
                                <li>Đánh giá sản phẩm trao số sao</li>
                                <li>Chia sẻ ý kiến chân thành của bạn trong phần bình luận</li>
                                <li>Thêm ảnh hoặc video của sản phẩm (tùy chọn)</li>
                                <li>Gửi phản hồi của bạn</li>
                            </ol>
                            <p style="margin-top: 15px; font-style: italic;">Phản hồi của bạn sẽ giúp những khách hàng khác đưa ra quyết định sáng suốt!</p>
                        </div>
                    </div>
                    
                    <!-- Feedback Form Section -->
                    <div class="form-section">
                        <c:choose>
                            <c:when test="${not empty existingReview}">
                                <!-- Edit/View Existing Feedback -->
                                <div class="edit-mode-header">
                                    <span><i class="fas fa-edit"></i> Bạn đã cung cấp phản hồi cho sản phẩm này</span>
                                    <div class="action-buttons">
                                        <button type="button" class="edit-btn" onclick="enableEditMode(${product.id})">
                                            <i class="fas fa-pencil-alt"></i> Chỉnh sửa
                                        </button>
                                        <button type="button" class="delete-btn" onclick="showDeleteConfirmation(${product.id}, ${existingReview.reviewId})">
                                            <i class="fas fa-trash-alt"></i> Xóa
                                        </button>
                                    </div>
                                </div>
                                
                                <!-- View-only form - will be hidden in edit mode -->
                                <div id="viewForm${product.id}" class="feedback-form">
                                    <div class="form-row">
                                        <div class="form-col">
                                            <div class="section-title">
                                                <i class="fas fa-star"></i> Xếp hạng của bạn
                                            </div>
                                            <div class="rating">
                                                <div class="stars view-only">
                                                    <c:forEach begin="1" end="5" var="star">
                                                        <span class="star ${star <= existingReview.rating ? 'active' : ''}">★</span>
                                                    </c:forEach>
                                                </div>
                                                <div class="stars-text">
                                                    <c:choose>
                                                        <c:when test="${existingReview.rating == 5}">Mười điểm không có nhưng</c:when>
                                                        <c:when test="${existingReview.rating == 4}">Tuyệt lắm nhưng chỉ được chín</c:when>
                                                        <c:when test="${existingReview.rating == 3}">Dùng cũng được</c:when>
                                                        <c:when test="${existingReview.rating == 2}">Xài thì được chứ tôi không thích lắm</c:when>
                                                        <c:when test="${existingReview.rating == 1}">Phí tiền 💸💸💸</c:when>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="form-row">
                                        <div class="form-col">
                                            <div class="section-title">
                                                <i class="fas fa-comment"></i> Phản hồi của bạn
                                            </div>
                                            <div style="padding: 15px; border: 1px solid #ddd; border-radius: 8px; background-color: #f9f9f9;">
                                                ${existingReview.comment}
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <c:if test="${not empty reviewImages}">
                                        <div class="form-row">
                                            <div class="form-col">
                                                <div class="section-title">
                                                    <i class="fas fa-images"></i> Ảnh/Video của bạn
                                                </div>
                                                <div class="existing-image-preview">
                                                    <c:forEach items="${reviewImages}" var="image">
                                                        <div class="${fn:endsWith(image.imageUrl, '.mp4') || fn:endsWith(image.imageUrl, '.webm') || fn:endsWith(image.imageUrl, '.mov') ? 'video-preview' : 'image-preview'}">
                                                            <c:choose>
                                                                <c:when test="${fn:endsWith(image.imageUrl, '.mp4') || fn:endsWith(image.imageUrl, '.webm') || fn:endsWith(image.imageUrl, '.mov')}">
                                                                    <video src="${image.imageUrl}" controlsList="nodownload" 
                                                                           onclick="playPauseVideo(this)" preload="metadata">
                                                                        Trình duyệt của bạn không hỗ trợ thẻ video.
                                                                    </video>
                                                                    <div class="play-icon"><i class="fas fa-play"></i></div>
                                                                    <div class="media-type-badge">VIDEO</div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <img src="${image.imageUrl}" alt="Review Image">
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <div class="file-name">Đăng ảnh/video</div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>
                                
                                <!-- Edit form - hidden by default -->
                                <form action="CustomerSendFeedback" method="post" enctype="multipart/form-data" 
                                      id="editForm${product.id}" class="feedback-form" style="display: none;">
                                    <input type="hidden" name="orderId" value="${orderId}">
                                    <input type="hidden" name="productId" value="${product.id}">
                                    <input type="hidden" name="reviewId" value="${existingReview.reviewId}">
                                    <input type="hidden" name="action" value="update">
                                    
                                    <div class="form-row">
                                        <div class="form-col">
                                            <div class="section-title">
                                                <i class="fas fa-star"></i> Cập nhật đánh giá của bạn
                                            </div>
                                            <div class="rating">
                                                <div class="stars">
                                                    <input type="radio" id="star5${product.id}" name="rating" value="5" ${existingReview.rating == 5 ? 'checked' : ''} required>
                                                    <label for="star5${product.id}" title="5 stars - Excellent"></label>
                                                    <input type="radio" id="star4${product.id}" name="rating" value="4" ${existingReview.rating == 4 ? 'checked' : ''}>
                                                    <label for="star4${product.id}" title="4 stars - Very Good"></label>
                                                    <input type="radio" id="star3${product.id}" name="rating" value="3" ${existingReview.rating == 3 ? 'checked' : ''}>
                                                    <label for="star3${product.id}" title="3 stars - Good"></label>
                                                    <input type="radio" id="star2${product.id}" name="rating" value="2" ${existingReview.rating == 2 ? 'checked' : ''}>
                                                    <label for="star2${product.id}" title="2 stars - Fair"></label>
                                                    <input type="radio" id="star1${product.id}" name="rating" value="1" ${existingReview.rating == 1 ? 'checked' : ''}>
                                                    <label for="star1${product.id}" title="1 star - Poor"></label>
                                                </div>
                                                <div class="stars-text" id="ratingText${product.id}">
                                                    <c:choose>
                                                        <c:when test="${existingReview.rating == 5}">Mười điểm không có nhưng</c:when>
                                                        <c:when test="${existingReview.rating == 4}">Tuyệt lắm nhưng chỉ được chín</c:when>
                                                        <c:when test="${existingReview.rating == 3}">Dùng cũng được</c:when>
                                                        <c:when test="${existingReview.rating == 2}">Xài thì được chứ tôi không thích lắm</c:when>
                                                        <c:when test="${existingReview.rating == 1}">Phí tiền 💸💸💸</c:when>
                                                        <c:otherwise>Nhấp để đánh giá</c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="form-row">
                                        <div class="form-col">
                                            <div class="section-title">
                                                <i class="fas fa-comment"></i> Cập nhật phản hồi của bạn
                                            </div>
                                            <textarea name="comment" placeholder="Share your experience with this product. What did you like or dislike? Would you recommend it to others?" required>${existingReview.comment}</textarea>
                                        </div>
                                    </div>
                                    
                                    <c:if test="${not empty reviewImages}">
                                        <div class="form-row">
                                            <div class="form-col">
                                                <div class="section-title">
                                                    <i class="fas fa-images"></i> Ảnh/Video hiện tại
                                                    <span style="margin-left: auto; font-size: 14px; color: #dc3545; cursor: pointer;" 
                                                          onclick="toggleDeleteImages(${product.id})">
                                                        <i class="fas fa-trash-alt"></i> <span id="deleteImagesText${product.id}">Xóa tất cả ảnh/video</span>
                                                    </span>
                                                </div>
                                                <input type="hidden" id="deleteImages${product.id}" name="deleteImages" value="false">
                                                <div class="existing-image-preview" id="existingImages${product.id}">
                                                    <c:forEach items="${reviewImages}" var="image">
                                                        <div class="${fn:endsWith(image.imageUrl, '.mp4') || fn:endsWith(image.imageUrl, '.webm') || fn:endsWith(image.imageUrl, '.mov') ? 'video-preview' : 'image-preview'}">
                                                            <c:choose>
                                                                <c:when test="${fn:endsWith(image.imageUrl, '.mp4') || fn:endsWith(image.imageUrl, '.webm') || fn:endsWith(image.imageUrl, '.mov')}">
                                                                    <video src="${image.imageUrl}" controlsList="nodownload" 
                                                                           onclick="playPauseVideo(this)" preload="metadata">
                                                                        Trình duyệt của bạn không hỗ trợ thẻ video.
                                                                    </video>
                                                                    <div class="play-icon"><i class="fas fa-play"></i></div>
                                                                    <div class="media-type-badge">VIDEO</div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <img src="${image.imageUrl}" alt="Review Image">
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <div class="file-name">Cập nhật ảnh/video</div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                    
                                    <div class="form-row">
                                        <div class="form-col">
                                            <div class="image-upload">
                                                <div class="upload-title">
                                                    <i class="fas fa-camera"></i>
                                                    <span>
                                                        <c:choose>
                                                            <c:when test="${empty reviewImages}">Thêm nhiều ảnh/video hơn (tùy chọn - tối đa 5 ảnh/video)</c:when>
                                                            <c:otherwise>Thêm nhiều ảnh/video hơn (tùy chọn - tối đa 5 ảnh/video)</c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </div>
                                                
                                                <div class="file-upload-container">
                                                    <label class="file-upload-btn">
                                                        <i class="fas fa-cloud-upload-alt"></i> Chọn tệp tin
                                                        <input type="file" name="media[]" id="mediaUpload${product.id}" multiple 
                                                               accept="image/*,video/mp4,video/webm,video/quicktime" 
                                                               onchange="previewMedia(this, ${product.id})" class="file-upload-input">
                                                    </label>
                                                    <div class="file-info">Chọn tối đa 5 tệp (tối đa 15MB cho video, 5MB cho hình ảnh)</div>
                                                    <div id="imagePreview${product.id}" class="image-preview-container"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div style="display: flex; justify-content: space-between; margin-top: 20px;">
                                        <button type="button" class="edit-btn" style="background-color: #6c757d;" 
                                                onclick="cancelEdit(${product.id})">
                                            <i class="fas fa-times"></i> Hủy bỏ
                                        </button>
                                        <button type="submit"><i class="fas fa-save"></i> Cập nhật phản hồi</button>
                                    </div>
                                </form>
                                
                                <!-- Delete confirmation modal -->
                                <div id="deleteModal${product.id}" class="modal">
                                    <div class="modal-content">
                                        <div class="modal-title">
                                            <i class="fas fa-exclamation-triangle" style="color: #dc3545;"></i>
                                            Xác nhận xóa
                                        </div>
                                        <p>Bạn có chắc chắn muốn xóa phản hồi "${product.name}" của bạn?</p>
                                        <p>Bạn không thể hoàn tác hành động này.</p>
                                        <div class="modal-buttons">
                                            <button class="modal-btn cancel-btn" onclick="hideDeleteConfirmation(${product.id})">
                                                Hủy bỏ
                                            </button>
                                            <form action="CustomerSendFeedback" method="post">
                                                <input type="hidden" name="orderId" value="${orderId}">
                                                <input type="hidden" name="productId" value="${product.id}">
                                                <input type="hidden" name="reviewId" value="${existingReview.reviewId}">
                                                <input type="hidden" name="action" value="delete">
                                                <button type="submit" class="modal-btn confirm-btn">
                                                    Xóa
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <!-- New Feedback Form -->
                                <form action="CustomerSendFeedback" method="post" enctype="multipart/form-data" class="feedback-form">
                                    <input type="hidden" name="orderId" value="${orderId}">
                                    <input type="hidden" name="productId" value="${product.id}">
                                    <input type="hidden" name="action" value="add">
                                    
                                    <div class="form-row">
                                        <div class="form-col">
                                            <div class="section-title">
                                                <i class="fas fa-star"></i> Đánh giá sản phẩm này
                                            </div>
                                            <div class="rating">
                                                <div class="stars">
                                                    <input type="radio" id="star5${product.id}" name="rating" value="5" required>
                                                    <label for="star5${product.id}" title="5 stars - Excellent"></label>
                                                    <input type="radio" id="star4${product.id}" name="rating" value="4">
                                                    <label for="star4${product.id}" title="4 stars - Very Good"></label>
                                                    <input type="radio" id="star3${product.id}" name="rating" value="3">
                                                    <label for="star3${product.id}" title="3 stars - Good"></label>
                                                    <input type="radio" id="star2${product.id}" name="rating" value="2">
                                                    <label for="star2${product.id}" title="2 stars - Fair"></label>
                                                    <input type="radio" id="star1${product.id}" name="rating" value="1">
                                                    <label for="star1${product.id}" title="1 star - Poor"></label>
                                                </div>
                                                <div class="stars-text" id="ratingText${product.id}">Nhấp để đánh giá</div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="form-row">
                                        <div class="form-col">
                                            <div class="section-title">
                                                <i class="fas fa-comment"></i> Phản hồi của bạn
                                            </div>
                                            <textarea name="comment" placeholder="Share your experience with this product. What did you like or dislike? Would you recommend it to others?" required></textarea>
                                        </div>
                                    </div>
                                    
                                    <div class="form-row">
                                        <div class="form-col">
                                            <div class="image-upload">
                                                <div class="upload-title">
                                                    <i class="fas fa-camera"></i>
                                                    <span>Thêm nhiều ảnh/video (tùy chọn - tối đa 5 ảnh/video)</span>
                                                </div>
                                                
                                                <div class="file-upload-container">
                                                    <label class="file-upload-btn">
                                                        <i class="fas fa-cloud-upload-alt"></i> Chọn tệp tin
                                                        <input type="file" name="media[]" id="mediaUpload${product.id}" multiple 
                                                               accept="image/*,video/mp4,video/webm,video/quicktime" 
                                                               onchange="previewMedia(this, ${product.id})" class="file-upload-input">
                                                    </label>
                                                    <div class="file-info">Chọn tới 5 ảnh/video (tối đa 15MB cho video, 5MB cho hình ảnh)</div>
                                                    <div id="imagePreview${product.id}" class="image-preview-container"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <button type="submit"><i class="fas fa-paper-plane"></i> Gửi phản hồi</button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:forEach>
            
            <a href="myordercontroller" class="back-link">
                <i class="fas fa-arrow-left"></i> Quay lại đơn hàng của tôi
            </a>
        </div>
        
        <!-- Footer -->
        <jsp:include page="../CommonPage/Footer.jsp"/>
        
        <script>
            // Media preview functionality
            function previewMedia(input, productId) {
                const previewContainer = document.getElementById('imagePreview' + productId);
                previewContainer.innerHTML = '';
                
                // Validate number of files
                if (input.files.length > 5) {
                    alert('You can only upload a maximum of 5 files');
                    input.value = '';
                    return;
                }
                
                // Validate file sizes and create previews
                let totalSize = 0;
                const maxImageSize = 5 * 1024 * 1024; // 5MB
                const maxVideoSize = 15 * 1024 * 1024; // 15MB
                
                for (let i = 0; i < input.files.length; i++) {
                    const file = input.files[i];
                    totalSize += file.size;
                    
                    // Determine file type
                    const isVideo = file.type.startsWith('video/');
                    const maxSize = isVideo ? maxVideoSize : maxImageSize;
                    
                    // Check individual file size
                    if (file.size > maxSize) {
                        alert(`File ${file.name} is too large. Maximum size is ${isVideo ? '15MB for videos' : '5MB for images'}.`);
                        input.value = '';
                        previewContainer.innerHTML = '';
                        return;
                    }
                    
                    // Create preview element
                    const preview = document.createElement('div');
                    preview.className = isVideo ? 'video-preview' : 'image-preview';
                    
                    // Add remove button
                    const removeBtn = document.createElement('div');
                    removeBtn.className = 'remove-btn';
                    removeBtn.innerHTML = '<i class="fas fa-times"></i>';
                    removeBtn.onclick = function() {
                        preview.remove();
                        updateFileInfo(input, productId);
                    };
                    preview.appendChild(removeBtn);
                    
                    // Create media element based on file type
                    if (isVideo) {
                        const video = document.createElement('video');
                        video.src = URL.createObjectURL(file);
                        video.preload = 'metadata';
                        video.onclick = function() { playPauseVideo(this); };
                        video.onloadedmetadata = function() {
                            URL.revokeObjectURL(this.src);
                        };
                        preview.appendChild(video);
                        
                        // Add play icon
                        const playIcon = document.createElement('div');
                        playIcon.className = 'play-icon';
                        playIcon.innerHTML = '<i class="fas fa-play"></i>';
                        preview.appendChild(playIcon);
                        
                        // Add video badge
                        const badge = document.createElement('div');
                        badge.className = 'media-type-badge';
                        badge.textContent = 'VIDEO';
                        preview.appendChild(badge);
                    } else {
                        const img = document.createElement('img');
                        img.src = URL.createObjectURL(file);
                        img.onload = function() {
                            URL.revokeObjectURL(this.src);
                        };
                        preview.appendChild(img);
                    }
                    
                    // Add file name
                    const fileName = document.createElement('div');
                    fileName.className = 'file-name';
                    fileName.textContent = file.name.length > 15 ? file.name.substring(0, 12) + '...' : file.name;
                    fileName.title = file.name;
                    preview.appendChild(fileName);
                    
                    previewContainer.appendChild(preview);
                }
                
                updateFileInfo(input, productId);
            }
            
            // Helper function to play/pause video previews
            function playPauseVideo(video) {
                const playIcon = video.parentElement.querySelector('.play-icon');
                
                if (video.paused) {
                    // Pause all other videos first
                    document.querySelectorAll('video').forEach(v => {
                        if (v !== video && !v.paused) {
                            v.pause();
                            const otherPlayIcon = v.parentElement.querySelector('.play-icon');
                            if (otherPlayIcon) {
                                otherPlayIcon.innerHTML = '<i class="fas fa-play"></i>';
                                otherPlayIcon.style.opacity = '1';
                            }
                        }
                    });
                    
                    // Play this video
                    video.play();
                    if (playIcon) {
                        playIcon.innerHTML = '<i class="fas fa-pause"></i>';
                        playIcon.style.opacity = '0';
                        setTimeout(() => { playIcon.style.opacity = '0'; }, 300);
                    }
                } else {
                    // Pause this video
                    video.pause();
                    if (playIcon) {
                        playIcon.innerHTML = '<i class="fas fa-play"></i>';
                        playIcon.style.opacity = '1';
                    }
                }
            }
            
            // Updated file info function to handle media types
            function updateFileInfo(input, productId) {
                // Update file info text
                const fileInfo = input.parentElement.parentElement.querySelector('.file-info');
                if (input.files.length > 0) {
                    let totalSize = 0;
                    let imageCount = 0;
                    let videoCount = 0;
                    
                    for (let i = 0; i < input.files.length; i++) {
                        totalSize += input.files[i].size;
                        if (input.files[i].type.startsWith('video/')) {
                            videoCount++;
                        } else {
                            imageCount++;
                        }
                    }
                    
                    fileInfo.innerHTML = '<i class="fas fa-check-circle" style="color: green;"></i> ' + 
                                        input.files.length + ' file(s) selected (' + formatFileSize(totalSize) + ') - ' +
                                        imageCount + ' images, ' + videoCount + ' videos';
                } else {
                    fileInfo.textContent = 'Select up to 5 files (max 15MB for videos, 5MB for images)';
                }
            }
            
            function formatFileSize(bytes) {
                if (bytes < 1024) return bytes + ' bytes';
                else if (bytes < 1048576) return (bytes / 1024).toFixed(2) + ' KB';
                else return (bytes / 1048576).toFixed(2) + ' MB';
            }
            
            // Rating text update
            document.addEventListener('DOMContentLoaded', function() {
                const products = document.querySelectorAll('.product-container');
                
                products.forEach(product => {
                    const formSection = product.closest('.feedback-panel').querySelector('.form-section');
                    const productId = formSection.querySelector('input[name="productId"]').value;
                    const stars = formSection.querySelectorAll(`input[name="rating"][id^="star"][id$="${productId}"]`);
                    const ratingText = formSection.querySelector('#ratingText' + productId);
                    
                    stars.forEach(star => {
                        star.addEventListener('change', function() {
                            const ratingValue = this.value;
                            let ratingDescription = '';
                            
                            switch(ratingValue) {
                                case '5': ratingDescription = 'Excellent - I love it!'; break;
                                case '4': ratingDescription = 'Very Good - I like it'; break;
                                case '3': ratingDescription = 'Good - It\'s okay'; break;
                                case '2': ratingDescription = 'Fair - Not that great'; break;
                                case '1': ratingDescription = 'Poor - I didn\'t like it'; break;
                                default: ratingDescription = 'Click to rate';
                            }
                            
                            ratingText.textContent = ratingDescription;
                        });
                    });
                });
            });
            
            // Edit mode functions
            function enableEditMode(productId) {
                document.getElementById('viewForm' + productId).style.display = 'none';
                document.getElementById('editForm' + productId).style.display = 'block';
            }
            
            function cancelEdit(productId) {
                document.getElementById('viewForm' + productId).style.display = 'block';
                document.getElementById('editForm' + productId).style.display = 'none';
                
                // Reset delete images flag
                const deleteImagesInput = document.getElementById('deleteImages' + productId);
                if (deleteImagesInput) {
                    deleteImagesInput.value = 'false';
                }
                
                // Reset existing image preview display
                const existingImagesContainer = document.getElementById('existingImages' + productId);
                if (existingImagesContainer) {
                    existingImagesContainer.style.display = 'flex';
                }
                
                // Reset delete images text
                const deleteImagesText = document.getElementById('deleteImagesText' + productId);
                if (deleteImagesText) {
                    deleteImagesText.textContent = 'Delete all media';
                }
            }
            
            function toggleDeleteImages(productId) {
                const deleteImagesInput = document.getElementById('deleteImages' + productId);
                const existingImagesContainer = document.getElementById('existingImages' + productId);
                const deleteImagesText = document.getElementById('deleteImagesText' + productId);
                
                if (deleteImagesInput.value === 'false') {
                    deleteImagesInput.value = 'true';
                    existingImagesContainer.style.display = 'none';
                    deleteImagesText.textContent = 'Keep media';
                } else {
                    deleteImagesInput.value = 'false';
                    existingImagesContainer.style.display = 'flex';
                    deleteImagesText.textContent = 'Delete all media';
                }
            }
            
            // Delete confirmation modal
            function showDeleteConfirmation(productId, reviewId) {
                document.getElementById('deleteModal' + productId).style.display = 'flex';
            }
            
            function hideDeleteConfirmation(productId) {
                document.getElementById('deleteModal' + productId).style.display = 'none';
            }
            
            // Close modal if clicked outside
            window.onclick = function(event) {
                const modals = document.getElementsByClassName('modal');
                for (let i = 0; i < modals.length; i++) {
                    if (event.target == modals[i]) {
                        modals[i].style.display = 'none';
                    }
                }
            }
        </script>
    </body>
</html>