<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ</title>
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
            border-radius: 5px; /* Giảm bo tròn */
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

        /*Thanh chạy ngang*/
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
            animation: slide 19s linear infinite; /* căn ẻ nhìn lú cả mắt */
        }

        .navbar {
            margin-top: 40px;
        }

        .main-content {
            display: flex;
            padding: 20px;
        }

        .sidebar {
            width: 20%;
            padding: 20px;
            border-right: 1px solid #ddd;
        }
        .filter-header {
            display: flex;
            align-items: center;
            font-size: 20px;
            color: #333;
            margin-bottom: 20px;
        }

        .filter-header i {
            margin-right: 10px;
            color: #333;
            font-size: 24px;
        }

        .filter-category {
            margin-bottom: 20px;
            cursor: pointer;
        }

        .filter-category h4 {
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .filter-category h4 i {
            margin-right: 10px;
        }

        .filter-options {
            display: none;
            padding-left: 20px;
            margin-top: 10px;
        }

        .filter-options input {
            margin-right: 10px;
        }

        .filter-options label {
            display: block;
            margin-bottom: 5px;
        }

        .product-card {
            border: none;
            padding: 0;
            text-align: center;
            position: relative;
            box-sizing: border-box;
        }

        .product-card img {
            width: 100%;
            height: 300px;
            object-fit: cover;
        }
        .product-card:hover {
            transform: scale(1.05);
        }
        .product-name {
            color: black;
            transition: color 0.3s;
        }

        .product-card:hover {
            color: red;
        }
        .product-grid {
            width: 100%;
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin: 0 auto;
        }

        .product-discount {
            background-color: red;
            color: white;
            padding: 5px;
            position: absolute;
            top: 10px;
            right: 10px;
            font-size: 12px;
            border-radius: 5px;
        }

        .old-price {
            text-decoration: line-through;
            color: #888;
        }

        .new-price {
            color: red;
            font-weight: bold;
        }
        .product-buttons {
            display: flex;
            gap: 10px;
            justify-content: center;
            margin-top: 10px;
        }

    /*Button mua ngay*/
        .buy-now-button, .add-to-cart-button {
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s, transform 0.2s;
        }

        .buy-now-button {
            background-color: red;
            color: white;
        }

        .buy-now-button:hover {
            background-color: darkred;
            transform: scale(1.05);
        }

        /*Button thêm vào giỏ*/
        .add-to-cart-button {
            background-color: #0066CC;
            color: white;
        }

        .add-to-cart-button:hover {
            background-color: darkgreen;
            transform: scale(1.05);
        }

        /*Mũi tên trỏ xuống (Bộ lọc)*/
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

        /*Lọc theo loại*/
        #filter-section {
            margin: 20px;
        }

        #filter-section label {
            display: block;
            margin-bottom: 10px;
        }

        /*Button Apply*/
        #apply-filters {
            margin-top: 10px;
            padding: 5px 10px;
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }

        #apply-filters:hover {
            background-color: #0056b3;
        }
        .pagination-container {
            display: flex;
            justify-content: center;
            margin-top: 30px;
            margin-bottom: 30px;
        }
        /*Phân trang*/
        .pagination {
            display: flex;
            gap: 10px;
        }

        .pagination a {
            padding: 10px 15px;
            margin: 0;
            text-decoration: none;
            color: black;
            border: 1px solid #ddd;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .pagination a.active {
            background-color: red;
            color: white;
            pointer-events: none;
        }

        .pagination a:hover {
            background-color: black;
            color: white;
        }

    </style>
</head>
<body>
<!-- Thanh chạy ngang với mã giảm giá -->
<div class="discount-banner-container">
    <div class="discount-banner">
        VOUCHER 10K CHO ĐƠN 99K | VOUCHER 50K CHO ĐƠN 799K | FREESHIP MỌI ĐƠN TỪ 399K
    </div>
