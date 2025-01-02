<%@page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Quản lý sản phẩm</title>

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
            width: 120px;
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
        /* Khi menu thu gọn */
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

        /* Khi menu thu gọn, giảm khoảng cách */
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
            color: #666; /* Màu chữ "Chào mừng bạn" */
        }

        .welcome strong {
            display: block;
            font-size: 16px;
            color: #333; /* Màu chữ tên người dùng */
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

        .navbar {
            background-color: #fff;
            border-bottom: 1px solid #ddd;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar span {
            font-size: 18px;
            font-weight: bold;
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

        /*Nút tìm kiếm*/
        .search-title {
            font-size: 20px;
            font-weight: 500;
            color: #333;
            margin-bottom: 15px;
            text-align: left;
        }
        .btn-refresh i, .btn-add i {
            margin-right: 5px;
        }

        .btn-info {
            align-items: center;
        }
        .table-phiphai {
            overflow-x: auto;
            width: 100%;
            margin-bottom: 1rem;
        }

        table {
            background-color: #ffffff;
            color: #212529;
            border-collapse: collapse;
            width: 100%;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
            min-width: 1000px;
        }

        table th, table tfoot td {
            border: 1px solid #dee2e6;
            padding: 12px;
            text-align: left;
            font-size: 14px;
        }

        table th {
            background-color: #f8f9fa;
            font-weight: bold;
            color: #495057;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        table tbody tr {
            border: none;
        }

        table tbody tr:nth-child(even) {
            background-color: #fdfdfe;
        }

        table tbody tr:hover {
            background-color: #e9f7ff;
            transition: background-color 0.3s ease;
        }

        table tbody td {
            padding: 12px;
        }

        table tbody td .btn {
            padding: 6px 10px;
            font-size: 14px;
            border-radius: 4px;
            margin-right: 4px;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        table tbody td .btn:hover {
            transform: scale(1.05);
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
        }

        .product-img {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 4px;
        }

        /* Các nút hành động */
        .btn-warning {
            background-color: #ffc107;
            color: white;
            border: none;
        }

        .btn-warning:hover {
            background-color: #e0a800;
        }

        .btn-info {
            background-color: #007bff;
            color: white;
            border: none;
        }

        .btn-info:hover {
            background-color: #0056b3;
        }

        table tbody td .btn {
            padding: 6px 10px;
            font-size: 14px;
            border-radius: 4px;
            margin-right: 4px;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        table tbody td .btn:hover {
            transform: scale(1.05);
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
        }

        .btn-info {
            background-color: #17a2b8;
            color: white;
            border: none;
            transition: background-color 0.3s;
        }

        .btn-info:hover {
            background-color: #138496;
        }

        /* Phân trang */
        .pagination a {
            display: inline-block;
            margin: 0 5px;
            padding: 8px 12px;
            text-decoration: none;
            color: #007bff;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: #f9f9f9;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .pagination a:hover {
            background-color: #007bff;
            color: #fff;
            border-color: #007bff;
        }

        .pagination a.active {
            background-color: #007bff;
            color: #fff;
            border-color: #007bff;
            cursor: default;
        }

        .pagination-container {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .pagination {
            display: inline-flex;
            list-style-type: none;
            padding: 0;
        }
        .pagination-info {
            display: none;
            text-align: center;
            font-size: 14px;
            color: #007bff;
            margin-top: 10px;
        }

        .pagination-container:hover .pagination-info {
            display: block;
        }

        .pagination-info .pagination-tooltip {
            background-color: rgba(0, 0, 0, 0.75);
            color: #fff;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 14px;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Thanh bên trái -->
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
                        <li class="active"><a href="/san-pham/index"><i class="fa-solid fa-shirt"></i><span>Sản phẩm</span></a></li>
                        <li><a href="/mau-sac/index"><i class="fa-solid fa-palette"></i><span>Màu sắc</span></a></li>
                        <li><a href="/thuong-hieu/index"><i class="fa-solid fa-tags"></i><span>Thương hiệu</span></a></li>
                    </ul>
                </li>
                <li><a href="/nhan-vien/index"><i class="fas fa-users"></i> <span>Nhân Viên</span></a></li>
                <li><a href="/khach-hang/index"><i class="fas fa-user"></i> <span>Khách Hàng</span></a></li>
                <li><a href="/voucher/index"><i class="fas fa-tags"></i> <span>Phiếu Giảm Giá</span></a></li>
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

    <!-- Nội dung chính -->
    <div class="main-content"id="content">
        <div class="navbar">
            <span>Quản lý sản phẩm</span>
        </div>
        <div class="content">
            <!-- Search Form -->
            <h3 class="search-title">Tìm kiếm</h3>
            <form action="/san-pham/search" method="get" class="d-flex justify-content-between mb-4">
                <div class="flex-grow-1 pe-2">
                    <input type="text" name="maSP" class="form-control" placeholder="Nhập mã sản phẩm">
                </div>
                <div class="pe-2">
                    <select name="trangThai" class="form-select">
                        <option value="">Chọn trạng thái</option>
                        <option value="true" ${trangThai ? 'selected' : ''}>Đang bán</option>
                        <option value="false" ${trangThai == false ? 'selected' : ''}>Ngừng bán</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-info">Tìm kiếm</button>
            </form>

            <!-- Add Button -->
            <div class="text-end mb-3">
                <button type="button" class="btn btn-info btn-refresh" onclick="resetForm()">
                    <i class="fa-solid fa-rotate-right"></i>Làm mới
                </button>
                <a href="/san-pham/add" class="btn btn-info btn-add">
                    <i class="fa-solid fa-plus"></i>Thêm sản phẩm
                </a>
            </div>

            <!-- Sản phẩm Table -->
            <table class="table table-hover">
                <thead style="background-color: #e3f2fd; color: #000; font-weight: bold;">
                <tr>
                    <th scope="col">STT</th>
                    <th scope="col">Ảnh</th>
                    <th scope="col">Mã sản phẩm</th>
                    <th scope="col">Tên sản phẩm</th>
                    <th scope="col">Giá</th>
                    <th scope="col">Loại</th>
                    <th scope="col">Trạng thái</th>
                    <th scope="col">Hành động</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${data}" var="sp">
                    <tr>
                        <td>${sp.id}</td>
                        <td><img class="product-img" src="<c:url value='${sp.anhSP}' />" alt="${sp.tenSP}"></td>
                        <td>${sp.maSP}</td>
                        <td>${sp.tenSP}</td>
                        <td><fmt:formatNumber value="${sp.gia}" type="number" maxFractionDigits="0" /></td>
                        <td>${sp.loai}</td>
                        <td>${sp.trangThai ? "Đang bán" : "Ngừng bán"}</td>
                        <td>
                            <a href="update/${sp.id}" data-bs-toggle="tooltip" title="Chỉnh sửa">
                                <button class="btn btn-warning">
                                    <i class="fas fa-edit"></i>
                                </button>
                            </a>
                            <a href="detail/${sp.id}" data-bs-toggle="tooltip" title="Chi tiết nhân viên">
                                <button class="btn btn-primary">
                                    <i class="fas fa-circle-info"></i>
                                </button>
                            </a>
                            <a href="changeStatus/${sp.id}" data-bs-toggle="tooltip" title="Thay đổi trạng thái">
                                <button class="btn btn-info">
                                    <i class="fa-solid fa-arrow-right-arrow-left"></i>
                                </button>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="pagination-container mt-4">
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                        <c:if test="${currentPage > 1}">
                            <a href="?page=${currentPage - 1}&size=10&maSP=${maNV}&trangThai=${trangThai}">Trước</a>
                        </c:if>

                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <a href="?page=${i}&size=10&maNV=${maNV}&trangThai=${trangThai}"
                               class="${i == currentPage ? 'active' : ''}">
                                    ${i}
                            </a>
                        </c:forEach>

                        <c:if test="${currentPage < totalPages}">
                            <a href="?page=${currentPage + 1}&size=10&maNV=${maNV}&trangThai=${trangThai}">Tiếp</a>
                        </c:if>
                    </ul>
                    <div class="pagination-info" title="Trang ${currentPage} của ${totalPages}">
                        <span class="pagination-tooltip">Trang ${currentPage} / ${totalPages}</span>
                    </div>
                </nav>
            </div>
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

        toggleButton.addEventListener("click", () => {
            sidebar.classList.toggle('collapsed');
            content.classList.toggle('expanded');
            hideAllSubmenus();
        });

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

    // Tooltip
    document.addEventListener("DOMContentLoaded", function () {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
    });

    function resetForm() {
        document.querySelector('input[name="maSP"]').value = '';

        window.location.href = '/san-pham/index';
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
