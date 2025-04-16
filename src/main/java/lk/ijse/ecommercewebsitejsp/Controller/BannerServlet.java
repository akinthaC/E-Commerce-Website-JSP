package lk.ijse.ecommercewebsitejsp.Controller;



import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.*;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import lk.ijse.ecommercewebsitejsp.BO.BOFactory;
import lk.ijse.ecommercewebsitejsp.BO.custome.BannerBO;
import lk.ijse.ecommercewebsitejsp.BO.custome.CategoryBO;
import lk.ijse.ecommercewebsitejsp.DTO.BannerDTO;
import org.apache.commons.dbcp2.BasicDataSource;
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
@WebServlet(name = "/AddBannerServlet",value = "/AddBanner-Servlet")

public class BannerServlet extends HttpServlet {
    BannerBO bannerBO = (BannerBO) BOFactory.getBoFactory().GetBo(BOFactory.BOType.BANNER);

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        ServletContext servletContext = req.getServletContext();
        BasicDataSource ds = (BasicDataSource) servletContext.getAttribute("datasource");

        // Handle file upload
        Part filePart = req.getPart("image");
        String fileName = filePart.getSubmittedFileName();
        String filePath = "assets/uploads/" + fileName;

        // Save the uploaded file
        String uploadDir = getServletContext().getRealPath("") + File.separator + filePath;
        File uploadDirectory = new File(getServletContext().getRealPath("") + File.separator + "assets/uploads");
        if (!uploadDirectory.exists()) {
            uploadDirectory.mkdirs();
        }

        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, Paths.get(uploadDir), StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "Failed to upload the image.");
            req.getRequestDispatcher("/addBanner.jsp").forward(req, resp);
            return;
        }

        BannerDTO bannerDTO=new BannerDTO(title,description,fileName);
        // Call the BannerService to add the banner
        boolean success = bannerBO.addBanner(bannerDTO,ds);

        if (success) {
            resp.sendRedirect("bannerList.jsp");  // Redirect to banner list after success
        } else {
            req.setAttribute("errorMessage", "Failed to add banner.");
            req.getRequestDispatcher("/addBanner.jsp").forward(req, resp);
        }
    }

}
