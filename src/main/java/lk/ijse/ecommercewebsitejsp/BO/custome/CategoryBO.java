package lk.ijse.ecommercewebsitejsp.BO.custome;

import lk.ijse.ecommercewebsitejsp.BO.SuperBo;
import lk.ijse.ecommercewebsitejsp.DTO.CategoryDTO;
import org.apache.commons.dbcp2.BasicDataSource;

import java.util.List;

public interface CategoryBO extends SuperBo {
    List<CategoryDTO> getAllCategories(BasicDataSource ds);

    boolean addCategory(CategoryDTO category, BasicDataSource ds);

    boolean updateCategory(CategoryDTO categoryDTO, BasicDataSource ds);

    boolean deleteCategory(int i, BasicDataSource ds);
}
