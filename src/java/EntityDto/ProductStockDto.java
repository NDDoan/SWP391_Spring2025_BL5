/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package EntityDto;

/**
 *
 * @author LENOVO
 */
public class ProductStockDto {

    private int productId;
    private String productName;
    private int totalStock;

    public ProductStockDto() {
    }

    public ProductStockDto(int productId, String productName, int totalStock) {
        this.productId = productId;
        this.productName = productName;
        this.totalStock = totalStock;
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

    public int getTotalStock() {
        return totalStock;
    }

    public void setTotalStock(int totalStock) {
        this.totalStock = totalStock;
    }
}
