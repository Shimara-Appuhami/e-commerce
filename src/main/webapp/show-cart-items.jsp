<%--
  Created by IntelliJ IDEA.
  User: shima
  Date: 1/25/2025
  Time: 1:14 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.List" %>


<%@ page import="java.text.DecimalFormat" %>
<%@ page import="lk.ijse.ecommerce.dto.CartDTO" %>
<%@ page import="lk.ijse.ecommerce.dto.ProductDTO" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            color: #333;
            margin: 0;
            padding: 0;
        }

        .container {
            margin-top: 30px;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.5rem;
            color: #007BFF;
        }

        .card {
            margin-bottom: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s ease-in-out;
        }

        .card:hover {
            transform: scale(1.02);
        }

        .card-title {
            color: #007BFF;
            font-size: 1.25rem;
        }

        .card-body {
            padding: 20px;
        }

        .btn {
            font-size: 0.9rem;
        }

        .alert {
            text-align: center;
            padding: 15px;
            font-size: 1.1rem;
            margin-bottom: 30px;
        }

        .checkout-btn {
            text-align: center;
            margin-top: 20px;
        }

        .checkout-btn a {
            font-size: 1.2rem;
            padding: 10px 20px;
        }
    </style>
</head>
<body>
<div class="container">

    <%
        List<CartDTO> cartItems = (List<CartDTO>) request.getAttribute("cartItems");

        if (cartItems == null || cartItems.isEmpty()) {
    %>
    <div class="alert alert-warning" role="alert">
        Your cart is empty.
    </div>
    <div class="checkout-btn">
        <a href="customer-product" class="btn btn-primary">Back to Products</a>
    </div>
    <%
    } else {
    %>
    <div class="row">
        <%
            for (CartDTO item : cartItems) {
                ProductDTO product = item.getProduct_id();
                String formattedPrice = new DecimalFormat("#0.00").format(product.getPrice());
        %>
        <div class="col-md-6 col-lg-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title"><%= product.getName() %></h5>
                    <p class="card-text"><strong>Price:</strong> $<%= formattedPrice %></p>
                    <p class="card-text">
                        <strong>Quantity:</strong>
                    <form method="POST" action="show-cart-items" class="d-inline">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="cartId" value="<%= item.getId() %>">
                        <input type="hidden" name="productId" value="<%= product.getId() %>">
                        <input type="number" name="quantity<%= item.getId() %>" value="<%= item.getQuantity() %>" min="1" class="form-control d-inline w-50">
                        <button type="submit" class="btn btn-primary btn-sm mt-2">Update</button>
                    </form>
                    </p>
                    <form method="POST" action="show-cart-item-delete" onsubmit="return confirm('Are you sure you want to remove this item from the cart?');">
                        <input type="hidden" name="action" value="remove">
                        <input type="hidden" name="cartId" value="<%= item.getId() %>">
                        <button type="submit" class="btn btn-danger btn-sm">Remove</button>
                    </form>
                </div>
            </div>
        </div>
        <%
            }
        %>
    </div>


    <%
        }
    %>

</div>
<form action="checkout" method="POST" >
    <div class="checkout-btn" >
        <a href="checkout" class="btn btn-success"> Checkout</a>
    </div>
</form>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>