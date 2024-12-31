<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập nhật nhân viên</title>
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
    <h2>Cập nhật nhân viên</h2>
    <form action="/nhan-vien/update/${nv.id}" method="post">
        <div class="form-group">
            <label for="maNV">Mã nhân viên</label>
            <input type="text" id="maNV" name="maNV" class="form-control" value="${nv.maNV}" readonly>
        </div>

        <div class="form-group">
            <label for="tenNV">Tên nhân viên</label>
            <input type="text" id="tenNV" name="tenNV" class="form-control" value="${nv.tenNV}">
        </div>

        <div class="form-group">
            <label for="ngaySinh">Ngày sinh</label>
            <fmt:formatDate value="${nv.ngaySinh}" pattern="dd-MM-yyyy" var="formattedDate"/>
            <input type="text" id="ngaySinh" name="ngaySinh" class="form-control" value="${formattedDate}" placeholder="dd-MM-yyyy">
        </div>

        <div class="form-group">
            <label for="gioiTinh">Giới tính</label>
            <select class="form-control" id="gioiTinh" name="gioiTinh">
                <option value="Nam" ${nv.gioiTinh == 'Nam' ? 'selected' : ''}>Nam</option>
                <option value="Nữ" ${nv.gioiTinh == 'Nữ' ? 'selected' : ''}>Nữ</option>
            </select>
        </div>

        <div class="form-group">
            <label for="sdt">Số điện thoại</label>
            <input type="text" id="sdt" name="sdt" class="form-control" value="${nv.sdt}">
        </div>

        <div class="form-group">
            <label for="diaChi">Địa chỉ</label>
            <input type="text" id="diaChi" name="diaChi" class="form-control" value="${nv.diaChi}">
        </div>
        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" class="form-control" value="${nv.email}">
        </div>
        <div class="form-group">
            <label for="chucVu">Chức vụ</label>
            <select name="chucVu" class="form-control">
                <option value="true" ${nv.chucVu ? 'selected' : ''}>Quản lý</option>
                <option value="false" ${!nv.chucVu ? 'selected' : ''}>Nhân viên</option>
            </select>
        </div>
        <div class="form-group">
            <label for="trangThai">Trạng thái</label>
            <select name="trangThai" class="form-control">
                <option value="true" ${nv.trangThai ? 'selected' : ''}>Đang làm việc</option>
                <option value="false" ${!nv.trangThai ? 'selected' : ''}>Đã nghỉ</option>
            </select>
        </div>
        <div class="form-actions">
            <button type="submit" class="btn">Cập nhật</button>
            <a href="/nhan-vien/index" class="btn-back">Quay lại</a>
        </div>
    </form>
</div>
</body>
</html>
