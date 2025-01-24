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

@WebServlet(name = "CategorySaveServlet",value = "/category-save")
public class CategorySaveServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("category_name");
        String description = req.getParameter("category_description");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = dataSource.getConnection(

            );
            String sql = "INSERT INTO categories (name,description) VALUES (?,?)";
            PreparedStatement pstm = connection.prepareStatement(sql);
            pstm.setString(1, name);
            pstm.setString(2, description);
            int effectedRowCount = pstm.executeUpdate();
            if (effectedRowCount > 0) {
                resp.sendRedirect(
                        "index?message=Category saved successfully"
                );
            } else {
                resp.sendRedirect(
                        "category-save.jsp?error=Fail to save category"
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(
                    "category-save.jsp?error=Fail to save category"
            );
        }
    }
}
