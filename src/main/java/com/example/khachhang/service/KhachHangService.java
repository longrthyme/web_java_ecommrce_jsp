package com.example.khachhang.service;

import com.example.khachhang.entity.KhachHang;
import com.example.khachhang.repository.KhachHangRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class KhachHangService {
    @Autowired
    private KhachHangRepository khachHangRepository;

    // Đổi trạng thái
    public void changeStatus(Integer id) {
        KhachHang kh = khachHangRepository.findById(id).orElseThrow(() -> new RuntimeException("Khách hàng không tồn tại"));
        kh.setTrangThai(!kh.getTrangThai());
        khachHangRepository.save(kh);
    }
}
