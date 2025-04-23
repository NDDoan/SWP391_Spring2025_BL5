/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author LENOVO
 */
public class RamOption {

    private int ramId;
    private String ram;

    public RamOption() {
    }

    public RamOption(int ramId, String ram) {
        this.ramId = ramId;
        this.ram = ram;
    }

    public int getRamId() {
        return ramId;
    }

    public void setRamId(int ramId) {
        this.ramId = ramId;
    }

    public String getRam() {
        return ram;
    }

    public void setRam(String ram) {
        this.ram = ram;
    }
}
