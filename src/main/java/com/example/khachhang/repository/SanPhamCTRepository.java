package com.example.khachhang.repository;

import com.example.khachhang.entity.SanPhamCT;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SanPhamCTRepository extends JpaRepository<SanPhamCT, Integer> {
    @Query("SELECT MAX(s.id) FROM SanPhamCT s")
    Integer findMaxId();

    @Query(value = "SELECT * FROM san_pham_ct WHERE id_san_pham = ?1", nativeQuery = true)
    List<SanPhamCT> findByIdSanPhamNative(Integer idSanPham);
}

