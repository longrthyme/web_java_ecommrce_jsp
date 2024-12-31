package com.example.khachhang.staff.controller;

import com.example.khachhang.entity.Voucher;
import com.example.khachhang.repository.VoucherRepository;
import com.example.khachhang.service.VoucherService;
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

@Controller
@RequestMapping("/staff/voucher")
public class VoucherController {
    @Autowired
    private VoucherRepository voucherRepository;

    @Autowired
    private VoucherService voucherService;

    @GetMapping("index")
    public String index(Model model,
                        @RequestParam(defaultValue = "1") int page,
                        @RequestParam(defaultValue = "10") int size) {
        Pageable pageable = PageRequest.of(page - 1, size);
        Page<Voucher> VoucherPage = voucherRepository.findAll(pageable);

        int totalPages = VoucherPage.getTotalPages();
        System.out.println("Current Page: " + page);
        System.out.println("Total Pages: " + totalPages);

        model.addAttribute("vouchers", VoucherPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        return "staff/voucher/index";
    }

    @GetMapping("search")
    public String search(
            @RequestParam(value = "maVc", required = false) String maVc,
            @RequestParam(value = "trangThai", required = false) Boolean trangThai,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            Model model) {

        Pageable pageable = PageRequest.of(page - 1, size);

        Page<Voucher> VoucherPage = voucherRepository.searchVoucher(
                maVc != null && !maVc.isEmpty() ? maVc : null,
                trangThai,
                pageable
        );
        model.addAttribute("vouchers", VoucherPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", VoucherPage.getTotalPages());
        model.addAttribute("maVc", maVc);
        model.addAttribute("trangThai", trangThai);

        return "staff/voucher/index";
    }

    @GetMapping("/changeStatus/{id}")
    public String changeStatus(@PathVariable Integer id) {
        voucherService.changeStatus(id);
        return "redirect:/staff/voucher/index";
    }
}
