package com.example.khachhang.admin.controller;

import com.example.khachhang.entity.MauSac;
import com.example.khachhang.repository.MauSacRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("mau-sac")
public class MauSacController {
    @Autowired
    MauSacRepository msRepo;

    @GetMapping("index")
    public String index(Model model,
                        @RequestParam(defaultValue = "1") int page,
                        @RequestParam(defaultValue = "10") int size) {
        Pageable pageable = PageRequest.of(page - 1, size);
        Page<MauSac> mauSacPage = msRepo.findAll(pageable);

        int totalPages = mauSacPage.getTotalPages();

        model.addAttribute("data", mauSacPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        return "admin/mau_sac/index";
    }

    @GetMapping("search")
    public String search(
            @RequestParam(value= "tenMS", required = false) String tenMS,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            Model model) {


        Pageable pageable = PageRequest.of(page - 1, size);

        Page<MauSac> mauSacPage = msRepo.searchMauSac(
                tenMS != null && !tenMS.isEmpty() ? tenMS : null,
                pageable
        );
        model.addAttribute("data", mauSacPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", mauSacPage.getTotalPages());
        model.addAttribute("tenMS", tenMS);
        return "admin/mau_sac/index";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("ms", new MauSac());
        return "admin/mau_sac/add";
    }

    @PostMapping("/add")
    public String saveMauSac(MauSac ms, Model model) {
        if (msRepo.existsByTenMS(ms.getTenMS())) {
            model.addAttribute("error", "Tên màu sắc đã tồn tại!");
            return "admin/mau_sac/index";
        }
        ms.setNgayThem(new Date());
        msRepo.save(ms);
        return "redirect:/mau-sac/index";
    }

    @GetMapping("delete/{id}")
    public String delete(@PathVariable("id") int idMS){
        this.msRepo.deleteById(idMS);
        return "redirect:/mau-sac/index";
    }
    @GetMapping("update/{id}")
    public String update(@PathVariable("id") Integer id, Model model) {
        MauSac ms = msRepo.findById(id).orElse(null);
        if (ms != null) {
            model.addAttribute("ms", ms);
        }
        return "admin/mau_sac/update";
    }

    @PostMapping("update/{id}")
    public String updateCustomer(@PathVariable("id") Integer id, @ModelAttribute MauSac ms) {
        MauSac existingMauSac = msRepo.findById(id).orElse(null);
        if (existingMauSac != null) {
            existingMauSac.setTenMS(ms.getTenMS());
            msRepo.save(existingMauSac);
        }
        return "redirect:/mau-sac/index";
    }
}
