package Dao;

import DBContext.DBContext;
import EntityDto.PostDto;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BlogDao {

    private Connection conn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    private void closeResources() {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            Logger.getLogger(BlogDao.class.getName()).log(Level.SEVERE, "Error closing resources", e);
        }
    }

    // Helper method to map ResultSet to PostDto
    private PostDto mapResultSetToPostDto(ResultSet rs) throws SQLException {
        int postId = rs.getInt("post_id");
        String title = rs.getString("title");
        String content = rs.getString("content");
        String thumbnailUrl = rs.getString("thumbnail_url");
        int userId = rs.getInt("user_id");
        String authorName = rs.getString("author_name"); // From Users table
        int categoryId = rs.getInt("category_id");
        String categoryName = rs.getString("category_name"); // From CategoryPost table
        boolean status = rs.getBoolean("status");
        Timestamp createdAt = rs.getTimestamp("created_at");

        // Convert status string to boolean
        // Assuming "Published" means true, and anything else (like "Draft") means false.
        // Adjust this logic if you have other status values representing an active/published post.

        return new PostDto(postId, title, content, thumbnailUrl, userId, authorName, categoryId, categoryName, status, createdAt);
    }

    /**
     * Retrieves all blog posts from the database. Only posts with status
     * 'Published' are considered active for display.
     *
     * @return A list of PostDto objects.
     */
    public List<PostDto> getAllBlog() {
        List<PostDto> blogList = new ArrayList<>();
        String query = "SELECT p.post_id, p.title, p.content, p.thumbnail_url, p.user_id, "
                + "u.full_name AS author_name, p.category_id, c.category_name, p.status, p.created_at "
                + "FROM Post p "
                + "JOIN Users u ON p.user_id = u.user_id "
                + "JOIN CategoryPost c ON p.category_id = c.category_id "
                + "ORDER BY p.created_at DESC"; // Optional: order by creation date
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                blogList.add(mapResultSetToPostDto(rs));
            }
        } catch (Exception e) {
            Logger.getLogger(BlogDao.class.getName()).log(Level.SEVERE, "Error fetching all blogs", e);
        } finally {
            closeResources();
        }
        return blogList;
    }

    /**
     * Retrieves all published blog posts from the database.
     *
     * @return A list of PostDto objects with status 'Published'.
     */
    public List<PostDto> getAllPublishedBlogs() {
        List<PostDto> blogList = new ArrayList<>();
        String query = "SELECT p.post_id, p.title, p.content, p.thumbnail_url, p.user_id, "
                + "u.full_name AS author_name, p.category_id, c.category_name, p.status, p.created_at "
                + "FROM Post p "
                + "JOIN Users u ON p.user_id = u.user_id "
                + "JOIN CategoryPost c ON p.category_id = c.category_id "
                + "WHERE p.status = 1"
                + // Only fetch published posts
                "ORDER BY p.created_at DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                blogList.add(mapResultSetToPostDto(rs));
            }
        } catch (Exception e) {
            Logger.getLogger(BlogDao.class.getName()).log(Level.SEVERE, "Error fetching published blogs", e);
        } finally {
            closeResources();
        }
        return blogList;
    }

    /**
     * Searches for blog posts by keyword in title or content. Only searches
     * within posts with status 'Published'.
     *
     * @param keyword The keyword to search for.
     * @return A list of PostDto objects matching the keyword.
     */
    public List<PostDto> searchBlog(String keyword) {
        List<PostDto> blogList = new ArrayList<>();
        String query = "SELECT p.post_id, p.title, p.content, p.thumbnail_url, p.user_id, "
                + "u.full_name AS author_name, p.category_id, c.category_name, p.status, p.created_at "
                + "FROM Post p "
                + "JOIN Users u ON p.user_id = u.user_id "
                + "JOIN CategoryPost c ON p.category_id = c.category_id "
                + "WHERE (p.title LIKE ? OR p.content LIKE ?) AND p.status = 1 "
                + // Search in published posts
                "ORDER BY p.created_at DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            String searchKeyword = "%" + keyword + "%";
            ps.setString(1, searchKeyword);
            ps.setString(2, searchKeyword);
            rs = ps.executeQuery();
            while (rs.next()) {
                blogList.add(mapResultSetToPostDto(rs));
            }
        } catch (Exception e) {
            Logger.getLogger(BlogDao.class.getName()).log(Level.SEVERE, "Error searching blogs", e);
        } finally {
            closeResources();
        }
        return blogList;
    }

    /**
     * Retrieves the newest blog posts. Only fetches posts with status
     * 'Published'.
     *
     * @param limit The maximum number of newest blog posts to retrieve.
     * @return A list of the newest PostDto objects.
     */
    public List<PostDto> getNewestBlogPosts(int limit) {
        List<PostDto> blogList = new ArrayList<>();
        String query = "SELECT TOP (?) p.post_id, p.title, p.content, p.thumbnail_url, p.user_id, "
                + "u.full_name AS author_name, p.category_id, c.category_name, p.status, p.created_at "
                + "FROM Post p "
                + "JOIN Users u ON p.user_id = u.user_id "
                + "JOIN CategoryPost c ON p.category_id = c.category_id "
                + "WHERE p.status = 1 "
                + // Only fetch published posts
                "ORDER BY p.created_at DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, limit);
            rs = ps.executeQuery();
            while (rs.next()) {
                blogList.add(mapResultSetToPostDto(rs));
            }
        } catch (Exception e) {
            Logger.getLogger(BlogDao.class.getName()).log(Level.SEVERE, "Error fetching newest blogs", e);
        } finally {
            closeResources();
        }
        return blogList;
    }

    /**
     * Retrieves a single blog post by its ID. It is assumed that if a direct
     * link is used, any status is fine, or you might want to restrict this to
     * 'Published' as well. For this example, it fetches regardless of status if
     * accessed by ID.
     *
     * @param postId The ID of the post to retrieve.
     * @return A PostDto object if found, otherwise null.
     */
    public PostDto getBlogById(int postId) {
        PostDto post = null;
        String query = "SELECT p.post_id, p.title, p.content, p.thumbnail_url, p.user_id, "
                + "u.full_name AS author_name, p.category_id, c.category_name, p.status, p.created_at "
                + "FROM Post p "
                + "JOIN Users u ON p.user_id = u.user_id "
                + "JOIN CategoryPost c ON p.category_id = c.category_id "
                + "WHERE p.post_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, postId);
            rs = ps.executeQuery();
            if (rs.next()) {
                post = mapResultSetToPostDto(rs);
            }
        } catch (Exception e) {
            Logger.getLogger(BlogDao.class.getName()).log(Level.SEVERE, "Error fetching blog by ID", e);
        } finally {
            closeResources();
        }
        return post;
    }

    // Example main method for testing DAO methods
    public static void main(String[] args) {
        BlogDao dao = new BlogDao();

        System.out.println("--- Testing getAllPublishedBlogs ---");
        List<PostDto> allBlogs = dao.getAllPublishedBlogs();
        if (allBlogs.isEmpty()) {
            System.out.println("No published blogs found.");
        } else {
            for (PostDto post : allBlogs) {
                System.out.println(post.getTitle() + " by " + post.getAuthorName() + " (Status: " + post.isStatus() + ")");
            }
        }
        System.out.println("----------------------------\n");

        System.out.println("--- Testing searchBlog (keyword: 'Post') ---"); // Assuming you have posts with 'Test'
        List<PostDto> searchResults = dao.searchBlog("Post");
        if (searchResults.isEmpty()) {
            System.out.println("No blogs found for keyword 'Post'.");
        } else {
            for (PostDto post : searchResults) {
                System.out.println(post.getTitle() + " - Brief: " + post.getBriefContent());
            }
        }
        System.out.println("----------------------------\n");

        System.out.println("--- Testing getNewestBlogPosts (limit: 3) ---");
        List<PostDto> newestBlogs = dao.getNewestBlogPosts(3);
        if (newestBlogs.isEmpty()) {
            System.out.println("No newest blogs found.");
        } else {
            for (PostDto post : newestBlogs) {
                System.out.println(post.getTitle() + " at " + post.getCreatedAt());
            }
        }
        System.out.println("----------------------------\n");

        System.out.println("--- Testing getBlogById (ID: 1) ---"); // Assuming a post with ID 1 exists
        PostDto singlePost = dao.getBlogById(1);
        if (singlePost != null) {
            System.out.println("Found post: " + singlePost.getTitle());
            System.out.println("Content: " + singlePost.getContent());
            System.out.println("Is Published in DTO (based on '1' status string): " + singlePost.isStatus());
        } else {
            System.out.println("Post with ID 1 not found.");
        }
        System.out.println("----------------------------\n");
    }
}
