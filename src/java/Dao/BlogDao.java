package Dao;

import DBContext.DBContext;
import Entity.Blog;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BlogDao {

    public List<Blog> getBlogs(int pageIndex, int pageSize) {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT * FROM Blogs ORDER BY updated_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, (pageIndex - 1) * pageSize);
            ps.setInt(2, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Blog blog = new Blog();
                blog.setBlogId(rs.getInt("blog_id"));
                blog.setTitle(rs.getString("title"));
                blog.setContent(rs.getString("content"));
                blog.setCreatedAt(rs.getTimestamp("created_at"));
                blog.setUpdatedAt(rs.getTimestamp("updated_at"));
                list.add(blog);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countBlogs() {
        String sql = "SELECT COUNT(*) FROM Blogs";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Blog> getLatestBlogs(int limit) {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT TOP(?) * FROM Blogs ORDER BY updated_at DESC";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Blog blog = new Blog();
                blog.setBlogId(rs.getInt("blog_id"));
                blog.setTitle(rs.getString("title"));
                blog.setContent(rs.getString("content"));
                blog.setCreatedAt(rs.getTimestamp("created_at"));
                blog.setUpdatedAt(rs.getTimestamp("updated_at"));
                list.add(blog);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Blog> searchBlogsByKeyword(String keyword) {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT * FROM Blogs WHERE title LIKE ? OR content LIKE ? ORDER BY updated_at DESC";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            String searchValue = "%" + keyword + "%";
            ps.setString(1, searchValue);
            ps.setString(2, searchValue);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Blog blog = new Blog();
                blog.setBlogId(rs.getInt("blog_id"));
                blog.setTitle(rs.getString("title"));
                blog.setContent(rs.getString("content"));
                blog.setCreatedAt(rs.getTimestamp("created_at"));
                blog.setUpdatedAt(rs.getTimestamp("updated_at"));
                list.add(blog);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }



    public Blog getBlogById(int id) {
        String sql = "SELECT * FROM Blogs WHERE blog_id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Blog blog = new Blog();
                blog.setBlogId(rs.getInt("blog_id"));
                blog.setTitle(rs.getString("title"));
                blog.setContent(rs.getString("content"));
                blog.setCreatedAt(rs.getTimestamp("created_at"));
                blog.setUpdatedAt(rs.getTimestamp("updated_at"));
                return blog;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
