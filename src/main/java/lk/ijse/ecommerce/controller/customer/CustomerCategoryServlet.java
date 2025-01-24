package lk.ijse.ecommerce.controller.customer;

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
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CustomerCategoryServlet", value = "/customer-category")
public class CustomerCategoryServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<CategoryDTO> categoryDTOList = new ArrayList<>();

        try (Connection connection = dataSource.getConnection();
             Statement stm = connection.createStatement();
             ResultSet rst = stm.executeQuery("SELECT id, name, description FROM categories")) {

            while (rst.next()) {
                CategoryDTO categoryDTO = new CategoryDTO(
                        rst.getInt("id"),        // Category ID
                        rst.getString("name"),   // Category Name
                        rst.getString("description")   // Image URL
                );
                categoryDTOList.add(categoryDTO);
            }

            // Attach the category list to the request and forward it to the JSP
            req.setAttribute("categories", categoryDTOList);
            RequestDispatcher rd = req.getRequestDispatcher("customer-category.jsp");
            rd.forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            // Forward to an error page or show an error message
            req.setAttribute("error", "Failed to load categories. Please try again later.");
            req.getRequestDispatcher("error.jsp").forward(req, resp);
        }
    }
}
