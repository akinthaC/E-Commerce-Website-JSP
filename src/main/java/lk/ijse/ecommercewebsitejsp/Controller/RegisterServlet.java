package lk.ijse.ecommercewebsitejsp.Controller;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.ecommercewebsitejsp.BO.BOFactory;
import lk.ijse.ecommercewebsitejsp.BO.custome.UserBO;
import lk.ijse.ecommercewebsitejsp.DTO.UserDTO;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;

@WebServlet(name = "/RegisterServlet",value = "/Register-Servlet")
public class RegisterServlet extends HttpServlet {

    UserBO userBO = (UserBO) BOFactory.getBoFactory().GetBo(BOFactory.BOType.USER);

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ServletContext servletContext = req.getServletContext();
        BasicDataSource ds = (BasicDataSource) servletContext.getAttribute("datasource");

        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phone = req.getParameter("contact");
        String role = "User";
        String username = req.getParameter("username");
        String name = req.getParameter("name");
        System.out.println("Received Username: " + username);
        try {

            UserDTO userDTO = new UserDTO(name,username, password, email, phone, role);
            System.out.println(userDTO.getUsername());
            System.out.println(name+" " +username + " " + password + " " + email + " " + phone + " " + role);

            boolean isRegistered = userBO.Register(userDTO, ds);

            if (isRegistered) {
                req.setAttribute("message", "Registration successful!");
                req.setAttribute("alertType", "success");
            } else {
                req.setAttribute("message", "Registration failed. Please try again.");
                req.setAttribute("alertType", "danger");
            }


        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ServletContext servletContext = req.getServletContext();
        BasicDataSource ds = (BasicDataSource) servletContext.getAttribute("datasource");

        String username = req.getParameter("username");
        System.out.println(req.getServerName());

        try {
            UserDTO existingUser = userBO.SearchByName(username, ds);

            if (existingUser != null) {
                resp.getWriter().write("true");

            } else {
                resp.getWriter().write("false"); // Username available
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }
}
