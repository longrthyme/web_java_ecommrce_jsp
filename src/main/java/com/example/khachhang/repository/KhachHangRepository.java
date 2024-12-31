package com.example.khachhang.repository;

import com.example.khachhang.entity.KhachHang;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface KhachHangRepository extends JpaRepository<KhachHang, Integer> {
    // -- Tìm kiếm --
    @Query("SELECT k FROM KhachHang k WHERE " +
            "(:makh IS NULL OR k.makh LIKE %:makh%) AND " +
            "(:email IS NULL OR k.email LIKE %:email%) AND " +
            "(:trangThai IS NULL OR k.trangThai = :trangThai)")
    Page<KhachHang> searchKhachHang(
            @Param("makh") String makh,
            @Param("email") String email,
            @Param("trangThai") Boolean trangThai,
            Pageable pageable);

    List<KhachHang> findByMakhContaining(String makh);

    Page<KhachHang> findByMakhContainingOrEmailContainingOrTrangThai(
            String makh, String email, Boolean trangThai, Pageable pageable);
    // Check trùng mã khách hàng
    boolean existsByMakh(String makh);
}
