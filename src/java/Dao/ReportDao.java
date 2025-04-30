/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import java.sql.*;
import DBContext.DBContext;
import EntityDto.ProductStockDto;
import EntityDto.RoleCountDto;
import EntityDto.TimeCountDto;
import EntityDto.VariantStockDto;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author LENOVO
 */
public class ReportDao {

    /**
     * Count products created per day within range.
     */
    /**
     * Count products created per day within range.
     */
    public List<TimeCountDto> getProductCountByDay(LocalDate from, LocalDate to) throws Exception {
        String sql = "SELECT CAST(created_at AS DATE) AS dt, COUNT(*) AS cnt "
                + "FROM Products "
                + "WHERE created_at BETWEEN ? AND ? "
                + "GROUP BY CAST(created_at AS DATE) "
                + "ORDER BY dt ASC";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, Date.valueOf(from));
            ps.setDate(2, Date.valueOf(to));
            ResultSet rs = ps.executeQuery();
            List<TimeCountDto> list = new ArrayList<>();
            while (rs.next()) {
                list.add(new TimeCountDto(
                        rs.getDate("dt").toLocalDate(),
                        rs.getInt("cnt")
                ));
            }
            return list;
        }
    }

    /**
     * Count products created per week within range (week start date).
     */
    public List<TimeCountDto> getProductCountByWeek(LocalDate from, LocalDate to) throws Exception {
        String sql = "SELECT DATEADD(wk, DATEDIFF(wk, 0, created_at), 0) AS wk, COUNT(*) AS cnt "
                + "FROM Products "
                + "WHERE created_at BETWEEN ? AND ? "
                + "GROUP BY DATEADD(wk, DATEDIFF(wk, 0, created_at), 0) "
                + "ORDER BY wk ASC";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, Date.valueOf(from));
            ps.setDate(2, Date.valueOf(to));
            ResultSet rs = ps.executeQuery();
            List<TimeCountDto> list = new ArrayList<>();
            while (rs.next()) {
                list.add(new TimeCountDto(
                        rs.getDate("wk").toLocalDate(),
                        rs.getInt("cnt")
                ));
            }
            return list;
        }
    }

    /**
     * Count products created per month within range (month start).
     */
    public List<TimeCountDto> getProductCountByMonth(LocalDate from, LocalDate to) throws Exception {
        String sql = "SELECT DATEFROMPARTS(YEAR(created_at), MONTH(created_at), 1) AS mon, COUNT(*) AS cnt "
                + "FROM Products "
                + "WHERE created_at BETWEEN ? AND ? "
                + "GROUP BY DATEFROMPARTS(YEAR(created_at), MONTH(created_at), 1) "
                + "ORDER BY mon ASC";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, Date.valueOf(from));
            ps.setDate(2, Date.valueOf(to));
            ResultSet rs = ps.executeQuery();
            List<TimeCountDto> list = new ArrayList<>();
            while (rs.next()) {
                list.add(new TimeCountDto(
                        rs.getDate("mon").toLocalDate(),
                        rs.getInt("cnt")
                ));
            }
            return list;
        }
    }

    /**
     * Get stock distribution for all variants of a product.
     */
    public List<VariantStockDto> getStockByVariant(int productId) throws Exception {
        String sql = "SELECT v.variant_id, CONCAT(cu.cpu, ' / ', r.ram, ' / ', sc.screen , ' / ', s.storage , ' / ', c.color) AS name, v.stock_quantity AS stock "
                + "FROM ProductVariants v "
                + "JOIN CpuOptions cu ON v.cpu_id = cu.cpu_id "
                + "JOIN RamOptions r ON v.ram_id = r.ram_id "
                + "JOIN ScreenOptions sc ON v.screen_id = sc.screen_id "
                + "JOIN StorageOptions s ON v.storage_id = s.storage_id "
                + "JOIN ColorOptions c ON v.color_id = c.color_id "
                + "WHERE v.product_id = ? ";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            List<VariantStockDto> list = new ArrayList<>();
            while (rs.next()) {
                list.add(new VariantStockDto(
                        rs.getString("name"), rs.getInt("stock")
                ));
            }
            return list;
        }
    }

    /**
     * Count of users per role.
     */
    public List<RoleCountDto> getUserCountByRole() throws Exception {
        String sql = "SELECT r.role_name AS role, COUNT(u.user_id) AS cnt "
                + "FROM Users u JOIN Roles r ON u.role_id = r.role_id "
                + "GROUP BY r.role_name";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            List<RoleCountDto> list = new ArrayList<>();
            while (rs.next()) {
                list.add(new RoleCountDto(rs.getString("role"), rs.getInt("cnt")));
            }
            return list;
        }
    }

    /**
     * Count new user registrations per day within range.
     */
    public List<TimeCountDto> getUserRegistrationsByDay(LocalDate from, LocalDate to) throws Exception {
        String sql = "SELECT CAST(created_at AS DATE) AS dt, COUNT(*) AS cnt "
                + "FROM Users "
                + "WHERE created_at BETWEEN ? AND ? "
                + "GROUP BY CAST(created_at AS DATE) "
                + "ORDER BY dt ASC";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, Date.valueOf(from));
            ps.setDate(2, Date.valueOf(to));
            ResultSet rs = ps.executeQuery();
            List<TimeCountDto> list = new ArrayList<>();
            while (rs.next()) {
                list.add(new TimeCountDto(
                        rs.getDate("dt").toLocalDate(), rs.getInt("cnt")
                ));
            }
            return list;
        }
    }

    public int getTotalProducts() throws Exception {
        String sql = "SELECT COUNT(*) FROM Products";
        try (Connection conn = new DBContext().getConnection(); Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    /**
     * Total number of customers (role_id = 2).
     */
    public int getTotalCustomers() throws Exception {
        String sql = "SELECT COUNT(*) FROM Users WHERE role_id = 2";
        try (Connection conn = new DBContext().getConnection(); Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    /**
     * Total stock per product.
     */
    public List<ProductStockDto> getAllProductsTotalStock() throws Exception {
        String sql
                = "SELECT p.product_id, p.product_name, SUM(v.stock_quantity) AS total_stock "
                + "FROM Products p "
                + "JOIN ProductVariants v ON p.product_id = v.product_id "
                + "GROUP BY p.product_id, p.product_name "
                + "ORDER BY p.product_name";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            List<ProductStockDto> list = new ArrayList<>();
            while (rs.next()) {
                list.add(new ProductStockDto(
                        rs.getInt("product_id"),
                        rs.getString("product_name"),
                        rs.getInt("total_stock")
                ));
            }
            return list;
        }
    }

    /**
     * Top N products by total stock (default 5).
     */
    public List<ProductStockDto> getTop5ProductsByStock() throws Exception {
        String sql = "SELECT TOP 5 p.product_id, p.product_name, SUM(v.stock_quantity) AS total_stock "
                + "FROM Products p JOIN ProductVariants v ON p.product_id=v.product_id "
                + "GROUP BY p.product_id, p.product_name "
                + "ORDER BY total_stock DESC ";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            List<ProductStockDto> list = new ArrayList<>();
            while (rs.next()) {
                list.add(new ProductStockDto(
                        rs.getInt("product_id"),
                        rs.getString("product_name"),
                        rs.getInt("total_stock")
                ));
            }
            return list;
        }
    }

    /**
     * Map of productId to its variant stock list.
     */
    public Map<Integer, List<VariantStockDto>> getAllVariantStocksMap() throws Exception {
        Map<Integer, List<VariantStockDto>> map = new HashMap<>();
        // first get all products
        for (ProductStockDto ps : getAllProductsTotalStock()) {
            map.put(ps.getProductId(), getStockByVariant(ps.getProductId()));
        }
        return map;
    }
}
