<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Order Details</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #4A90E2;
                text-align: center;
                margin: 0;
                padding: 0;
            }
            .container {
                width: 80%;
                margin: 30px auto;
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            }
            h2 {
                color: #333;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 12px;
                text-align: center;
            }
            th {
                background-color: #007bff;
                color: white;
            }
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
            .popup-container {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                display: flex;
                justify-content: center;
                align-items: center;
            }
            .popup-content {
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
                width: 500px;
                text-align: left;
            }
            .close-btn {
                background-color: #ff5722;
                color: white;
                border: none;
                padding: 10px;
                cursor: pointer;
                border-radius: 5px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Order Details</h2>

            <!-- Display Order Details Here -->
            <table>
                <tr>
                    <th>Order ID</th>
                    <th>Order Date</th>
                    <th>Product Name</th>
                    <th>Total Cost</th>
                    <th>Status</th>
                </tr>
                <tr>
                    <td>${order.orderId}</td>
                    <td>${order.orderDate}</td>
                    <td>${order.productNames}</td>
                    <td>${order.totalCost}</td>
                    <td>${order.status}</td>
                </tr>
            </table>

            <!-- Close Button -->
            <button class="close-btn" id="closePopupBtn">Close</button>
        </div>

        <!-- Popup container -->
        <div class="popup-container" id="popupContainer">
            <div class="popup-content">
                <h2>Order Details</h2>
                <p><strong>Order ID:</strong> ${order.orderId}</p>
                <p><strong>Order Date:</strong> ${order.orderDate}</p>
                <p><strong>Product Name:</strong> ${order.productNames}</p>
                <p><strong>Total Cost:</strong> ${order.totalCost}</p>
                <p><strong>Status:</strong> ${order.status}</p>
                <button class="close-btn" id="closePopupBtn">Close</button>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const closePopupBtn = document.getElementById("closePopupBtn");
                const popupContainer = document.getElementById("popupContainer");

                // Close popup when clicking the close button
                closePopupBtn.addEventListener("click", function () {
                    popupContainer.style.display = "none";
                });

                // Show popup when clicking "View Details"
                const viewDetailsButtons = document.querySelectorAll('.detail-btn');
                viewDetailsButtons.forEach(function (button) {
                    button.addEventListener("click", function () {
                        popupContainer.style.display = "flex"; // Show the popup
                    });
                });
            });
        </script>
    </body>
</html>
