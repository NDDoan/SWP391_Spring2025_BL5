<%-- 
    Tài liệu   : CustomizeTable
    Tạo vào : Mar 3, 2025, 2:32:32 PM
    Tác giả     : Acer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tùy Chỉnh Bảng</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        /* Nút Tùy Chỉnh Bảng */
        .customize-btn {
            background-color: #ff7f50;
            color: white;
            padding: 10px 15px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            border-radius: 5px;
        }

        /* Modal (hộp thoại) ẩn ban đầu */
        .modal {
            display: none; 
            position: fixed; 
            z-index: 1; 
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }

        /* Nội dung modal */
        .modal-content {
            background-color: #3498db;
            margin: 10% auto;
            padding: 20px;
            width: 40%;
            border-radius: 10px;
            color: white;
            position: relative;
        }

        /* Nút đóng modal */
        .close-btn {
            position: absolute;
            top: 10px;
            right: 15px;
            font-size: 22px;
            cursor: pointer;
        }

        /* Ô nhập số dòng */
        input[type="number"] {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
        }

        /* Checkboxes chọn cột */
        .checkbox-group {
            margin: 10px 0;
        }

        /* Nút Áp Dụng */
        .apply-btn {
            background-color: #28a745;
            color: white;
            padding: 10px 15px;
            border: none;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            margin-top: 10px;
            border-radius: 5px;
        }
    </style>
</head>
<body>

    <!-- Nút Tùy Chỉnh Bảng -->
    <button class="customize-btn" onclick="openModal()">Tùy Chỉnh Bảng</button>

    <!-- Modal (Hộp thoại tùy chỉnh) -->
    <div id="customModal" class="modal">
        <div class="modal-content">
            <span class="close-btn" onclick="closeModal()">&times;</span>
            <h2>Tùy Chỉnh Bảng</h2>
            
            <label for="rows">Số Dòng Mỗi Bảng:</label>
            <input type="number" id="rows" min="1" max="100">

            <div class="checkbox-group">
                <label><input type="checkbox" checked> Cột A</label><br>
                <label><input type="checkbox"> Cột B</label><br>
                <label><input type="checkbox"> Cột C</label><br>
            </div>

            <button class="apply-btn" onclick="applySettings()">Áp Dụng Cài Đặt</button>
        </div>
    </div>

    <script>
        // Hiển thị modal
        function openModal() {
            document.getElementById("customModal").style.display = "block";
        }

        // Ẩn modal
        function closeModal() {
            document.getElementById("customModal").style.display = "none";
        }

        // Xử lý khi người dùng bấm Áp Dụng
        function applySettings() {
            let rows = document.getElementById("rows").value;
            alert("Số dòng: " + rows);
            closeModal(); // Đóng modal sau khi áp dụng
        }
    </script>

</body>
</html>
