package lk.ijse.ecommerce.controller.user;

import jakarta.annotation.Resource;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


import javax.sql.DataSource;
import java.io.*;
import java.sql.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection conn = dataSource.getConnection()) {
            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                stmt.setString(2, password);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        // User found, create a session and redirect to dashboard
                        HttpSession session = request.getSession();
                        session.setAttribute("username", username);
                        response.sendRedirect("index");
                    } else {
                        // User not found, show error message
                        request.setAttribute("errorMessage", "Invalid username or password");
                        RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
                        dispatcher.forward(request, response);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}

