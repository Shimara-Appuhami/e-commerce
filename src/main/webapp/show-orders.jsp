<%--
  Created by IntelliJ IDEA.
  User: shima
  Date: 1/26/2025
  Time: 3:41 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.List" %>
<%@ page import="lk.ijse.ecommerce.dto.OrderDetailDTO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
        }
        h1 {
            text-align: center;
            color: #333;
            margin-top: 30px;
        }
        .container {
            width: 80%;
            margin: 0 auto;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            border-radius: 8px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
        @media (max-width: 768px) {
            table, th, td {
                font-size: 14px;
            }
            .container {
                width: 95%;
                padding: 10px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Order Details</h1>
    <table>
        <thead>
        <tr>
            <th>Order ID</th>
            <th>Order Date</th>
            <th>Product ID</th>
            <th>Quantity</th>
            <th>Total Price</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<OrderDetailDTO> orderDetails = (List<OrderDetailDTO>) request.getAttribute("orderDetails");
            for (OrderDetailDTO orderDetail : orderDetails) {
        %>
        <tr>
            <td><%= orderDetail.getOrder_id() %></td>
            <td><%= orderDetail.getDate() %></td>
            <td><%= orderDetail.getProduct_id() %></td>
            <td><%= orderDetail.getQuantity() %></td>
            <td><%= orderDetail.getTotal() %></td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
