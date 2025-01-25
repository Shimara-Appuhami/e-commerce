package lk.ijse.ecommerce.controller.customer;
import jakarta.annotation.Resource;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.ecommerce.dto.CartDTO;
import lk.ijse.ecommerce.dto.ProductDTO;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CustomerCartItemsServlet", value = "/show-cart-items")
public class CustomerCartItemsServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            System.out.println("User ID is null. Redirecting to login page.");
            resp.sendRedirect("login.jsp");
            return;
        }

        List<CartDTO> cartItems = new ArrayList<>();

        try (Connection connection = dataSource.getConnection()) {
            String sql = "SELECT id, product_id, quantity FROM cart WHERE user_id = ?";
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    int productId = rs.getInt("product_id");
                    ProductDTO product = getProductById(productId);  // Fetch product details
                    int quantity = rs.getInt("quantity");
                    double totalPrice = product.getPrice() * quantity;  // Multiply using double
                    CartDTO cartItem = new CartDTO(
                            rs.getInt("id"),
                            userId,
                            product,
                            quantity,
                            totalPrice
                    );
                    cartItems.add(cartItem);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "Error while fetching cart items.");
            RequestDispatcher rd = req.getRequestDispatcher("errorPage.jsp");
            rd.forward(req, resp);
            return;
        }

        session.setAttribute("cart", cartItems);

        req.setAttribute("cartItems", cartItems);
        RequestDispatcher rd = req.getRequestDispatcher("show-cart-items.jsp");
        rd.forward(req, resp);
    }

//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        HttpSession session = req.getSession();
//        Integer userId = (Integer) session.getAttribute("userId");
//
//        if (userId == null) {
//            System.out.println("User ID is null. Redirecting to login page.");
//            resp.sendRedirect("login.jsp");
//            return;
//        }
//
//        String action = req.getParameter("action");
//
//        try (Connection connection = dataSource.getConnection()) {
//            if ("add".equals(action)) {
//                int productId = Integer.parseInt(req.getParameter("productId"));
//                int quantity = Integer.parseInt(req.getParameter("quantity"));
//
//                if (productId <= 0 || quantity <= 0) {
//                    req.setAttribute("errorMessage", "Invalid product or quantity.");
//                    RequestDispatcher rd = req.getRequestDispatcher("errorPage.jsp");
//                    rd.forward(req, resp);
//                    return;
//                }
//
//                addProductToCart(connection, userId, productId, quantity);
//
//            } else if ("update".equals(action)) {
//                int cartId = Integer.parseInt(req.getParameter("cartId"));
//                int quantity = Integer.parseInt(req.getParameter("quantity"));
//                updateCartQuantity(connection, cartId, quantity);
//
//            } else if ("remove".equals(action)) {
//                int cartId = Integer.parseInt(req.getParameter("cartId"));
//                removeProductFromCart(connection, cartId);
//            }
//
//            List<CartDTO> updatedCartItems = getCartItemsFromDatabase(connection, userId);
//            session.setAttribute("cart", updatedCartItems);
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//            req.setAttribute("errorMessage", "Error while updating the cart.");
//            RequestDispatcher rd = req.getRequestDispatcher("errorPage.jsp");
//            rd.forward(req, resp);
//            return;
//        }
//
//        resp.sendRedirect("show-cart-items.jsp");
//    }

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
                                        updateCartStmt.setInt(1, existingQty+productQty );
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
            request.setAttribute("cartCount", cartCount);

            response.setContentType("text/html");
            response.getWriter().println("<script>alert('Product successfully added to cart.'); window.location='show-cart-items';</script>");

        } catch (SQLException e) {
            throw new ServletException("Database error", e);

        }
    }

//    private List<CartDTO> getCartItemsFromDatabase(Connection connection, int userId) throws SQLException {
//        List<CartDTO> cartItems = new ArrayList<>();
//        String sql = "SELECT id, product_id, quantity FROM cart WHERE user_id = ?";
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ps.setInt(1, userId);
//            ResultSet rs = ps.executeQuery();
//
//            while (rs.next()) {
//                int productId = rs.getInt("product_id");
//                ProductDTO product = getProductById(productId);  // Fetch product details
//                int quantity = rs.getInt("quantity");
//                double totalPrice = product.getPrice() * quantity;  // Multiply using double
//                CartDTO cartItem = new CartDTO(
//                        rs.getInt("id"),
//                        userId,
//                        product,
//                        quantity,
//                        totalPrice  // Set the total price as BigDecimal
//                );
//                cartItems.add(cartItem);
//            }
//        }
//        return cartItems;
//    }


    private ProductDTO getProductById(int productId) throws SQLException {
        ProductDTO product = null;
        try (Connection connection = dataSource.getConnection()) {
            String sql = "SELECT id, name, price ,qty FROM products WHERE id = ?";
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setInt(1, productId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    product = new ProductDTO(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getDouble("price"),
                            rs.getInt("qty")
                    );
                }
            }
        }
        return product;
    }


//    private void addProductToCart(Connection connection, int userId, int productId, int quantity) throws SQLException {
//        String sql = "INSERT INTO cart (user_id, product_id, quantity) VALUES (?, ?, ?)";
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ps.setInt(1, userId);
//            ps.setInt(2, productId);
//            ps.setInt(3, quantity);
//            ps.executeUpdate();
//        }
//    }
//
//    private void updateCartQuantity(Connection connection, int cartId, int quantity) throws SQLException {
//        String sql = "UPDATE cart SET quantity = ? WHERE id = ?";
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ps.setInt(1, quantity);
//            ps.setInt(2, cartId);
//            ps.executeUpdate();
//        }
//    }
//
    private void removeProductFromCart(Connection connection, int cartId) throws SQLException {
        String sql = "DELETE FROM cart WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            ps.executeUpdate();
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