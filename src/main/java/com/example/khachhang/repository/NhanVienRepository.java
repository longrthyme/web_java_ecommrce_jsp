package com.example.khachhang.repository;

import com.example.khachhang.entity.KhachHang;
import com.example.khachhang.entity.NhanVien;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface NhanVienRepository extends JpaRepository<NhanVien, Integer> {
    // -- Tìm kiếm --
    @Query("SELECT k FROM NhanVien k WHERE " +
            "(:maNV IS NULL OR k.maNV LIKE %:maNV%) AND " +
            "(:email IS NULL OR k.email LIKE %:email%) AND " +
            "(:chucVu IS NULL OR k.chucVu = :chucVu) AND" +
            "(:trangThai IS NULL OR k.trangThai = :trangThai)")
    Page<NhanVien> searchNhanVien(
            @Param("maNV") String maNV,
            @Param("email") String email,
            @Param("chucVu") Boolean chucVu,
            @Param("trangThai") Boolean trangThai,
            Pageable pageable);

    List<NhanVien> findByMaNVContaining(String maNV);

    // Check trùng mã nhân viên
    boolean existsByMaNV(String maNV);
}
