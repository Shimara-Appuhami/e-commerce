package lk.ijse.ecommerce.controller.customer;

import jakarta.annotation.Resource;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.ecommerce.dto.CategoryDTO;
import lk.ijse.ecommerce.dto.ProductDTO;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static lk.ijse.ecommerce.db.DBConnection.dataSource;

@WebServlet(name = "CustomerProductServlet", value = "/customer-product")
public class CustomerProductServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<CategoryDTO> categoryList = new ArrayList<>();
        Map<Integer, List<ProductDTO>> productsByCategory = new HashMap<>();

        try (Connection connection = dataSource.getConnection()) {
            Class.forName("com.mysql.cj.jdbc.Driver");

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
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession(false);
//        if (session == null || session.getAttribute("userId") == null) {
//            response.setContentType("text/html");
//            response.getWriter().println("<script>alert('User is not logged in. Please log in to continue.'); window.location='login.jsp';</script>");
//            return;
//        }
//
//        int userId = (int) session.getAttribute("userId");
//
//        String productId = request.getParameter("productId");
//        String quantityParam = request.getParameter("quantity");
//
//        int productQty = (quantityParam != null) ? Integer.parseInt(quantityParam) : 1;
//
//        if (productId == null) {
//            response.setContentType("text/html");
//            response.getWriter().println("<script>alert('Product ID is required.'); window.history.back();</script>");
//            return;
//        }
//
//        try (Connection conn = dataSource.getConnection()) {
//            String productQuery = "SELECT id, name, price, qty FROM products WHERE id = ?";
//            try (PreparedStatement productStmt = conn.prepareStatement(productQuery)) {
//                productStmt.setInt(1, Integer.parseInt(productId));
//
//                try (ResultSet rs = productStmt.executeQuery()) {
//                    if (rs.next()) {
//                        int productStock = rs.getInt("qty");
//
//                        if (productQty > productStock) {
//                            response.setContentType("text/html");
//                            response.getWriter().println("<script>alert('Insufficient stock available.'); window.history.back();</script>");
//                            return;
//                        }
//
//                        String cartCheckQuery = "SELECT quantity FROM cart WHERE user_id = ? AND product_id = ?";
//                        try (PreparedStatement cartCheckStmt = conn.prepareStatement(cartCheckQuery)) {
//                            cartCheckStmt.setInt(1, userId);
//                            cartCheckStmt.setInt(2, Integer.parseInt(productId));
//
//                            try (ResultSet cartRs = cartCheckStmt.executeQuery()) {
//                                if (cartRs.next()) {
//                                    int existingQty = cartRs.getInt("quantity");
//                                    String updateCartQuery = "UPDATE cart SET quantity = ? WHERE user_id = ? AND product_id = ?";
//                                    try (PreparedStatement updateCartStmt = conn.prepareStatement(updateCartQuery)) {
//                                        updateCartStmt.setInt(1, existingQty + productQty);
//                                        updateCartStmt.setInt(2, userId);
//                                        updateCartStmt.setInt(3, Integer.parseInt(productId));
//                                        updateCartStmt.executeUpdate();
//                                    }
//                                } else {
//                                    String insertCartQuery = "INSERT INTO cart (user_id, product_id, quantity) VALUES (?, ?, ?)";
//                                    try (PreparedStatement insertCartStmt = conn.prepareStatement(insertCartQuery)) {
//                                        insertCartStmt.setInt(1, userId);
//                                        insertCartStmt.setInt(2, Integer.parseInt(productId));
//                                        insertCartStmt.setInt(3, productQty);
//                                        insertCartStmt.executeUpdate();
//                                    }
//                                }
//                            }
//                        }
//                    } else {
//                        response.setContentType("text/html");
//                        response.getWriter().println("<script>alert('Product not found.'); window.history.back();</script>");
//                        return;
//                    }
//                }
//            }
//
//
//            int cartCount = getCartCount(userId);
//            request.setAttribute("cartCount", cartCount);
//
//            response.setContentType("text/html");
//            response.getWriter().println("<script>alert('Product successfully added to cart.'); window.location='customer-product';</script>");
//
//        } catch (SQLException e) {
//            throw new ServletException("Database error", e);
//
//        }
//    }
//    private int getCartCount(int userId) throws SQLException {
//        String cartCountQuery = "SELECT SUM(quantity) AS cartCount FROM cart WHERE user_id = ?";
//        try (Connection conn = dataSource.getConnection();
//             PreparedStatement stmt = conn.prepareStatement(cartCountQuery)) {
//            stmt.setInt(1, userId);
//            try (ResultSet rs = stmt.executeQuery()) {
//                if (rs.next()) {
//                    return rs.getInt("cartCount");
//                }
//            }
//        }return 0;
//}
@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("userId") == null) {
        response.setContentType("text/html");
        response.getWriter().println("<script>alert('User is not logged in. Please log in to continue.'); window.location='login.jsp';</script>");
        return;
    }

    int userId = (int) session.getAttribute("userId");
    String productId = request.getParameter("productId");
    String quantityParam = request.getParameter("quantity");
    int productQty = (quantityParam != null) ? Integer.parseInt(quantityParam) : 1;

    if (productId == null) {
        response.setContentType("text/html");
        response.getWriter().println("<script>alert('Product ID is required.'); window.history.back();</script>");
        return;
    }

    try (Connection conn = dataSource.getConnection()) {
        String productQuery = "SELECT id, name, price, qty FROM products WHERE id = ?";
        try (PreparedStatement productStmt = conn.prepareStatement(productQuery)) {
            productStmt.setInt(1, Integer.parseInt(productId));

            try (ResultSet rs = productStmt.executeQuery()) {
                if (rs.next()) {
                    int productStock = rs.getInt("qty");

                    if (productQty > productStock) {
                        response.setContentType("text/html");
                        response.getWriter().println("<script>alert('Insufficient stock available.'); window.history.back();</script>");
                        return;
                    }

                    String cartCheckQuery = "SELECT quantity FROM cart WHERE user_id = ? AND product_id = ?";
                    try (PreparedStatement cartCheckStmt = conn.prepareStatement(cartCheckQuery)) {
                        cartCheckStmt.setInt(1, userId);
                        cartCheckStmt.setInt(2, Integer.parseInt(productId));

                        try (ResultSet cartRs = cartCheckStmt.executeQuery()) {
                            if (cartRs.next()) {
                                int existingQty = cartRs.getInt("quantity");
                                String updateCartQuery = "UPDATE cart SET quantity = ? WHERE user_id = ? AND product_id = ?";
                                try (PreparedStatement updateCartStmt = conn.prepareStatement(updateCartQuery)) {
                                    updateCartStmt.setInt(1, existingQty + productQty);
                                    updateCartStmt.setInt(2, userId);
                                    updateCartStmt.setInt(3, Integer.parseInt(productId));
                                    updateCartStmt.executeUpdate();
                                }
                            } else {
                                String insertCartQuery = "INSERT INTO cart (user_id, product_id, quantity) VALUES (?, ?, ?)";
                                try (PreparedStatement insertCartStmt = conn.prepareStatement(insertCartQuery)) {
                                    insertCartStmt.setInt(1, userId);
                                    insertCartStmt.setInt(2, Integer.parseInt(productId));
                                    insertCartStmt.setInt(3, productQty);
                                    insertCartStmt.executeUpdate();
                                }
                            }
                        }
                    }
                } else {
                    response.setContentType("text/html");
                    response.getWriter().println("<script>alert('Product not found.'); window.history.back();</script>");
                    return;
                }
            }
        }

        int cartCount = getCartCount(userId);
        session.setAttribute("cartCount", cartCount);

        response.setContentType("text/html");
        response.getWriter().println("<script>alert('Product successfully added to cart.'); window.location='customer-product';</script>");

    } catch (SQLException e) {
        throw new ServletException("Database error", e);
    }
}

    private int getCartCount(int userId) throws SQLException {
        String cartCountQuery = "SELECT SUM(quantity) AS cartCount FROM cart WHERE user_id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(cartCountQuery)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("cartCount");
                }
            }
        }
        return 0;
    }
}
