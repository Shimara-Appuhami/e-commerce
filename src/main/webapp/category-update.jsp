<%--
  Created by IntelliJ IDEA.
  User: shima
  Date: 1/20/2025
  Time: 12:00 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Category</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
<header class="navbar">
    <div class="logo">TEMU</div>
</header>

<main class="container">
    <h1>Update Category</h1>

    <%
        String categoryName = (String) request.getAttribute("category_name");
        String categoryDescription = (String) request.getAttribute("category_description");
        Integer categoryId = (Integer) request.getAttribute("category_id");
    %>


    <form action="category-update" method="post">
        <input type="hidden" name="category_id" value="<%= categoryId %>">

        <div class="form-group">
            <label for="category_name">Category Name</label>
            <input type="text" id="category_name" name="category_name" value="<%= categoryName != null ? categoryName : "" %>" class="form-control" required>
        </div>

        <div class="form-group">
            <label for="category_description">Category Description</label>
            <input type="text" id="category_description" name="category_description" value="<%= categoryDescription != null ? categoryDescription : "" %>" class="form-control" required>
        </div>

        <button type="submit" class="btn btn-primary">Update Category</button>
    </form>
</main>
</body>
</html>

