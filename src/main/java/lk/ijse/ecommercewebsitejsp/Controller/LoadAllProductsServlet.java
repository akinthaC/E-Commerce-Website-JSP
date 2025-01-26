package lk.ijse.ecommercewebsitejsp.Controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.ecommercewebsitejsp.BO.BOFactory;
import lk.ijse.ecommercewebsitejsp.BO.custome.ProductBO;
import lk.ijse.ecommercewebsitejsp.DTO.ProductDTO;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "/LoadAllProductServlet",value = "/LoadAllProduct-Servlet")
public class LoadAllProductsServlet extends HttpServlet {
    ProductBO productBO = (ProductBO) BOFactory.getBoFactory().GetBo(BOFactory.BOType.PRODUCT);

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ServletContext servletContext = req.getServletContext();
        BasicDataSource ds = (BasicDataSource) servletContext.getAttribute("datasource");

        List<ProductDTO> productDTOList = productBO.getAllProducts(ds);
        System.out.println(productDTOList.size());

        // Set the product list as a request attribute
        req.setAttribute("productDTOList", productDTOList);
        req.getRequestDispatcher("adminDashboard.jsp#").forward(req, resp);
    }
}
