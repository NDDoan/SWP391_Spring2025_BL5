/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import DBContext.DBContext;
import EntityDto.ProductSummaryDto;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author LENOVO
 */
public class HomePageDao {

    public List<ProductSummaryDto> getFeaturedProducts(int limit) throws Exception {
        List<ProductSummaryDto> list = new ArrayList<>();
        String sql
                = "SELECT TOP (?) p.product_id, p.product_name, b.brand_name, c.category_name, "
                + "       MIN(v.price) AS price, pm.media_url AS primaryMediaUrl "
                + "FROM Products p "
                + "JOIN ProductVariants v ON p.product_id = v.product_id "
                + "LEFT JOIN Brands b ON p.brand_id = b.brand_id "
                + "LEFT JOIN Categories c ON p.category_id = c.category_id "
                + "LEFT JOIN ProductMedia pm ON p.product_id = pm.product_id AND pm.is_primary = 1 "
                + "GROUP BY p.product_id, p.product_name, b.brand_name, c.category_name, pm.media_url "
                + "ORDER BY MIN(v.price) ASC";  // giá thấp nhất lên trước
        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
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
        return list;
    }
}
