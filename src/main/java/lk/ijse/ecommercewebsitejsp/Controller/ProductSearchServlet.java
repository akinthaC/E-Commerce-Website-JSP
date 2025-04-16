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

@WebServlet(name = "/productSearch" , value = "/productSearch-Servlet")
public class ProductSearchServlet extends HttpServlet {
    ProductBO productBO = (ProductBO) BOFactory.getBoFactory().GetBo(BOFactory.BOType.PRODUCT);

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchTerm = request.getParameter("searchTerm");

        ServletContext servletContext = request.getServletContext();
        BasicDataSource ds = (BasicDataSource) servletContext.getAttribute("datasource");

      /*  List<ProductDTO> products = productBO.searchProducts(searchTerm);*/
        
       /* request.setAttribute("products", products);
        RequestDispatcher dispatcher = request.getRequestDispatcher("product-page.jsp");
        dispatcher.forward(request, response);*/
    }
}
