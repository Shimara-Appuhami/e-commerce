<%@ page import="lk.ijse.ecommerce.dto.CategoryDTO" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: shima
  Date: 1/20/2025
  Time: 12:02 AM
  To change this template use File | Settings | File Templates.
--%><%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Category List</title>
</head>
<body>
<h1>Delete category</h1>

<%
    String message = request.getParameter("message");
    String error = request.getParameter("error");
%>
<%
    if (message != null) {
%>
<div style="color: green"><%=message%>
</div>
<%
    }
%>
<%
    if (error != null) {
%>
<div style="color: red"><%=error%>
</div>
<%
    }
%>

<form action="category-delete" method="post">
    <label for="id">ID</label><br/>
    <input type="number" id="id" name="category_id"/>
    <br/><br/>
    <button type="submit">Delete Customer</button>
</form>

</body>
</html>
