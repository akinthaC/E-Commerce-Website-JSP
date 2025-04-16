package lk.ijse.ecommercewebsitejsp.BO.custome.impl;

import lk.ijse.ecommercewebsitejsp.BO.custome.BannerBO;
import lk.ijse.ecommercewebsitejsp.DAO.DAOFactory;
import lk.ijse.ecommercewebsitejsp.DAO.custome.BannerDao;
import lk.ijse.ecommercewebsitejsp.DAO.custome.ProductDao;
import lk.ijse.ecommercewebsitejsp.DTO.BannerDTO;
import org.apache.commons.dbcp2.BasicDataSource;

public class BannerBOImpl implements BannerBO {
    BannerDao bannerDao = (BannerDao) DAOFactory.getDaoFactory().getDAO(DAOFactory.DAOType.BANNER);

    @Override
    public boolean addBanner(BannerDTO bannerDTO, BasicDataSource ds) {
        return bannerDao.save(bannerDTO,ds);
    }
}
