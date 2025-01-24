<%@ page import="lk.ijse.ecommerce.dto.CategoryDTO" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: shima
  Date: 1/19/2025
  Time: 7:47 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="lk.ijse.ecommerce.dto.CategoryDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>E-Commerce Categories</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <style>
        body {
            font-family: "Poppins", sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }
        .navbar{
            background: #578E7E;
        }
        .categories-container {
            max-width: 1200px;
            margin: 20px auto;
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }
        .category-card {
            width: 250px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
            overflow: hidden;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .category-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }
        .category-card img {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }
        .category-card h3 {
            margin: 15px 0;
            font-size: 18px;
            color: #333;
        }
        .category-card a, .category-card form button {
            display: inline-block;
            margin: 10px 5px;
            padding: 10px 20px;
            font-size: 14px;
            color: #fff;
            background-color: #007bff;
            text-decoration: none;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .category-card a:hover, .category-card form button:hover {
            background-color: #0056b3;
        }
        .category-card form button.delete {
            background-color: #dc3545;
        }
        .category-card form button.delete:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
<header class="navbar">
    <div class="logo">TEMU</div>
    <a href="category-save.jsp"><button>Add Category</button></a>
</header>

<main class="categories-container">
    <%
        // Retrieve categories from request attribute
        List<CategoryDTO> categories = (List<CategoryDTO>) request.getAttribute("categories");
        if (categories != null && !categories.isEmpty()) {
            for (CategoryDTO category : categories) {
    %>
    <!-- Category Card -->
    <div class="category-card">
        <img src="<%= category.getName() %>" alt="<%= category.getName() %>">
        <h3><%= category.getName() %></h3>
        <a href="product-list?categoryId=<%= category.getId() %>">View More</a>
        <a href="category-update?category_id=<%= category.getId() %>" class="btn btn-primary">Update</a>
        <!-- Delete Form -->
        <form action="category-delete" method="post" style="display:inline;">
            <input type="hidden" name="categoryId" value="<%= category.getId() %>">
            <button type="submit" class="delete" onclick="return confirm('Are you sure you want to delete this category?');">Delete</button>
        </form>
    </div>
    <%
        }
    } else {
    %>
    <p>No categories available.</p>
    <% } %>
</main>
</body>
</html>
