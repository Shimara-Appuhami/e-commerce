<%@ page import="lk.ijse.ecommerce.dto.CategoryDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Commerce Categories</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <style>
        @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap");

        body {
            font-family: "Poppins", sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f7fc;
        }

        .navbar {
            background-color: #578E7E;
            padding: 15px 30px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar .logo {
            font-size: 24px;
            font-weight: 600;
        }

        .navbar button {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .navbar button:hover {
            background-color: #218838;
        }

        .categories-container {
            max-width: 1200px;
            margin: 40px auto;
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            justify-content: center;
        }

        .add-category-form {
            width: 100%;
            max-width: 400px;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 40px;
        }

        .add-category-form h2 {
            font-size: 24px;
            margin-bottom: 20px;
            color: #333;
        }

        .add-category-form label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            color: #333;
        }

        .add-category-form input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 4px;
            border: 1px solid #ddd;
        }

        .add-category-form button {
            width: 100%;
            padding: 10px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .add-category-form button:hover {
            background-color: #218838;
        }

        .category-card {
            width: 250px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
            overflow: hidden;
            transition: transform 0.2s, box-shadow 0.2s ease;
            cursor: pointer;
        }

        .category-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }

        .category-card img {
            width: 100%;
            height: 150px;
            object-fit: cover;
            border-bottom: 2px solid #ddd;
        }

        .category-card h3 {
            margin: 15px 0;
            font-size: 18px;
            color: #333;
        }

        .category-card a {
            display: inline-block;
            margin-bottom: 15px;
            padding: 10px 20px;
            font-size: 14px;
            color: #fff;
            background-color: #007bff;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.2s ease;
        }

        .category-card a:hover {
            background-color: #0056b3;
        }

        .delete {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
            margin-bottom: 15px;
            font-size: 14px;
            transition: background-color 0.3s ease;
        }

        .delete:hover {
            background-color: #c82333;
        }

        @media (max-width: 768px) {
            .categories-container {
                flex-direction: column;
                align-items: center;
            }

            .category-card {
                width: 90%;
                margin-bottom: 20px;
            }
        }
        .navbar{
            width: 100%;
            height: 50px;
        }
    </style>
</head>
<body>

<header class="navbar">
    <a href="category-save.jsp"><button>Add Category</button></a>
</header>

<main class="categories-container">
    <%
        List<CategoryDTO> categories = (List<CategoryDTO>) request.getAttribute("categories");
        if (categories != null && !categories.isEmpty()) {
            for (CategoryDTO category : categories) {
    %>

    <div class="category-card" id="category-<%= category.getId() %>">
<%--        <img src="<%= category.getImageUrl() %>" alt="<%= category.getName() %>">--%>
        <h3><%= category.getName() %></h3>
        <a href="product-list?categoryId=<%= category.getId() %>">View More</a>
        <button type="button" class="delete" onclick="deleteCategory(<%= category.getId() %>)">Delete</button>
    </div>

    <%
        }
    } else {
    %>
    <p>No categories available.</p>
    <% } %>
</main>

<script>
    function deleteCategory(categoryId) {
        if (confirm("Are you sure you want to delete this category?")) {
            window.location.href = "category-delete?categoryId=" + categoryId;
        }
    }
</script>

</body>
</html>
