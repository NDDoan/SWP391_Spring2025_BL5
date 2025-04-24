<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.List, EntityDto.PostDto" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Kết quả tìm kiếm</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <style>
            html, body {
                height: 100%;
                margin: 0;
                display: flex;
                flex-direction: column;
            }
            .main-content {
                flex: 1;
                overflow: auto;
            }
            .thumb {
                width:150px;
                height:100px;
                object-fit:cover;
            }
            .card-post {
                margin-bottom:20px;
            }
            .sidebar .list-unstyled a {
                text-decoration:none;
                color:#007bff;
            }
            .sidebar .list-unstyled a:hover {
                text-decoration:underline;
            }
        </style>
    </head>
    <body>

        <!-- Header -->
        <jsp:include page="/CommonPage/Header.jsp"/>

        <!-- Main content -->
        <div class="main-content container mt-4">
            <div class="row">
                <!-- Kết quả tìm kiếm -->
                <div class="col-md-8">
                    <h2>Kết quả tìm kiếm cho: "<strong>${keyword}</strong>"</h2>

                    <c:if test="${empty searchResults}">
                        <p>Không tìm thấy bài viết phù hợp.</p>
                    </c:if>

                    <c:forEach var="post" items="${searchResults}">
                        <div class="card card-post">
                            <div class="row g-0">
                                <div class="col-md-4">
                                    <img src="${post.thumbnailUrl}" alt="${post.title}" class="thumb img-fluid">
                                </div>
                                <div class="col-md-8">
                                    <div class="card-body">
                                        <h5 class="card-title">${post.title}</h5>
                                        <p class="card-text">
                                            ${fn:length(post.content) > 150 
                                              ? fn:substring(post.content, 0, 150) + "..." 
                                              : post.content}
                                        </p>
                                        <p class="text-muted small">Cập nhật: ${post.createdAt}</p>
                                        <a href="${pageContext.request.contextPath}/BlogDetail?id=${post.postId}" class="btn btn-primary btn-sm">
                                            Xem chi tiết
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Sidebar -->
                <div class="col-md-4 sidebar">
                    <!-- Search -->
                    <div class="mb-4 p-3 bg-white rounded shadow-sm">
                        <form action="${pageContext.request.contextPath}/BlogSearch" method="get">
                            <div class="input-group">
                                <input type="text" name="keyword" class="form-control"
                                       placeholder="Tìm kiếm bài viết..." value="${keyword}"/>
                                <button class="btn btn-outline-secondary" type="submit">Tìm</button>
                            </div>
                        </form>
                    </div>

                    <!-- Bài viết nổi bật -->
                    <div class="mb-4 p-3 bg-white rounded shadow-sm">
                        <h5>Bài viết nổi bật</h5>
                        <ul class="list-unstyled">
                            <c:forEach var="lp" items="${latestBlogs}">
                                <li>
                                    <a href="${pageContext.request.contextPath}/BlogDetail?id=${lp.postId}">
                                        ${lp.title}
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <jsp:include page="/CommonPage/Footer.jsp"/>

    </body>
</html>
