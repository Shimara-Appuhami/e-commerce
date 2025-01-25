package lk.ijse.ecommerce.controller.category;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "CategoryDeleteServlet", urlPatterns = "/category-delete")
public class CategoryDeleteServlet extends HttpServlet {

    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoryId = request.getParameter("categoryId");

        if (categoryId == null || categoryId.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Category ID is required.");
            return;
        }

        try (Connection connection = dataSource.getConnection()) {
            String deleteQuery = "DELETE FROM categories WHERE id = ?";
            try (PreparedStatement ps = connection.prepareStatement(deleteQuery)) {
                ps.setInt(1, Integer.parseInt(categoryId));
                int rowsAffected = ps.executeUpdate();

                if (rowsAffected > 0) {
                    response.sendRedirect("index?message=Category deleted successfully");
                } else {
                    response.sendRedirect("category-list.jsp?error=Category not found");
                }
            }
        } catch (NumberFormatException e) {
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
