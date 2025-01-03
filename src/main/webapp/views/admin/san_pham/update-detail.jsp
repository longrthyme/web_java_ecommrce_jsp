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

     /* Container */
     form {
         max-width: 600px;
         margin: 50px auto;
         background: #fff;
         padding: 20px 30px;
         border-radius: 8px;
         box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
     }

     /* Form Title */
     h1 {
         text-align: center;
         color: #4CAF50;
         margin-bottom: 20px;
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

     <h1>Update Product</h1>
   <div class="modal-body">
       <form id="detailForm" action="/san-pham/update/detail/${sanPhamCT.id}" method="post">
           <div class="mb-3">
               <label for="mauSac">Màu Sắc</label>
               <select id="mauSac" name="mauSac" class="form-control" required>
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
               <select id="thuongHieu" name="thuongHieu" class="form-control" required>
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
                   <!-- Lặp qua danh sách kích cỡ -->
                   <c:forEach var="kichCo" items="${size}">

                         <option value="${kichCo.id}"
                                                                    ${kichCo.id == sanPhamCT.kichCo ? 'selected' : ''}>
                                                                ${kichCo.size}
                                                            </option>
                   </c:forEach>
               </select>
           </div>
           <div class="mb-3">
               <label for="soLuong">Số Lượng</label>
               <input type="number" id="soLuong" name="soLuong" value="${sanPhamCT.soLuongTon}" class="form-control" required />
           </div>
               <button type="submit" class="btn btn-primary">Cập Nhật</button>

       </form>
   </div>


</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>