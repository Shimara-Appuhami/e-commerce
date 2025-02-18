package lk.ijse.ecommerce.controller.product;
import jakarta.annotation.Resource;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.ecommerce.dto.CategoryDTO;
import lk.ijse.ecommerce.dto.ProductDTO;

import javax.sql.DataSource;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ProductServlet", value = "/product-list")
public class ProductListServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<CategoryDTO> categoryList = new ArrayList<>();
        Map<Integer, List<ProductDTO>> productsByCategory = new HashMap<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = dataSource.getConnection();

            // Fetch categories
            String categorySql = "SELECT * FROM categories";
            Statement categoryStatement = connection.createStatement();
            ResultSet categoryResultSet = categoryStatement.executeQuery(categorySql);

            while (categoryResultSet.next()) {
                CategoryDTO category = new CategoryDTO(
                        categoryResultSet.getInt("id"),
                        categoryResultSet.getString("name"),
                        categoryResultSet.getString("description")
                );
                categoryList.add(category);

                String productSql = "SELECT * FROM products WHERE category_id = ?";
                PreparedStatement productStatement = connection.prepareStatement(productSql);
                productStatement.setInt(1, category.getId());
                ResultSet productResultSet = productStatement.executeQuery();

                List<ProductDTO> productList = new ArrayList<>();
                while (productResultSet.next()) {
                    ProductDTO product = new ProductDTO(
                            productResultSet.getInt("id"),
                            productResultSet.getString("name"),
                            productResultSet.getDouble("price"),
                            productResultSet.getDouble("qty"),
                            productResultSet.getInt("category_id"),
                            productResultSet.getString("image_path")
                    );
                    productList.add(product);
                }
                productsByCategory.put(category.getId(), productList);
            }

            req.setAttribute("categories", categoryList);
            req.setAttribute("productsByCategory", productsByCategory);
            RequestDispatcher rd = req.getRequestDispatcher("/product-list.jsp");
            rd.forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("Error: " + e.getMessage());
        }
    }

}
