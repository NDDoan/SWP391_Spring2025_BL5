/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package EntityDto;

/**
 *
 * @author LENOVO
 */
public class VariantStockDto {

    private String variantName;
    private int stock;

    public VariantStockDto() {
    }

    public VariantStockDto(String variantName, int stock) {
        this.variantName = variantName;
        this.stock = stock;
    }

    public String getVariantName() {
        return variantName;
    }

    public void setVariantName(String variantName) {
        this.variantName = variantName;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }
}
