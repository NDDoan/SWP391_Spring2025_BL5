<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Danh sách bài viết</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
        <style>
            body { font-family: 'Segoe UI', sans-serif; background-color: #f8f9fa; }
            .container-main { padding: 60px 15px; min-height: 70vh; }
            .list-item { display: flex; background: #fff; margin-bottom: 20px; border-radius: 10px; overflow: hidden; box-shadow: 0 0 10px rgba(0,0,0,0.05); }
            .item-thumb { flex: 0 0 180px; height: 120px; object-fit: cover; }
            .item-content { padding: 15px; flex: 1; }
            .item-content h5 { margin: 0 0 10px; }
            .item-meta { font-size: 0.875rem; color: #6c757d; margin-bottom: 10px; }
            .post-excerpt { max-height: 120px; overflow: hidden; }
            .pagination { justify-content: center; margin-top: 30px; }
        </style>
    </head>
    <body>
        <jsp:include page="/CommonPage/Header.jsp" />
        <div class="container container-main">
            <div class="row">
                <div class="col-md-8 mx-auto">
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger">${errorMessage}</div>
                    </c:if>
                    <!-- List layout: single column -->
                    <c:forEach var="p" items="${blogList}">
                        <div class="list-item">
                            <c:choose>
                                <c:when test="${not empty p.thumbnailUrl}">
                                    <img src="${pageContext.request.contextPath}/${fn:escapeXml(p.thumbnailUrl)}" alt="${fn:escapeXml(p.title)}" class="item-thumb" />
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/default-thumb.png" alt="No image" class="item-thumb" />
                                </c:otherwise>
                            </c:choose>
                            <div class="item-content">
                                <h5><a href="${pageContext.request.contextPath}/BlogDetailController?postId=${p.postId}" class="text-dark text-decoration-none">${fn:escapeXml(p.title)}</a></h5>
                                <p class="item-meta">${p.categoryName} | bởi ${p.authorName} | <fmt:formatDate value="${p.createdAt}" pattern="dd/MM/yyyy HH:mm"/></p>
                                <div class="post-excerpt">
                                    <!-- Render CKEditor HTML output without escaping -->
                                    <c:out value="${p.content}" escapeXml="false"/>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <!-- Pagination -->
                    <nav>
                        <ul id="pagination" class="pagination"></ul>
                    </nav>
                </div>
                <div class="col-md-4 sidebar">
                    <div class="card mb-4">
                        <div class="card-body">
                            <h5 class="card-title">Tìm kiếm</h5>
                            <form action="${pageContext.request.contextPath}/BlogListController" method="get">
                                <div class="input-group">
                                    <input type="text" name="search" class="form-control" placeholder="Tìm kiếm bài viết..." value="${fn:escapeXml(searchKeyword)}" />
                                    <button class="btn btn-warning" type="submit"><i class="fas fa-search"></i></button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Bài mới nhất</h5>
                            <ul class="list-unstyled">
                                <c:forEach var="p" items="${newestList}">
                                    <li><a href="${pageContext.request.contextPath}/BlogDetailController?postId=${p.postId}">${fn:escapeXml(p.title)}</a></li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="/CommonPage/Footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Pagination script -->
        <script>
            var pageSize = 5;
            var currentPage = 1;
            function showPage(page) {
                currentPage = page;
                renderList();
            }
            function renderList() {
                var listEls = document.getElementsByClassName('list-item');
                for (var i = 0; i < listEls.length; i++) {
                    listEls[i].style.display = (i >= (currentPage-1)*pageSize && i < currentPage*pageSize) ? 'flex' : 'none';
                }
                renderPagination();
            }
            function renderPagination() {
                var listEls = document.getElementsByClassName('list-item');
                var totalPages = Math.ceil(listEls.length / pageSize);
                var ul = document.getElementById('pagination');
                ul.innerHTML = '';
                for (var i = 1; i <= totalPages; i++) {
                    var li = document.createElement('li');
                    li.className = 'page-item' + (i === currentPage ? ' active' : '');
                    var a = document.createElement('a');
                    a.className = 'page-link';
                    a.href = '#';
                    a.innerText = i;
                    a.onclick = (function(page) { return function() { showPage(page); return false; }; })(i);
                    li.appendChild(a);
                    ul.appendChild(li);
                }
            }
            document.addEventListener('DOMContentLoaded', function() { showPage(1); });
        </script>
    </body>
</html>