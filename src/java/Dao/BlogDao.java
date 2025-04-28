package Dao;

import DBContext.DBContext;
import EntityDto.PostDto;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BlogDao {

    public List<PostDto> searchPostsByKeyword(String keyword) {
        List<PostDto> list = new ArrayList<>();
        String sql = """
            SELECT p.post_id, p.title, p.content, p.thumbnail_url, 
                   p.created_at, u.full_name AS author_name, c.category_name
            FROM Post p
            JOIN [Users] u ON p.user_id = u.user_id
            JOIN CategoryPost c ON p.category_id = c.category_id
            WHERE p.status = 1 AND (p.title LIKE ? OR p.content LIKE ?)
            ORDER BY p.created_at DESC
        """;

        try (Connection connection = new DBContext().getConnection(); PreparedStatement ps = connection.prepareStatement(sql)) {

            String likeKeyword = "%" + keyword + "%";
            ps.setString(1, likeKeyword);
            ps.setString(2, likeKeyword);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                PostDto post = new PostDto();
                post.setPostId(rs.getInt("post_id"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setThumbnailUrl(rs.getString("thumbnail_url"));
                post.setCreatedAt(rs.getTimestamp("created_at"));
                post.setAuthorName(rs.getString("author_name"));
                post.setCategoryName(rs.getString("category_name"));
                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<PostDto> getLatestBlogs(int limit) {
        List<PostDto> list = new ArrayList<>();
        String sql = """
        SELECT TOP ? p.post_id, p.title, p.content, p.thumbnail_url, 
                               p.created_at, u.full_name AS author_name, c.category_name 
        FROM Post p
        JOIN [Users] u ON p.user_id = u.user_id
        JOIN CategoryPost c ON p.category_id = c.category_id
        WHERE p.status = 1
        ORDER BY p.created_at DESC
    """;

        try (Connection connection = new DBContext().getConnection(); PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                PostDto post = new PostDto();
                post.setPostId(rs.getInt("post_id"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setThumbnailUrl(rs.getString("thumbnail_url"));
                post.setCreatedAt(rs.getTimestamp("created_at"));
                post.setAuthorName(rs.getString("author_name"));
                post.setCategoryName(rs.getString("category_name"));
                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

}
