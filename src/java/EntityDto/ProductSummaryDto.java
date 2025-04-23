/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package EntityDto;

/**
 *
 * @author LENOVO
 */
public class ProductSummaryDto {

    private int productId;
    private String productName;
    private String brandName;
    private String categoryName;
    private double price;
    private String primaryMediaUrl;

    public ProductSummaryDto() {
    }

    public ProductSummaryDto(int productId, String productName, String brandName, String categoryName, double price, String primaryMediaUrl) {
        this.productId = productId;
        this.productName = productName;
        this.brandName = brandName;
        this.categoryName = categoryName;
        this.price = price;
        this.primaryMediaUrl = primaryMediaUrl;
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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getPrimaryMediaUrl() {
        return primaryMediaUrl;
    }

    public void setPrimaryMediaUrl(String primaryMediaUrl) {
        this.primaryMediaUrl = primaryMediaUrl;
    }

}
