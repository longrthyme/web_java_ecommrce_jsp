package com.example.khachhang.admin.controller;

import com.example.khachhang.entity.KhachHang;
import com.example.khachhang.repository.KhachHangRepository;
import com.example.khachhang.service.KhachHangService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


import java.util.List;

@Controller
@RequestMapping("khach-hang")
public class QLKhachHangController {
    @Autowired
    KhachHangRepository repo;

    @Autowired
    KhachHangService khachHangService;

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

        return "admin/khach_hang/index";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("khachHang", new KhachHang());
        return "admin/khach_hang/add";
    }

    @PostMapping("add")
    public String saveKhachHang(KhachHang khachHang, Model model) {
        if (repo.existsByMakh(khachHang.getMakh())) {
            model.addAttribute("error", "Mã khách hàng đã tồn tại!");
            return "admin/khach_hang/add";
        }
        repo.save(khachHang);
        return "redirect:/khach-hang/index";
    }

    // -- Xóa khách hàng --
    @GetMapping("delete/{id}")
    public String delete(@PathVariable("id") int id){
        this.repo.deleteById(id);
        return "redirect:/khach-hang/index";
    }

    // -- Chi tiết khách hàng
    @GetMapping("/detail/{id}")
    public String detail(@PathVariable("id") Integer id, Model model) {
        KhachHang kh = repo.getById(id);
        model.addAttribute("detail", kh);
        return "admin/khach_hang/detail";
    }

    // -- Cập nhật khách hàng --
    @GetMapping("update/{id}")
    public String update(@PathVariable("id") Integer id, Model model) {
        KhachHang khachHang = repo.findById(id).orElse(null);
        if (khachHang != null) {
            model.addAttribute("khachHang", khachHang);
        }
        return "admin/khach_hang/update";
    }
    @PostMapping("update/{id}")
    public String updateCustomer(@PathVariable("id") Integer id, @ModelAttribute KhachHang khachHang) {
        KhachHang existingKhachHang = repo.findById(id).orElse(null);
        if (existingKhachHang != null) {
            existingKhachHang.setTenkh(khachHang.getTenkh());
            existingKhachHang.setNgaySinh(khachHang.getNgaySinh());
            existingKhachHang.setGioiTinh(khachHang.getGioiTinh());
            existingKhachHang.setSdt(khachHang.getSdt());
            existingKhachHang.setDiaChi(khachHang.getDiaChi());
            existingKhachHang.setEmail(khachHang.getEmail());
            existingKhachHang.setTrangThai(khachHang.getTrangThai());
            repo.save(existingKhachHang);
        }
        return "redirect:/khach-hang/index";
    }

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
        return "admin/khach_hang/index";
    }

    @GetMapping("/changeStatus/{id}")
    public String changeStatus(@PathVariable Integer id) {
        khachHangService.changeStatus(id);
        return "redirect:/khach-hang/index";
    }
}
