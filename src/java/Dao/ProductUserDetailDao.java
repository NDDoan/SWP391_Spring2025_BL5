/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import DBContext.DBContext;
import EntityDto.ProductUserDetailDto;
import Entity.ProductMedia;
import Entity.ProductVariant;
import EntityDto.ProductSummaryDto;
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

    public List<ProductSummaryDto> getRelatedProducts(String categoryName, int currentProductId, int limit) throws Exception {
        List<ProductSummaryDto> list = new ArrayList<>();
        String sql = """
        SELECT TOP (?) 
               p.product_id, 
               p.product_name, 
               b.brand_name, 
               c.category_name, 
               MIN(v.price) AS price, 
               pm.media_url AS primaryMediaUrl
        FROM Products p
        JOIN Categories c 
          ON p.category_id = c.category_id
        JOIN ProductVariants v 
          ON p.product_id = v.product_id
        LEFT JOIN Brands b 
          ON p.brand_id = b.brand_id
        LEFT JOIN ProductMedia pm 
          ON p.product_id = pm.product_id AND pm.is_primary = 1
        WHERE c.category_name = ?
          AND p.product_id <> ?
        GROUP BY 
            p.product_id, 
            p.product_name, 
            b.brand_name, 
            c.category_name, 
            pm.media_url
        ORDER BY MIN(v.price) ASC
        """;

        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, limit);
            ps.setString(2, categoryName);
            ps.setInt(3, currentProductId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new ProductSummaryDto(
                            rs.getInt("product_id"),
                            rs.getString("product_name"),
                            rs.getString("brand_name"),
                            rs.getString("category_name"),
                            rs.getDouble("price"),
                            rs.getString("primaryMediaUrl")
                    ));
                }
            }
        }

        return list;
    }
}
