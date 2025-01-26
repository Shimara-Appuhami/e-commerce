package lk.ijse.ecommerce.controller.user;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.ecommerce.dto.UserDTO;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "UserUpdateServlet", value = "/user-update")
public class UserUpdateServlet extends HttpServlet {

    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<UserDTO> users = new ArrayList<>();

        String query = "SELECT id, username,password, email,role, active FROM users";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                UserDTO user = new UserDTO(
                        resultSet.getInt("id"),
                        resultSet.getString("username"),
                        resultSet.getString("password"),
                        resultSet.getString("email"),
                        resultSet.getString("role"),
                        resultSet.getBoolean("active")
                );
                users.add(user);
            }

            request.setAttribute("users", users);
            request.getRequestDispatcher("user-update.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index?message=Error retrieving users");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userId = request.getParameter("userId");
        String action = request.getParameter("action");

        String updateQuery = "UPDATE users SET active = ? WHERE id = ?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement statement = connection.prepareStatement(updateQuery)) {

            if (action.equals("activate")) {
                statement.setString(1, "active");
            } else if (action.equals("deactivate")) {
                statement.setString(1, "inactive");
            }

            statement.setInt(2, Integer.parseInt(userId));
            int rowsUpdated = statement.executeUpdate();

            if (rowsUpdated > 0) {
                response.sendRedirect("user-update");
            } else {
                response.sendRedirect("index?message=Error updating user status");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index?message=Error updating user status");
        }
    }
}
