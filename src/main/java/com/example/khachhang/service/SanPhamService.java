package com.example.khachhang.service;

import com.example.khachhang.dto.SanPhamDTO;
import com.example.khachhang.entity.SanPham;
import com.example.khachhang.repository.SanPhamRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class SanPhamService {
    @Autowired
    SanPhamRepository spRepo;

    public Page<SanPhamDTO> getAllSanPham(Pageable pageable) {
        Page<SanPham> sanPhams = spRepo.findAll(pageable);
        return sanPhams.map(this::convertToDto);
    }

    public void addSanPham(SanPhamDTO dto) {
        if (spRepo.existsByMaSP(dto.getMaSP())) {
            throw new RuntimeException("Mã sản phẩm đã tồn tại!");
        }
        SanPham sp = convertToEntity(dto);
        spRepo.save(sp);
    }

    private SanPhamDTO convertToDto(SanPham sp) {
        return new SanPhamDTO(sp.getMaSP(), sp.getTenSP(), sp.getLoai(), sp.getAnhSP(), sp.getGia(), sp.getTrangThai());
    }

    private SanPham convertToEntity(SanPhamDTO dto) {
        return new SanPham(dto.getMaSP(), dto.getTenSP(), dto.getLoai(), dto.getAnhSP(), dto.getGia(), dto.getTrangThai());
    }

    public List<SanPhamDTO> getProductDetails(Integer productId) {
        List<SanPham> details = spRepo.findDetailsByProductId(productId);
        return details.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    public SanPham save(SanPhamDTO dto) {
        SanPham sp = new SanPham();
        sp.setMaSP(dto.getMaSP());
        sp.setTenSP(dto.getTenSP());
        sp.setGia(dto.getGia());
        sp.setLoai(dto.getLoai());
        sp.setTrangThai(true);
        return spRepo.save(sp);
    }
    // Đổi trạng thái
    public void changeStatus(Integer id) {
        SanPham sp = spRepo.findById(id).orElseThrow(() -> new RuntimeException("Sản phẩm không tồn tại"));
        sp.setTrangThai(!sp.getTrangThai());
        spRepo.save(sp);
    }
}
