package com.example.khachhang.admin.controller;

import com.example.khachhang.entity.NhanVien;
import com.example.khachhang.repository.NhanVienRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/nhan-vien")
public class NhanVienApiController {
    @Autowired
    NhanVienRepository nvRepo;

//    @GetMapping("/detail/{id}")
//    public NhanVien getNhanVienDetail(@PathVariable("id") Integer id) {
//        return nvRepo.findById(id).orElse(null);
//    }
}
