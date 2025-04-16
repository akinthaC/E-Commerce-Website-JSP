package lk.ijse.ecommercewebsitejsp.DAO.custome.impl;

import lk.ijse.ecommercewebsitejsp.DAO.custome.UserDAO;
import lk.ijse.ecommercewebsitejsp.DTO.ProductDTO;
import lk.ijse.ecommercewebsitejsp.DTO.UserDTO;
import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class UserDaoImpl implements UserDAO {
    @Override
    public boolean save(UserDTO userDTO, BasicDataSource ds) {
        String sql = "INSERT INTO User (name,username,email, password, contact, role) VALUES (?, ?, ?, ?, ?, ?)";

        try (
                Connection connection = ds.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql)
        ) {
            ps.setString(1, userDTO.getName());      // Setting 'name'
            ps.setString(2, userDTO.getUsername()); // Setting 'username'
            ps.setString(3, userDTO.getEmail());    // Setting 'email'
            ps.setString(4, userDTO.getPassword()); // Setting 'password'
            ps.setString(5, userDTO.getPhone());    // Setting 'contact'
            ps.setString(6, userDTO.getRole());     // Setting 'role'

            // Execute the update and check if any rows were affected
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public UserDTO SearchByName(String name, BasicDataSource ds) {
        String sql = "SELECT * FROM User WHERE username = ?";

        try(Connection connection = ds.getConnection()) {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new UserDTO(
                        rs.getInt("userId"),
                        rs.getString("name"),       // Assuming 'name' is now part of the table
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("email"),
                        rs.getString("contact"),
                        rs.getString("role")
                );
            } else {
                return null;
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<UserDTO> getAll(BasicDataSource ds) {
        return null;
    }

    @Override
    public boolean update(UserDTO DTO, BasicDataSource ds) {
        return false;
    }

    @Override
    public boolean Delete(int id, BasicDataSource ds) {
        return false;
    }

}
