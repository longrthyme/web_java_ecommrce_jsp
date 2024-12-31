package com.example.khachhang.repository;

import com.example.khachhang.entity.Home;
import com.example.khachhang.entity.KhachHang;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface HomeRepository extends JpaRepository<Home, Long> {
    List<Home> findByLoai(String loai);

    //Tìm kiếm
    List<Home> findByTenSpContainingIgnoreCase(String tenSp);

    @Query("SELECT k FROM Home k WHERE " +
            "(:tenSp IS NULL OR k.tenSp LIKE %:tenSp%) AND " +
            "(:loai IS NULL OR k.loai LIKE %:loai%)")

    Page<Home> searchHome(
            @Param("tenSp") String tenSp,
            @Param("loai") String loai,
            Pageable pageable);

    // Lọc
    @Query("SELECT h FROM Home h WHERE " +
            "(:loai IS NULL OR h.loai = :loai) AND " +
            "(:minPrice IS NULL OR h.gia >= :minPrice) AND " +
            "(:maxPrice IS NULL OR h.gia <= :maxPrice)")
    Page<Home> findByFilters(
            @Param("loai") String loai,
            @Param("minPrice") Double minPrice,
            @Param("maxPrice") Double maxPrice,
            Pageable pageable);

    // Phân trang
    Page<Home> findAll(Pageable pageable);
}


