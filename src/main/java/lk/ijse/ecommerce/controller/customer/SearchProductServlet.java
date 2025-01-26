package lk.ijse.ecommerce.controller.customer;

import jakarta.annotation.Resource;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.ecommerce.HelloServlet;
import lk.ijse.ecommerce.dto.CategoryDTO;
import lk.ijse.ecommerce.dto.ProductDTO;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
@WebServlet(name = "SearchProductServlet", value = "/search-product")
public class SearchProductServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");
        double minPrice = 0;
        double maxPrice = Double.MAX_VALUE;

        try {
            if (request.getParameter("minPrice") != null) {
                minPrice = Double.parseDouble(request.getParameter("minPrice"));
            }
            if (request.getParameter("maxPrice") != null) {
                maxPrice = Double.parseDouble(request.getParameter("maxPrice"));
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        List<CategoryDTO> categories = new ArrayList<>();
        Map<Integer, List<ProductDTO>> productsByCategory = new HashMap<>();

        try (Connection connection = dataSource.getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM categories")) {

            while (rs.next()) {
                CategoryDTO category = new CategoryDTO();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        StringBuilder sql = new StringBuilder("SELECT * FROM products WHERE name LIKE CONCAT('%', ?, '%')");

        if (minPrice > 0) {
            sql.append(" AND price >= ?");
        }

        if (maxPrice < Double.MAX_VALUE) {
            sql.append(" AND price <= ?");
        }

        try (Connection connection = dataSource.getConnection()) {
            try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
                stmt.setString(1, query);

                int parameterIndex = 2;

                if (minPrice > 0) {
                    stmt.setDouble(parameterIndex++, minPrice);
                }
                if (maxPrice < Double.MAX_VALUE) {
                    stmt.setDouble(parameterIndex, maxPrice);
                }

                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        ProductDTO product = new ProductDTO();
                        product.setId(rs.getInt("id"));
                        product.setName(rs.getString("name"));
                        product.setPrice(rs.getDouble("price"));
                        product.setQty(rs.getInt("qty"));
                        product.setCategory_id(rs.getInt("category_id"));
                        product.setImage_path(rs.getString("image_path"));

                        productsByCategory
                                .computeIfAbsent(product.getCategory_id(), k -> new ArrayList<>())
                                .add(product);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("categories", categories);
        request.setAttribute("productsByCategory", productsByCategory);

        // Forward to the JSP page to display the results
        RequestDispatcher dispatcher = request.getRequestDispatcher("customer-product.jsp");
        dispatcher.forward(request, response);
    }
}
