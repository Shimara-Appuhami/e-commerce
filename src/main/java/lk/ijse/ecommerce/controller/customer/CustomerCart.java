//package lk.ijse.ecommerce.controller.customer;
//
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import lk.ijse.ecommerce.dto.ProductDTO;
//
//import java.io.IOException;
//import java.util.HashMap;
//import java.util.Map;
//
//@WebServlet(name = "CustomerCart", urlPatterns = {"/show-cart"})
//public class CustomerCart extends HttpServlet {
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession();
//
//        // Retrieve product ID and quantity from the form
//        String productId = request.getParameter("productId");
//        int quantity = Integer.parseInt(request.getParameter("quantity"));
//
//        // Retrieve or initialize the cart
//        Map<String, Integer> cart = (Map<String, Integer>) session.getAttribute("cart");
//        if (cart == null) {
//            cart = new HashMap<>();
//        }
//
//        // Add product to the cart
//        cart.put(productId, cart.getOrDefault(productId, 0) + quantity);
//        session.setAttribute("cart", cart);
//
//        // Update the cart count
//        Integer cartCount = (Integer) session.getAttribute("cartCount");
//        if (cartCount == null) {
//            cartCount = 0;
//        }
//        cartCount += quantity;
//        session.setAttribute("cartCount", cartCount);
//
//        // Redirect back to the product page
//        response.sendRedirect("customer-product.jsp");
//    }
//}