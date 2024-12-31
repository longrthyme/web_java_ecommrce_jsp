package com.example.khachhang.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;

@Data
@Entity
@Table(name = "mau_sac")
public class MauSac {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id_mau_sac")
    private Integer idMS;
    @Column(name="ten_mau_sac")
    private String tenMS;
    @Column(name = "NgayThem", updatable = false, insertable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date ngayThem;
}
