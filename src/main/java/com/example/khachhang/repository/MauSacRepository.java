package com.example.khachhang.repository;

import com.example.khachhang.entity.MauSac;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface MauSacRepository extends JpaRepository<MauSac, Integer> {
    @Query("SELECT k FROM MauSac k WHERE " +
            "(:tenMS IS NULL OR k.tenMS LIKE %:tenMS%)")
    Page<MauSac> searchMauSac(
            @Param("tenMS") String tenMS,
            Pageable pageable);
    boolean existsByTenMS(String tenMS);

}
