package lk.ijse.ecommerce.controller.category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet(name = "CategoryDeleteServlet", value = "/category-delete")
public class CategoryDeleteServlet extends HttpServlet {
    String DB_URL = "jdbc:mysql://localhost:3306/ecommerce";
    String DB_USER = "root";
    String DB_PASSWORD = "harshima@123";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("category_id"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            String sql = "DELETE FROM categories WHERE id = ?";
            PreparedStatement pstm = connection.prepareStatement(sql);
            pstm.setInt(1, id);

            int rowsAffected = pstm.executeUpdate();
            if (rowsAffected > 0) {
                resp.sendRedirect("category-delete.jsp?message=Category deleted successfully");
            } else {
                resp.sendRedirect("category-delete.jsp?error=Failed to delete category");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("category-delete.jsp?error=Failed to delete category");
        }
    }
}
