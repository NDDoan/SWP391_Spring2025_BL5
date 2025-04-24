/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import DBContext.DBContext;
import EntityDto.ProductUserDetailDto;
import Entity.ProductMedia;
import Entity.ProductVariant;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author LENOVO
 */
public class ProductUserDetailDao {

    private final ProductDao productDao = new ProductDao();
    private final ProductMediaDao mediaDao = new ProductMediaDao();
    private final ProductVariantDao variantDao = new ProductVariantDao();

    public ProductUserDetailDto getProductDetail(int productId) throws Exception {
        // 1. Lấy thông tin cơ bản
        var base = productDao.getProductById(productId);
        if (base == null) {
            return null;
        }

        // 2. Lấy media và variants
        List<ProductMedia> media = mediaDao.getMediaByProductId(productId);
        List<ProductVariant> variants = variantDao.getVariantsByProductId(productId);

        // 3. Map vào DTO
        ProductUserDetailDto dto = new ProductUserDetailDto();
        dto.setProductId(productId);
        dto.setProductName(base.getProductName());
        dto.setBrandName(base.getBrandName());
        dto.setCategoryName(base.getCategoryName());
        dto.setDescription(base.getDescription());
        dto.setMediaList(media);
        dto.setVariants(variants);
        return dto;
    }
}
