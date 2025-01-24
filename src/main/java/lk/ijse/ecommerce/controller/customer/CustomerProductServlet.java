package lk.ijse.ecommerce.controller.customer;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.ecommerce.dto.CategoryDTO;
import lk.ijse.ecommerce.dto.ProductDTO;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "CustomerProductServlet", value = "/customer-product")
public class CustomerProductServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/ecommerce";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "harshima@123";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<CategoryDTO> categoryList = new ArrayList<>();
        Map<Integer, List<ProductDTO>> productsByCategory = new HashMap<>();

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Fetch categories
            String categorySql = "SELECT * FROM categories";
            try (Statement categoryStatement = connection.createStatement();
                 ResultSet categoryResultSet = categoryStatement.executeQuery(categorySql)) {

                while (categoryResultSet.next()) {
                    CategoryDTO category = new CategoryDTO(
                            categoryResultSet.getInt("id"),
                            categoryResultSet.getString("name"),
                            categoryResultSet.getString("description")
                    );
                    categoryList.add(category);

                    // Fetch products for each category
                    String productSql = "SELECT * FROM products WHERE category_id = ?";
                    try (PreparedStatement productStatement = connection.prepareStatement(productSql)) {
                        productStatement.setInt(1, category.getId());
                        try (ResultSet productResultSet = productStatement.executeQuery()) {
                            List<ProductDTO> productList = new ArrayList<>();
                            while (productResultSet.next()) {
                                ProductDTO product = new ProductDTO(
                                        productResultSet.getInt("id"),
                                        productResultSet.getString("name"),
                                        productResultSet.getDouble("price"),
                                        productResultSet.getDouble("qty"),
                                        productResultSet.getInt("category_id")
                                );
                                productList.add(product);
                            }
                            productsByCategory.put(category.getId(), productList);
                        }
                    }
                }
            }

            req.setAttribute("categories", categoryList);
            req.setAttribute("productsByCategory", productsByCategory);
            RequestDispatcher rd = req.getRequestDispatcher("customer-product.jsp");
            rd.forward(req, resp);

        } catch (ClassNotFoundException e) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database driver not found.");
            e.printStackTrace();
        } catch (SQLException e) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
