package com.example.khachhang.repository;

import com.example.khachhang.entity.Voucher;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface VoucherRepository extends JpaRepository<Voucher, Integer> {
    boolean existsByMaVc(String maVc);

    @Query("SELECT k FROM Voucher k WHERE " +
            "(:maVc IS NULL OR k.maVc LIKE %:maVc%) AND " +
            "(:trangThai IS NULL OR k.trangThai = :trangThai)")
    Page<Voucher> searchVoucher(
            @Param("maVc") String maVc,
            @Param("trangThai") Boolean trangThai,
            Pageable pageable);

    List<Voucher> findByMaVcContaining(String maVc);

    List<Voucher> findByTrangThai(Boolean trangThai);

    List<Voucher> findByMaVcContainingAndTrangThai(String maVc, Boolean trangThai);
}
