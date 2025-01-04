<%@page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
     /* General Styles */
     body {
         font-family: Arial, sans-serif;
         margin: 0;
         padding: 0;
         background-color: #f4f4f4;
         color: #333;
     }

form  {
         max-width: 600px;
         margin: 10px auto;

         border-radius: 8px;
     }

     /* Container */
     form#main  {
         max-width: 600px;
         margin: 50px auto;
         background-color:white;
         padding: 20px 30px;
         border-radius: 8px;
         box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
     }

 h1 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 24px;
            margin-top:20px;

        }

     /* Form Group */
     div {
         margin-bottom: 15px;
     }

     label {
         font-weight: bold;
         display: block;
         margin-bottom: 5px;
         color: #555;
     }

     input[type="text"],
     input[type="number"],
     input[type="file"],
     select {
         width: 100%;
         padding: 10px;
         font-size: 16px;
         border: 1px solid #ccc;
         border-radius: 4px;
         box-sizing: border-box;
         transition: border-color 0.3s ease-in-out;
     }

     input[type="text"]:focus,
     input[type="number"]:focus,
     input[type="file"]:focus,
     select:focus {
         border-color: #4CAF50;
         outline: none;
     }

      .styled-button {
      width: 200px !important;
                         background-color: #4CAF50; /* Green background */
                         color: white; /* White text */
                         border: none; /* Remove border */
                         padding: 10px 20px; /* Padding for size */
                         text-align: center; /* Center text */
                         text-decoration: none; /* Remove underline */
                         display: inline-block; /* Inline block for proper spacing */
                         font-size: 16px; /* Font size */
                         margin: 4px 2px; /* Margins for spacing */
                         cursor: pointer; /* Pointer cursor on hover */
                         border-radius: 5px; /* Rounded corners */
                         transition: background-color 0.3s ease; /* Smooth transition */
                          margin-bottom: 20px;

                     }

                     /* Hover effect */
                     .styled-button:hover {
                         background-color: #45a049; /* Darker green on hover */

                     }

     /* Image Preview */
     img {
         display: block;
         margin: 10px 0;
         max-width: 100%;
         height: auto;
         border: 1px solid #ddd;
         border-radius: 4px;
         padding: 5px;
         background-color: #f9f9f9;
     }

     /* Submit Button */
     button[type="submit"] {
         background-color: #4CAF50;
         color: white;
         font-size: 16px;
         padding: 10px 15px;
         border: none;
         border-radius: 4px;
         cursor: pointer;
         width: 100%;
         transition: background-color 0.3s ease-in-out;
     }

     button[type="submit"]:hover {
         background-color: #45a049;
     }

     /* Form Responsiveness */
     @media (max-width: 768px) {
         form {
             padding: 15px 20px;
         }

         h1 {
             font-size: 24px;
         }
     }

    </style>
</head>
<body>





   <div class="modal-body">

    <form action="/san-pham/detail/${id}" method="get">
                       <button type="submit" class="styled-button">Quay lại  </button>
                   </form>


     <form id="main" action="/san-pham/update/detail/${sanPhamCT.id}" method="post">
         <!-- Hidden field to send the ID -->
         <h1>Cập nhật sản phẩm </h1>
         <input type="hidden" name="id" value="${sanPhamCT.id}">

         <div class="mb-3" hidden>
             <label for="maSpct">Mã Sản Phẩm CT</label>
             <input type="text" id="maSpct" name="maSpct" value="${sanPhamCT.maSpct}" class="form-control" required>
         </div>

         <div class="mb-3" hidden>
             <label for="idSanPham">Sản Phẩm</label>
             <input type="text" id="idSanPham" name="idSanPham" value="${sanPhamCT.idSanPham}" class="form-control" required>
         </div>

         <div class="mb-3">
             <label for="idMauSac">Màu Sắc</label>
                     <select id="mauSac" name="idMauSac" class="form-control" required>

                 <option value="">Chọn Màu Sắc</option>
                 <c:forEach var="mauSac" items="${mauSacs}">
                     <option value="${mauSac.idMS}"
                             ${mauSac.idMS == sanPhamCT.idMauSac ? 'selected' : ''}>
                         ${mauSac.tenMS}
                     </option>
                 </c:forEach>
             </select>
         </div>

         <div class="mb-3">
             <label for="thuongHieu">Thương Hiệu</label>
        <select id="idThuongHieu" name="idThuongHieu" class="form-control" required>
                 <option value="">Chọn Thương Hiệu</option>
                 <c:forEach var="thuongHieu" items="${thuongHieus}">
                     <option value="${thuongHieu.id}"
                             ${thuongHieu.id == sanPhamCT.idThuongHieu ? 'selected' : ''}>
                         ${thuongHieu.tenTH}
                     </option>
                 </c:forEach>
             </select>
         </div>

         <div class="mb-3">
             <label for="kichCo">Kích Cỡ</label>
        <select id="kichCo" name="kichCo" class="form-control" required>
                 <option value="">Chọn Kích Cỡ</option>
                 <c:forEach var="kichCo" items="${size}">
                     <option value="${kichCo.id}"
                             ${kichCo.id == sanPhamCT.kichCo ? 'selected' : ''}>
                         ${kichCo.size}
                     </option>
                 </c:forEach>
             </select>
         </div>

         <div class="mb-3">
             <label for="gia">Giá</label>
             <input type="text" id="gia" name="gia" value="${sanPhamCT.gia}" class="form-control" required>
         </div>

         <div class="mb-3">
             <label for="soLuongTon">Số Lượng Tồn</label>
             <input type="number" id="soLuongTon" name="soLuongTon" value="${sanPhamCT.soLuongTon}" class="form-control" required>
         </div>

         <div class="mb-3" hidden>
             <label for="trangThai">Trạng Thái</label>
             <input type="checkbox" id="trangThai" name="trangThai" ${sanPhamCT.trangThai ? 'checked' : ''}>
         </div>

         <button type="submit" class="btn btn-primary">Cập Nhật</button>
     </form>

   </div>


</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>