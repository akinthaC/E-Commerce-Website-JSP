package lk.ijse.ecommercewebsitejsp.Listner;

import jakarta.servlet.ServletContext;

public class ServletContextHolder {
    private static ServletContext servletContext;

    private ServletContextHolder() {
        // Private constructor to prevent instantiation
    }

    public static void setServletContext(ServletContext context) {
        servletContext = context;
    }

    public static ServletContext getServletContext() {
        if (servletContext == null) {
            throw new IllegalStateException("ServletContext has not been initialized.");
        }
        return servletContext;
    }
}
