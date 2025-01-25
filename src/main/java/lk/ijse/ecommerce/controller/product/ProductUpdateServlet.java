package lk.ijse.ecommerce.controller.product;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.ecommerce.dto.CategoryDTO;
import lk.ijse.ecommerce.dto.ProductDTO;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ProductUpdateServlet", value = "/product-update")
public class ProductUpdateServlet extends HttpServlet {

    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productId;
        try {
            productId = Integer.parseInt(req.getParameter("product_id"));
        } catch (NumberFormatException e) {
            resp.sendRedirect("product-update.jsp?error=Invalid product ID");
            return;
        }

        ProductDTO product = null;
        List<CategoryDTO> categories = new ArrayList<>();

        try (Connection connection = dataSource.getConnection()) {
            String productSql = "SELECT id, name, price, qty, category_id FROM products WHERE id = ?";
            try (PreparedStatement pstm = connection.prepareStatement(productSql)) {
                pstm.setInt(1, productId);
                try (ResultSet rs = pstm.executeQuery()) {
                    if (rs.next()) {
                        product = new ProductDTO(
                                rs.getInt("id"),
                                rs.getString("name"),
                                rs.getDouble("price"),
                                rs.getInt("qty"),
                                rs.getInt("category_id")
                        );
                    } else {
                        resp.sendRedirect("product-update.jsp?error=Product not found");
                        return;
                    }
                }
            }

            String categorySql = "SELECT id, name FROM categories";
            try (PreparedStatement pstm = connection.prepareStatement(categorySql);
                 ResultSet rs = pstm.executeQuery()) {
                while (rs.next()) {
                    categories.add(new CategoryDTO(rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("description")));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("error", "Error retrieving product details");
        }

        req.setAttribute("product", product);
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("product-update.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productId, qty, categoryId;
        double price;
        String name = req.getParameter("product_name");

        try {
            productId = Integer.parseInt(req.getParameter("product_id"));
            price = Double.parseDouble(req.getParameter("product_price"));
            qty = Integer.parseInt(req.getParameter("product_qty"));
            categoryId = Integer.parseInt(req.getParameter("category_id"));

            if (name == null || name.trim().isEmpty()) {
                throw new IllegalArgumentException("Product name is required");
            }
        } catch (IllegalArgumentException e) {
            resp.sendRedirect("product-update.jsp?error=" + e.getMessage());
            return;
        }

        try (Connection connection = dataSource.getConnection()) {
            String sql = "UPDATE products SET name = ?, price = ?, qty = ?, category_id = ? WHERE id = ?";
            try (PreparedStatement pstm = connection.prepareStatement(sql)) {
                pstm.setString(1, name);
                pstm.setDouble(2, price);
                pstm.setInt(3, qty);
                pstm.setInt(4, categoryId);
                pstm.setInt(5, productId);

                int rowsAffected = pstm.executeUpdate();
                if (rowsAffected > 0) {
                    resp.sendRedirect("product-update.jsp?message=Product updated successfully");
                } else {
                    resp.sendRedirect("product-update.jsp?error=Failed to update product");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendRedirect("product-update.jsp?error=An unexpected error occurred");
        }
    }
}
