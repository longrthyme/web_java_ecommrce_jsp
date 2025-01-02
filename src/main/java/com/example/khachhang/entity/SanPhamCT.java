package com.example.khachhang.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "san_pham_ct")
@Data
public class SanPhamCT {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_san_pham_ct")
    private Integer id;

    @Column(name = "ma_spct")
    private String maSpct;

    @Column(name = "id_san_pham")
    private Integer idSanPham;

    @Column(name = "id_mau_sac")
    private Integer idMauSac;

    @Column(name = "id_thuong_hieu")
    private Integer idThuongHieu;

    @Column(name = "size")
    private String kichCo;

    @Column(name = "gia_ban")
    private String gia;

    @Column(name = "so_luong_ton")
    private Integer soLuongTon;

    @Column(name = "trang_thai")
    private Boolean trangThai;

    // Getters and Setters
}