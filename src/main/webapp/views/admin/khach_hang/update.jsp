<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập nhật khách hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
    body {
    background-color: #f0f0f0;
    font-family: 'Comic Sans MS', sans-serif;
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    margin: 0;
    }

    .container {
    background-color: white;
    padding: 40px;
    border-radius: 15px;
    box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 600px;
    }

    h2 {
    text-align: center;
    color: #007bff;
    margin-bottom: 30px;
    }

    label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
    color: #333;
    }

    .form-group {
    margin-bottom: 20px;
    }

    .form-control {
    border: 2px solid #007bff;
    border-radius: 8px;
    }

    .btn {
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 8px;
    padding: 10px 20px;
    font-size: 16px;
    transition: box-shadow 0.3s ease;
    }

    .btn-back {
    background-color: #28a745;
    color: white;
    border: none;
    border-radius: 8px;
    padding: 10px 20px;
    font-size: 16px;
    text-decoration: none;
    transition: box-shadow 0.3s ease, background-color 0.3s ease;
    }

    .btn-back:hover {
    background-color: #218838;
    box-shadow: 0px 0px 15px 5px rgba(0, 123, 255, 0.7);
    }

    .btn:hover {
    box-shadow: 0px 0px 15px 5px rgba(0, 123, 255, 0.7);
    }

    .form-actions {
    text-align: center;
    margin-top: 30px;
    }

    label {
    margin-top: 10px;
    }

    .form-group input {
    margin-top: 5px;
    }

    @media (max-width: 768px) {
    .container {
    padding: 20px;
    }
    }
    </style>
</head>
<body>

<div class="container">
    <h2>Cập nhật khách hàng</h2>
    <form action="/khach-hang/update/${khachHang.id}" method="post">
        <div class="form-group">
            <label for="makh">Mã khách hàng</label>
            <input type="text" id="makh" name="makh" class="form-control" value="${khachHang.makh}" readonly>
        </div>

        <div class="form-group">
            <label for="tenkh">Tên khách hàng</label>
            <input type="text" id="tenkh" name="tenkh" class="form-control" value="${khachHang.tenkh}">
        </div>

        <div class="form-group">
            <label for="ngaySinh">Ngày sinh</label>
            <fmt:formatDate value="${khachHang.ngaySinh}" pattern="dd-MM-yyyy" var="formattedDate"/>
            <input type="date" id="ngaySinh" name="ngaySinh" class="form-control" value="${khachHang.ngaySinh}">
        </div>

        <div class="form-group">
            <label for="gioiTinh">Giới tính</label>
            <select class="form-control" id="gioiTinh" name="gioiTinh">
                <option value="Nam" ${khachHang.gioiTinh == 'Nam' ? 'selected' : ''}>Nam</option>
                <option value="Nữ" ${khachHang.gioiTinh == 'Nữ' ? 'selected' : ''}>Nữ</option>
            </select>
        </div>

        <div class="form-group">
            <label for="sdt">Số điện thoại</label>
            <input type="text" id="sdt" name="sdt" class="form-control" value="${khachHang.sdt}">
        </div>

        <div class="form-group">
            <label for="diaChi">Địa chỉ</label>
            <input type="text" id="diaChi" name="diaChi" class="form-control" value="${khachHang.diaChi}">
        </div>

        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" class="form-control" value="${khachHang.email}">
        </div>
        <div class="form-group">
            <label for="trangThai">Trạng thái</label>
            <select name="trangThai" class="form-control">
                <option value="true" ${khachHang.trangThai ? 'selected' : ''}>Hoạt động</option>
                <option value="false" ${!khachHang.trangThai ? 'selected' : ''}>Không hoạt động</option>
            </select>
        </div>

        <div class="form-actions">
            <button type="submit" class="btn">Cập nhật</button>
            <a href="/khach-hang/index" class="btn-back">Quay lại</a>
        </div>
    </form>
</div>

</body>
</html>
