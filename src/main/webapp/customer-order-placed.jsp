<%--
  Created by IntelliJ IDEA.
  User: shima
  Date: 1/26/2025
  Time: 11:54 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .confirmation-container {
            margin-top: 30px;
        }
    </style>
</head>
<body>
<div class="container confirmation-container">
    <h2>Order Confirmation</h2>
    <p><strong>Order ID:</strong> ${orderId}</p>
    <p><strong>Order Date:</strong> ${orderDate}</p>
    <p><strong>Status:</strong> ${status}</p>
    <p><strong>Total Amount:</strong> ${totalAmount}</p>

    <a href="customer-product" class="btn btn-primary">Go to Products</a>
</div>
</body>
</html>
