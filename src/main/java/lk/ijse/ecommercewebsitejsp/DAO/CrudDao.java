package lk.ijse.ecommercewebsitejsp.DAO;

import lk.ijse.ecommercewebsitejsp.DTO.CategoryDTO;
import lk.ijse.ecommercewebsitejsp.DTO.ProductDTO;
import lk.ijse.ecommercewebsitejsp.DTO.UserDTO;
import org.apache.commons.dbcp2.BasicDataSource;

import java.util.List;

public interface CrudDao<T> extends SuperDao{
    boolean save(T DTO,BasicDataSource ds);

    UserDTO SearchByName(String name, BasicDataSource ds);

    List<T> getAll(BasicDataSource ds);

    boolean update(T DTO, BasicDataSource ds);

    boolean Delete(int id, BasicDataSource ds);
}
