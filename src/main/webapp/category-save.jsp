<%--
  Created by IntelliJ IDEA.
  User: shima
  Date: 1/19/2025
  Time: 11:21 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Category Save</title>
</head>
<body>
    <h1>Category Save</h1>


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

    <form action="category-save" method="post">
        <label for="name">Name</label><br>
        <input type="text" id="name" name="category_name"/><br><br>

        <label for="description">Description</label><br>
        <input type="text" id="description" name="category_description"/><br><br>

        <button type="submit">Save Category</button>
    </form>

</body>
</html>
