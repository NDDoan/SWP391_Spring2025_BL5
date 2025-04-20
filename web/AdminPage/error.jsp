<%-- 
    Document   : error
    Created on : Apr 16, 2025, 10:18:42 PM
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Error - Manager Page</title>
        <!-- Sử dụng Bootstrap CSS CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
                padding-top: 50px;
            }
            .error-container {
                max-width: 600px;
                margin: auto;
            }
        </style>
    </head>
    <body>
        <div class="container error-container">
            <div class="alert alert-danger text-center" role="alert">
                <h4 class="alert-heading">Đã xảy ra lỗi!</h4>
                <p>${errorMessage != null ? errorMessage : "Có lỗi xảy ra trong quá trình xử lý."}</p>
                <hr>
                <a href="${pageContext.request.contextPath}/ProductForManagerListController" class="btn btn-primary">Quay lại danh sách sản phẩm</a>
            </div>
        </div>

        <!-- Bootstrap JS Bundle CDN (bao gồm Popper) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
