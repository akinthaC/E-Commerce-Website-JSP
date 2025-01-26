package lk.ijse.ecommercewebsitejsp.BO.custome;

import lk.ijse.ecommercewebsitejsp.BO.SuperBo;
import lk.ijse.ecommercewebsitejsp.DTO.UserDTO;
import org.apache.commons.dbcp2.BasicDataSource;

public interface UserBO extends SuperBo {
    boolean Register(UserDTO userDTO, BasicDataSource ds);

    UserDTO SearchByName(String name, BasicDataSource ds);
}
