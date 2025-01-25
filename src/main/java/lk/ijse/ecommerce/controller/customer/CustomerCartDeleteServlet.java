package lk.ijse.ecommerce.controller.customer;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.ecommerce.dto.CartDTO;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
@WebServlet(name = "CustomerCartDeleteServlet",value = "/show-cart-item-delete")
public class CustomerCartDeleteServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false); // false to prevent creating a new session if it doesn't exist
        if (session == null || session.getAttribute("userId") == null) {
            resp.setContentType("text/html");
            resp.getWriter().println("<script>alert('User is not logged in. Please log in to continue.'); window.location='login.jsp';</script>");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String action = req.getParameter("action");

        try (Connection conn = dataSource.getConnection()) {
            if ("remove".equals(action)) {
                String cartIdParam = req.getParameter("cartId");
                if (cartIdParam != null) {
                    int cartId = Integer.parseInt(cartIdParam);

                    String deleteCartQuery = "DELETE FROM cart WHERE id = ? AND user_id = ?";
                    try (PreparedStatement deleteStmt = conn.prepareStatement(deleteCartQuery)) {
                        deleteStmt.setInt(1, cartId);
                        deleteStmt.setInt(2, userId);
                        deleteStmt.executeUpdate();
                        resp.getWriter().println("<script>alert('Item remove successfully.');</script>");
                    }

                    resp.sendRedirect("show-cart-items");


                } else {
                    resp.setContentType("text/html");
                    resp.getWriter().println("<script>alert('Cart ID is required to remove an item.'); window.history.back();</script>");
                }
            } else {
                resp.setContentType("text/html");
                resp.getWriter().println("<script>alert('Invalid action.'); window.history.back();</script>");
            }
        } catch (SQLException e) {
            throw new ServletException("Database error while removing item from cart", e);
        }
    }

}
