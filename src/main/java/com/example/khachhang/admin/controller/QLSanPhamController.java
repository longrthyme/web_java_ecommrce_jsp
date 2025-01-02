package com.example.khachhang.admin.controller;

import com.example.khachhang.dto.SanPhamCTDTO;
import com.example.khachhang.dto.SanPhamDTO;
import com.example.khachhang.entity.*;
import com.example.khachhang.repository.MauSacRepository;
import com.example.khachhang.repository.SanPhamCTRepository;
import com.example.khachhang.repository.SanPhamRepository;
import com.example.khachhang.repository.ThuongHieuRepository;
import com.example.khachhang.service.SanPhamCTService;
import com.example.khachhang.service.SanPhamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("san-pham")
public class QLSanPhamController {
    @Autowired
    SanPhamRepository spRepo;

    @Autowired
    SanPhamService sanPhamService;

    @Autowired
    private SanPhamCTService sanPhamCTService;

    @Autowired
    private ThuongHieuRepository thuongHieuRepository;

    @Autowired
    private MauSacRepository mauSacRepository;

    @Autowired
    private SanPhamCTRepository sanPhamCTRepository;



    @GetMapping("index")
    public String index(Model model,
                        @RequestParam(defaultValue = "1") int page,
                        @RequestParam(defaultValue = "10") int size) {
        Pageable pageable = PageRequest.of(page - 1, size);
        Page<SanPham> sanPhamPage = spRepo.findAll(pageable);

        int totalPages = sanPhamPage.getTotalPages();
        System.out.println("Current Page: " + page);
        System.out.println("Total Pages: " + totalPages);

        model.addAttribute("data", sanPhamPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        return "admin/san_pham/index";
    }




    @GetMapping("search")
    public String search(
            @RequestParam(value = "maSP", required = false) String maSP,
            @RequestParam(value = "trangThai", required = false) Boolean trangThai,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            Model model) {

        Pageable pageable = PageRequest.of(page - 1, size);

        Page<SanPham> sanPhamPage = spRepo.searchSanPham(
                maSP != null && !maSP.isEmpty() ? maSP : null,
                trangThai,
                pageable
        );

        model.addAttribute("data", sanPhamPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", sanPhamPage.getTotalPages());
        model.addAttribute("maSP", maSP);
        model.addAttribute("trangThai", trangThai);

        return "admin/san_pham/index";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        List<ThuongHieu> thuongHieu = thuongHieuRepository.findAll();
        List<MauSac> mauSac = mauSacRepository.findAll();

        model.addAttribute("sp", new SanPham());
        model.addAttribute("thuongHieus", thuongHieu);
        model.addAttribute("mauSacs", mauSac);
        return "admin/san_pham/add";
    }

    @PostMapping("/add")
    public ResponseEntity<Integer> saveSanPham(@RequestBody SanPhamDTO spDto) {
        try {
            SanPham savedProduct = sanPhamService.save(spDto);
            return ResponseEntity.ok(savedProduct.getId());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
        }
    }

    @PostMapping("/detail/add")
    public ResponseEntity<String> createSanPhamCT(@RequestBody SanPhamCTDTO request) {
        try {
            sanPhamCTService.createSanPhamCT(request);
            return ResponseEntity.ok("Chi tiết sản phẩm đã được thêm thành công!");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Lỗi khi thêm chi tiết sản phẩm!");
        }
    }


    @GetMapping("/detail/{id}")
    public String detail(@PathVariable("id") Integer id, Model model) {
        SanPham sp = spRepo.getById(id);
        model.addAttribute("detail", sp);
        return "admin/san_pham/detail";
    }

    @GetMapping("/update/{id}")
    public String update(@PathVariable("id") Integer id, Model model) {
        SanPham sp = spRepo.findById(id).orElse(null);
        if (sp != null) {
            model.addAttribute("sp", sp);
        }
        return "admin/san_pham/update";
    }
    @PostMapping("update/{id}")
    public String updateCustomer(@PathVariable("id") Integer id, @ModelAttribute SanPham sanPham) {
        SanPham sp = spRepo.findById(id).orElse(null);
        if (sp != null) {
            sp.setTenSP(sanPham.getTenSP());
            sp.setGia(sanPham.getGia());
            sp.setLoai(sanPham.getLoai());
            sp.setTrangThai(sanPham.getTrangThai());
            spRepo.save(sp);
        }
        return "redirect:/san_pham/index";
    }

    @GetMapping("/changeStatus/{id}")
    public String changeStatus(@PathVariable Integer id) {
        sanPhamService.changeStatus(id);
        return "redirect:/san-pham/index";
    }
}
