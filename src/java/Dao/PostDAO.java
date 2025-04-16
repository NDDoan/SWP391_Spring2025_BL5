package Dao;

import Entity.Post;
import java.sql.*;
import java.util.*;
import DBContext.DBContext;

public class PostDAO extends DBContext {

    public PostDAO(Connection conn) {
    }
    public List<Post> getHotPosts() throws Exception {
        List<Post> list = new ArrayList<>();
        String sql = "SELECT * FROM Posts WHERE is_featured = 1 AND is_published = 1";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Post(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("thumbnail_url"),
                    rs.getString("brief_info"),
                    rs.getBoolean("is_featured"),
                    rs.getBoolean("is_published")
                ));
            }
        }
        return list;
    }

    public List<Post> getLatestPosts(int limit) throws Exception {
        List<Post> list = new ArrayList<>();
        String sql = "SELECT TOP (?) id, title FROM Posts WHERE is_published = 1 ORDER BY created_at DESC";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Post(rs.getInt("id"), rs.getString("title"), null, null, false, true));
            }
        }
        return list;
    }
}
