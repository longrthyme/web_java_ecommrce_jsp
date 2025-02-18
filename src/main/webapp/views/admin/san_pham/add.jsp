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
        body {
            background-color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }

          .styled-button {
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

        .alert-danger {
            color: #d9534f;
            background-color: white;
            border-color: #f5c6cb;
            border-radius: 5px;
            padding: 15px;
            margin-top: 10px;
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }
        }
    </style>
</head>
<body>

<div class="container mt-4">
<form action="/san-pham/index" method="get">
            <button type="submit" class="styled-button">Quay lại  </button>
        </form>
    <!-- Form Thêm Sản Phẩm -->
    <h3>Thêm Sản Phẩm</h3>
    <form id="productForm" action="/san-pham/add" method="POST">

        <div class="row">
            <div class="col-md-6">
                <label for="maSP">Mã Sản Phẩm</label>
                <input type="text" id="maSP" class="form-control" required />
            </div>
            <div class="col-md-6">
                <label for="tenSP">Tên Sản Phẩm</label>
                <input type="text" id="tenSP" class="form-control" required />
            </div>
            <div class="col-md-6">
                <label for="gia">Giá</label>
                <input type="number" id="gia" class="form-control" required />
            </div>
            <div class="col-md-6">
                <label for="loai">Loại</label>
                <input type="text" id="loai" class="form-control" required />
            </div>
        </div>
        <button type="button" id="addProductBtn" class="btn btn-primary mt-3">Thêm Sản Phẩm</button>
    </form>
    <div id="detailsSection" class="mt-4" style="display:none;">
        <h4>Chi Tiết Sản Phẩm</h4>
        <table class="table table-bordered">
            <thead>
            <tr>
            <th>Mã </th>
                <th>Màu Sắc</th>
                <th>Thương Hiệu</th>
                <th>Kích Cỡ</th>
                <th>Số Lượng</th>
                <th>Trạng Thái</th>
                <th>Hành Động</th>
            </tr>
            </thead>
            <tbody id="detailsTable"></tbody>
            <td></td>
        </table>
        <button type="button" id="addDetailBtn" class="btn btn-success">Thêm Chi Tiết</button>
    </div>

    <!-- Thêm Ảnh -->
    <div id="imageSection" class="mt-4" style="display:none;">
        <h4>Thêm Ảnh</h4>
        <input type="file" id="productImage" class="form-control" />
        <button type="button" id="uploadImageBtn" class="btn btn-primary mt-2">Thêm Ảnh</button>
         <div id="uploadResult" class="mt-2"></div>
    </div>


</div>

<!-- Modal Nhập Chi Tiết -->
<div class="modal" id="detailModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Nhập Chi Tiết Sản Phẩm</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="detailForm">
                    <div class="mb-3">
                        <label for="mauSac">Màu Sắc</label>
                        <select id="mauSac" class="form-control" required>
                            <option value="">Chọn Màu Sắc</option>
                            <!-- Lặp qua danh sách màu sắc -->
                            <c:forEach var="mauSac" items="${mauSacs}">
                                <option value="${mauSac.idMS}">${mauSac.tenMS}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="thuongHieu">Thương Hiệu</label>
                        <select id="thuongHieu" class="form-control" required>
                            <option value="">Chọn Thương Hiệu</option>
                            <!-- Lặp qua danh sách thương hiệu -->
                            <c:forEach var="thuongHieu" items="${thuongHieus}">
                                <option value="${thuongHieu.id}">${thuongHieu.tenTH}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                         <label for="kichCo">Kích Cỡ</label>
                                       <select id="kichCo" name="kichCo" class="form-control" required>
                                           <option value="">Chọn Kích Cỡ</option>
                                           <!-- Lặp qua danh sách kích cỡ -->
  <c:forEach var="kichCo" items="${size}">
                                                                           <option value="${kichCo.id}">${kichCo.size}</option>
                                                                       </c:forEach>
                                       </select>

                    </div>
                    <div class="mb-3">
                        <label for="soLuong">Số Lượng</label>
                        <input type="number" id="soLuong" class="form-control" required />
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="button" id="confirmDetailBtn" class="btn btn-primary">Xác Nhận</button>
            </div>
        </div>
    </div>
