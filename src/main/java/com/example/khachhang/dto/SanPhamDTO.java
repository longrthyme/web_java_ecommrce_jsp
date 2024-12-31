package com.example.khachhang.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.math.BigDecimal;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class SanPhamDTO {
    private String maSP;
    private String tenSP;
    private String loai;
    private String anhSP;
    private BigDecimal gia;
    private Boolean trangThai;

}
