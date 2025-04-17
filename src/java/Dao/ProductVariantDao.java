/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import DBContext.DBContext;
import Entity.ProductVariant;
import java.sql.*;
import java.util.*;

/**
 *
 * @author LENOVO
 */
public class ProductVariantDao {

    public List<ProductVariant> getVariantsByProductId(int productId) {
        List<ProductVariant> list = new ArrayList<>();
        String sql = "SELECT * FROM ProductVariants WHERE product_id = ?";
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
        String sql = "SELECT * FROM ProductVariants WHERE variant_id = ?";
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
        String sql = "INSERT INTO ProductVariants (product_id, cpu, ram, screen, storage, color, price, stock_quantity, created_at, updated_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), GETDATE())";
        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, v.getProductId());
            ps.setString(2, v.getCpu());
            ps.setString(3, v.getRam());
            ps.setString(4, v.getScreen());
            ps.setString(5, v.getStorage());
            ps.setString(6, v.getColor());
            ps.setDouble(7, v.getPrice());
            ps.setInt(8, v.getStockQuantity());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateVariant(ProductVariant v) {
        String sql = "UPDATE ProductVariants SET cpu=?, ram=?, screen=?, storage=?, color=?, price=?, stock_quantity=?, updated_at=GETDATE() "
                + "WHERE variant_id = ?";
        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, v.getCpu());
            ps.setString(2, v.getRam());
            ps.setString(3, v.getScreen());
            ps.setString(4, v.getStorage());
            ps.setString(5, v.getColor());
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
}
