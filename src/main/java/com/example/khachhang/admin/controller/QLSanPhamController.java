package com.example.khachhang.admin.controller;

import com.example.khachhang.dto.SanPhamCTDTO;
import com.example.khachhang.dto.SanPhamDTO;
import com.example.khachhang.entity.*;
import com.example.khachhang.repository.*;
import com.example.khachhang.service.CloudinaryService;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
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


    @Autowired
        private SanPhamRepository    sanPhamRepository;


    @Autowired
    private CloudinaryService cloudinaryService;

    @Autowired
    private SizeRepository sizeRepository;



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

        List<Size> listSize = sizeRepository.findAll();

        model.addAttribute("size", listSize);

        model.addAttribute("sp", new SanPham());
        model.addAttribute("thuongHieus", thuongHieu);
        model.addAttribute("mauSacs", mauSac);
        return "admin/san_pham/add";
    }

    @PostMapping("/add")
    public ResponseEntity<Integer> saveSanPham(@RequestBody SanPhamDTO spDto) {
        try {
            SanPham savedProduct = sanPhamService.save(spDto, null);
            return ResponseEntity.ok(savedProduct.getId());
//                        return ResponseEntity.ok(12);
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
        // Fetch the SanPham entity by its ID
        SanPham sp = sanPhamRepository.findById(id).orElseThrow(() -> new RuntimeException("SanPham not found"));

        // Fetch all SanPhamCT records related to the given SanPham ID
        List<SanPhamCT> sanPhamCTList = sanPhamCTRepository.findByIdSanPham(id);


        // Add both SanPham and related SanPhamCT list to the model
        model.addAttribute("detail", sp);
        model.addAttribute("sanPhamCTList", sanPhamCTList);


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

    @GetMapping("/update/detail/{id}")
    public String showUpdateForm(@PathVariable("id") Integer id, Model model) {
        SanPhamCT sanPhamCT = sanPhamCTRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid SanPhamCT ID: " + id));

        model.addAttribute("sanPhamCT", sanPhamCT);
        List<ThuongHieu> thuongHieu = thuongHieuRepository.findAll();
        List<MauSac> mauSac = mauSacRepository.findAll();
        List<Size> listSize = sizeRepository.findAll();

        model.addAttribute("thuongHieus", thuongHieu);
        model.addAttribute("mauSacs", mauSac);
        model.addAttribute("size", listSize);

        return "admin/san_pham/update-detail";  // This view will render the form
    }

    @PostMapping("/update/detail/{id}")
    public String updateSanPhamCT(@PathVariable("id") Integer id,
                                  @ModelAttribute SanPhamCT updatedSanPhamCT) {

        // Fetch the existing SanPhamCT based on ID
        SanPhamCT existingSanPhamCT = sanPhamCTRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid SanPhamCT ID: " + id));

        // Update the fields of the existing entity
        existingSanPhamCT.setMaSpct(updatedSanPhamCT.getMaSpct());
        existingSanPhamCT.setIdSanPham(updatedSanPhamCT.getIdSanPham());
        existingSanPhamCT.setIdMauSac(updatedSanPhamCT.getIdMauSac());
        existingSanPhamCT.setIdThuongHieu(updatedSanPhamCT.getIdThuongHieu());
        existingSanPhamCT.setKichCo(updatedSanPhamCT.getKichCo());  // Map size
        existingSanPhamCT.setGia(updatedSanPhamCT.getGia());
        existingSanPhamCT.setSoLuongTon(updatedSanPhamCT.getSoLuongTon());
        existingSanPhamCT.setTrangThai(updatedSanPhamCT.getTrangThai());


        // Save the updated entity
        sanPhamCTRepository.save(existingSanPhamCT);

        return "redirect:/admin/san-pham/index"; // Redirect to the updated list or details page
    }

    @PostMapping("/upload-image")
    public ResponseEntity<Integer> uploadImage(@RequestParam("imageFile") MultipartFile imageFile,
                                               @RequestParam("id") String id) {
        String urlPath = cloudinaryService.uploadFile(imageFile);
        SanPham sp = null;
        if (sanPhamRepository.findById(Integer.valueOf(id)).isPresent()) {

            sp = sanPhamRepository.findById(Integer.valueOf(id)).get();
            sp.setAnhSP(urlPath);

            sanPhamRepository.save(sp);
        }

        return ResponseEntity.ok(12);
    }

    @PostMapping("update/{id}")
    public String updateCustomer(
            @PathVariable("id") Integer id,
            @ModelAttribute SanPham sanPham,
            @RequestParam("anhSPP") MultipartFile anhSP) {
        SanPham sp = spRepo.findById(id).orElse(null);
        if (sp != null) {
            sp.setTenSP(sanPham.getTenSP());
            sp.setGia(sanPham.getGia());
            sp.setLoai(sanPham.getLoai());
            sp.setTrangThai(sanPham.getTrangThai());

            // Handle image upload if a new file is provided
            if (anhSP != null && !anhSP.isEmpty()) {
                try {
                    // Save the new image
                    String imagePath = cloudinaryService.uploadFile(anhSP);
                    sp.setAnhSP(imagePath);
                } catch (Exception e) {
                    e.printStackTrace(); // Handle exceptions appropriately
                    return "redirect:/san_pham/edit/" + id + "?error=image_upload_failed";
                }
            }

            spRepo.save(sp);
        }
        return "redirect:/san-pham/index";
    }


    @GetMapping("/changeStatus/{id}")
    public String changeStatus(@PathVariable Integer id) {
        sanPhamService.changeStatus(id);
        return "redirect:/san-pham/index";
    }
}
