package com.example.khachhang.service;

import com.example.khachhang.dto.SanPhamCTDTO;
import com.example.khachhang.entity.SanPhamCT;
import com.example.khachhang.repository.SanPhamCTRepository;
import jakarta.persistence.Column;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SanPhamCTService {
//    @Autowired
//    private SanPhamRepository sanPhamRepository;

    @Autowired
    private SanPhamCTRepository sanPhamCTRepository;

    public void createSanPhamCT(SanPhamCTDTO request) {
        // Create a new instance of SanPhamCT
        SanPhamCT sanPhamCT = new SanPhamCT();

        // Map DTO properties to the entity
        sanPhamCT.setIdMauSac(request.getIdMauSac());
        sanPhamCT.setIdThuongHieu(request.getIdThuongHieu());
        sanPhamCT.setKichCo(request.getKichCo());
        sanPhamCT.setSoLuongTon(request.getSoLuong());
        sanPhamCT.setIdSanPham(request.getIdSanPham());
        sanPhamCT.setTrangThai(false); // Default to active status

        Integer maxId = sanPhamCTRepository.findMaxId(); // Custom query to get the max id
        String newMaSpct = "SPCT" + String.format("%03d", (maxId != null ? maxId + 1 : 1));
        sanPhamCT.setMaSpct(newMaSpct);

        // Optionally set default price
        sanPhamCT.setGia("150000.00"); // Example default price

        // Save to the database
        sanPhamCTRepository.save(sanPhamCT);
    }

}
