package com.example.khachhang.repository;

import com.example.khachhang.entity.NhanVien;
import com.example.khachhang.entity.SanPham;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface SanPhamRepository extends JpaRepository<SanPham, Integer> {
    @Query("SELECT k FROM SanPham k WHERE " +
            "(:maSP IS NULL OR k.maSP LIKE %:maSP%) AND " +
            "(:trangThai IS NULL OR k.trangThai = :trangThai)")
    Page<SanPham> searchSanPham(
            @Param("maSP") String maSP,
            @Param("trangThai") Boolean trangThai,
            Pageable pageable);

    boolean existsByMaSP(String maSP);

    @Query("SELECT sp FROM SanPham sp WHERE sp.id = :productId")
    List<SanPham> findDetailsByProductId(@Param("productId") Integer productId);
}
