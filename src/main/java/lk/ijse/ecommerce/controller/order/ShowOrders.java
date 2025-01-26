package lk.ijse.ecommerce.controller.order;

import jakarta.annotation.Resource;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import lk.ijse.ecommerce.dto.OrderDetailDTO;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import lk.ijse.ecommerce.dto.OrderDetailDTO;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ShowOrders", value = "/show-orders")
public class ShowOrders extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<OrderDetailDTO> orderDetails = new ArrayList<>();

        try (Connection connection = dataSource.getConnection()) {
            String sql = "SELECT od.order_id, o.order_date, od.product_id, p.name AS product_name, od.quantity, od.price, od.total " +
                    "FROM orders o " +
                    "JOIN order_details od ON o.id = od.order_id " +
                    "JOIN products p ON od.product_id = p.id;";
            try (PreparedStatement stmt = connection.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    OrderDetailDTO orderDetail = new OrderDetailDTO();
                    orderDetail.setOrder_id(rs.getInt("order_id"));
                    orderDetail.setDate(rs.getTimestamp("order_date"));
                    orderDetail.setProduct_id(rs.getInt("product_id"));
//                    orderDetail.setProductName(rs.getString("product_name"));
                    orderDetail.setQuantity(rs.getInt("quantity"));
                    orderDetail.setPrice(rs.getDouble("price"));
                    orderDetail.setTotal(rs.getDouble("total"));

                    orderDetails.add(orderDetail);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Pass the data to the JSP page
        request.setAttribute("orderDetails", orderDetails);
        RequestDispatcher dispatcher = request.getRequestDispatcher("show-orders.jsp");
        dispatcher.forward(request, response);
    }
}
