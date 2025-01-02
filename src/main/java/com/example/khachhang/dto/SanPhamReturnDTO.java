package com.example.khachhang.dto;

import lombok.Data;

@Data
public class SanPhamReturnDTO {

    private String mauSac;
    private String thuongHieu;
    private String kichCo;
    private Integer soLuong;
    private String trangThai;

    public SanPhamReturnDTO(String mauSac, String thuongHieu, String kichCo, Integer soLuong, String trangThai) {
        this.mauSac = mauSac;
        this.thuongHieu = thuongHieu;
        this.kichCo = kichCo;
        this.soLuong = soLuong;
        this.trangThai = trangThai;
    }
}
