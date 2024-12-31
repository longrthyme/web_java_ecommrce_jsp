<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết nhân viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #ffffff;
            color: #333333;
            font-family: 'Arial', sans-serif;
        }

        .container {
            margin-top: 50px;
        }

        .card {
            background-color: #f8f9fa;
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .card-header {
            background-color: #007bff;
            color: white;
            font-size: 1.5rem;
            padding: 15px;
            border-radius: 10px 10px 0 0;
        }

        .form-label {
            font-weight: bold;
            color: #333333;
        }

        .form-control {
            border-radius: 5px;
            border: 1px solid #ccc;
            background-color: #ffffff;
            color: #333333;
        }

        .btn-back {
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .btn-back:hover {
            background-color: #0056b3;
        }

        .text-center {
            text-align: right;
        }

        .mb-3 {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="card">
        <div class="card-header">Chi tiết nhân viên</div>
        <div class="card-body">
            <div class="mb-3">
                <label for="maNV" class="form-label">Mã nhân viên:</label>
                <input type="text" class="form-control" id="maNV" value="${detail.maNV}" readonly>
            </div>
            <div class="mb-3">
                <label for="tenNV" class="form-label">Tên nhân viên:</label>
                <input type="text" class="form-control" id="tenNV" value="${detail.tenNV}" readonly>
            </div>
            <div class="mb-3">
                <label for="ngaysinh" class="form-label">Ngày sinh:</label>
                <input type="text" class="form-control" id="ngaysinh"
                <fmt:formatDate value="${detail.ngaySinh}" pattern="dd-MM-yyyy" var="formattedDate"/>
                <input type="text" class="form-control" id="ngaysinh" value="${formattedDate}" readonly>
            </div>

            <div class="mb-3">
                <label for="gioitinh" class="form-label">Giới tính:</label>
                <input type="text" class="form-control" id="gioitinh" value="${detail.gioiTinh}" readonly>
            </div>
            <div class="mb-3">
                <label for="sdt" class="form-label">Số điện thoại:</label>
                <input type="text" class="form-control" id="sdt" value="${detail.sdt}" readonly>
            </div>
            <div class="mb-3">
                <label for="diachi" class="form-label">Địa chỉ:</label>
                <input type="text" class="form-control" id="diachi" value="${detail.diaChi}" readonly>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email:</label>
                <input type="text" class="form-control" id="email" value="${detail.email}" readonly>
            </div>
            <div class="mb-3">
                <label for="chucVu" class="form-label">Chức vụ:</label>
                <input type="text" class="form-control" id="chucVu" value="${detail.chucVu ? 'Quản lý' : 'Nhân viên'}" readonly>
            </div>
            <div class="mb-3">
                <label for="trangThai" class="form-label">Trạng thái:</label>
                <input type="text" class="form-control" id="trangThai" value="${detail.trangThai ? 'Đang làm việc' : 'Nghỉ việc'}" readonly>
            </div>
            <div class="text-center">
                <a href="/staff/nhan-vien/index" class="btn btn-back">Quay lại</a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>