package com.example.khachhang.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;

@Data
@Entity
@Table(name = "thuong_hieu")
public class ThuongHieu {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name= "id_thuong_hieu")
    private Integer id;

    @Column(name = "ten_thuong_hieu")
    private String tenTH;

    @Column(name = "NgayThem", updatable = false, insertable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date ngayThem;
}

