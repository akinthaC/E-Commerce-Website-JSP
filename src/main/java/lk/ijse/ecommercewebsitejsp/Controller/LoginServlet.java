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
import lk.ijse.ecommercewebsitejsp.PasswordUtil;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;
import java.net.URLEncoder;


@WebServlet(name = "/LoginServlet",value = "/Login-Servlet")
public class LoginServlet extends HttpServlet {
    UserBO userBO = (UserBO) BOFactory.getBoFactory().GetBo(BOFactory.BOType.USER);

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ServletContext servletContext = req.getServletContext();
        BasicDataSource ds = (BasicDataSource) servletContext.getAttribute("datasource");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        System.out.println(username);
        System.out.println(password);


        if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
            resp.sendRedirect("index.jsp?error=Username and password are required");
            return;
        }

        try {
            UserDTO existingUser = userBO.SearchByName(username, ds);
            boolean passwordCheck;

            // Log username and name if the user exists
            if (existingUser != null) {
                System.out.println(existingUser.getUsername());
                System.out.println(existingUser.getPassword());

                passwordCheck = PasswordUtil.checkPassword(password, existingUser.getPassword());
                String type = existingUser.getRole();
                String id = String.valueOf(existingUser.getId());
                System.out.println(id);

                if (passwordCheck) {
                    req.getSession().setAttribute("userId", id);
                    req.getSession().setAttribute("currentUser", existingUser);
                    resp.sendRedirect("index.jsp?message=" + URLEncoder.encode("Logged in Successfully", "UTF-8") + "&type=" + type  );
                } else {
                    resp.sendRedirect("index.jsp?error=Invalid password");
                }
            } else {
                resp.sendRedirect("index.jsp?error=User not found");
            }
        } catch (Exception e) {
            // Log the exception for debugging purposes
            e.printStackTrace();

            // Redirect with a more descriptive error message
            resp.sendRedirect("index.jsp?error=An error occurred. Please try again later.");
        }

    }
}
