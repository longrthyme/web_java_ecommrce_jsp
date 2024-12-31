package com.example.khachhang.service;

import com.example.khachhang.entity.Voucher;
import com.example.khachhang.repository.VoucherRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class VoucherService {
    @Autowired
    private VoucherRepository voucherRepository;

    // Tìm kiếm
    public List<Voucher> search(String maVc, String trangThai) {
        if ((maVc == null || maVc.isEmpty()) && (trangThai == null || trangThai.isEmpty())) {
            return voucherRepository.findAll();
        }

        if (trangThai != null && !trangThai.isEmpty()) {
            boolean status = "1".equals(trangThai);
            if (maVc != null && !maVc.isEmpty()) {
                return voucherRepository.findByMaVcContainingAndTrangThai(maVc, status);
            }
            return voucherRepository.findByTrangThai(status);
        }

        return voucherRepository.findByMaVcContaining(maVc);
    }

    // Đổi trạng thái
    public void changeStatus(Integer id) {
        Voucher voucher = voucherRepository.findById(id).orElseThrow(() -> new RuntimeException("Voucher không tồn tại"));
        voucher.setTrangThai(!voucher.getTrangThai());
        voucherRepository.save(voucher);
    }

}
