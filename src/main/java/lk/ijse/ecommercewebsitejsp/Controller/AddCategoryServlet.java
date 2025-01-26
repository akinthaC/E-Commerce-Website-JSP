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
import lk.ijse.ecommercewebsitejsp.DTO.CategoryDTO;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
@WebServlet(name = "AddCategoryServlet", value = "/AddCategory-Servlet")
public class AddCategoryServlet extends HttpServlet {
   CategoryBO categoryBO = (CategoryBO) BOFactory.getBoFactory().GetBo(BOFactory.BOType.CATEGORY);
    private static final String UPLOAD_DIRECTORY = "assets/uploads";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Get the DataSource from ServletContext
        ServletContext servletContext = req.getServletContext();
        BasicDataSource ds = (BasicDataSource) servletContext.getAttribute("datasource");

        // Retrieve category data from the form
        String categoryName = req.getParameter("categoryName");
        String description = req.getParameter("description");

        // Handle file upload (category image)
        Part filePart = req.getPart("image"); // The "image" part from the form
        String fileName = Path.of(filePart.getSubmittedFileName()).getFileName().toString();

        // Define the path to save the uploaded file
        String uploadPath = req.getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();  // Create directory if not exists
        }

        // Write the file to the directory
        filePart.write(uploadPath + File.separator + fileName);
        String mainImagePath = UPLOAD_DIRECTORY + "/" + fileName;  // Store relative path

        // Create a CategoryDTO and set data
        CategoryDTO categoryDTO = new CategoryDTO();
        categoryDTO.setCategoryName(categoryName);
        categoryDTO.setDescription(description);
        categoryDTO.setImage(mainImagePath); // Save relative image path to the database

        // Use CategoryBO to save category to the database
        boolean isSaved = categoryBO.addCategory(categoryDTO, ds);

        if (isSaved) {
            // Redirect to category list page if saved successfully
            resp.sendRedirect("categoryList.jsp?status=success");
        } else {
            // If there is an error saving, redirect with error status
            resp.sendRedirect("categoryList.jsp?status=error");
        }
    }
}
