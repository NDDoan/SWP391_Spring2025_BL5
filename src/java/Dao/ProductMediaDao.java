/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import DBContext.DBContext;
import Entity.ProductMedia;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author LENOVO
 */
public class ProductMediaDao {

    public List<ProductMedia> getMediaByProductId(int productId) {
        List<ProductMedia> list = new ArrayList<>();
        String sql = "SELECT * FROM ProductMedia WHERE product_id = ? ORDER BY is_primary DESC, created_at";
        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductMedia m = new ProductMedia();
                m.setMediaId(rs.getInt("media_id"));
                m.setProductId(rs.getInt("product_id"));
                m.setMediaUrl(rs.getString("media_url"));
                m.setMediaType(rs.getString("media_type"));
                m.setPrimary(rs.getBoolean("is_primary"));
                list.add(m);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addMedia(ProductMedia pm) {
        String resetSql = "UPDATE ProductMedia SET is_primary = 0 WHERE product_id = ?";
        String insertSql = "INSERT INTO ProductMedia (product_id, media_url, media_type, is_primary, created_at, updated_at) "
                + "VALUES (?, ?, ?, ?, GETDATE(), GETDATE())";
        Connection con = null;
        try {
            con = new DBContext().getConnection();
            con.setAutoCommit(false);

            // Nếu muốn set làm primary, reset tất cả bản trước
            if (pm.isPrimary()) {
                try (PreparedStatement resetPs = con.prepareStatement(resetSql)) {
                    resetPs.setInt(1, pm.getProductId());
                    resetPs.executeUpdate();
                }
            }

            // Chèn bản ghi mới
            try (PreparedStatement ps = con.prepareStatement(insertSql)) {
                ps.setInt(1, pm.getProductId());
                ps.setString(2, pm.getMediaUrl());
                ps.setString(3, pm.getMediaType());
                ps.setBoolean(4, pm.isPrimary());
                ps.executeUpdate();
            }

            con.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        } finally {
            if (con != null) {
                try {
                    con.setAutoCommit(true);
                    con.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
        return false;
    }

    public boolean deleteMedia(int mediaId) {
        String sql = "DELETE FROM ProductMedia WHERE media_id = ?";
        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, mediaId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean setPrimaryMedia(int mediaId, int productId) {
        String resetSql = "UPDATE ProductMedia SET is_primary = 0 WHERE product_id = ?";
        String setSql = "UPDATE ProductMedia SET is_primary = 1 WHERE media_id = ?";
        try (Connection con = new DBContext().getConnection()) {
            con.setAutoCommit(false);
            try (PreparedStatement ps1 = con.prepareStatement(resetSql)) {
                ps1.setInt(1, productId);
                ps1.executeUpdate();
            }
            try (PreparedStatement ps2 = con.prepareStatement(setSql)) {
                ps2.setInt(1, mediaId);
                ps2.executeUpdate();
            }
            con.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
