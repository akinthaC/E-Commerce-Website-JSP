package lk.ijse.ecommercewebsitejsp.Controller;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.ecommercewebsitejsp.DTO.UserDTO;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "/addToCart",value = "/addToCart-servlet")
public class AddToCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        ServletContext servletContext = request.getServletContext();
        BasicDataSource ds = (BasicDataSource) servletContext.getAttribute("datasource");

        HttpSession session = request.getSession();

// Retrieve the userId from the session
        String userId = (String) session.getAttribute("userId");
        System.out.println(userId);

        if (userId == null) {
            response.sendRedirect("login.jsp");  // Redirect to login page if no user is found
            return;
        }


        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));



        System.out.println(userId+" "+productId+" "+quantity);

        // Ensure valid quantity and product ID
        if (quantity > 0 && productId > 0) {
            try {
                // Insert the cart item into the database (example query)
                String query = "INSERT INTO cart (user_id, product_id, quantity) VALUES (?, ?, ?)";
                try (Connection connection = ds.getConnection();
                     PreparedStatement stmt = connection.prepareStatement(query)) {
                    stmt.setInt(1, Integer.parseInt(userId));
                    stmt.setInt(2, productId);
                    stmt.setInt(3, quantity);
                    int rowsAffected = stmt.executeUpdate();
                    if (rowsAffected > 0) {
                        // Successfully added to the cart
                        response.sendRedirect("cart.jsp");  // Redirect to the cart page
                    } else {
                        response.sendRedirect("error.jsp");  // Handle error if no rows were affected
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp");
            }
        }
    }
}
