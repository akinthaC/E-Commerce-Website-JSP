package lk.ijse.ecommercewebsitejsp.Listner;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import org.apache.commons.dbcp2.BasicDataSource;

@WebListener
public class MyListener implements ServletContextListener {
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("contextInitialized");
        BasicDataSource ds = new BasicDataSource();
        ds.setDriverClassName("com.mysql.jdbc.Driver");
        ds.setUrl("jdbc:mysql://localhost:3306/E_Commerce_Website");
        ds.setUsername("root");
        ds.setPassword("Ijse@123");
        ds.setMaxTotal(5);
        ds.setInitialSize(5);

        ServletContext servletContext = sce.getServletContext();
        servletContext.setAttribute("datasource", ds);

        ServletContextHolder.setServletContext(servletContext);
    }

    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("Context Destroyed");
        ServletContext sc = sce.getServletContext();
        BasicDataSource ds = (BasicDataSource) sc.getAttribute("dataSource");

        try {
            ds.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }
}
