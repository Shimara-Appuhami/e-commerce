package lk.ijse.ecommerce.controller.customer;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.*;

import javax.sql.DataSource;

@WebServlet(name = "CheckoutServlet", value = "/checkout")
public class CheckoutServlet extends HttpServlet {

    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement insertOrderStmt = null;
        PreparedStatement insertOrderDetailsStmt = null;
        PreparedStatement clearCartStmt = null;
        ResultSet generatedKeys = null;

        try {
            Integer userId = (Integer) request.getSession().getAttribute("userId");
            if (userId == null) {
                throw new IllegalArgumentException("User ID is missing in the session.");
            }

            String totalParam = request.getParameter("total");
            if (totalParam == null || totalParam.isEmpty()) {
                throw new IllegalArgumentException("Total amount is missing in the request.");
            }

            BigDecimal total = new BigDecimal(totalParam);

            conn = dataSource.getConnection();
            conn.setAutoCommit(false);

            String insertOrderQuery = "INSERT INTO orders (user_id, order_date, total) VALUES (?, ?, ?)";
            insertOrderStmt = conn.prepareStatement(insertOrderQuery, PreparedStatement.RETURN_GENERATED_KEYS);
            insertOrderStmt.setInt(1, userId);
            insertOrderStmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            insertOrderStmt.setBigDecimal(3, total);
            insertOrderStmt.executeUpdate();

            generatedKeys = insertOrderStmt.getGeneratedKeys();
            if (!generatedKeys.next()) {
                throw new SQLException("Failed to retrieve the generated order ID.");
            }
            int orderId = generatedKeys.getInt(1);

            String fetchCartQuery = "SELECT product_id, quantity, price FROM cart WHERE user_id = ?";
            try (PreparedStatement fetchCartStmt = conn.prepareStatement(fetchCartQuery)) {
                fetchCartStmt.setInt(1, userId);
                try (ResultSet cartRs = fetchCartStmt.executeQuery()) {
                    String insertOrderDetailsQuery = "INSERT INTO order_details (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
                    insertOrderDetailsStmt = conn.prepareStatement(insertOrderDetailsQuery);

                    while (cartRs.next()) {
                        int productId = cartRs.getInt("product_id");
                        int quantity = cartRs.getInt("quantity");
                        BigDecimal price = cartRs.getBigDecimal("price");

                        insertOrderDetailsStmt.setInt(1, orderId);
                        insertOrderDetailsStmt.setInt(2, productId);
                        insertOrderDetailsStmt.setInt(3, quantity);
                        insertOrderDetailsStmt.setBigDecimal(4, price);
                        insertOrderDetailsStmt.addBatch();
                    }
                    insertOrderDetailsStmt.executeBatch();
                }
            }

            String clearCartQuery = "DELETE FROM cart WHERE user_id = ?";
            clearCartStmt = conn.prepareStatement(clearCartQuery);
            clearCartStmt.setInt(1, userId);
            clearCartStmt.executeUpdate();

            conn.commit();

            response.sendRedirect("checkoutSuccess.jsp");

        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            e.printStackTrace();
            response.sendRedirect("checkoutError.jsp");
        }
    }
}
