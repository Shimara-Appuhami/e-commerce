<%@ page import="lk.ijse.ecommerce.dto.CategoryDTO" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: shima
  Date: 1/19/2025
  Time: 7:47 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Category List</title>
</head>
<body>
<h1>Category List</h1>
<%
    List<CategoryDTO> dataList = (List<CategoryDTO>) request.getAttribute("categories");
    if (dataList != null && !dataList.isEmpty()) {
%>
<table border="1">
    <thead>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>des</th>

    </tr>
    </thead>
    <tbody>
    <%
        for (CategoryDTO categoryDTO : dataList) {
    %>
    <tr>
        <td><%=categoryDTO.getId()%></td>
        <td><%=categoryDTO.getName()%></td>
        <td><%=categoryDTO.getDescription()%></td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>
<%
    }
%>

</body>
</html>
