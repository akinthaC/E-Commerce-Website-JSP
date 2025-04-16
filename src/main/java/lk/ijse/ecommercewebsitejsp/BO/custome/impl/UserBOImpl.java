package lk.ijse.ecommercewebsitejsp.BO.custome.impl;

import lk.ijse.ecommercewebsitejsp.BO.custome.UserBO;
import lk.ijse.ecommercewebsitejsp.DAO.DAOFactory;
import lk.ijse.ecommercewebsitejsp.DAO.custome.UserDAO;
import lk.ijse.ecommercewebsitejsp.DTO.UserDTO;
import lk.ijse.ecommercewebsitejsp.PasswordUtil;
import org.apache.commons.dbcp2.BasicDataSource;

public class UserBOImpl implements UserBO {

    UserDAO userDAO = (UserDAO) DAOFactory.getDaoFactory().getDAO(DAOFactory.DAOType.USER);

    @Override
    public boolean Register(UserDTO userDTO, BasicDataSource ds) {

        String hashedPassword = PasswordUtil.hashPassword(userDTO.getPassword());
        userDTO.setPassword(hashedPassword);
        return userDAO.save(userDTO,ds);
    }

    @Override
    public UserDTO SearchByName(String name, BasicDataSource ds) {
        return userDAO.SearchByName(name,ds);
    }
}
