package Entity;

import java.sql.Timestamp;

public class Post {
    private int id;
    private String title;
    private String thumbnailUrl;
    private String briefInfo;
    private String content;
    private boolean isPublished;
    private boolean isFeatured;
    private Timestamp createdAt;

    public Post() {}

    public Post(int id, String title, String thumbnailUrl, String briefInfo, String content,
                boolean isPublished, boolean isFeatured, Timestamp createdAt) {
        this.id = id;
        this.title = title;
        this.thumbnailUrl = thumbnailUrl;
        this.briefInfo = briefInfo;
        this.content = content;
        this.isPublished = isPublished;
        this.isFeatured = isFeatured;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getThumbnailUrl() { return thumbnailUrl; }
    public void setThumbnailUrl(String thumbnailUrl) { this.thumbnailUrl = thumbnailUrl; }

    public String getBriefInfo() { return briefInfo; }
    public void setBriefInfo(String briefInfo) { this.briefInfo = briefInfo; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public boolean isPublished() { return isPublished; }
    public void setPublished(boolean published) { isPublished = published; }

    public boolean isFeatured() { return isFeatured; }
    public void setFeatured(boolean featured) { isFeatured = featured; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
