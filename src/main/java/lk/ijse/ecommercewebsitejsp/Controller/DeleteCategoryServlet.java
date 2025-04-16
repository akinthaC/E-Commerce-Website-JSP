package lk.ijse.ecommercewebsitejsp.Controller;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.ecommercewebsitejsp.BO.BOFactory;
import lk.ijse.ecommercewebsitejsp.BO.custome.CategoryBO;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;

@WebServlet(name = "/deleteCategoryServlet" , value = "/DeleteCategory-Servlet")
public class DeleteCategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    CategoryBO categoryBO = (CategoryBO) BOFactory.getBoFactory().GetBo(BOFactory.BOType.CATEGORY);


    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, IOException {
        String categoryId = req.getParameter("id");
        ServletContext servletContext = req.getServletContext();
        BasicDataSource ds = (BasicDataSource) servletContext.getAttribute("datasource");


        // Validate categoryId
        if (categoryId == null || categoryId.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Category ID");
            return;
        }

        try {
            // Call service to delete the category

            boolean isDeleted = categoryBO.deleteCategory(Integer.parseInt(categoryId),ds);

            if (isDeleted) {
                // Redirect to categories page with a success message
                resp.sendRedirect("adminDashboard.jsp?success=Category deleted successfully");
            } else {
                // Redirect to categories page with an error message
                resp.sendRedirect("adminDashboard.jsp?error=Category not found or could not be deleted");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("adminDashboard.jsp?error=An error occurred while deleting the category");
        }
    }
}
