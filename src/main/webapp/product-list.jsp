<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="lk.ijse.ecommerce.dto.CategoryDTO" %>
<%@ page import="lk.ijse.ecommerce.dto.ProductDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products by Category</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        body {
            background-color: #f8f9fa;
        }

        h1, h2 {
            color: #333;
        }

        .btn-primary, .btn-success {
            border-radius: 50px;
            font-size: 14px;
            font-weight: 600;
        }

        .category-section {
            margin-bottom: 40px;
        }

        .card {
            border: none;
            border-radius: 10px;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        }

        .card-img-top {
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
            height: 150px;
            object-fit: cover;
        }

        .btn-sm {
            border-radius: 50px;
        }

        hr {
            border-top: 2px solid #ddd;
        }
        .card-img-top{
            width: 200px;
            height: 250px;
            margin-left: 50px;

        }
        .products-title {
            font-size: 36px;
            font-weight: 700;
            color: #4CAF50;
            text-transform: uppercase;
            letter-spacing: 2px;
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            transition: color 0.3s ease, transform 0.3s ease;
        }

        .products-title:hover {
            color: #388e3c;
            transform: scale(1.05);
        }
        .btn-add-product {
            margin-left: 1200px;
            display: inline-block;
            padding: 12px 25px;
            font-size: 16px;
            font-weight: 600;
            color: #fff;
            background-color: #4CAF50;
            border: none;
            border-radius: 50px;
            text-align: center;
            text-decoration: none;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .btn-add-product:hover {
            background-color: #388e3c;
            transform: scale(1.05);
            box-shadow: 0 6px 10px rgba(0, 0, 0, 0.2);
        }

        .btn-add-product:active {
            background-color: #2c6e2f;
            transform: scale(1);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .category-title {
            font-size: 28px;
            font-weight: 700;
            color: #727c72;
            text-align: center;
            margin-bottom: 20px;
            position: relative;
        }

        .category-title::after {
            content: "";
            position: absolute;
            bottom: -5px;
            left: 0;
            width: 100%;
            height: 3px;
            background-color: #4CAF50;
            border-radius: 2px;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            font-size: 14px;
            font-weight: 600;
            text-align: center;
            border-radius: 25px;
            text-decoration: none;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .btn-update {
            background-color: #ffcc00;
            color: white;
            border: 2px solid #ffcc00;
        }

        .btn-update:hover {
            background-color: #ffb700;
            border-color: #ffb700;
        }

        .btn-delete {
            background-color: #dc3545;
            color: white;
            border: 2px solid #dc3545;
        }

        .btn-delete:hover {
            background-color: #c82333;
            border-color: #c82333;
        }

        .btn:focus {
            outline: none;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }


    </style>
</head>
<body>
<div class="container my-5">
    <a href="index" class="btn "><img src="img/icons8-back-to-50.png"></a>

    <h1 class="text-center mb-5 products-title">Products</h1>

    <a href="product-save" class="btn-add-product">Add New Product</a>

    <%
        List<CategoryDTO> categories = (List<CategoryDTO>) request.getAttribute("categories");
        Map<Integer, List<ProductDTO>> productsByCategory = (Map<Integer, List<ProductDTO>>) request.getAttribute("productsByCategory");

        for (CategoryDTO category : categories) {
    %>
    <div class="category-section">
        <h2 class="category-title"><%= category.getName() %></h2>

        <div class="row g-4">
            <%
                List<ProductDTO> products = productsByCategory.get(category.getId());
                if (products != null && !products.isEmpty()) {
                    for (ProductDTO product : products) {
            %>
            <div class="col-md-3">
                <div class="card shadow-sm">
                    <!-- Display the product image -->
                    <img src="<%= product.getImage_path() %>" class="card-img-top" alt="<%= product.getName() %>">
                    <div class="card-body">
                        <h5 class="card-title text-truncate"><%= product.getName() %></h5>
                        <p class="card-text fw-bold">Price: $<%= product.getPrice() %></p>
                        <p class="card-text">Qty: <%= product.getQty() %></p>

                        <div class="d-flex justify-content-between">
                            <a href="product-update.jsp?id=<%= product.getId() %>" class="btn btn-update">Update</a>
                            <a href="product-delete.jsp?id=<%= product.getId() %>" class="btn btn-delete">Delete</a>

                        </div>
                    </div>
                </div>
            </div>
            <%
                }
            } else {
            %>
            <div class="col-12">
                <p class="text-muted">No products available in this category.</p>
            </div>
            <%
                }
            %>
        </div>
    </div>
    <hr class="my-4">
    <%
        }
    %>
</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.7/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>