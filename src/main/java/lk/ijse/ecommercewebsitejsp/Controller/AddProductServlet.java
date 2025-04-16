package lk.ijse.ecommercewebsitejsp.Controller;

import com.google.gson.Gson;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import lk.ijse.ecommercewebsitejsp.BO.BOFactory;
import lk.ijse.ecommercewebsitejsp.BO.custome.ProductBO;
import lk.ijse.ecommercewebsitejsp.DTO.ProductDTO;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
@WebServlet(name = "/AddProductServlet",value = "/AddProduct-Servlet")
public class AddProductServlet extends HttpServlet {
    ProductBO productBO = (ProductBO) BOFactory.getBoFactory().GetBo(BOFactory.BOType.PRODUCT);

    private static final String UPLOAD_DIRECTORY = "assets/uploads";
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ServletContext servletContext = req.getServletContext();
        BasicDataSource ds = (BasicDataSource) servletContext.getAttribute("datasource");

        try {
            // Retrieve product details
            String productName = req.getParameter("productName");
            String productCategory = req.getParameter("productCategory");
            String productPriceStr = req.getParameter("productPrice");
            String productStock = req.getParameter("productStock");

            // Validate input
            if (productName == null || productCategory == null || productPriceStr == null || productStock == null) {
                throw new IllegalArgumentException("Missing required product information");
            }

            double productPrice = Double.parseDouble(productPriceStr);
            int stock = Integer.parseInt(productStock);

            // Upload files
            String uploadPath = req.getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
            new File(uploadPath).mkdirs();

            // Handle main image
            Part mainImagePart = req.getPart("mainImage");
            String mainImageName = UUID.randomUUID() + "_" + mainImagePart.getSubmittedFileName();
            mainImagePart.write(uploadPath + File.separator + mainImageName);
            String mainImagePath = UPLOAD_DIRECTORY + "/" + mainImageName;

            // Handle sample images
            List<String> sampleImages = new ArrayList<>();
            for (Part part : req.getParts()) {
                if ("sampleImages".equals(part.getName()) && part.getSubmittedFileName() != null) {
                    String sampleImageName = UUID.randomUUID() + "_" + part.getSubmittedFileName();
                    part.write(uploadPath + File.separator + sampleImageName);
                    sampleImages.add(UPLOAD_DIRECTORY + "/" + sampleImageName);
                }
            }

            // Save product
            ProductDTO product = new ProductDTO();
            product.setName(productName);
            product.setCategory(productCategory);
            product.setPrice(productPrice);
            product.setStock(stock);
            product.setMainImage(mainImagePath);
            product.setSampleImages(sampleImages);

            boolean isSaved = productBO.saveProduct(product, ds);

            if (isSaved) {
                resp.sendRedirect("adminDashboard.jsp?status=success");
            } else {
                resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error saving product.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error: " + e.getMessage());
        }
    }



    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ServletContext servletContext = req.getServletContext();
        BasicDataSource ds = (BasicDataSource) servletContext.getAttribute("datasource");


        try {
            // Fetch categories using the service layer
            List<String> categories = productBO.fetchCategories(ds);

            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");

            // Create a map to hold the categories data
            Map<String, Object> data = new HashMap<>();
            data.put("categorySelect", categories);  // Add categories to the response data

            // Convert the map to JSON using a library like Gson
            Gson gson = new Gson();
            String jsonResponse = gson.toJson(data);

            // Send the JSON response
            resp.getWriter().write(jsonResponse);
        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch categories", e);
        }
    }

}
