package com.example.khachhang.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.util.Date;

@Data
@Entity
@Table(name="khach_hang")
public class KhachHang {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name="id_khach_hang")
    Integer id;
    @Column(name="ma_kh")
    String makh;
    @Column(name="ten_kh")
    String tenkh;
    @Column(name = "ngay_sinh")
    private Date ngaySinh;
    @Column(name = "gioi_tinh")
    private String gioiTinh;
    @Column(name = "sdt")
    private String sdt;
    @Column(name = "dia_chi")
    private String diaChi;
    @Column(name = "email")
    private String email;
    @Column(name = "mat_khau")
    private String matKhau;
    @Column(name = "trang_thai")
    private Boolean trangThai;
}
