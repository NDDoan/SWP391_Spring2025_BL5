/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import DBContext.DBContext;
import EntityDto.ProductUserListDto;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author LENOVO
 */
public class ProductUserListDao {

    /**
     * Fetches summary of all products: lowest variant price + primary media
     */
    public List<ProductUserListDto> getAllProductsSummary() throws Exception {
        String sql = "SELECT p.product_id, p.product_name, b.brand_name, c.category_name,"
                + " MIN(v.price) AS price, pm.media_url "
                + "FROM Products p "
                + "JOIN ProductVariants v ON p.product_id = v.product_id "
                + "LEFT JOIN Brands b ON p.brand_id = b.brand_id "
                + "LEFT JOIN Categories c ON p.category_id = c.category_id "
                + "LEFT JOIN ProductMedia pm ON p.product_id = pm.product_id AND pm.is_primary = 1 "
                + "GROUP BY p.product_id, p.product_name, b.brand_name, c.category_name, pm.media_url";
        List<ProductUserListDto> list = new ArrayList<>();
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new ProductUserListDto(
                        rs.getInt("product_id"),
                        rs.getString("product_name"),
                        rs.getString("brand_name"),
                        rs.getString("category_name"),
                        rs.getDouble("price"),
                        rs.getString("media_url") // media_url
                ));
            }
        }
        return list;
    }

    public List<String> getAllCategories() throws Exception {
        List<String> cats = new ArrayList<>();
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement("SELECT category_name FROM Categories"); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                cats.add(rs.getString(1));
            }
        }
        return cats;
    }

    public List<String> getAllBrands() throws Exception {
        List<String> bs = new ArrayList<>();
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement("SELECT brand_name FROM Brands"); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                bs.add(rs.getString(1));
            }
        }
        return bs;
    }

    public List<ProductUserListDto> getProductsSummary(String search) throws Exception {
        String sql = "SELECT p.product_id, p.product_name, b.brand_name, c.category_name, "
                + " MIN(v.price) AS price, pm.media_url "
                + "FROM Products p "
                + "JOIN ProductVariants v ON p.product_id = v.product_id "
                + "LEFT JOIN Brands b ON p.brand_id = b.brand_id "
                + "LEFT JOIN Categories c ON p.category_id = c.category_id "
                + "LEFT JOIN ProductMedia pm ON p.product_id = pm.product_id AND pm.is_primary = 1 "
                + (search != null && !search.isBlank()
                ? "WHERE p.product_name LIKE ? "
                : "")
                + "GROUP BY p.product_id, p.product_name, b.brand_name, c.category_name, pm.media_url "
                + "ORDER BY MIN(v.price) ASC";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            if (search != null && !search.isBlank()) {
                ps.setString(1, "%" + search.trim() + "%");
            }
            try (ResultSet rs = ps.executeQuery()) {
                List<ProductUserListDto> list = new ArrayList<>();
                while (rs.next()) {
                    list.add(new ProductUserListDto(
                            rs.getInt("product_id"),
                            rs.getString("product_name"),
                            rs.getString("brand_name"),
                            rs.getString("category_name"),
                            rs.getDouble("price"),
                            rs.getString("media_url")
                    ));
                }
                return list;
            }
        }
    }
}
