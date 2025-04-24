<%@ page contentType="text/html;charset=UTF-8" language="java" import="EntityDto.PostDto" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><c:out value="${post.title}" /></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f9f9f9; color: #333; line-height: 1.7; }
        .blog-container { background-color: #fff; padding: 40px; border-radius: 12px; box-shadow: 0 8px 24px rgba(0,0,0,0.1); margin: 60px auto; max-width: 800px; }
        .blog-title { font-size: 2.5rem; font-weight: 600; margin-bottom: 15px; }
        .blog-meta { font-size: 0.95rem; color: #888; margin-bottom: 15px; }
        .blog-content { font-size: 1.1rem; margin-top: 30px; }
        .thumbnail { max-width: 100%; height: auto; margin-bottom: 20px; border-radius: 8px; }
        .back-link { margin-top: 30px; display: inline-block; color: #4A90E2; text-decoration: none; font-weight: 500; }
        .back-link:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="blog-container">
        <h1 class="blog-title"><c:out value="${post.title}" /></h1>
        <!-- Display Post ID -->
        <p class="blog-meta">Post ID: <c:out value="${post.postId}" /></p>
        <!-- Display Thumbnail Image -->
        <c:if test="${not empty post.thumbnailUrl}">
            <img src="${post.thumbnailUrl}" alt="Thumbnail for ${post.title}" class="thumbnail" />
        </c:if>
        <!-- Meta Information -->
        <p class="blog-meta">
            <span>Created at: <fmt:formatDate value="${post.createdAt}" pattern="dd/MM/yyyy HH:mm"/></span>
        </p>
        <hr />
        <div class="blog-content">
            <c:out value="${post.content}" escapeXml="false" />
        </div>
        <a href="${pageContext.request.contextPath}/BlogListController" class="back-link">← Quay về danh sách bài viết</a>
    </div>
</body>
</html>
