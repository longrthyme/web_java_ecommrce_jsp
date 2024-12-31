package com.example.khachhang.admin.controller;

import com.example.khachhang.entity.ThuongHieu;
import com.example.khachhang.repository.ThuongHieuRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Date;

@Controller
@RequestMapping("thuong-hieu")
public class ThuongHieuController {
    @Autowired
    ThuongHieuRepository thRepo;

    @GetMapping("index")
    public String index(Model model,
                        @RequestParam(defaultValue = "1") int page,
                        @RequestParam(defaultValue = "10") int size) {
        Pageable pageable = PageRequest.of(page - 1, size);
        Page<ThuongHieu> thuongHieuPage = thRepo.findAll(pageable);

        int totalPages = thuongHieuPage.getTotalPages();

        model.addAttribute("data", thuongHieuPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        return "admin/thuong_hieu/index";
    }

    @GetMapping("search")
    public String search(
            @RequestParam(value= "tenTH", required = false) String tenTH,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            Model model) {

        Pageable pageable = PageRequest.of(page - 1, size);

        Page<ThuongHieu> mauSacPage = thRepo.searchThuongHieu(
                tenTH != null && !tenTH.isEmpty() ? tenTH : null,
                pageable
        );
        model.addAttribute("data", mauSacPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", mauSacPage.getTotalPages());
        model.addAttribute("tenTH", tenTH);
        return "admin/thuong_hieu/index";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("th", new ThuongHieu());
        return "admin/thuong_hieu/add";
    }

    @PostMapping("/add")
    public String saveThuongHieu(ThuongHieu th, Model model) {
        if (thRepo.existsByTenTH(th.getTenTH())) {
            model.addAttribute("error", "Tên thương hiệu đã tồn tại!");
            return "admin/thuong_hieu/index";
        }
        th.setNgayThem(new Date());
        thRepo.save(th);
        model.addAttribute("success", "Thêm thành công!");
        return "redirect:/thuong-hieu/index";
    }

    @GetMapping("delete/{id}")
    public String delete(@PathVariable("id") int id){
        this.thRepo.deleteById(id);
        return "redirect:/thuong-hieu/index";
    }
    @GetMapping("update/{id}")
    public String update(@PathVariable("id") Integer id, Model model) {
        ThuongHieu th = thRepo.findById(id).orElse(null);
        if (th != null) {
            model.addAttribute("th", th);
        }
        return "admin/thuong_hieu/update";
    }

    @PostMapping("update/{id}")
    public String updateCustomer(@PathVariable("id") Integer id, @ModelAttribute ThuongHieu th, Model model) {
        ThuongHieu existingThuongHieu = thRepo.findById(id).orElse(null);
        if (existingThuongHieu != null) {
            existingThuongHieu.setTenTH(th.getTenTH());
            thRepo.save(existingThuongHieu);
            model.addAttribute("success", "Cập nhật thành công!");
        }
        return "redirect:/thuong-hieu/index";
    }
}
