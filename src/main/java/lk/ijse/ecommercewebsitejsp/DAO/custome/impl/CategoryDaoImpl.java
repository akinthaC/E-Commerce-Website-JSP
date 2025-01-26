package lk.ijse.ecommercewebsitejsp.DAO.custome.impl;

import lk.ijse.ecommercewebsitejsp.DAO.custome.CategoryDao;
import lk.ijse.ecommercewebsitejsp.DTO.CategoryDTO;
import lk.ijse.ecommercewebsitejsp.DTO.UserDTO;
import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDaoImpl implements CategoryDao {
    @Override
    public boolean save(CategoryDTO DTO, BasicDataSource ds) {
        String sql = "INSERT INTO category (category_name, description, image) VALUES (?, ?, ?)";

        // Get a connection from the BasicDataSource
        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Set the parameters for the SQL query
            stmt.setString(1, DTO.getCategoryName());  // Category name
            stmt.setString(2, DTO.getDescription());   // Description
            stmt.setString(3, DTO.getImage());         // Image path (URL)

            // Execute the query
            int rowsAffected = stmt.executeUpdate();

            // If at least one row is affected, return true
            return rowsAffected > 0;

        } catch (SQLException e) {
            // Log the exception
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public UserDTO SearchByName(String name, BasicDataSource ds) {
        return null;
    }

    @Override
    public List<CategoryDTO> getAll(BasicDataSource ds) {
        System.out.println("okkk");
        List<CategoryDTO> categoryList = new ArrayList<>();
        String query = "SELECT category_id, category_name, description, image, created_at, updated_at FROM category";

        // Try-with-resources to automatically close resources
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            // Process each row in the result set
            while (rs.next()) {
                CategoryDTO categoryDTO = new CategoryDTO();
                categoryDTO.setCategoryId(rs.getInt("category_id"));
                categoryDTO.setCategoryName(rs.getString("category_name"));
                categoryDTO.setDescription(rs.getString("description"));
                categoryDTO.setImage(rs.getString("image"));


                // Add the categoryDTO object to the list
                categoryList.add(categoryDTO);
            }
        } catch (SQLException e) {
            e.printStackTrace();  // Handle SQL exceptions
        }

        return categoryList;
    }

    @Override
    public boolean update(CategoryDTO DTO, BasicDataSource ds) {
        String updateQuery = "UPDATE category SET category_name = ?, description = ?, image = ? WHERE category_id = ?";

        try (Connection conn = ds.getConnection(); // Get a connection from the data source
             PreparedStatement ps = conn.prepareStatement(updateQuery)) {

            System.out.println(DTO.getCategoryName()+" "+DTO.getDescription()+" "+DTO.getImage() + " "+DTO.getCategoryId());
            // Set the parameters for the query
            ps.setString(1, DTO.getCategoryName());   // category name
            ps.setString(2, DTO.getDescription());    // description
            ps.setString(3, DTO.getImage());          // image (file path)
            ps.setInt(4, DTO.getCategoryId());       // category ID (where to update)

            // Execute the update query
            int rowsUpdated = ps.executeUpdate();

            // Return true if one or more rows were updated, false otherwise
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;  // Return false if an exception occurs
        }

    }

    @Override
    public boolean Delete(int id, BasicDataSource ds) {
        String sql = "DELETE FROM category WHERE category_id = ?";
        try (Connection connection = ds.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            // Set the ID parameter in the query
            preparedStatement.setInt(1, id);

            // Execute the update and check if any rows were affected
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0; // Return true if a record was deleted
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging
            return false; // Return false in case of any failure
        }
    }

}
