package lk.ijse.ecommercewebsitejsp.BO.custome;

import lk.ijse.ecommercewebsitejsp.BO.SuperBo;
import lk.ijse.ecommercewebsitejsp.DTO.ProductDTO;
import org.apache.commons.dbcp2.BasicDataSource;

import java.util.List;

public interface ProductBO extends SuperBo {
    List<String> fetchCategories(BasicDataSource ds);

    boolean saveProduct(ProductDTO product, BasicDataSource ds);

    List<ProductDTO> getAllProducts(BasicDataSource ds);
}
