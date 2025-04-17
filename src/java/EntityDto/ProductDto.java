/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package EntityDto;

import Entity.ProductMedia;
import Entity.ProductVariant;
import java.util.Date;
import java.util.List;

/**
 *
 * @author LENOVO
 */
public class ProductDto {

    private int productId;
    private String productName;
    private String brandName;
    private String categoryName;
    private String description;
    private Date createdAt;
    private Date updatedAt;

    // Danh sách phiên bản của sản phẩm
    private List<ProductVariant> variants;
    // Danh sách media liên quan
    private List<ProductMedia> mediaList;

    public ProductDto() {
    }

    public ProductDto(int productId, String productName, String brandName, String categoryName, String description, Date createdAt, Date updatedAt, List<ProductVariant> variants, List<ProductMedia> mediaList) {
        this.productId = productId;
        this.productName = productName;
        this.brandName = brandName;
        this.categoryName = categoryName;
        this.description = description;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.variants = variants;
        this.mediaList = mediaList;
    }

    // Getters and setters
    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    public List<ProductVariant> getVariants() {
        return variants;
    }

    public void setVariants(List<ProductVariant> variants) {
        this.variants = variants;
    }

    public List<ProductMedia> getMediaList() {
        return mediaList;
    }

    public void setMediaList(List<ProductMedia> mediaList) {
        this.mediaList = mediaList;
    }

    @Override
    public String toString() {
        return "ProductDto{"
                + "productId=" + productId
                + ", productName='" + productName + '\''
                + ", brandId=" + brandName
                + ", categoryId=" + categoryName
                + ", description='" + description + '\''
                + ", createdAt=" + createdAt
                + ", updatedAt=" + updatedAt
                + ", variants=" + variants
                + ", mediaList=" + mediaList
                + '}';
    }
}
