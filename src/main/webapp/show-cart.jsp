<%--
  Created by IntelliJ IDEA.
  User: shima
  Date: 1/24/2025
  Time: 7:54 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.Map" %>
<%@ page import="lk.ijse.ecommerce.dto.ProductDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container my-5">
    <h1 class="text-center mb-4">Shopping Cart</h1>
    <%
        Map<Integer, ProductDTO> cart = (Map<Integer, ProductDTO>) session.getAttribute("cart");
        if (cart != null && !cart.isEmpty()) {
    %>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>Product Name</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Total</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            double grandTotal = 0;
            for (ProductDTO product : cart.values()) {
                double total = product.getPrice() * product.getQty();
                grandTotal += total;
        %>
        <tr>
            <td><%= product.getName() %></td>
            <td>Rs.<%= product.getPrice() %></td>
            <td>
                <form action="show-cart" method="post" class="d-inline">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="productId" value="<%= product.getId() %>">
                    <input type="number" name="quantity" value="<%= product.getQty() %>" min="1" max="10" style="width: 60px;">
                    <button type="submit" class="btn btn-primary btn-sm">Update</button>
                </form>
            </td>
            <td>Rs.<%= total %></td>
            <td>
                <form action="remove-cart.jsp" method="post" class="d-inline">
                    <input type="hidden" name="action" value="remove">
                    <input type="hidden" name="productId" value="<%= product.getId() %>">
                    <button type="submit" class="btn btn-danger btn-sm">Remove</button>
                </form>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
        <tfoot>
        <tr>
            <th colspan="3" class="text-end">Grand Total</th>
            <th colspan="2">Rs.<%= grandTotal %></th>
        </tr>
        </tfoot>
    </table>
    <div class="text-end">
        <a href="checkout.jsp" class="btn btn-success">Proceed to Checkout</a>
    </div>
    <%
    } else {
    %>
    <div class="alert alert-warning text-center" role="alert">
        Your cart is empty!
    </div>
    <%
        }
    %>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