</div>
<!-- Navbar -->
<div class="navbar">
    <div class="navbar-left">
        <a href="/home/index"><img src="${pageContext.request.contextPath}/StyleL.jpg" alt="Style life"></a>
        <span style="color: white; font-size: 20px; margin-left: 10px;">Style Life</span>
    </div>
    <div class="navbar-center">
        <form action="/home/search" method="get" class="search-bar">
            <input type="text" name="tenSp" class="form-control" placeholder="Bạn cần tìm gì" value="${tenSp}">
            <button type="submit" class="search-button">Tìm Kiếm</button>
        </form>
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
<div class="main-content">
    <div class="sidebar">
        <div id="filter-section">
            <h3 class="filter-header"><i class="fas fa-filter"></i> Bộ lọc</h3>
            <div class="filter-category" onclick="toggleFilter('filter-style')">
                <h4><i class="fas fa-tshirt"></i> Loại <i class="fas fa-chevron-down"></i></h4>

                <div class="filter-options" id="filter-style">
                    <h4>Áo nam</h4>
                    <label>
                        <input type="checkbox" name="product-type" value="Áo Thun"> Áo Thun
                    </label>
                    <label>
                        <input type="checkbox" name="product-type" value="Áo Sơ Mi"> Áo Sơ Mi
                    </label>
                    <label>
                        <input type="checkbox" name="product-type" value="Áo Polo"> Áo Polo
                    </label>
                    <label>
                        <input type="checkbox" name="product-type" value="Áo Khoác"> Áo Khoác
                    </label>
                    <label>
                        <input type="checkbox" name="product-type" value="Áo Nỉ"> Áo Nỉ
                    </label>
                    <label>
                        <input type="checkbox" name="product-type" value="Áo Bomber"> Áo bomber
                    </label>
                    <h4>Quần nam</h4>
                    <label>
                        <input type="checkbox" name="product-type" value="Quần Dài"> Quần Dài
                    </label>
                    <label>
                        <input type="checkbox" name="product-type" value="Quần Short"> Quần Short
                    </label>
                    <label>
                        <input type="checkbox" name="product-type" value="Quần Jean"> Quần Jean
                    </label>
                    <label>
                        <input type="checkbox" name="product-type" value="Quần Tây"> Quần Tây
                    </label>
                </div>
            </div>
            <button id="apply-filters">Áp dụng</button>
        </div>
    </div>
    <div class="product-grid">
        <c:forEach var="home" items="${homes}">
            <div class="product-card product" data-type="${home.loai}">
                    <%--                <span class="product-discount">${home.discount}%</span>--%>
                <img src="${home.anh_sp}" alt="${home.tenSp}">
                <h3>${home.tenSp}</h3>
                <h4>Loại: ${home.loai}</h4>
                <h3 class="new-price">${home.gia}</h3>
                    <%--                <p class="new-price">₫${home.gia * (1 - home.discount / 100)}</p>--%>
                <div class="product-buttons">
                    <button onclick="buyNow(${home.ma_sp})" class="buy-now-button">Mua Ngay</button>
                    <button onclick="addToCart(${home.ma_sp})" class="add-to-cart-button">Thêm vào Giỏ Hàng</button>
                </div>
            </div>
        </c:forEach>
        <div class="no-results-message" style="display: none; text-align: center; color: red; font-size: 18px; margin-top: 20px;">
            Không tìm thấy sản phẩm phù hợp.
        </div>
        <c:if test="${empty homes}">
            <script>
                document.querySelector('.no-results-message').style.display = 'block';
            </script>
        </c:if>
    </div>
</div>

<div class="pagination-container">
    <div class="pagination">
        <ul class="pagination justify-content-center">
            <c:if test="${currentPage > 1}">
                <a href="?page=${currentPage - 1}&size=12&tenSp=${tenSp}&loai=${loai}">Trước</a>
            </c:if>
            <c:forEach begin="1" end="${totalPages}" var="i">
                <a href="?page=${i}&size=12&tenSp=${tenSp}&loai=${loai}"
                   class="${i == currentPage ? 'active' : ''}">
                        ${i}
                </a>
            </c:forEach>
            <c:if test="${currentPage < totalPages}">
                <a href="?page=${currentPage + 1}&size=12&tenSp=${tenSp}&loai=${loai}">Tiếp</a>
            </c:if>
        </ul>
    </div>
</div>
<script>
    document.getElementById('apply-filters').addEventListener('click', function () {
        const selectedTypes = Array.from(
            document.querySelectorAll('input[name="product-type"]:checked')
        ).map(checkbox => checkbox.value);

        const products = document.querySelectorAll('.product');

        products.forEach(product => {
            const productType = product.dataset.type;
            if (selectedTypes.length === 0 || selectedTypes.includes(productType)) {
                product.style.display = 'block';
            } else {
                product.style.display = 'none';
            }
        });
    });

    function toggleDropdown() {
        const dropdown = document.getElementById('profile-dropdown');
        dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
    }

    window.onclick = function(event) {
        if (!event.target.matches('.fa-user')) {
            const dropdown = document.getElementById('profile-dropdown');
            if (dropdown.style.display === 'block') {
                dropdown.style.display = 'none';
            }
        }
    }

    function toggleFilter(id) {
        const filterOptions = document.getElementById(id);
        filterOptions.style.display = filterOptions.style.display === "none" || filterOptions.style.display === "" ? "block" : "none";
    }

    function filterByCategory(category) {
        window.location.href = '/home/filter?loai=' + encodeURIComponent(category);
    }

    // function searchProducts() {
    //     let query = document.querySelector('.search-bar input').value;
    //     query = query.trim().replace(/\s+/g, ' ');
    //     window.location.href = '/home/search?query=' + encodeURIComponent(query);
    // }
    // document.getElementById('apply-filters').addEventListener('click', function () {
    //     const selectedTypes = Array.from(
    //         document.querySelectorAll('input[name="product-type"]:checked')
    //     ).map(checkbox => checkbox.value);
    //
    //     const products = document.querySelectorAll('.product');
    //     let visibleProductCount = 0;
    //
    //     products.forEach(product => {
    //         const productType = product.dataset.type;
    //         if (selectedTypes.length === 0 || selectedTypes.includes(productType)) {
    //             product.style.display = 'block';
    //             visibleProductCount++;
    //         } else {
    //             product.style.display = 'none';
    //         }
    //     });
    //
    //     const noResultsMessage = document.querySelector('.no-results-message');
    //     if (visibleProductCount === 0) {
    //         noResultsMessage.style.display = 'block';
    //     } else {
    //         noResultsMessage.style.display = 'none';
    //     }
    // });
</script>
</body>
</html>
