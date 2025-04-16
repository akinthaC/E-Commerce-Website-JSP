package lk.ijse.ecommercewebsitejsp.DTO;

public class ItemDTO {
    private String item_id;
    private String item_name;
    private Double price;
    private int quantity;

    public ItemDTO() {
    }

    public ItemDTO(String item_id, String item_name, Double price, int quantity) {
        this.item_id = item_id;
        this.item_name = item_name;
        this.price = price;
        this.quantity = quantity;
    }

    public String getItem_id() {
        return item_id;
    }

    public void setItem_id(String item_id) {
        this.item_id = item_id;
    }

    public String getItem_name() {
        return item_name;
    }

    public void setItem_name(String item_name) {
        this.item_name = item_name;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
