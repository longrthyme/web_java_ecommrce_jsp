package com.example.khachhang.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name= "san_pham")
public class SanPham {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_san_pham")
    private Integer id;
    @Column(name = "ma_sp")
    private String maSP;
    @Column(name = "ten_sp")
    private String tenSP;
    @Column(name = "anh_sp")
    private String anhSP;
    @Column(name = "gia")
    private BigDecimal gia;
    @Column(name = "loai")
    private String loai;
    @Column(name = "trang_thai")
    private Boolean trangThai;

    public SanPham(String maSP, String tenSP, String loai, String anhSP, BigDecimal gia, Boolean trangThai) {
        this.maSP = maSP;
        this.tenSP = tenSP;
        this.loai = loai;
        this.anhSP = anhSP;
        this.gia = gia;
        this.trangThai = trangThai;
    }
}
