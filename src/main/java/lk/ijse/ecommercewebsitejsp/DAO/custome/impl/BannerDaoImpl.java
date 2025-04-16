package lk.ijse.ecommercewebsitejsp.DAO.custome.impl;

import lk.ijse.ecommercewebsitejsp.DAO.custome.BannerDao;
import lk.ijse.ecommercewebsitejsp.DTO.BannerDTO;
import lk.ijse.ecommercewebsitejsp.DTO.UserDTO;
import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class BannerDaoImpl implements BannerDao {
    @Override
    public boolean save(BannerDTO bannerDTO, BasicDataSource ds) {
        String query = "INSERT INTO dashboardBanners (bannerTitle, bannerDescription, bannerImage) VALUES (?, ?, ?)";

        // Use try-with-resources to ensure the resources are closed
        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Set the parameters from BannerDTO
            stmt.setString(1, bannerDTO.getTitle());
            stmt.setString(2, bannerDTO.getDescription());
            stmt.setString(3, bannerDTO.getImagePath());

            // Execute the query
            int rowsAffected = stmt.executeUpdate();

            // Return true if the insert was successful (i.e., rowsAffected > 0)
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Return false if there's an exception
        }

    }

    @Override
    public UserDTO SearchByName(String name, BasicDataSource ds) {
        return null;
    }

    @Override
    public List<BannerDTO> getAll(BasicDataSource ds) {
        return null;
    }

    @Override
    public boolean update(BannerDTO DTO, BasicDataSource ds) {
        return false;
    }

    @Override
    public boolean Delete(int id, BasicDataSource ds) {
        return false;
    }
}
