package com.example.khachhang.repository;


import com.example.khachhang.entity.Size;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SizeRepository extends JpaRepository<Size, Integer> {
    // You can add custom queries if needed, for example:
    // List<Size> findBySize(String size);
}