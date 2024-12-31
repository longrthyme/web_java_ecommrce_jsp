<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }

        /* Navbar */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: black;
            padding: 10px 20px;
            color: white;
            position: relative;
        }

        .navbar-left {
            display: flex;
            align-items: center;
        }

        .navbar-left img {
            height: 50px;
        }

        .navbar-center {
            display: flex;
            align-items: center;
            flex-grow: 1;
            justify-content: center;
        }

        .search-bar {
            display: flex;
        }

        .search-bar input {
            width: 400px;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .search-button {
            background-color: black;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-left: 10px;
            ransition: background-color 0.3s, transform 0.2s;
        }
        .search-button:hover {
            background-color: red;
            transform: scale(1.05);
        }
        .navbar-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .navbar-right a {
            color: white;
            font-size: 20px;
            position: relative;
        }
        .navbar-right a:hover {
            background-color: rgba(255, 255, 255, 0.2);
            transform: scale(1.1);
        }
        .navbar-right a span {
            position: absolute;
            top: -10px;
            right: -10px;
            background-color: red;
            color: white;
            padding: 3px 6px;
            border-radius: 50%;
            font-size: 12px;
        }

        /* Container */
        .checkout-container {
            max-width: 900px;
            margin: 20px auto;
            padding: 20px;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        /* Product Summary */
        .product-summary {
            margin-bottom: 20px;
        }

        .product-summary h2 {
            font-size: 24px;
            color: #333;
            margin-bottom: 15px;
        }

        .product-table {
            width: 100%;
            border-collapse: collapse;
        }

        .product-table th,
        .product-table td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }

        .product-table th {
            background-color: #f0f0f0;
            font-weight: bold;
        }

        .product-table img {
            width: 80px;
            border-radius: 5px;
        }

        /* Address Section */
        .address-section {
            margin-bottom: 20px;
        }

        .address-section h2 {
            font-size: 24px;
            color: #333;
            margin-bottom: 15px;
        }

        .address-section input, .voucher-section input, .note-section textarea {
            width: 100%;
            max-width: 100%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .address-section .save-address-button {
            background-color: #007bff;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }
        /* Payment Method Section */
        .payment-method-section select {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        /* Voucher Section */
        .voucher-display {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .voucher-button {
            background-color: #007bff;
            color: white;
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .voucher-button:hover {
            background-color: #0056b3;
        }

        .voucher-modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background: white;
            padding: 30px;
            border-radius: 8px;
            width: 400px;
            text-align: center;
        }

        .voucher-list {
            margin: 20px 0;
            text-align: left;
        }

        .voucher-item {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .voucher-image {
            width: 70px;
            height: 70px;
            margin-right: 15px;
        }

        .voucher-info {
            flex-grow: 1;
        }

        .modal-actions {
            display: flex;
            justify-content: space-between;
        }

        .modal-close,
        .modal-confirm {
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .modal-close {
            background-color: #ddd;
        }

        .modal-confirm {
            background-color: #007bff;
            color: white;
        }

        .modal-confirm:hover {
            background-color: #0056b3;
        }

        /* Summary Section */
        .summary-section {
            margin-top: 20px;
            padding: 20px;
            border-top: 1px solid #ddd;
        }

        .summary-section h2 {
            font-size: 24px;
            color: #333;
            margin-bottom: 15px;
        }

        .summary-details {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 16px;
        }

        .summary-details .label {
            font-weight: bold;
            color: #333;
        }

        .total-payment {
            font-size: 20px;
            color: red;
            font-weight: bold;
        }

        /* Place Order Button */
        .place-order-button {
            background-color: #f53d2d;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 5px;
            width: 100%;
            font-size: 18px;
            cursor: pointer;
            display: none;
        }
        .place-order-button.show {
            display: block;
        }
        .place-order-button:hover {
            background-color: #d13428;
        }
    </style>
    <script>
        function toggleSummary() {
            const paymentMethod = document.getElementById("payment-method").value;
            const summarySection = document.querySelector(".summary-section");
            const placeOrderButton = document.querySelector(".place-order-button");

            if (paymentMethod) {
                summarySection.style.display = "block";
                placeOrderButton.classList.add("show");
            } else {
                summarySection.style.display = "none";
                placeOrderButton.classList.remove("show");
            }
        }
    </script>
</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <div class="navbar-left">
        <a href="/home/index"><img src="${pageContext.request.contextPath}/StyleL.jpg" alt="Style life"></a>
        <span style="color: white; font-size: 20px; margin-left: 10px;">Style Life</span>
    </div>
    <div class="navbar-center">
        <div class="search-bar">
            <input type="text" placeholder="Bạn cần tìm gì?">
        </div>
        <button class="search-button" onclick="searchProducts()">Tìm Kiếm</button>
    </div>
    <div class="navbar-right">
        <a href="#"><i class="fas fa-user"></i></a>
        <a href="#"><i class="fas fa-bell"></i><span>4</span></a>
        <a href="/home/cart"><i class="fas fa-shopping-cart"></i><span>0</span></a>
    </div>
</div>


<div class="checkout-container">

    <div class="product-summary">
        <h2>Sản phẩm đã chọn</h2>
        <table class="product-table">
            <thead>
            <tr>
                <th>Ảnh sản phẩm</th>
                <th>Tên sản phẩm</th>
                <th>Số lượng</th>
                <th>Giá</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td><img src="${pageContext.request.contextPath}/images/Thun1.jpg" alt="Áo thun"></td>
                <td>Áo Thun Nam Lót Trong StyleS Chất Cotton Phom Slimfit</td>
                <td>1</td>
                <td>₫1,800,000</td>
            </tr>
            </tbody>
        </table>
    </div>

    <!-- Địa chỉ nhận hàng -->
    <div class="address-section">
        <h2>Địa chỉ nhận hàng</h2>
        <input type="text" placeholder="Tên người nhận">
        <input type="text" placeholder="Số điện thoại">
        <input type="text" placeholder="Địa chỉ">
        <input type="text" placeholder="Phường/Xã">
        <input type="text" placeholder="Quận/Huyện">
        <input type="text" placeholder="Tỉnh/Thành phố">
        <button class="save-address-button">Lưu địa chỉ</button>
    </div>
    <div class="voucher-section">
        <h2>Voucher của Shop</h2>
        <div class="voucher-display">
            <span class="voucher-text">Chọn voucher</span>
            <button class="voucher-button" onclick="showVoucherModal()">Chọn Voucher</button>
        </div>
        <p id="selected-voucher" style="color: green; margin-top: 10px;"></p>
    </div>

    <!-- Modal hiển thị voucher -->
    <div class="voucher-modal" id="voucherModal" style="display: none;">
        <div class="modal-content">
            <h3>Chọn Voucher</h3>

            <div class="voucher-list">
                <c:forEach var="voucher" items="${vouchers}">
                    <div class="voucher-item">
                        <div class="voucher-info">
                            <input type="radio" id="voucher${voucher.id}" name="voucher" value="${voucher.giaTri}" />
                            <label for="voucher${voucher.id}">
                                    ${voucher.tenVc} <br>
                                Giảm: ${voucher.giaTri} ${voucher.loaiGiamGia} <br>
                                Đơn tối thiểu: ${voucher.giaTriToiThieu} <br>
                                HSD: ${voucher.ngayKetThuc}
                            </label>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="modal-actions">
                <button class="modal-close" onclick="hideVoucherModal()">Trở lại</button>
                <button class="modal-confirm" onclick="confirmVoucher()">Xác nhận</button>
            </div>
        </div>
    </div>

    <div class="note-section">
        <h2>Lưu ý với người bán</h2>
        <textarea placeholder="Nhập lưu ý của bạn" rows="3"></textarea>
    </div>
    <div class="payment-method-section">
        <h2>Chọn phương thức thanh toán</h2>
        <select id="payment-method" onchange="toggleSummary()">
            <option value="">Chọn phương thức thanh toán</option>
            <option value="cash">Tiền mặt</option>
            <option value="vnpay">VNPay</option>
        </select>
    </div>

    <!-- Thông tin thanh toán (ẩn/hiện) -->
    <div class="summary-section" style="display: none;">
        <h2>Thông tin thanh toán</h2>
        <div class="summary-details">
            <span class="label">Tổng tiền hàng:</span>
            <span>₫1800000</span>
        </div>
        <div class="summary-details">
            <span class="label">Phí vận chuyển:</span>
            <span class="shipping-fee">₫0</span>
        </div>
        <div class="summary-details">
            <span class="label">Voucher giảm giá:</span>
            <span class="voucher-discount">₫0</span>
        </div>
        <div class="summary-details">
            <span class="label">Tổng thanh toán:</span>
            <span class="total-payment">₫1800000</span>
        </div>
    </div>

    <!-- VNPay Section (ẩn/hiện) -->
    <div class="vnpay-section" style="display: none;">
        <h2>Thanh toán qua VNPay</h2>
        <p>Vui lòng sử dụng ứng dụng VNPay để thanh toán. Quét mã QR hoặc đăng nhập để hoàn tất giao dịch.</p>
        Tích hợp vnpay vào đây nhóe
    </div>
    <button class="place-order-button">Đặt hàng</button>
</div>
<script>
    function toggleSummary() {
        const paymentMethod = document.getElementById("payment-method").value;
        const summarySection = document.querySelector(".summary-section");
        const vnpaySection = document.querySelector(".vnpay-section");
        const placeOrderButton = document.querySelector(".place-order-button");

        if (paymentMethod === "cash") {
            summarySection.style.display = "block";
            vnpaySection.style.display = "none";
            placeOrderButton.classList.add("show");
        } else if (paymentMethod === "vnpay") {
            summarySection.style.display = "none";
            vnpaySection.style.display = "block";
            placeOrderButton.classList.add("show");
        } else {
            summarySection.style.display = "none";
            vnpaySection.style.display = "none";
            placeOrderButton.classList.remove("show");
        }
    }
    function showVoucherModal() {
        // Hiển thị modal
        document.getElementById("voucherModal").style.display = "flex";

        // Gọi API để lấy danh sách voucher
        fetch("/api/vouchers")
            .then(response => response.json())
            .then(data => {
                const voucherList = document.querySelector(".voucher-list");

                voucherList.innerHTML = "";

                data.forEach(voucher => {
                    const voucherItem = document.createElement("div");
                    voucherItem.className = "voucher-item";

                    voucherItem.innerHTML = `
                    <div class="voucher-info">
                        <input type="radio" id="voucher${voucher.id}" name="voucher" value="${voucher.giaTri}" />
                        <label for="voucher${voucher.id}">
                            ${voucher.tenVc}<br>
                            Giảm: ${voucher.giaTri} ${voucher.loaiGiamGia}<br>
                            Đơn tối thiểu: ${voucher.giaTriToiThieu}<br>
                            HSD: ${voucher.ngayKetThuc}
                        </label>
                    </div>
                `;

                    voucherList.appendChild(voucherItem);
                });
            })
            .catch(error => {
                console.error("Error fetching vouchers:", error);
            });
    }

    function hideVoucherModal() {
        document.getElementById("voucherModal").style.display = "none";
    }

    function confirmVoucher() {
        const selectedVoucher = document.querySelector('input[name="voucher"]:checked');
        const selectedVoucherText = document.getElementById("selected-voucher");

        if (selectedVoucher) {
            const discount = parseFloat(selectedVoucher.value);

            if (discount === 0) {
                selectedVoucherText.textContent = "Bạn không sử dụng voucher.";
            } else {
                selectedVoucherText.textContent = `Bạn đã chọn voucher giảm ${discount.toLocaleString()}₫`;
            }

            updateTotalPayment(discount);
        }

        hideVoucherModal();
    }
    function updateTotalPayment(discount) {
        const totalAmount = 1800000;
        const shippingFee = 30000;
        const finalAmount = totalAmount + shippingFee - discount;

        // Hiển thị tổng thanh toán mới
        document.querySelector(".total-payment").textContent = `₫${finalAmount.toLocaleString()}`;
    }
    document.addEventListener("DOMContentLoaded", function () {
        fetch("/api/vouchers") // Gọi API để lấy danh sách vouchers
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                return response.json();
            })
            .then(data => {
                const tableBody = document.querySelector("#voucherTable tbody");
                tableBody.innerHTML = ""; // Xóa các hàng hiện có (nếu cần)

                // Duyệt qua danh sách vouchers và thêm vào bảng
                data.forEach(voucher => {
                    const row = `
                    <tr>
                        <td>${voucher.id}</td>
                        <td>${voucher.maVc}</td>
                        <td>${voucher.tenVc}</td>
                        <td>${voucher.ngayBatDau}</td>
                        <td>${voucher.ngayKetThuc}</td>
                        <td>${voucher.giaTri}</td>
                        <td>${voucher.loaiGiamGia}</td>
                        <td>${voucher.giaTriToiThieu}</td>
                        <td>${voucher.trangThai ? "Hoạt động" : "Không hoạt động"}</td>
                    </tr>
                `;
                    tableBody.innerHTML += row;
                });
            })
            .catch(error => {
                console.error("Có lỗi khi gọi API:", error);
            });
    });

</script>
</body>
</html>
