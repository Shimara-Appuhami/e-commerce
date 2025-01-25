package lk.ijse.ecommerce.controller.product;

import jakarta.annotation.Resource;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.ecommerce.dto.CategoryDTO;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
@WebServlet(name = "ProductSaveServlet", value = "/product-save")
public class ProductSaveServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String priceStr = req.getParameter("price");
        String qtyStr = req.getParameter("qty");
        String categoryIdStr = req.getParameter("productCategory");

        try {
            double price = Double.parseDouble(priceStr);
            double qty = Double.parseDouble(qtyStr);
            int categoryId = Integer.parseInt(categoryIdStr);

            Connection connection = dataSource.getConnection();

            String sql = "INSERT INTO products (name, price, qty, category_id) VALUES (?, ?, ?, ?)";
            PreparedStatement pstm = connection.prepareStatement(sql);
            pstm.setString(1, name);
            pstm.setDouble(2, price);
            pstm.setDouble(3, qty);
            pstm.setInt(4, categoryId);

            int effectedRowCount = pstm.executeUpdate();

            if (effectedRowCount > 0) {
                resp.sendRedirect("index?message=Product saved successfully");
            } else {
                resp.sendRedirect("product-save.jsp?error=Failed to save product");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("product-save.jsp?error=Failed to save product");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<CategoryDTO> categories = new ArrayList<>();
        try (Connection connection = dataSource.getConnection()) {
            String sql = "SELECT id, name FROM categories";
            PreparedStatement pstm = connection.prepareStatement(sql);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                CategoryDTO category = new CategoryDTO();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }



        req.setAttribute("categories", categories);
        req.getRequestDispatcher("product-save.jsp").forward(req, resp);
    }
}