</div>

<script>

var  tempProductId = 0;

    document.getElementById('addProductBtn').addEventListener('click', () => {
        const maSP = document.getElementById('maSP').value;
        const tenSP = document.getElementById('tenSP').value;
        const gia = document.getElementById('gia').value;
        const loai = document.getElementById('loai').value;


        if (!maSP || !tenSP || !gia || !loai) {
            alert("Vui lòng nhập đầy đủ thông tin sản phẩm!");
            return;
        }

        const productData = {
            maSP,
            tenSP,
            gia: parseFloat(gia),
            loai
        };

        fetch('/san-pham/add', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(productData)
        })
            .then(response => {
                if (!response.ok) {
                    return response.text().then(errMessage => {
                        throw new Error(errMessage || 'Thêm sản phẩm thất bại');
                    });
                }
                return response.json();
            })
            .then(newProductId => {
                alert('Thêm sản phẩm thành công!');
                document.getElementById('productForm').reset();
                tempProductId = newProductId;
                document.getElementById('productForm').style.display = 'none';;
                document.getElementById('detailsSection').style.display = 'block';
                document.getElementById('imageSection').style.display = 'block';
            })
            .catch(error => {
                const errorDiv = document.createElement('div');
                errorDiv.className = 'alert alert-danger mt-3';
                errorDiv.textContent = error.message;
                document.querySelector('.container').appendChild(errorDiv);

                setTimeout(() => errorDiv.remove(), 5000);
            });
    });

    document.getElementById('addDetailBtn').addEventListener('click', () => {
        // Hiển thị modal thêm chi tiết
        const detailModal = new bootstrap.Modal(document.getElementById('detailModal'));
        detailModal.show();
    });



            var saveCTSPId = 0;








            


   async function addSanPhamCT(payload) {
       try {
           const response = await fetch('/san-pham/detail/add', {
               method: 'POST',
               headers: {
                   'Content-Type': 'application/json',
               },
               body: JSON.stringify(payload)
           });

           if (!response.ok) {
               throw new Error('Failed to add product detail');
           }


        const message = await response.text();
        console.log("response 1:", message);


           saveCTSPId = message;  // Set saveCTSPId after getting the response
           document.getElementById('detailForm').reset();

             return saveCTSPId;

       } catch (error) {
           console.error("Error:", error);
           alert('Lỗi khi thêm chi tiết sản phẩm!');
       }
   }


    document.getElementById('confirmDetailBtn').addEventListener('click', () => {
        const mauSacId = document.getElementById('mauSac').value;
        const thuongHieuId = document.getElementById('thuongHieu').value;
        const kichCo = document.getElementById('kichCo').value;

        const soLuong = parseInt(document.getElementById('soLuong').value, 10);

        if (!mauSacId || !thuongHieuId || !kichCo || isNaN(soLuong)) {
            alert('Vui lòng nhập đầy đủ thông tin!');
            return;
        }

console.log("prdocut id is "  + tempProductId);
            const payload = {
                idMauSac: mauSacId,
                idThuongHieu: thuongHieuId,
                kichCo: kichCo,
                soLuong: soLuong,
                idSanPham: tempProductId
            };


       (async () => {
           try {
               const id = await addSanPhamCT(payload);  // Await the result
               console.log("saveCTSPId outside:", id);

                 const selectElement = document.getElementById("mauSac");
                                 // Get the selected option's text
                                 const mauSac = selectElement.options[selectElement.selectedIndex].text;
                                 // Display the result



               const thuongHieuElement = document.getElementById('thuongHieu');
               const thuongHieuId2 = thuongHieuElement.value;

               // Get the text content of the selected option
               const thuongHieuText = thuongHieuElement.options[thuongHieuElement.selectedIndex].text;

               console.log('Selected Thương Hiệu Text:', thuongHieuText);


               console.log("mau sac " + mauSac);
               console.log("thuong hieu " + thuongHieu);
                       const status = soLuong > 0 ? 'Còn hàng' : 'Hết hàng';

                       console.log("value before  " + saveCTSPId);

                          let newRow = "<tr data-id='" + saveCTSPId + "'>";

                          newRow += "<td>" + saveCTSPId + "</td>";
                              newRow += "<td>" + mauSac + "</td>";
                              newRow += "<td>" + thuongHieuText + "</td>";
                              newRow += "<td>" + kichCo + "</td>";
                              newRow += "<td>" + soLuong + "</td>";
                              newRow += "<td>" + status + "</td>";
                              newRow += "<td><button class='btn btn-warning btn-sm'>Thay đổi trạng thái</button></td>";
                              newRow += "</tr>";


                                                      console.log("Generated newRow:", newRow); // Log the constructed HTML string



                       document.getElementById('detailsTable').insertAdjacentHTML('beforeend', newRow);

                       document.getElementById('detailForm').reset();
                       const detailModal = bootstrap.Modal.getInstance(document.getElementById('detailModal'));
                       detailModal.hide();

               // You can now safely use id (or saveCTSPId) here
           } catch (error) {
               console.error("Error handling outside:", error);
           }
       })();





    });

    function updateStatusAPI(id, newStatus) {
        console.log("id " + id + " new status " + newStatus);
        return fetch(`/san-pham/updateStatus`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ id: id, status: newStatus })
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to update status');
            }
            return response.json();
        })
        .then(data => {
            console.log('Status updated successfully:', data);
        })
        .catch(error => {
            console.error('Error updating status:', error);
            alert('Failed to update status. Please try again.');
        });
    }


    document.getElementById('detailsTable').addEventListener('click', function (event) {
        if (event.target.classList.contains('btn-warning')) {  // Check if the clicked element is the button
            const row = event.target.closest('tr');             // Get the row where the button was clicked
            const statusCell = row.cells[5];                    // Get the status cell in that row
            const currentStatus = statusCell.innerText;         // Get current status value

            console.log("status is " + currentStatus );

            // Toggle the status (Active <-> Inactive)
            const newStatus = currentStatus === 'Còn hàng' ? 'Hết hàng' : 'Còn hàng';

            // Update the status cell visually
            statusCell.innerText = newStatus;

            // Optionally call an API to persist the change
            const id = row.dataset.id;  // Assuming row has a data-id attribute for identifying the item
            console.log("id sent " + id);
            updateStatusAPI(id, newStatus);
        }
    });




      document.getElementById("uploadImageBtn").addEventListener("click", async () => {
            const productImage = document.getElementById("productImage").files[0];
            const uploadResult = document.getElementById("uploadResult");

            if (!productImage) {
                uploadResult.innerHTML = "<p style='color: red;'>Vui lòng chọn một tệp để tải lên.</p>";
                return;
            }

            const formData = new FormData();
            formData.append("imageFile", productImage);

            formData.append("id", tempProductId);

            try {
                const response = await fetch("/san-pham/upload-image", {
                    method: "POST",
                    body: formData,
                });

                if (response.ok) {
                    const data = await response.json();
                    uploadResult.innerHTML = `<p style='color: green;'>Tải ảnh lên thành công: ${data.fileName}</p>`;
                } else {
                    uploadResult.innerHTML = `<p style='color: red;'>Lỗi tải lên ảnh. Vui lòng thử lại.</p>`;
                }
            } catch (error) {
                console.error("Error uploading image:", error);
                uploadResult.innerHTML = "<p style='color: red;'>Lỗi kết nối với máy chủ.</p>";
            }
        });

</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>