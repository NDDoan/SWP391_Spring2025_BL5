<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.List,EntityDto.PostDto" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Danh sách bài viết</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
        <style>
            html, body {
                height:100%;
                margin:0;
                display:flex;
                flex-direction:column;
            }
            .main-content {
                flex:1;
                overflow:auto;
                padding-top:20px;
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
        <jsp:include page="/CommonPage/Header.jsp" />

        <div class="main-content container">
            <div class="row">
                <!-- List posts -->
                <div class="col-md-8">
                    <h2>Danh sách bài viết</h2>

                    <!-- Search form -->
                    <form action="${pageContext.request.contextPath}/BlogListController" method="get" class="mb-4">
                        <div class="input-group">
                            <input type="text" name="keyword" class="form-control" placeholder="Tìm kiếm bài viết..."
                                   value="${keyword != null ? keyword : ''}" />
                            <button class="btn btn-outline-secondary" type="submit">Tìm</button>
                        </div>
                    </form>

                    <!-- No posts alert -->
                    <c:if test="${empty posts}">
                        <div class="alert alert-warning">Không tìm thấy bài viết nào.</div>
                    </c:if>

                    <!-- Posts loop -->
                    <c:forEach var="post" items="${posts}">
                        <div class="card card-post">
                            <div class="row g-0">
                                <div class="col-md-4">
                                    <img src="${post.thumbnailUrl}" alt="${post.title}" class="thumb img-fluid" />
                                </div>
                                <div class="col-md-8">
                                    <div class="card-body">
                                        <h5 class="card-title">${post.title}</h5>
                                        <p class="card-text">
                                            ${fn:length(post.content) > 150 ? fn:substring(post.content, 0, 150) + '...' : post.content}
                                        </p>
                                        <p class="text-muted small">Cập nhật: ${post.createdAt}</p>
                                        <a href="${pageContext.request.contextPath}/BlogDetailController?id=${post.postId}" class="btn btn-primary btn-sm">Xem chi tiết</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <!-- Pagination -->
                    <c:if test="${totalPages > 1 && empty keyword}">
                        <nav>
                            <ul class="pagination">
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <c:url var="pageUrl" value="/BlogListController">
                                        <c:param name="page" value="${i}" />
                                    </c:url>
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}${pageUrl}">${i}</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </nav>
                    </c:if>

                </div>

                <!-- Sidebar -->
                <div class="col-md-4 sidebar">
                    <div class="mb-4 p-3 bg-white rounded shadow-sm">
                        <h5>Bài viết nổi bật</h5>
                        <ul class="list-unstyled">
                            <c:forEach var="lp" items="${latestPosts}">
                                <li>
                                    <a href="${pageContext.request.contextPath}/BlogDetailController?id=${lp.postId}">${lp.title}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <jsp:include page="/CommonPage/Footer.jsp" />
    </body>
</html>
