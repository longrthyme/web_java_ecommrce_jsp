<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tạo voucher</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        body, html {
            margin: 0;
            padding: 0;
            width: 100%;
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }

        .container {
            max-width: 100%;
            padding: 0;
            display: flex;
            height: 100vh;
            overflow: hidden;
        }

        .sidebar {
            width: 280px;
            background-color: #fff;
            color: black;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            position: fixed; /*cố định sidebar*/
            top: 0;
            bottom: 0;
            left: 0;
        }

        .sidebar-header {
            display: flex;
            align-items: center;
            padding: 15px 20px;
        }

        .sidebar-header img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            margin-right: 10px;
        }
        .sidebar.collapsed {
            width: 120px; /* Thu nhỏ chiều rộng */
            transition: width 0.3s ease;
        }

        .sidebar.collapsed .welcome,
        .sidebar.collapsed strong {
            display: none;
        }
        .sidebar.collapsed .menu a .menu-title {
            display: none;
        }
        .sidebar.collapsed img {
            margin: auto;
        }
        .sidebar.collapsed .menu-title {
            display: none;
        }

        .sidebar.collapsed .menu a span {
            display: none;
        }
        .sidebar.collapsed .menu a {
            justify-content: center;
            padding: 12px 0;
        }

        .sidebar.collapsed .menu a i {
            font-size: 24px;
            margin-right: 0;
        }
        .menu .has-submenu a i.toggle-icon {
            margin-left: 10px;
            font-size: 14px;
        }
        .menu .submenu a {
            padding: 10px 20px;
            margin-bottom: 5px;
            border-radius: 4px;
        }

        .menu .submenu a:hover {
            background-color: #f0f8ff;
            color: #004d99;
        }

        .sidebar.collapsed .menu .has-submenu:hover .submenu {
            display: block;
            position: absolute;
            left: 120px;
            top: 50%;
            transform: translateY(-50%);
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px;
            z-index: 1000;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .sidebar.collapsed .menu .submenu a {
            padding: 8px 15px;
            font-size: 14px;
        }

        .main-content {
            transition: margin-left 0.3s ease;
        }

        .sidebar.collapsed + .main-content {
            margin-left: 120px;
        }

        .sidebar.collapsed .submenu a {
            justify-content: center;
        }

        .sidebar.collapsed .submenu a span {
            display: none;
        }

        .menu .submenu {
            margin-left: 10px;
        }

        .menu .has-submenu.open .submenu {
            max-height: 500px;
        }

        .sidebar .menu a {
            display: flex;
            align-items: center;
            justify-content: start;
        }
        .sidebar .menu a i {
            margin-right: 10px;
        }
        .sidebar .menu section {
            display: none;
        }

        .sidebar .menu section span {
            display: none;
        }
        .main-content.expanded {
            margin-left: 120px;
            transition: margin-left 0.3s ease;
        }
        .welcome {
            text-align: left;
            font-size: 14px;
            margin-top: 10px;
        }

        .welcome p {
            margin-bottom: 5px;
            margin: 0;
            color: #666;c
        }

        .welcome strong {
            display: block;
            font-size: 16px;
            color: #333;
        }

        .menu-section {
            margin-top: 3px;
        }

        .menu-title {
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            text-transform: uppercase;
            color: #666;
        }

        .menu {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .menu li {
            margin-bottom: 5px;
        }

        .menu a {
            text-decoration: none;
            color: #000;
            display: flex;
            align-items: center;
            padding: 12px 20px;
            transition: background-color 0.3s, color 0.3s;
        }

        .menu a i {
            margin-right: 10px;
            color: #000; /* Màu icon */
        }

        .menu a:hover, .menu .active a {
            background-color: #e6f7ff;
            color: #004d99;
        }

        .menu a:hover i {
            color: #004d99;
        }
        .menu-section:last-child {
            margin-top: -14px;
        }

        .toggle-menu {
            background-color: transparent;
            border: none;
            color: #666;
            font-size: 20px;
            cursor: pointer;
            margin-left: auto;
        }

        /* Nội dung chính */
        .main-content {
            margin-left: 280px;
            flex: 1;
            padding: 20px;
            background-color: #f8f9fa;
            overflow-y: auto;
            height: 100vh;
        }

        .createvc {
            font-size: 24px;
            font-weight: bold;
            color: #333;
        }

        .content {
            margin-top: 20px;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .menu .submenu {
            display: none;
            padding-left: 20px;
            gap: 10px;
        }
        .menu .submenu li {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .has-submenu.open .submenu {
            display: block;
        }

        .menu .has-submenu a i.toggle-icon {
            font-size: 14px;
        }

         form {
             max-width: 600px;
             margin: 0 auto;
             padding: 20px;
             background-color: #ffffff;
             border-radius: 8px;
             box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
             font-size: 16px;
         }

        form label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
        }

        form input, form select, form button {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }

        form input:focus, form select:focus {
            border-color: #80bdff;
            outline: none;
            box-shadow: 0 0 5px rgba(128, 189, 255, 0.5);
        }

        form button {
            background-color: #007bff;
            color: #ffffff;
            border: none;
            cursor: pointer;
            font-weight: bold;
            text-transform: uppercase;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        form button:hover {
            background-color: #0056b3;
            transform: scale(1.05);
        }

        form button:focus {
            outline: none;
            box-shadow: 0 0 5px rgba(128, 189, 255, 0.5);
        }

        form .error-message {
            color: red;
            font-size: 14px;
            margin-top: -10px;
            margin-bottom: 10px;
        }
        .d-flex button,
        .d-flex a.btn {
            flex: 1;
            margin: 0 5px;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <img src="${pageContext.request.contextPath}/images/hehe.jpg" alt="AvtCuaBan">
            <div class="welcome">
                <p>Chào mừng bạn</p>
                <strong>Con cu nho nhỏ</strong>
            </div>
            <button class="toggle-menu">
                <i class="fas fa-bars"></i>
            </button>
        </div>

        <!-- Menu chính -->
        <div class="menu-section">
            <div class="menu-title">Main</div>
            <ul class="menu">
                <li><a href="#"><i class="fa-solid fa-chart-line"></i> <span>Thống kê</span></a></li>
                <li><a href="/home/index"><i class="fas fa-home"></i> <span>Trang Chủ</span></a></li>
                <li><a href="#"><i class="fas fa-cash-register"></i> <span>Tại Quầy</span></a></li>
                <li><a href="#"><i class="fas fa-undo"></i> <span>Trả Hàng</span></a></li>
                <li><a href="#"><i class="fas fa-file-invoice"></i> <span>Hóa Đơn</span></a></li>
                <li class="has-submenu">
                    <a href="#">
                        <i class="fas fa-box"></i>
                        <span>Quản lý Sản Phẩm</span>
                        <i class="fas fa-chevron-down toggle-icon"></i>
                    </a>
                    <ul class="submenu">
                        <li><a href="/san-pham/index"><i class="fa-solid fa-shirt"></i><span>Sản phẩm</span></a></li>
                        <li><a href="/san-pham/mau-sac"><i class="fa-solid fa-palette"></i><span>Màu sắc</span></a></li>
                        <li><a href="/san-pham/thuong-hieu"><i class="fa-solid fa-tags"></i><span>Thương hiệu</span></a></li>
                    </ul>
                </li>
                <li><a href="/nhan-vien/index"><i class="fas fa-users"></i> <span>Nhân Viên</span></a></li>
                <li><a href="/khach-hang/index"><i class="fas fa-user"></i> <span>Khách Hàng</span></a></li>
                <li class="active"><a href="/voucher/index"><i class="fas fa-tags"></i> <span>Phiếu Giảm Giá</span></a></li>
                <li><a href="#"><i class="fas fa-percent"></i> <span>Đợt Giảm Giá</span></a></li>
            </ul>
        </div>
        <div class="menu-section">
            <div class="menu-title">Account</div>
            <ul class="menu">
                <li><a href="/logout"><i class="fas fa-sign-out-alt"></i> <span>Đăng Xuất</span></a></li>
            </ul>
        </div>
    </div>
    <div class="main-content"id="content">
        <div class="content d-flex flex-column align-items-center">
            <div class="createvc mb-4">
                <span>Tạo voucher</span>
            </div>
            <form:form method="post" modelAttribute="voucher" class="w-50">
                <label for="maVc">Mã voucher:</label>
                <form:input path="maVc" id="maVc" /><br/>

                <label for="tenVc">Tên voucher:</label>
                <form:input path="tenVc" id="tenVc" /><br/>

                <label for="ngayBatDau">Ngày bắt đầu:</label>
                <form:input path="ngayBatDau" id="ngayBatDau" type="date" /><br/>

                <label for="ngayKetThuc">Ngày kết thúc:</label>
                <form:input path="ngayKetThuc" id="ngayKetThuc" type="date" /><br/>

                <label for="giaTri">Giá trị giảm:</label>
                <form:input path="giaTri" id="giaTri" type="number" /><br/>

                <label for="loaiGiamGia">Loại giảm giá:</label>
                <form:select path="loaiGiamGia" id="loaiGiamGia">
                    <form:option value="VND">VND</form:option>
                    <form:option value="%">%</form:option>
                </form:select><br/>

                <label for="giaTriToiThieu">Giá trị tối thiểu đơn hàng:</label>
                <form:input path="giaTriToiThieu" id="giaTriToiThieu" type="number" /><br/>


                <div class="d-flex justify-content-between">
                    <button type="submit" class="btn btn-primary">Tạo Voucher</button>
                    <a href="/voucher/index" class="btn btn-secondary">Quay lại</a>
                </div>
            </form:form>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

        </div>
    </div>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const allSubmenus = document.querySelectorAll('.submenu');
        const menuItems = document.querySelectorAll(".has-submenu > a");
        const sidebar = document.getElementById('sidebar');
        const toggleButton = document.querySelector('.toggle-menu');
        const content = document.querySelector('.main-content');

        function hideAllSubmenus(except = null) {
            allSubmenus.forEach(submenu => {
                if (submenu !== except) {
                    submenu.style.display = 'none';
                    submenu.parentElement.classList.remove("open");
                }
            });
        }

        menuItems.forEach(function (item) {
            item.addEventListener("click", function (e) {
                e.preventDefault();

                const submenu = item.nextElementSibling;

                hideAllSubmenus(submenu);

                if (submenu) {
                    submenu.style.display = submenu.style.display === "block" ? "none" : "block";
                    item.parentElement.classList.toggle("open");
                }
            });
        });

        // Sự kiện thu gọn/mở rộng sidebar
        toggleButton.addEventListener("click", () => {
            sidebar.classList.toggle('collapsed');
            content.classList.toggle('expanded');
            hideAllSubmenus(); // Ẩn tất cả submenu khi thu gọn sidebar
        });

        // Xử lý submenu khi sidebar thu gọn
        function handleSidebarHover(show = false) {
            if (sidebar.classList.contains('collapsed')) {
                const openSubmenu = sidebar.querySelector('.has-submenu.open .submenu');
                if (openSubmenu) {
                    openSubmenu.style.display = show ? 'block' : 'none';
                    if (!show) {
                        openSubmenu.parentElement.classList.remove("open");
                    }
                }
            }
        }

        sidebar.addEventListener("mouseenter", () => handleSidebarHover(true));
        sidebar.addEventListener("mouseleave", () => handleSidebarHover(false));

    });

        document.querySelector("form").addEventListener("submit", function (e) {
        let isValid = true;
        const fields = ["maVc", "tenVc", "ngayBatDau", "ngayKetThuc", "giaTri", "giaTriToiThieu"];

        fields.forEach(field => {
        const input = document.getElementById(field);
        if (!input.value.trim()) {
        isValid = false;
        input.style.border = "2px solid red";
        input.nextElementSibling?.remove();
        const error = document.createElement("span");
        error.classList.add("error-message");
        error.textContent = "Trường này không được để trống";
        input.insertAdjacentElement("afterend", error);
    } else {
        input.style.border = "";
        input.nextElementSibling?.remove();
    }
    });

        if (!isValid) {
        e.preventDefault();
    }
    });
</script>
</body>
</html>
