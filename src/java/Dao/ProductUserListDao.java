/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import DBContext.DBContext;
import Entity.ProductVariant;
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
        String sql = """
        SELECT p.product_id, p.product_name, b.brand_name, c.category_name,
               MIN(v.price) AS price, pm.media_url
        FROM Products p
        JOIN Categories c ON p.category_id = c.category_id
        LEFT JOIN Brands b ON p.brand_id = b.brand_id
        JOIN ProductVariants v ON p.product_id = v.product_id
        LEFT JOIN ProductMedia pm
          ON p.product_id = pm.product_id AND pm.is_primary = 1
        LEFT JOIN CpuOptions     o_cpu     ON v.cpu_id     = o_cpu.cpu_id
        LEFT JOIN RamOptions     o_ram     ON v.ram_id     = o_ram.ram_id
        LEFT JOIN ScreenOptions  o_screen  ON v.screen_id  = o_screen.screen_id
        LEFT JOIN StorageOptions o_storage ON v.storage_id = o_storage.storage_id
        LEFT JOIN ColorOptions   o_color   ON v.color_id   = o_color.color_id
        GROUP BY
          p.product_id, p.product_name, b.brand_name, c.category_name, pm.media_url
        ORDER BY MIN(v.price) ASC
    """;

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            List<ProductUserListDto> list = new ArrayList<>();
            ProductVariantDao variantDao = new ProductVariantDao();
            while (rs.next()) {
                int pid = rs.getInt("product_id");
                // Lấy tất cả variants cho product này
                List<ProductVariant> varList = variantDao.getVariantsByProductId(pid);

                list.add(new ProductUserListDto(
                        pid,
                        rs.getString("product_name"),
                        rs.getString("brand_name"),
                        rs.getString("category_name"),
                        rs.getDouble("price"),
                        rs.getString("media_url"),
                        varList
                ));
            }
            return list;
        }
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

    public List<ProductUserListDto> getProductsSummary(
            String search,
            String category,
            String cpu, String ram,
            String screen, String storage, String color
    ) throws Exception {
        StringBuilder sql = new StringBuilder("""
        SELECT
          p.product_id,
          p.product_name,
          b.brand_name,
          c.category_name,
          MIN(v.price)      AS price,
          pm.media_url
        FROM Products p
        JOIN Categories c      ON p.category_id = c.category_id
        LEFT JOIN Brands b     ON p.brand_id = b.brand_id
        JOIN ProductVariants v ON p.product_id = v.product_id
        LEFT JOIN ProductMedia pm
          ON p.product_id = pm.product_id AND pm.is_primary = 1
        LEFT JOIN CpuOptions     o_cpu     ON v.cpu_id     = o_cpu.cpu_id
        LEFT JOIN RamOptions     o_ram     ON v.ram_id     = o_ram.ram_id
        LEFT JOIN ScreenOptions  o_screen  ON v.screen_id  = o_screen.screen_id
        LEFT JOIN StorageOptions o_storage ON v.storage_id = o_storage.storage_id
        LEFT JOIN ColorOptions   o_color   ON v.color_id   = o_color.color_id
    """);

        // gom điều kiện filter vào
        List<String> clauses = new ArrayList<>();
        if (search != null && !search.isBlank()) {
            clauses.add("p.product_name LIKE ?");
        }
        if (category != null && !category.isBlank()) {
            clauses.add("c.category_name = ?");
        }
        if (cpu != null && !cpu.isBlank()) {
            clauses.add("o_cpu.cpu = ?");
        }
        if (ram != null && !ram.isBlank()) {
            clauses.add("o_ram.ram = ?");
        }
        if (screen != null && !screen.isBlank()) {
            clauses.add("o_screen.screen = ?");
        }
        if (storage != null && !storage.isBlank()) {
            clauses.add("o_storage.storage = ?");
        }
        if (color != null && !color.isBlank()) {
            clauses.add("o_color.color = ?");
        }

        if (!clauses.isEmpty()) {
            sql.append(" WHERE ")
                    .append(String.join(" AND ", clauses));
        }

        sql.append("""
        GROUP BY
          p.product_id,
          p.product_name,
          b.brand_name,
          c.category_name,
          pm.media_url
        ORDER BY MIN(v.price) ASC
    """);

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int idx = 1;
            if (search != null && !search.isBlank()) {
                ps.setString(idx++, "%" + search.trim() + "%");
            }
            if (category != null && !category.isBlank()) {
                ps.setString(idx++, category);
            }
            if (cpu != null && !cpu.isBlank()) {
                ps.setString(idx++, cpu);
            }
            if (ram != null && !ram.isBlank()) {
                ps.setString(idx++, ram);
            }
            if (screen != null && !screen.isBlank()) {
                ps.setString(idx++, screen);
            }
            if (storage != null && !storage.isBlank()) {
                ps.setString(idx++, storage);
            }
            if (color != null && !color.isBlank()) {
                ps.setString(idx++, color);
            }

            List<ProductUserListDto> list = new ArrayList<>();
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int pid = rs.getInt("product_id");
                    // Lấy list variants bằng DAO riêng
                    List<ProductVariant> varList = new ProductVariantDao().getVariantsByProductId(pid);
                    list.add(new ProductUserListDto(
                            pid,
                            rs.getString("product_name"),
                            rs.getString("brand_name"),
                            rs.getString("category_name"),
                            rs.getDouble("price"),
                            rs.getString("media_url"),
                            varList
                    ));
                }
            }
            return list;
        }
    }

    /**
     * Lấy tất cả CPU đã được dùng trong variants
     */
    public List<String> getAllCpuOptions() throws Exception {
        List<String> list = new ArrayList<>();
        String sql = """
            SELECT DISTINCT o.[cpu]
            FROM CpuOptions o
            JOIN ProductVariants v ON o.cpu_id = v.cpu_id
            ORDER BY o.[cpu]
            """;
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(rs.getString("cpu"));
            }
        }
        return list;
    }

    /**
     * Lấy tất cả RAM đã được dùng
     */
    public List<String> getAllRamOptions() throws Exception {
        List<String> list = new ArrayList<>();
        String sql = """
            SELECT DISTINCT o.[ram]
            FROM RamOptions o
            JOIN ProductVariants v ON o.ram_id = v.ram_id
            ORDER BY o.[ram]
            """;
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(rs.getString("ram"));
            }
        }
        return list;
    }

    /**
     * Lấy tất cả màn hình đã được dùng
     */
    public List<String> getAllScreenOptions() throws Exception {
        List<String> list = new ArrayList<>();
        String sql = """
            SELECT DISTINCT o.[screen]
            FROM ScreenOptions o
            JOIN ProductVariants v ON o.screen_id = v.screen_id
            ORDER BY o.[screen]
            """;
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(rs.getString("screen"));
            }
        }
        return list;
    }

    /**
     * Lấy tất cả dung lượng lưu trữ đã được dùng
     */
    public List<String> getAllStorageOptions() throws Exception {
        List<String> list = new ArrayList<>();
        String sql = """
            SELECT DISTINCT o.[storage]
            FROM StorageOptions o
            JOIN ProductVariants v ON o.storage_id = v.storage_id
            ORDER BY o.[storage]
            """;
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(rs.getString("storage"));
            }
        }
        return list;
    }

    /**
     * Lấy tất cả màu sắc đã được dùng
     */
    public List<String> getAllColorOptions() throws Exception {
        List<String> list = new ArrayList<>();
        String sql = """
            SELECT DISTINCT o.[color]
            FROM ColorOptions o
            JOIN ProductVariants v ON o.color_id = v.color_id
            ORDER BY o.[color]
            """;
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(rs.getString("color"));
            }
        }
        return list;
    }
}
