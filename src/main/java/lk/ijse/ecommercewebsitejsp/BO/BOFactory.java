package lk.ijse.ecommercewebsitejsp.BO;

import lk.ijse.ecommercewebsitejsp.BO.custome.impl.BannerBOImpl;
import lk.ijse.ecommercewebsitejsp.BO.custome.impl.CategoryBOImpl;
import lk.ijse.ecommercewebsitejsp.BO.custome.impl.ProductBOImpl;
import lk.ijse.ecommercewebsitejsp.BO.custome.impl.UserBOImpl;

public class BOFactory {
    private static BOFactory boFactory;
    public static BOFactory getBoFactory() {
        return (boFactory == null) ? new BOFactory() : boFactory;
    }

    public enum BOType{
        USER,PRODUCT,CATEGORY,BANNER
    }

    public SuperBo GetBo(BOType boType) {
        switch (boType) {
            case USER:
                return new UserBOImpl();
            case PRODUCT:
                return new ProductBOImpl();
            case CATEGORY:
                return new CategoryBOImpl();
            case BANNER:
                return new BannerBOImpl();
            default:
                return null;
        }
    }

}
