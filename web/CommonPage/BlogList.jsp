<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <title>Blog List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <div class="row">
        <!-- Main Content -->
        <div class="col-md-8">
            <h2>Latest Blog Posts</h2>
            <c:forEach var="b" items="${blogs}">
                <div class="card mb-3">
                    <div class="card-body">
                        <h5 class="card-title">${b.title}</h5>
                        <p class="card-text">
                            ${fn:substring(b.content, 0, 150)}...
                        </p>
                        <p class="card-text"><small class="text-muted">Updated on ${b.updatedAt}</small></p>
                        <a href="blog-detail.jsp?id=${b.blogId}" class="btn btn-primary">Read More</a>
                    </div>
                </div>
            </c:forEach>


            <!-- Pagination -->
            <nav>
                <ul class="pagination">
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${i == pageIndex ? 'active' : ''}">
                            <a class="page-link" href="BlogList?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
        </div>

        <!-- Sidebar -->
        <div class="col-md-4">
            <!-- Search -->
            <form action="BlogSearch" method="get" class="mb-4">
                <div class="input-group">
                    <input type="text" name="keyword" class="form-control" placeholder="Search blogs...">
                    <button class="btn btn-outline-secondary" type="submit">Search</button>
                </div>
            </form>

            <!-- Latest Blogs -->
            <h5>Latest Blogs</h5>
            <ul class="list-group mb-4">
                <c:forEach var="lb" items="${latestBlogs}">
                    <li class="list-group-item">
                        <a href="blog-detail.jsp?id=${lb.id}">${lb.title}</a>
                    </li>
                </c:forEach>
            </ul>

            <!-- Static Links -->
            <h5>Contact / Links</h5>
            <ul class="list-group">
                <li class="list-group-item"><a href="#">About Us</a></li>
                <li class="list-group-item"><a href="#">Contact</a></li>
                <li class="list-group-item"><a href="#">Privacy Policy</a></li>
            </ul>
        </div>
    </div>
</div>
</body>
</html>
