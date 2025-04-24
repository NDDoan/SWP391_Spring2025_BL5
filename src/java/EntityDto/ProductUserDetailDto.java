/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package EntityDto;

import java.util.List;
import Entity.ProductMedia;
import Entity.ProductVariant;

/**
 *
 * @author LENOVO
 */
public class ProductUserDetailDto {

    private int productId;
    private String productName, brandName, categoryName, description;
    private List<ProductMedia> mediaList;
    private List<ProductVariant> variants;

    public ProductUserDetailDto() {
    }

    public ProductUserDetailDto(int productId, String productName, String brandName, String categoryName, String description, List<ProductMedia> mediaList, List<ProductVariant> variants) {
        this.productId = productId;
        this.productName = productName;
        this.brandName = brandName;
        this.categoryName = categoryName;
        this.description = description;
        this.mediaList = mediaList;
        this.variants = variants;
    }

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

    public List<ProductMedia> getMediaList() {
        return mediaList;
    }

    public void setMediaList(List<ProductMedia> mediaList) {
        this.mediaList = mediaList;
    }

    public List<ProductVariant> getVariants() {
        return variants;
    }

    public void setVariants(List<ProductVariant> variants) {
        this.variants = variants;
    }

}
