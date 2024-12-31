<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ Hàng</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        /* Navbar */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: black;
            padding: 10px 20px;
            color: white;
            position: relative;
        }

        .navbar-left {
            display: flex;
            align-items: center;
        }

        .navbar-left img {
            height: 50px;
        }

        .navbar-center {
            display: flex;
            align-items: center;
            flex-grow: 1;
            justify-content: center;
        }

        .search-bar {
            display: flex;
        }

        .search-bar input {
            width: 400px;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .search-button {
            background-color: black;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-left: 10px;
            ransition: background-color 0.3s, transform 0.2s;
        }
        .search-button:hover {
            background-color: red;
            transform: scale(1.05);
        }
        .navbar-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .navbar-right a {
            color: white;
            font-size: 20px;
            position: relative;
        }
        .navbar-right a:hover {
            background-color: rgba(255, 255, 255, 0.2);
            transform: scale(1.1);
        }
        .navbar-right a span {
            position: absolute;
            top: -10px;
            right: -10px;
            background-color: red;
            color: white;
            padding: 3px 6px;
            border-radius: 50%;
            font-size: 12px;
        }
        @keyframes slide {
            0% {
                transform: translateX(-100%);
            }
            100% {
                transform: translateX(100%);
            }
        }
        .discount-banner {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            background-color: white;
            color: black;
            font-size: 14px;
            padding: 10px 0;
            border-bottom: 1px solid #ddd;
            overflow: hidden;
            z-index: 9999;
            animation: slide 19s linear infinite;
        }
        .navbar {
            margin-top: 40px;
        }
        .dropdown-menu {
            display: none;
            position: absolute;
            top: 50px;
            right: 20px;
            background-color: white;
            border: 1px solid #ccc;
            padding: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            z-index: 1000;
            border-radius: 5px;
        }

        .dropdown-menu a {
            display: block;
            color: black;
            text-decoration: none;
            padding: 8px 0;
        }

        .dropdown-menu a:hover {
            background-color: #f1f1f1;
        }

        .dropdown-menu button {
            background-color: black;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            text-align: left;
            margin-bottom: 10px;
        }

        .dropdown-menu button:last-child {
            margin-bottom: 0;
        }

        .dropdown-menu button:hover {
            background-color: red;
        }

        .cart-section {
            max-width: 900px;
            margin: 20px auto;
            padding: 0 20px;
            overflow: hidden;
        }

        .cart-section h2 {
            font-size: 24px;
            color: #333;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .cart-container {
            padding: 20px;
            border: 1px solid #ddd;
            background-color: #f9f9f9;
            border-radius: 5px;
            margin-top: 10px;
        }

        .cart-title {
            font-weight: bold;
            font-size: 18px;
            margin-top: -10px;
            margin-bottom: 15px;
            text-align: left;
        }

        .cart-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        .cart-table th,
        .cart-table td {
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        .cart-table th {
            background-color: #f0f0f0;
            font-weight: bold;
        }

        .cart-table img {
            width: 80px;
            border-radius: 5px;
        }

        .product-details {
            text-align: left;
        }

        .product-info {
            text-align: left;
            display: flex;
            flex-direction: column;
            gap: 5px; /
        }

        .product-name,
        .product-price,
        .product-type {
            margin: 0;
        }

        .quantity-control {
            display: flex;
            align-items: center;
        }

        .quantity-control button {
            background-color: #f0f0f0;
            border: none;
            width: 30px;
            height: 30px;
            cursor: pointer;
        }

        .quantity-control input {
            width: 40px;
            text-align: center;
            border: 1px solid #ddd;
            margin: 0 5px;
        }

        .total-price,
        .discount-price {
            color: red;
            font-weight: bold;
        }

        .original-price {
            text-decoration: line-through;
            color: gray;
        }

        .action-button {
            background: none;
            border: none;
            cursor: pointer;
        }

        .action-button.view {
            color: #007bff;
        }

        .action-button.delete {
            color: #dc3545;
        }

        .cart-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: 15px;
        }

        .back-button {
            background-color: #007bff;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .back-button:hover {
            background-color: #0056b3;
        }

        .payment-summary {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .total-label {
            font-size: 18px;
            font-weight: bold;
        }

        .total-payment {
            color: red;
            font-size: 20px;
            font-weight: bold;
            margin-left: 5px;
        }

        .checkout-button {
            background-color: #f53d2d;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .checkout-button:hover {
            background-color: #d13428;
        }
    </style>
</head>
<body>

<!-- Discount Banner -->
<div class="discount-banner">
    VOUCHER 10K CHO ĐƠN 99K | VOUCHER 50K CHO ĐƠN 799K | FREESHIP MỌI ĐƠN TỪ 399K
</div>
<!-- Navbar -->
<div class="navbar">
    <div class="navbar-left">
        <a href="/home/index"><img src="${pageContext.request.contextPath}/StyleL.jpg" alt="Style life"></a>
        <span style="color: white; font-size: 20px; margin-left: 10px;">Style Life</span>
    </div>
    <div class="navbar-center">
        <div class="search-bar">
            <input type="text" placeholder="Bạn cần tìm gì?">
        </div>
        <button class="search-button" onclick="searchProducts()">Tìm Kiếm</button>
    </div>
    <div class="navbar-right">
        <a href="#" onclick="toggleDropdown()"><i class="fas fa-user"></i></a>
        <div id="profile-dropdown" class="dropdown-menu">
            <button onclick="window.location.href='/login'">Đăng Nhập</button>
            <button onclick="window.location.href='/register'">Đăng Ký</button>
        </div>

        <a href="#"><i class="fas fa-bell"></i><span>4</span></a>
        <a href="/home/cart"><i class="fas fa-shopping-cart"></i><span>0</span></a>
    </div>
</div>
<!-- Giỏ hàng -->
<div class="cart-section">
    <h2><i class="fas fa-shopping-cart"></i> Giỏ hàng</h2>
    <!-- Giỏ hàng Container -->
    <div class="cart-container">
        <p class="cart-title">Tổng sản phẩm: 1</p>
        <table class="cart-table">
            <thead>
            <tr>
                <th><input type="checkbox" onclick="selectAllCheckboxes(this)"></th>
                <th>Ảnh sản phẩm</th>
                <th>Tên sản phẩm</th>
                <th>Số lượng</th>
                <th>Thành tiền</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td><input type="checkbox" class="product-checkbox"></td>
                <td><img src="${pageContext.request.contextPath}/images/Thun1.jpg" alt="Áo thun"></td>
                <td class="product-details">
                    <div class="product-info">
                        <p class="product-name">Áo Thun Nam Lót Trong StyleS Chất Cotton Phom Slimfit</p>
                        <p class="product-price">Giá gốc <span class="original-price">₫2,000,000</span> <span class="discount-price">₫1,800,000</span></p>
                        <p class="product-type">Loại: Áo thun</p>
                    </div>
                </td>
                <td>
                    <div class="quantity-control">
                        <button>-</button>
                        <input type="text" value="1">
                        <button>+</button>
                    </div>
                </td>
                <td><span class="total-price">₫1,800,000</span></td>
                <td>
                    <button class="action-button view"><i class="fas fa-eye"></i></button>
                    <button class="action-button delete"><i class="fas fa-trash-alt"></i></button>
                </td>
            </tr>
            </tbody>
        </table>

        <!-- Footer của giỏ hàng -->
        <div class="cart-footer">
            <button class="back-button" onclick="window.location.href='/home/index'">Quay lại</button>
            <div class="payment-summary">
                <p class="total-label">Tổng thanh toán: <span class="total-payment">₫1,800,000</span></p>
                <button class="checkout-button" onclick="window.location.href='/home/thanh-toan'">Mua hàng</button>
            </div>
        </div>
    </div>
</div>
<script>
    function selectAllCheckboxes(source) {
        let checkboxes = document.querySelectorAll('.product-checkbox');
        checkboxes.forEach(checkbox => checkbox.checked = source.checked);
    }
</script>
</body>
</html>
