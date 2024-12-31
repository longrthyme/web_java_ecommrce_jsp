package com.example.khachhang.admin.controller;

import com.example.khachhang.entity.KhachHang;
import com.example.khachhang.entity.NhanVien;
import com.example.khachhang.repository.NhanVienRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("nhan-vien")
public class QLNhanVienController {
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
        return "admin/nhan_vien/index";
    }

    // Sợt nhân viên
    @GetMapping("search")
    public String search(
            @RequestParam(value = "maNV", required = false) String maNV,
            @RequestParam(value = "email", required = false) String email,
            @RequestParam(value = "chucVu", required = false) Boolean chucVu,
            @RequestParam(value = "trangThai", required = false) Boolean trangThai,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            Model model) {

        Pageable pageable = PageRequest.of(page - 1, size);

        Page<NhanVien> nvPage = nvRepo.searchNhanVien(
                maNV != null && !maNV.isEmpty() ? maNV : null,
                email != null && !email.isEmpty() ? email : null,
                chucVu,
                trangThai,
                pageable
        );

        model.addAttribute("data", nvPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", nvPage.getTotalPages());
        model.addAttribute("maNV", maNV);
        model.addAttribute("email", email);
        model.addAttribute("chucVu", chucVu);
        model.addAttribute("trangThai", trangThai);

        return "admin/nhan_vien/index";
    }

    // Thêm nhân viên
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("nhanVien", new NhanVien());
        return "admin/nhan_vien/add";
    }

    @PostMapping("add")
    public String saveNhanVien(NhanVien nv, Model model) {
        if (nvRepo.existsByMaNV(nv.getMaNV())) {
            model.addAttribute("error", "Mã nhân viên đã tồn tại! :) :) :) :)");
            return "admin/nhan_vien/add";
        }
        nvRepo.save(nv);
        return "redirect:/nhan-vien/index";
    }

    // -- Xóa nhân viên --
    @GetMapping("delete/{id}")
    public String delete(@PathVariable("id") int id){
        this.nvRepo.deleteById(id);
        return "redirect:/nhan-vien/index";
    }

    // -- Chi tiết nhân viên
    @GetMapping("/detail/{id}")
    public String detail(@PathVariable("id") Integer id, Model model) {
        NhanVien nv = nvRepo.getById(id);
        model.addAttribute("detail", nv);
        return "admin/nhan_vien/detail";
    }


    // -- Cập nhật nhân viên --
    @GetMapping("update/{id}")
    public String update(@PathVariable("id") Integer id, Model model) {
        NhanVien nv = nvRepo.findById(id).orElse(null);
        if (nv != null) {
            model.addAttribute("nv", nv);
        }
        return "admin/nhan_vien/update";
    }
    @PostMapping("update/{id}")
    public String updateCustomer(@PathVariable("id") Integer id, @ModelAttribute NhanVien nv, @RequestParam("ngaySinh") String ngaySinhStr) throws ParseException {
        NhanVien existingNV = nvRepo.findById(id).orElse(null);
        if (existingNV != null) {
            existingNV.setTenNV(nv.getTenNV());
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
            Date ngaySinh = dateFormat.parse(ngaySinhStr);
            existingNV.setNgaySinh(ngaySinh);
            existingNV.setGioiTinh(nv.getGioiTinh());
            existingNV.setSdt(nv.getSdt());
            existingNV.setDiaChi(nv.getDiaChi());
            existingNV.setEmail(nv.getEmail());
            existingNV.setChucVu(nv.getChucVu());
            existingNV.setTrangThai(nv.getTrangThai());
            nvRepo.save(existingNV);
        }
        return "redirect:/nhan-vien/index";
    }

}
