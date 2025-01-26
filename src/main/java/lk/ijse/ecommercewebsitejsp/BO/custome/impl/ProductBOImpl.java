package lk.ijse.ecommercewebsitejsp.BO.custome.impl;

import lk.ijse.ecommercewebsitejsp.BO.custome.ProductBO;
import lk.ijse.ecommercewebsitejsp.DAO.DAOFactory;
import lk.ijse.ecommercewebsitejsp.DAO.custome.ProductDao;
import lk.ijse.ecommercewebsitejsp.DTO.ProductDTO;
import org.apache.commons.dbcp2.BasicDataSource;

import java.util.List;

public class ProductBOImpl implements ProductBO {
    ProductDao productDao = (ProductDao) DAOFactory.getDaoFactory().getDAO(DAOFactory.DAOType.PRODUCT);

    @Override
    public List<String> fetchCategories(BasicDataSource ds) {
        return productDao.getAllCategories(ds);
    }

    @Override
    public boolean saveProduct(ProductDTO product, BasicDataSource ds) {
        return productDao.save(product,ds);
    }

    @Override
    public List<ProductDTO> getAllProducts(BasicDataSource ds) {
        return productDao.getAll(ds);
    }
}
