<%@ page import="java.math.BigDecimal" %><%--
  Created by IntelliJ IDEA.
  User: shima
  Date: 1/25/2025
  Time: 8:39 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="checkout" method="post">
  <input type="hidden" name="total" value="<%= session.getAttribute("totalAmount") %>">
  <button type="submit" class="btn btn-primary">Checkout</button>
</form>
<%
  BigDecimal totalAmount = (BigDecimal) session.getAttribute("totalAmount");
%>
<h1>Order Successful!</h1>
<p>Your order total is: $<%= totalAmount %></p>
<a href="home.jsp">Continue Shopping</a>


</body>
</html>
