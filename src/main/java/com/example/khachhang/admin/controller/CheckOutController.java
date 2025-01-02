package com.example.khachhang.admin.controller;

import com.example.khachhang.dto.SanPhamReturnDTO;
import com.example.khachhang.entity.MauSac;
import com.example.khachhang.entity.SanPhamCT;
import com.example.khachhang.entity.ThuongHieu;
import com.example.khachhang.entity.Voucher;
import com.example.khachhang.repository.MauSacRepository;
import com.example.khachhang.repository.SanPhamCTRepository;
import com.example.khachhang.repository.ThuongHieuRepository;
import com.example.khachhang.repository.VoucherRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@RestController
public class CheckOutController {
    @Autowired
    private VoucherRepository voucherRepository;


    @Autowired
    private SanPhamCTRepository sanPhamCTRepository;


    @Autowired
    private   ThuongHieuRepository thuongHieuRepository;


    @Autowired
    private   MauSacRepository mauSacRepository;

    @GetMapping("/api/vouchers")
    public List<Voucher> getVouchers() {
        return voucherRepository.findAll();
    }




    private static String getMauSacName(Integer idMauSac) {
        // Logic to fetch the color name based on idMauSac
        return "Color Name for ID: " + idMauSac;
    }

    private static String getThuongHieuName(Integer idThuongHieu) {
        // Logic to fetch the brand name based on idThuongHieu
        return "Brand Name for ID: " + idThuongHieu;
    }

    public  SanPhamReturnDTO toDTO(SanPhamCT sanPhamCT) {
        String trangThai = sanPhamCT.getTrangThai() ? "Còn hàng" : "Hết hàng";

        Optional<ThuongHieu> thuongHieuOptional = thuongHieuRepository.findById(sanPhamCT.getIdThuongHieu());

        Optional<MauSac> mauSacOptional = mauSacRepository.findById(sanPhamCT.getIdMauSac());

    String thuongHieu = "None"; String mauSac = "";

        if(thuongHieuOptional.isPresent()) { thuongHieu = thuongHieuOptional.get().getTenTH();}

        if(mauSacOptional.isPresent()) { mauSac = mauSacOptional.get().getTenMS();}

        return new SanPhamReturnDTO(
                mauSac, thuongHieu,
                sanPhamCT.getKichCo(),
                sanPhamCT.getSoLuongTon(),
                trangThai
        );
    }

    public  List<SanPhamReturnDTO> toDTOList(List<SanPhamCT> sanPhamCTList) {
        return sanPhamCTList.stream()
                .map(this::toDTO)
                .collect(Collectors.toList());
    }

    @GetMapping("/details/{id}")
    public List<SanPhamReturnDTO> getProductDetails(@PathVariable("id") Integer productId) throws Exception {
        List<SanPhamCT> productDetails = sanPhamCTRepository.findByIdSanPhamNative(productId);

        // Log the results
        System.out.println("Found product details: " + productDetails);

        if (productDetails.isEmpty()) {
            throw new Exception("No product details found for product ID:" );
        }

        List<SanPhamReturnDTO> dtoList = toDTOList(productDetails);

        return dtoList;
    }
}
