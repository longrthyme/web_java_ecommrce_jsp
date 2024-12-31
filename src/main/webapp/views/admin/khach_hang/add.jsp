<%@page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm khách hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #ffe6f2;
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
            color: #ff66b2;
            margin-bottom: 30px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #ff66b2;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-control {
            border: 2px solid #ff66b2;
            border-radius: 8px;
        }

        .btn {
            background-color: #ff66b2;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            font-size: 16px;
            transition: box-shadow 0.3s ease;
        }
        .btn-back {
            background-color: #ff66b2;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            font-size: 16px;
            text-decoration: none;
            transition: box-shadow 0.3s ease, background-color 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .btn-back:hover {
            background-color: #ff66b2;
            box-shadow: 0px 0px 15px 5px rgba(255, 102, 178, 0.7);
        }

        .btn-back::before {
            content: '';
            position: absolute;
            width: 300%;
            height: 300%;
            top: -100%;
            left: -100%;
            background: radial-gradient(circle, rgba(255,102,178,0.7) 10%, transparent 10%);
            background-size: 10px 10px;
            animation: sparkle 2s infinite linear;
            pointer-events: none;
        }

        @keyframes sparkle {
            0% {
                transform: translate(0, 0);
            }
            100% {
                transform: translate(300px, 300px);
            }
        }

        .btn:hover {
            box-shadow: 0px 0px 15px 5px rgba(255, 102, 178, 0.7);
        }

        /* Center button */
        .form-actions {
            text-align: center;
            margin-top: 30px;
        }

        /* Adjust label and input alignment */
        label {
            margin-top: 10px;
        }

        .form-group input {
            margin-top: 5px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Thêm khách hàng</h2>

    <form action="/khach-hang/add" method="post">
        <div class="form-group">
            <label for="makh">Mã khách hàng</label>
            <input type="text" id="makh" name="makh" class="form-control" value="${khachHang.makh}">
        </div>
        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
                    ${error}
            </div>
        </c:if>

        <div class="form-group">
            <label for="tenkh">Tên khách hàng</label>
            <input type="text" id="tenkh" name="tenkh" class="form-control" value="${khachHang.tenkh}">
        </div>

        <div class="form-group">
            <label for="ngaySinh">Ngày sinh</label>
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
            <label for="matKhau">Mật khẩu</label>
            <input type="password" id="matKhau" name="matKhau" class="form-control" value="${khachHang.matKhau}">
        </div>

        <div class="form-actions">
            <button type="submit" class="btn">Thêm</button>
            <a href="/khach-hang/index" class="btn-back">Quay lại</a>
        </div>


    </form>
</div>

</body>
</html>


