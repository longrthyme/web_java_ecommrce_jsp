package com.example.khachhang.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import jakarta.persistence.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "san_pham")
public class Home {
    @Id
    private String ma_sp;
    @Column(name = "ten_sp")
    private String tenSp;
    @Column(name = "anh_sp")
    private String anh_sp;
    private double gia;
    private String loai;
    private boolean trang_thai;


}
