package lk.ijse.ecommerce.controller.customer;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.ecommerce.dto.ProductDTO;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "CustomerCart", urlPatterns = {"/show-cart"})
public class CustomerCart extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve product ID and quantity
        String productId = request.getParameter("productId");
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Retrieve the session
        HttpSession session = request.getSession();

        // Update cart total
        Integer cartTotal = (Integer) session.getAttribute("cartTotal");
        if (cartTotal == null) {
            cartTotal = 0;
        }
        cartTotal += quantity;

        // Save updated total back to the session
        session.setAttribute("cartTotal", cartTotal);

        // Redirect back to the product page
        response.sendRedirect("customer-product");
    }
}