package com.example.khachhang.staff.controller;

import com.example.khachhang.entity.KhachHang;
import com.example.khachhang.repository.KhachHangRepository;
import com.example.khachhang.service.KhachHangService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("staff/khach-hang")
public class KhachHangController {

    @Autowired
    KhachHangRepository repo;

    @Autowired
    KhachHangService khachHangService;

    @GetMapping("index")
    public String index(Model model,
                        @RequestParam(defaultValue = "1") int page,
                        @RequestParam(defaultValue = "10") int size) {
        Pageable pageable = PageRequest.of(page - 1, size);
        Page<KhachHang> khachHangPage = repo.findAll(pageable);

        int totalPages = khachHangPage.getTotalPages();
        System.out.println("Current Page: " + page);
        System.out.println("Total Pages: " + totalPages);

        model.addAttribute("data", khachHangPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        return "staff/khach_hang/index";
    }

    @GetMapping("search")
    public String search(
            @RequestParam(value = "makh", required = false) String makh,
            @RequestParam(value = "email", required = false) String email,
            @RequestParam(value = "trangThai", required = false) Boolean trangThai,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            Model model) {

        Pageable pageable = PageRequest.of(page - 1, size);

        Page<KhachHang> khachHangPage = repo.searchKhachHang(
                makh != null && !makh.isEmpty() ? makh : null,
                email != null && !email.isEmpty() ? email : null,
                trangThai,
                pageable
        );

        model.addAttribute("data", khachHangPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", khachHangPage.getTotalPages());
        model.addAttribute("makh", makh);
        model.addAttribute("email", email);
        model.addAttribute("trangThai", trangThai);

        return "staff/khach_hang/index";
    }

    @GetMapping("/detail/{id}")
    public String detail(@PathVariable("id") Integer id, Model model) {
        KhachHang kh = repo.getById(id);
        model.addAttribute("detail", kh);
        return "staff/khach_hang/detail";
    }

    @GetMapping("/changeStatus/{id}")
    public String changeStatus(@PathVariable Integer id) {
        khachHangService.changeStatus(id);
        return "redirect:/staff/khach-hang/index";
    }
}
