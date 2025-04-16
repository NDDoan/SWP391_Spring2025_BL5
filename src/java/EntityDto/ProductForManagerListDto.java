/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package EntityDto;

/**
 *
 * @author LENOVO
 */
public class ProductForManagerListDto {

    private int productId;
    private String productName;
    private String brandName;
    private String categoryName;
    private int totalStockQuantity;
    private String primaryMediaUrl;  // URL ảnh media được đánh dấu is_primary

    public ProductForManagerListDto() {
    }

    public ProductForManagerListDto(int productId, String productName, String brandName, String categoryName, int totalStockQuantity, String primaryMediaUrl) {
        this.productId = productId;
        this.productName = productName;
        this.brandName = brandName;
        this.categoryName = categoryName;
        this.totalStockQuantity = totalStockQuantity;
        this.primaryMediaUrl = primaryMediaUrl;
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

    public int getTotalStockQuantity() {
        return totalStockQuantity;
    }

    public void setTotalStockQuantity(int totalStockQuantity) {
        this.totalStockQuantity = totalStockQuantity;
    }

    public String getPrimaryMediaUrl() {
        return primaryMediaUrl;
    }

    public void setPrimaryMediaUrl(String primaryMediaUrl) {
        this.primaryMediaUrl = primaryMediaUrl;
    }

    @Override
    public String toString() {
        return "ProductForMarketingListDto{"
                + "productId=" + productId
                + ", productName='" + productName + '\''
                + ", brandName='" + brandName + '\''
                + ", categoryName='" + categoryName + '\''
                + ", totalStockQuantity=" + totalStockQuantity
                + ", primaryMediaUrl='" + primaryMediaUrl + '\''
                + '}';
    }
}
