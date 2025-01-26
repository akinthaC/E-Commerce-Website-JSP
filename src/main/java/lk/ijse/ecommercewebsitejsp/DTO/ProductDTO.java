package lk.ijse.ecommercewebsitejsp.DTO;

import java.util.List;


public class ProductDTO {
    private int id;
    private String name;
    private String category;
    private double price;
    private int stock;
    private String mainImage;
    private List<String> sampleImages;

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }

    public String getMainImage() { return mainImage; }
    public void setMainImage(String mainImage) { this.mainImage = mainImage; }

    public List<String> getSampleImages() { return sampleImages; }
    public void setSampleImages(List<String> sampleImages) { this.sampleImages = sampleImages; }
}
