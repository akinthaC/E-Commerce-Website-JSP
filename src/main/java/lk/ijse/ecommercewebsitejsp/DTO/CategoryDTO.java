package lk.ijse.ecommercewebsitejsp.DTO;

import java.sql.Timestamp;

public class CategoryDTO {
    private int categoryId;
    private String categoryName;
    private String description;
    private String image;


    // Default constructor
    public CategoryDTO() {
    }

    // Constructor to initialize all fields
    public CategoryDTO(int categoryId, String categoryName, String description, String image) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.description = description;
        this.image = image;

    }

    // Getter and Setter methods
    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }



    @Override
    public String toString() {
        return "CategoryDTO{" +
                "categoryId=" + categoryId +
                ", categoryName='" + categoryName + '\'' +
                ", description='" + description + '\'' +
                ", image='" + image + '\'' +
                '}';
    }
}
