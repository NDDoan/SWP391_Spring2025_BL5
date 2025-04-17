<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Thêm đơn giao hàng mới</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 30px auto;
            max-width: 600px;
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #2c3e50;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            font-weight: bold;
            margin-top: 10px;
        }

        input[type="text"],
        input[type="number"],
        input[type="date"],
        select,
        textarea {
            padding: 8px;
            margin-top: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        textarea {
            resize: vertical;
        }

        input[type="submit"] {
            margin-top: 20px;
            padding: 10px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #2980b9;
        }

        a {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: #2c3e50;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <h2>Thêm đơn giao hàng mới</h2>

    <form action="shipping" method="post">
        <label for="orderId">Mã đơn hàng:</label>
        <input type="number" name="orderId" id="orderId" required>

        <label for="shippingAddress">Địa chỉ:</label>
        <input type="text" name="shippingAddress" id="shippingAddress" required>

        <label for="shippingStatus">Trạng thái:</label>
        <select name="shippingStatus" id="shippingStatus" required>
            <option value="Pending">Pending</option>
            <option value="Shipped">Shipped</option>
            <option value="Delivered">Delivered</option>
            <option value="Canceled">Canceled</option>
            <option value="Returned">Returned</option>
        </select>

        <label for="trackingNumber">Mã tracking:</label>
        <input type="text" name="trackingNumber" id="trackingNumber">

        <label for="shippingDate">Ngày giao:</label>
        <input type="date" name="shippingDate" id="shippingDate">

        <label for="estimatedDelivery">Ngày dự kiến:</label>
        <input type="date" name="estimatedDelivery" id="estimatedDelivery">

        <label for="deliveryNotes">Ghi chú:</label>
        <textarea name="deliveryNotes" id="deliveryNotes" rows="4"></textarea>

        <input type="submit" value="Tạo mới">
    </form>

    <a href="shipping">⬅ Quay lại danh sách</a>

</body>
</html>
