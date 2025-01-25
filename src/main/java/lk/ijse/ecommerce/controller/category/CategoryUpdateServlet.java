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
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "CategoryUpdateServlet", value = "/category-update")
public class CategoryUpdateServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("category_id"));

        try (Connection connection = dataSource.getConnection()) {
            String sql = "SELECT name, description FROM categories WHERE id = ?";
            try (PreparedStatement pstm = connection.prepareStatement(sql)) {
                pstm.setInt(1, id);
                try (ResultSet rs = pstm.executeQuery()) {
                    if (rs.next()) {
                        req.setAttribute("category_id", id);
                        req.setAttribute("category_name", rs.getString("name"));
                        req.setAttribute("category_description", rs.getString("description"));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Failed to load category data");
        }

        req.getRequestDispatcher("category-update.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("category_id"));
        String name = req.getParameter("category_name");
        String description = req.getParameter("category_description");

        try (Connection connection = dataSource.getConnection()) {
            String sql = "UPDATE categories SET name = ?, description = ? WHERE id = ?";
            try (PreparedStatement pstm = connection.prepareStatement(sql)) {
                pstm.setString(1, name);
                pstm.setString(2, description);
                pstm.setInt(3, id);

                int rowsAffected = pstm.executeUpdate();
                if (rowsAffected > 0) {
                    resp.sendRedirect("index?message=Category updated successfully");
                } else {
                    resp.sendRedirect("category-update.jsp?error=Failed to update category");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("category-update.jsp?error=An unexpected error occurred");
        }
    }
}
