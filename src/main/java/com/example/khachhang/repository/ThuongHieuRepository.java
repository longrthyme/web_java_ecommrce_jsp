package com.example.khachhang.repository;

import com.example.khachhang.entity.ThuongHieu;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;



public interface ThuongHieuRepository extends JpaRepository<ThuongHieu, Integer> {
    @Query("SELECT k FROM ThuongHieu k WHERE " +
            "(:tenTH IS NULL OR k.tenTH LIKE %:tenTH%)")
    Page<ThuongHieu> searchThuongHieu(
            @Param("tenTH") String tenTH,
            Pageable pageable);
    boolean existsByTenTH(String tenTH);
}
