package com.example.khachhang.admin.controller;

import com.example.khachhang.entity.Voucher;
import com.example.khachhang.repository.VoucherRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class CheckOutController {
    @Autowired
    private VoucherRepository voucherRepository;

    @GetMapping("/api/vouchers")
    public List<Voucher> getVouchers() {
        return voucherRepository.findAll();
    }
}
