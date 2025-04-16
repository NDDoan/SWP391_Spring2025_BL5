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
public class Product {

    private int productId;
    private String productName;
    private int brandId;
    private int categoryId;
    private String description;
    private Date createdAt;
    private Date updatedAt;

    public Product() {
    }

    public Product(int productId, String productName, int brandId, int categoryId, String description, Date createdAt, Date updatedAt) {
        this.productId = productId;
        this.productName = productName;
        this.brandId = brandId;
        this.categoryId = categoryId;
        this.description = description;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters và Setters
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

    public int getBrandId() {
        return brandId;
    }

    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
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

    @Override
    public String toString() {
        return "Product{"
                + "productId=" + productId
                + ", productName='" + productName + '\''
                + ", brandId=" + brandId
                + ", categoryId=" + categoryId
                + ", description='" + description + '\''
                + ", createdAt=" + createdAt
                + ", updatedAt=" + updatedAt
                + '}';
    }
}
