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
        <form action="<c:url value='/san-pham/update/${sp.id}' />" method="post" enctype="multipart/form-data">
            <!-- Hidden input to include the product ID -->
            <input type="hidden" name="id" value="${sp.id}" />

            <!-- Product Code -->
            <div>
                <label for="maSP">Product Code:</label>
                <input type="text" id="maSP" name="maSP" value="${sp.maSP}" required />
            </div>

            <!-- Product Name -->
            <div>
                <label for="tenSP">Product Name:</label>
                <input type="text" id="tenSP" name="tenSP" value="${sp.tenSP}" required />
            </div>

           <div>
                 <label for="anhSP">Product Image:</label>
                 <input type="file" id="anhSPP" name="anhSPP" />
                 <c:if test="${sp.anhSP != null}">
                     <p>Current Image:</p>
                     <img src="<c:url value='/images/${sp.anhSP}' />" alt="${sp.tenSP}" width="150" />
                 </c:if>
             </div>

            <!-- Product Price -->
            <div>
                <label for="gia">Price:</label>
                <input type="number" id="gia" name="gia" value="${sp.gia}" step="0.01" required />
            </div>

            <!-- Product Type -->
            <div>
                <label for="loai">Category:</label>
                <input type="text" id="loai" name="loai" value="${sp.loai}" required />
            </div>

            <!-- Product Status -->
            <div>
                <label for="trangThai">Status:</label>
                <select id="trangThai" name="trangThai" required>
                    <option value="true" <c:if test="${sp.trangThai}">selected</c:if>>Active</option>
                    <option value="false" <c:if test="${!sp.trangThai}">selected</c:if>>Inactive</option>
                </select>
            </div>

            <!-- Submit Button -->
            <div>
                <button type="submit">Update Product</button>
            </div>
        </form>

</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>