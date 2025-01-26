<%@ page import="java.math.BigDecimal" %><%--
  Created by IntelliJ IDEA.
  User: shima
  Date: 1/25/2025
  Time: 8:39 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="lk.ijse.ecommerce.dto.CartDTO" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- SweetAlert2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.5.0/dist/sweetalert2.min.css" rel="stylesheet">
    <!-- SweetAlert2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.5.0/dist/sweetalert2.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
        }

        .container {
            margin-top: 50px;
            max-width: 600px;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h1 {
            font-size: 2rem;
            color: #28a745;
            text-align: center;
            margin-bottom: 20px;
        }

        p {
            font-size: 1.2rem;
            color: #333;
            text-align: center;
        }

        .btn {
            display: block;
            width: 100%;
            font-size: 1rem;
            padding: 10px;
            margin-top: 20px;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .btn-success {
            background-color: #28a745;
            border-color: #28a745;
        }

        .btn-success:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Review Your Order</h2>

    <!-- Order Form -->
    <form action="checkout" method="POST">
        <div class="order-summary">
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>Product</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Total</th>
                </tr>
                </thead>
                <tbody>
                <%
                    List<CartDTO> cartItems = (List<CartDTO>) request.getAttribute("cartItems");
                    for (CartDTO cartItem : cartItems) {
                %>
                <tr>
                    <td><%= cartItem.getProduct_id().getName() %></td>
                    <td><%= cartItem.getQuantity() %></td>
                    <td><%= cartItem.getProduct_id().getPrice() %></td>
                    <td><%= cartItem.getTotalPrice() %></td>
                </tr>
                <!-- Hidden Inputs for each cart item, outside the table -->
                <input type="hidden" name="product_id<%= cartItem.getProduct_id().getId() %>" value="<%= cartItem.getProduct_id().getId() %>">
                <input type="hidden" name="quantity<%= cartItem.getProduct_id().getId() %>" value="<%= cartItem.getQuantity() %>">
                <input type="hidden" name="price<%= cartItem.getProduct_id().getId() %>" value="<%= cartItem.getProduct_id().getPrice() %>">
                <% } %>
                </tbody>
            </table>

            <!-- Total Amount -->
            <div class="total-amount">
                <p><strong>Total Amount: </strong><%= request.getAttribute("totalAmount") %></p>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn btn-primary btn-submit">Place Order</button>
        </div>
    </form>
    <script type="text/javascript">
        <% if (request.getAttribute("orderPlaced") != null && (Boolean) request.getAttribute("orderPlaced")) { %>
        Swal.fire({
            title: 'Order Placed Successfully!',
            text: 'Your order has been successfully placed and is pending.',
            icon: 'success',
            confirmButtonText: 'OK'
        });
        <% } %>

        <% if (request.getAttribute("orderFailed") != null && (Boolean) request.getAttribute("orderFailed")) { %>
        Swal.fire({
            title: 'Oops!',
            text: 'An error occurred while processing your order. Please try again.',
            icon: 'error',
            confirmButtonText: 'OK'
        });
        <% } %>
    </script>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>