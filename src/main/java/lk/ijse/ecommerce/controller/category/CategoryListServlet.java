package lk.ijse.ecommerce.controller.category;

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
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
@WebServlet(name = "CategoryListServlet", value = "/index")
public class CategoryListServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    DataSource dataSource;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<CategoryDTO> categoryDTOList = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = dataSource.getConnection();
            String sql = "SELECT * FROM categories";
            Statement stm = connection.createStatement();
            ResultSet rst = stm.executeQuery(sql);
            while (rst.next()) {
                CategoryDTO categoryDTO = new CategoryDTO(
                        rst.getInt(1),
                        rst.getString(2),
                        rst.getString(3)  // Assuming the third column is the image URL
                );
                categoryDTOList.add(categoryDTO);
            }
            req.setAttribute("categories", categoryDTOList);
            RequestDispatcher rd = req.getRequestDispatcher("category-list.jsp");
            rd.forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("category-list.jsp?error=Failed to retrieve categories");
        }
    }
}
