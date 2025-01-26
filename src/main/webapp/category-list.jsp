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
        .navbar{
            width: 100%;
            height: 50px;
        }
        .navbar {
            height: 60px;
            display: flex;
            justify-content: center;
            gap: 5px;
            background-color: #5d9160;
            padding: 10px 0;
        }

        .add {
            margin-left: 100px;
            background-color: transparent;
            color: white;
            font-size: 16px;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .add:hover {
            border-radius: 50px;
            background-color: #a2aca3;
        }

    </style>
</head>
<body>

<header class="navbar">
    <a href="category-save.jsp"><button class="add">Add Category</button></a>
    <a href="user.jsp"><button class="add">Register</button></a>
    <a href="product-list"><button class="add">My Products</button></a>
    <a href="show-orders"><button class="add">My Orders</button></a>
    <a href="show-cart-items.jsp"><button class="add">Add Category</button></a>
    <a href="user-update.jsp"><button class="add">Manage Customers</button></a>



</header>
<a href="login.jsp"><img src="img/icons8-back-to-50.png"></a>

<main class="categories-container">

    <%
        List<CategoryDTO> categories = (List<CategoryDTO>) request.getAttribute("categories");
        if (categories != null && !categories.isEmpty()) {
            for (CategoryDTO category : categories) {
    %>
    <img src="img/img.png">
    <div class="category-card">
<%--        <img src="<%= category.getName() %>" alt="<%= category.getName() %>">--%>
        <h3><%= category.getName() %></h3>
        <a href="product-list?categoryId=<%= category.getId() %>">View More</a>
        <a href="category-update?category_id=<%= category.getId() %>" class="btn btn-primary">Update</a>

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
