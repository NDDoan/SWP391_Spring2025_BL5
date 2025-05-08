<%-- 
    Document   : contact
    Created on : May 8, 2025, 9:50:44 PM
    Author     : LENOVO
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đang chuyển hướng...</title>
    <!-- Thêm thẻ meta để backup redirect sau 5 giây -->
    <meta http-equiv="refresh" content="5; url=https://www.youtube.com/watch?v=dQw4w9WgXcQ">
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 100px;
        }
        #countdown {
            font-size: 48px;
            color: #333;
        }
    </style>
</head>
<body>
    <h1>Trang sẽ chuyển hướng sau</h1>
    <div id="countdown">5</div>
    <p>Nếu không tự chuyển, <a href="https://www.youtube.com/watch?v=dQw4w9WgXcQ">bấm vào đây</a>.</p>

    <script>
        // Số giây đếm ngược
        let seconds = 5;
        const countdownEl = document.getElementById('countdown');

        const interval = setInterval(() => {
            seconds--;
            countdownEl.textContent = seconds;
            if (seconds <= 0) {
                clearInterval(interval);
                // Thực hiện chuyển hướng bằng JS (nếu meta refresh không hoạt động)
                window.location.href = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ';
            }
        }, 1000);
    </script>
</body>
</html>

