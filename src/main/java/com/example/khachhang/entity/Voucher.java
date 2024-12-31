package com.example.khachhang.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Data
@Table(name = "voucher")
public class Voucher {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_voucher")
    private Integer id;
    @Column(name = "ma", nullable = false, unique = true)
    private String maVc;
    @Column(name = "ten", nullable = false)
    private String tenVc;
    @Column(name = "ngay_bat_dau", nullable = false)
    private LocalDate ngayBatDau;
    @Column(name = "ngay_ket_thuc", nullable = false)
    private LocalDate ngayKetThuc;
    @Column(name = "gia_tri", nullable = false)
    private BigDecimal giaTri;
    @Column(name = "loai_giam_gia", nullable = false)
    private String loaiGiamGia;
    @Column(name = "gia_tri_toi_thieu", nullable = false)
    private BigDecimal giaTriToiThieu;
    @Column(name = "trang_thai", nullable = false)
    private Boolean trangThai;
}
