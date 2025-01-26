package lk.ijse.ecommercewebsitejsp.DAO.custome.impl;

import lk.ijse.ecommercewebsitejsp.DAO.custome.ProductDao;
import lk.ijse.ecommercewebsitejsp.DTO.ProductDTO;
import lk.ijse.ecommercewebsitejsp.DTO.UserDTO;
import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class ProductDaoImpl implements ProductDao {


    @Override
    public boolean save(ProductDTO product, BasicDataSource ds) {
        String sql = "INSERT INTO products (name, category, price, stock, main_image, sample_images) VALUES (?, ?, ?, ?, ?, ?)";
        boolean isSaved = false;

        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // Set values for the prepared statement
            pstmt.setString(1, product.getName());
            pstmt.setString(2, product.getCategory());
            pstmt.setDouble(3, product.getPrice());
            pstmt.setInt(4, product.getStock());
            pstmt.setString(5, product.getMainImage());

            // If sample images exist, join them as a comma-separated string
            if (product.getSampleImages() != null && !product.getSampleImages().isEmpty()) {
                pstmt.setString(6, String.join(",", product.getSampleImages()));
            } else {
                pstmt.setNull(6, Types.VARCHAR);
            }

            // Execute the update
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                isSaved = true;  // Product was successfully saved
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isSaved;
    }

    @Override
    public UserDTO SearchByName(String name, BasicDataSource ds) {
        return null;
    }

    @Override
    public List<ProductDTO> getAll(BasicDataSource ds) {
        List<ProductDTO> productList = new ArrayList<>();

        String query = "SELECT * FROM products";  // Select all columns from the products table

        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            // Loop through the result set and map the results to ProductDTO
            while (rs.next()) {
                ProductDTO product = new ProductDTO();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setCategory(rs.getString("category"));
                product.setPrice(rs.getDouble("price"));
                product.setStock(rs.getInt("stock"));
                product.setMainImage(rs.getString("main_image"));
                String sampleImagesStr = rs.getString("sample_images");
                if (sampleImagesStr != null && !sampleImagesStr.isEmpty()) {
                    // Split the string by commas and remove any leading/trailing spaces from image paths
                    List<String> sampleImages = Arrays.asList(sampleImagesStr.split(","));
                    product.setSampleImages(sampleImages);

                } else {
                    product.setSampleImages(Collections.emptyList());
                }


                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle or log the exception appropriately
        }

        return productList;
    }

    @Override
    public boolean update(ProductDTO DTO, BasicDataSource ds) {
        return false;
    }

    @Override
    public boolean Delete(int id, BasicDataSource ds) {
        return false;
    }


    @Override
    public List<String> getAllCategories(BasicDataSource ds) {
        List<String> categories = new ArrayList<>();
        try (Connection connection = ds.getConnection()) {
            // SQL query to fetch categories
            String query = "SELECT category_name FROM category"; // Adjust table/column names as needed
            PreparedStatement statement = connection.prepareStatement(query);

            // Execute query
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                categories.add(resultSet.getString("category_name")); // Adjust column name
            }

            resultSet.close();
            statement.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return categories;
    }
}
