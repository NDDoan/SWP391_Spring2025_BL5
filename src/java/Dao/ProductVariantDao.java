/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import DBContext.DBContext;
import Entity.ColorOption;
import Entity.CpuOption;
import Entity.ProductVariant;
import Entity.RamOption;
import Entity.ScreenOption;
import Entity.StorageOption;
import java.sql.*;
import java.util.*;

/**
 *
 * @author LENOVO
 */
public class ProductVariantDao {

    public List<ProductVariant> getVariantsByProductId(int productId) {
        List<ProductVariant> list = new ArrayList<>();
        String sql
                = "SELECT v.variant_id, v.product_id, "
                + "       co.cpu, "
                + "       ro.ram, "
                + "       so.screen, "
                + "       sto.storage, "
                + "       clo.color, "
                + "       v.price, v.stock_quantity "
                + "FROM ProductVariants v "
                + "  LEFT JOIN CpuOptions co    ON v.cpu_id    = co.cpu_id "
                + "  LEFT JOIN RamOptions ro    ON v.ram_id    = ro.ram_id "
                + "  LEFT JOIN ScreenOptions so ON v.screen_id = so.screen_id "
                + "  LEFT JOIN StorageOptions sto ON v.storage_id = sto.storage_id "
                + "  LEFT JOIN ColorOptions clo ON v.color_id  = clo.color_id "
                + "WHERE v.product_id = ?";
        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductVariant v = new ProductVariant();
                v.setVariantId(rs.getInt("variant_id"));
                v.setProductId(rs.getInt("product_id"));
                v.setCpu(rs.getString("cpu"));
                v.setRam(rs.getString("ram"));
                v.setScreen(rs.getString("screen"));
                v.setStorage(rs.getString("storage"));
                v.setColor(rs.getString("color"));
                v.setPrice(rs.getDouble("price"));
                v.setStockQuantity(rs.getInt("stock_quantity"));
                list.add(v);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public ProductVariant getVariantById(int variantId) {
        String sql
                = "SELECT v.variant_id, v.product_id, "
                + "       co.cpu, "
                + "       ro.ram, "
                + "       so.screen, "
                + "       sto.storage, "
                + "       clo.color, "
                + "       v.price, v.stock_quantity "
                + "FROM ProductVariants v "
                + "  LEFT JOIN CpuOptions co    ON v.cpu_id    = co.cpu_id "
                + "  LEFT JOIN RamOptions ro    ON v.ram_id    = ro.ram_id "
                + "  LEFT JOIN ScreenOptions so ON v.screen_id = so.screen_id "
                + "  LEFT JOIN StorageOptions sto ON v.storage_id = sto.storage_id "
                + "  LEFT JOIN ColorOptions clo ON v.color_id  = clo.color_id "
                + "WHERE v.variant_id = ?";
        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, variantId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ProductVariant v = new ProductVariant();
                v.setVariantId(rs.getInt("variant_id"));
                v.setProductId(rs.getInt("product_id"));
                v.setCpu(rs.getString("cpu"));
                v.setRam(rs.getString("ram"));
                v.setScreen(rs.getString("screen"));
                v.setStorage(rs.getString("storage"));
                v.setColor(rs.getString("color"));
                v.setPrice(rs.getDouble("price"));
                v.setStockQuantity(rs.getInt("stock_quantity"));
                return v;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addVariant(ProductVariant v) {
        String sql = "INSERT INTO ProductVariants "
                + "(product_id, cpu_id, ram_id, screen_id, storage_id, color_id, price, stock_quantity, created_at, updated_at) "
                + "VALUES (?,?,?,?,?,?,?,?,GETDATE(),GETDATE())";
        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, v.getProductId());
            ps.setInt(2, v.getCpuId());
            ps.setInt(3, v.getRamId());
            ps.setInt(4, v.getScreenId());
            ps.setInt(5, v.getStorageId());
            ps.setInt(6, v.getColorId());
            ps.setDouble(7, v.getPrice());
            ps.setInt(8, v.getStockQuantity());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateVariant(ProductVariant v) {
        String sql = "UPDATE ProductVariants SET cpu_id=?,ram_id=?,screen_id=?,storage_id=?,color_id=?,"
                + "price=?,stock_quantity=?,updated_at=GETDATE() WHERE variant_id = ?";
        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, v.getCpuId());
            ps.setInt(2, v.getRamId());
            ps.setInt(3, v.getScreenId());
            ps.setInt(4, v.getStorageId());
            ps.setInt(5, v.getColorId());
            ps.setDouble(6, v.getPrice());
            ps.setInt(7, v.getStockQuantity());
            ps.setInt(8, v.getVariantId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteVariant(int variantId) {
        String sql = "DELETE FROM ProductVariants WHERE variant_id = ?";
        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, variantId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Fetch lookup CPU options
     */
    public List<CpuOption> getAllCpuOptions() {
        List<CpuOption> list = new ArrayList<>();
        String sql = "SELECT cpu_id, cpu FROM CpuOptions ORDER BY cpu";
        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new CpuOption(rs.getInt("cpu_id"), rs.getString("cpu")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Fetch lookup RAM options
     */
    public List<RamOption> getAllRamOptions() {
        List<RamOption> list = new ArrayList<>();
        String sql = "SELECT ram_id, ram FROM RamOptions ORDER BY ram";
        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new RamOption(rs.getInt("ram_id"), rs.getString("ram")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Fetch lookup Screen options
     */
    public List<ScreenOption> getAllScreenOptions() {
        List<ScreenOption> list = new ArrayList<>();
        String sql = "SELECT screen_id, screen FROM ScreenOptions ORDER BY screen";
        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new ScreenOption(rs.getInt("screen_id"), rs.getString("screen")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Fetch lookup Storage options
     */
    public List<StorageOption> getAllStorageOptions() {
        List<StorageOption> list = new ArrayList<>();
        String sql = "SELECT storage_id, storage FROM StorageOptions ORDER BY storage";
        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new StorageOption(rs.getInt("storage_id"), rs.getString("storage")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Fetch lookup Color options
     */
    public List<ColorOption> getAllColorOptions() {
        List<ColorOption> list = new ArrayList<>();
        String sql = "SELECT color_id, color FROM ColorOptions ORDER BY color";
        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new ColorOption(rs.getInt("color_id"), rs.getString("color")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
