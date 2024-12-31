package com.example.khachhang.admin.controller;

import com.example.khachhang.entity.KhachHang;
import com.example.khachhang.entity.Voucher;
import com.example.khachhang.repository.VoucherRepository;
import com.example.khachhang.service.VoucherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;

@Controller
@RequestMapping("/voucher")
public class QLVoucherController {
    @Autowired
    private VoucherRepository voucherRepository;

    @Autowired
    private VoucherService voucherService;

    @GetMapping("/create")
    public String CreateIndex(Model model) {
        model.addAttribute("voucher", new Voucher());
        return "admin/voucher/create";
    }

    @PostMapping("/create")
    public String createVoucher(@ModelAttribute Voucher voucher, Model model) {
        if (voucherRepository.existsByMaVc(voucher.getMaVc())) {
            model.addAttribute("error", "Mã voucher đã tồn tại!");
            return "admin/voucher/create";
        }

        if (voucher.getNgayKetThuc().isBefore(voucher.getNgayBatDau())) {
            model.addAttribute("error", "Ngày kết thúc phải sau ngày bắt đầu!");
            return "admin/voucher/create";
        }

        voucher.setGiaTri(voucher.getGiaTri().setScale(0, BigDecimal.ROUND_DOWN));
        voucher.setGiaTriToiThieu(voucher.getGiaTriToiThieu().setScale(0, BigDecimal.ROUND_DOWN));

        voucher.setTrangThai(true);
        voucherRepository.save(voucher);
        return "redirect:/voucher/index";
    }

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
        return "admin/voucher/index";
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

        return "admin/voucher/index";
    }

    @GetMapping("/changeStatus/{id}")
    public String changeStatus(@PathVariable Integer id) {
        voucherService.changeStatus(id);
        return "redirect:/voucher/index";
    }

    @GetMapping("delete/{id}")
    public String delete(@PathVariable("id") int id){
        this.voucherRepository.deleteById(id);
        return "redirect:/voucher/index";
    }

    @GetMapping("update/{id}")
    public String update(@PathVariable("id") Integer id, Model model) {
        Voucher voucher = voucherRepository.findById(id).orElse(null);
        if (voucher != null) {
            model.addAttribute("giaTriFormatted", voucher.getGiaTri().setScale(0, BigDecimal.ROUND_DOWN).toPlainString());
            model.addAttribute("giaTriToiThieuFormatted", voucher.getGiaTriToiThieu().setScale(0, BigDecimal.ROUND_DOWN).toPlainString());
            model.addAttribute("voucher", voucher);
        }
        return "admin/voucher/update";
    }
    @PostMapping("update/{id}")
    public String updateCustomer(@PathVariable("id") Integer id, @ModelAttribute Voucher voucher) {
        Voucher vc = voucherRepository.findById(id).orElse(null);
        if (vc != null) {
            vc.setMaVc(voucher.getMaVc());
            vc.setTenVc(voucher.getTenVc());
            vc.setNgayBatDau(voucher.getNgayBatDau());
            vc.setNgayKetThuc(voucher.getNgayKetThuc());
            vc.setGiaTri(voucher.getGiaTri());
            vc.setLoaiGiamGia(voucher.getLoaiGiamGia());
            vc.setGiaTriToiThieu(voucher.getGiaTriToiThieu());
            vc.setTrangThai(voucher.getTrangThai());
            voucherRepository.save(vc);
        }
        return "redirect:/voucher/index";
    }
}
