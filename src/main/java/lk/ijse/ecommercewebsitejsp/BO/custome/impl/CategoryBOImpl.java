package lk.ijse.ecommercewebsitejsp.BO.custome.impl;

import lk.ijse.ecommercewebsitejsp.BO.custome.CategoryBO;
import lk.ijse.ecommercewebsitejsp.DAO.DAOFactory;
import lk.ijse.ecommercewebsitejsp.DAO.custome.CategoryDao;
import lk.ijse.ecommercewebsitejsp.DTO.CategoryDTO;
import org.apache.commons.dbcp2.BasicDataSource;

import java.util.List;

public class CategoryBOImpl implements CategoryBO {
    CategoryDao categoryDao = (CategoryDao) DAOFactory.getDaoFactory().getDAO(DAOFactory.DAOType.CATEGORY);

    @Override
    public List<CategoryDTO> getAllCategories(BasicDataSource ds) {
        return categoryDao.getAll(ds);
    }

    @Override
    public boolean addCategory(CategoryDTO category, BasicDataSource ds) {
        return categoryDao.save(category, ds);
    }

    @Override
    public boolean updateCategory(CategoryDTO categoryDTO, BasicDataSource ds) {
            return categoryDao.update(categoryDTO,ds);
    }

    @Override
    public boolean deleteCategory(int id, BasicDataSource ds) {
        return categoryDao.Delete(id ,ds);
    }
}
