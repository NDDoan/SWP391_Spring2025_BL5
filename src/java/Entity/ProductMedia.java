/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

import java.util.Date;

/**
 *
 * @author LENOVO
 */
public class ProductMedia {

    private int mediaId;
    private int productId;
    private String mediaUrl;
    private String mediaType; // ví dụ: "image" hoặc "video"
    private boolean isPrimary;
    private Date createdAt;
    private Date updatedAt;

    public ProductMedia() {
    }

    public ProductMedia(int mediaId, int productId, String mediaUrl, String mediaType, boolean isPrimary, Date createdAt, Date updatedAt) {
        this.mediaId = mediaId;
        this.productId = productId;
        this.mediaUrl = mediaUrl;
        this.mediaType = mediaType;
        this.isPrimary = isPrimary;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters và Setters
    public int getMediaId() {
        return mediaId;
    }

    public void setMediaId(int mediaId) {
        this.mediaId = mediaId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getMediaUrl() {
        return mediaUrl;
    }

    public void setMediaUrl(String mediaUrl) {
        this.mediaUrl = mediaUrl;
    }

    public String getMediaType() {
        return mediaType;
    }

    public void setMediaType(String mediaType) {
        this.mediaType = mediaType;
    }

    public boolean isPrimary() {
        return isPrimary;
    }

    public void setPrimary(boolean primary) {
        isPrimary = primary;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "ProductMedia{"
                + "mediaId=" + mediaId
                + ", productId=" + productId
                + ", mediaUrl='" + mediaUrl + '\''
                + ", mediaType='" + mediaType + '\''
                + ", isPrimary=" + isPrimary
                + ", createdAt=" + createdAt
                + ", updatedAt=" + updatedAt
                + '}';
    }
}
