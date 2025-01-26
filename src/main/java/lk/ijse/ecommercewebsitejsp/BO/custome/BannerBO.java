package lk.ijse.ecommercewebsitejsp.BO.custome;

import lk.ijse.ecommercewebsitejsp.BO.SuperBo;
import lk.ijse.ecommercewebsitejsp.DTO.BannerDTO;
import org.apache.commons.dbcp2.BasicDataSource;

public interface BannerBO extends SuperBo {
    boolean addBanner(BannerDTO bannerDTO, BasicDataSource ds);
}
