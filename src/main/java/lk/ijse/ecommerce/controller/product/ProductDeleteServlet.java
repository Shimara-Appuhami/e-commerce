package lk.ijse.ecommerce.controller.product;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.sql.DataSource;

@WebServlet(name = "ProductDeleteServlet", urlPatterns = "/product-delete")
public class ProductDeleteServlet extends HttpServlet {

    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productId = request.getParameter("productId");

        if (productId == null || productId.isEmpty()) {
            response.sendRedirect("product-list.jsp?error=Invalid Product ID");
            return;
        }

        try (Connection connection = dataSource.getConnection()) {
            // SQL query to delete the product
            String deleteQuery = "DELETE FROM products WHERE id = ?";
            try (PreparedStatement ps = connection.prepareStatement(deleteQuery)) {
                ps.setInt(1, Integer.parseInt(productId));
                int rowsAffected = ps.executeUpdate();

                if (rowsAffected > 0) {
                    response.sendRedirect("product-list.jsp?message=Product deleted successfully");
                } else {
                    response.sendRedirect("product-list.jsp?error=Product not found");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("product-list.jsp?error=Error deleting product");
        }
    }
}
