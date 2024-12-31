package com.example.khachhang.controller;

import com.example.khachhang.entity.Home;
import com.example.khachhang.entity.KhachHang;
import com.example.khachhang.repository.HomeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

// Trang chủ: home/index
// Giỏ hàng(trang chủ): home/cart | thanh-toan
// -- nhân viên --
// Khách hàng: /staff/khach-hang/index | detail/{id}
// Nhân viên: /staff/nhan-vien/index | detail/{id}
// Voucher: /staff/voucher/index | changeStatus/{id}

// -- admin --
// Khách hàng: khach-hang/index | add | detail/{id}
// Nhân viên: /nhan-vien/index | add | delete/{id} | changeStatus/{id}
// Voucher: /voucher/index | create | delete/{id} | changeStatus/{id}

@Controller
@RequestMapping("home")
public class HomeController {

    @Autowired
    private HomeRepository homeRepository;

    @GetMapping("/index")
    public String index(Model model,
                        @RequestParam(defaultValue = "1") int page,
                        @RequestParam(defaultValue = "12") int size) {
        Pageable pageable = PageRequest.of(page - 1, size);
        Page<Home> homePage = homeRepository.findAll(pageable);

        model.addAttribute("homes", homePage.getContent());
        return "trang_chu/home";
    }

    @GetMapping("/filter")
    public String filter(
            @RequestParam(required = false) String loai,
            @RequestParam(required = false) Double minPrice,
            @RequestParam(required = false) Double maxPrice,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "12") int size,
            Model model) {

        Pageable pageable = PageRequest.of(page, size);
        Page<Home> homePage = homeRepository.findByFilters(loai, minPrice, maxPrice, pageable);

        model.addAttribute("loai", loai);
        model.addAttribute("minPrice", minPrice);
        model.addAttribute("maxPrice", maxPrice);
        model.addAttribute("size", size);

        model.addAttribute("homes", homePage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", homePage.getTotalPages());
        return "trang_chu/home";
    }

    @GetMapping("search")
    public String search(
            @RequestParam(value = "tenSp", required = false) String tenSp,
            @RequestParam(value = "loai", required = false) String loai,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "12") int size,
            Model model) {

        Pageable pageable = PageRequest.of(page - 1, size);

        Page<Home> homePage = homeRepository.searchHome(
                tenSp != null && !tenSp.isEmpty() ? tenSp : null,
                loai != null && !loai.isEmpty() ? loai : null,
                pageable
        );

        model.addAttribute("homes", homePage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", homePage.getTotalPages());
        model.addAttribute("tenSp", tenSp);
        model.addAttribute("loai", loai);

        return "trang_chu/home";
    }

    @GetMapping("/cart")
    public String showCart() {
        return "gio_hang/cart";
    }

    @GetMapping("/thanh-toan")
    public String ThanhToan() {
        return "thanh_toan/index";
    }
}

