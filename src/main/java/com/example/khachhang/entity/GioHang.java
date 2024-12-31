package com.example.khachhang.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name="gio_hang")
public class GioHang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id_gio_hang")
    Integer id;
    @Column(name = "ma_gh")
    private String maGh;

    // giỏ hàng cấn quá ae

//    @Column(name = "ten_sp")
//    private String tenSp;
//    @Column(name = "anh_sp")
//    private String anh_sp;
//    private double gia;
//    private String loai;
//    private boolean trang_thai;
}
