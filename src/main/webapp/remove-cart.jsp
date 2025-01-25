<%@ page import="java.util.Map" %><%--
  Created by IntelliJ IDEA.
  User: shima
  Date: 1/24/2025
  Time: 7:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>

<%
    String productId = request.getParameter("productId");
    Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");

    if (cart != null && cart.containsKey(Integer.parseInt(productId))) {
        cart.remove(Integer.parseInt(productId));
    }

    response.sendRedirect("show-cart.jsp");
%>

