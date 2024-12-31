package com.example.khachhang.staff.controller;

import com.example.khachhang.entity.NhanVien;
import com.example.khachhang.repository.NhanVienRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("staff/nhan-vien")
public class NhanVienController {
    @Autowired
    NhanVienRepository nvRepo;

    @GetMapping("index")
    public String index(Model model,
                        @RequestParam(defaultValue = "1") int page,
                        @RequestParam(defaultValue = "10") int size) {
        Pageable pageable = PageRequest.of(page - 1, size);
        Page<NhanVien> nvPage = nvRepo.findAll(pageable);

        int totalPages = nvPage.getTotalPages();
        System.out.println("Current Page: " + page);
        System.out.println("Total Pages: " + totalPages);

        model.addAttribute("data", nvPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        return "staff/nhan_vien/index";
    }

    @GetMapping("search")
    public String search(@RequestParam("maNV") String maNV, Model model) {
        List<NhanVien> nvList = nvRepo.findByMaNVContaining(maNV);
        model.addAttribute("data", nvList);
        return "staff/nhan_vien/index";
    }
}
