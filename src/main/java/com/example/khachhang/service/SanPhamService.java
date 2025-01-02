package com.example.khachhang.service;

import com.example.khachhang.dto.SanPhamDTO;
import com.example.khachhang.entity.SanPham;
import com.example.khachhang.repository.SanPhamRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class SanPhamService {
    @Autowired
    SanPhamRepository spRepo;

    public Page<SanPhamDTO> getAllSanPham(Pageable pageable) {
        Page<SanPham> sanPhams = spRepo.findAll(pageable);
        return sanPhams.map(this::convertToDto);
    }

    public void addSanPham(SanPhamDTO dto) {
        if (spRepo.existsByMaSP(dto.getMaSP())) {
            throw new RuntimeException("Mã sản phẩm đã tồn tại!");
        }
        SanPham sp = convertToEntity(dto);
        spRepo.save(sp);
    }

    private SanPhamDTO convertToDto(SanPham sp) {
        return new SanPhamDTO(sp.getMaSP(), sp.getTenSP(), sp.getLoai(), sp.getAnhSP(), sp.getGia(), sp.getTrangThai());
    }

    private SanPham convertToEntity(SanPhamDTO dto) {
        return new SanPham(dto.getMaSP(), dto.getTenSP(), dto.getLoai(), dto.getAnhSP(), dto.getGia(), dto.getTrangThai());
    }

    public String saveImage(MultipartFile imageFile) throws IOException, IOException {
        if (imageFile.isEmpty()) {
            throw new IllegalArgumentException("Image file is required");
        }
        String projectRoot = Paths.get("").toAbsolutePath().toString();

        // Define a path to save the image within the project directory
        String uploadDir = projectRoot + File.separator + "uploads" + File.separator + "images" + File.separator;

        // Create directory if it doesn't exist
        File uploadPath = new File(uploadDir);
        if (!uploadPath.exists()) {
            uploadPath.mkdirs();
        }

        // Generate a unique file name
        String fileName = UUID.randomUUID().toString() + "_" + imageFile.getOriginalFilename();

        // Define the path to save the uploaded file
        File savedFile = new File(uploadDir + fileName);

        // Save the file
        imageFile.transferTo(savedFile);
        System.out.println("File name is " + fileName);

        // Return the file path (relative or absolute, depending on your setup)
        return savedFile.getAbsolutePath();

    }


    public List<SanPhamDTO> getProductDetails(Integer productId) {
        List<SanPham> details = spRepo.findDetailsByProductId(productId);
        return details.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    public SanPham save(SanPhamDTO dto, @RequestParam("imageFile") MultipartFile imageFile) throws IOException {
        SanPham sp = new SanPham();
        sp.setMaSP(dto.getMaSP());
        sp.setTenSP(dto.getTenSP());
        sp.setGia(dto.getGia());
        sp.setLoai(dto.getLoai());
        sp.setTrangThai(true);

        if(imageFile !=null && !imageFile.isEmpty())  {
            String imagePath = saveImage(imageFile);
            sp.setAnhSP(imagePath);
        }


        return spRepo.save(sp);
    }
    // Đổi trạng thái
    public void changeStatus(Integer id) {
        SanPham sp = spRepo.findById(id).orElseThrow(() -> new RuntimeException("Sản phẩm không tồn tại"));
        sp.setTrangThai(!sp.getTrangThai());
        spRepo.save(sp);
    }
}
