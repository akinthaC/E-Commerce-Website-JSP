package lk.ijse.ecommercewebsitejsp.Controller;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import lk.ijse.ecommercewebsitejsp.BO.BOFactory;
import lk.ijse.ecommercewebsitejsp.BO.custome.CategoryBO;
import lk.ijse.ecommercewebsitejsp.BO.custome.impl.CategoryBOImpl;
import lk.ijse.ecommercewebsitejsp.DTO.CategoryDTO;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;

@MultipartConfig(
                 fileSizeThreshold = 1024 * 1024 * 2,
                 maxFileSize = 1024 * 1024 * 10,
                 maxRequestSize = 1024 * 1024 * 50)
@WebServlet(name = "EditCategoryServlet", value = "/EditCategory-Servlet")
public class EditCategoryServlet extends HttpServlet {
    
    private static final String UPLOAD_DIRECTORY = "assets/uploads";
     CategoryBO categoryBO = (CategoryBO) BOFactory.getBoFactory().GetBo(BOFactory.BOType.CATEGORY);

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ServletContext servletContext = req.getServletContext();
        BasicDataSource ds = (BasicDataSource) servletContext.getAttribute("datasource");

        if (ds == null) {
            resp.getWriter().write("Database connection is not configured properly!");
            return;
        }

        // Retrieve form parameters
        String categoryId = req.getParameter("categoryId");
        String categoryName = req.getParameter("categoryName");
        String categoryDescription = req.getParameter("categoryDescription");

        // Handle file upload
        Part filePart = req.getPart("categoryImage");
        String fileName = null;

        if (filePart != null && filePart.getSize() > 0) {
            fileName = Path.of(filePart.getSubmittedFileName()).getFileName().toString();

            // Upload directory
            String uploadPath = servletContext.getRealPath("") + File.separator + UPLOAD_DIRECTORY;
            File uploadDir = new File(uploadPath);

            // Create directory if it doesn't exist
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Save the file
            filePart.write(uploadPath + File.separator + fileName);
        }

        // Populate CategoryDTO
        CategoryDTO categoryDTO = new CategoryDTO();
        categoryDTO.setCategoryId(Integer.parseInt(categoryId));
        categoryDTO.setCategoryName(categoryName);
        categoryDTO.setDescription(categoryDescription);

        // If a file was uploaded, update the image path
        if (fileName != null) {
            categoryDTO.setImage(UPLOAD_DIRECTORY + "/" + fileName);
        }

        // Update category in the database
        boolean isUpdated = categoryBO.updateCategory(categoryDTO, ds);

        if (isUpdated) {
            resp.sendRedirect("categoryList.jsp"); // Redirect to category list
        } else {
            resp.getWriter().write("Failed to update category!");
        }
    }

}
