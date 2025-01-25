<%--
  Created by IntelliJ IDEA.
  User: shima
  Date: 1/24/2025
  Time: 7:06 PM
  To change this template use File | Settings | File Templates.
--%>
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
  <title>Shop Products</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <style>
    body {
      background-color: #f8f9fa;
    }

    h1, h2 {
      color: #333;
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
  </style>
</head>
<body>
<div class="container my-5">
  <a href="customer-category" class="btn btn-primary mb-3">Back to Categories</a>

  <div class="text-end mb-3">
    <a href="show-cart-items"><button class="btn bg-success p-2">
      See Cart Items: <%= session.getAttribute("cartCount") != null ? session.getAttribute("cartCount") : 0 %>
    </button></a>
  </div>

  <h1 class="text-center mb-5">Shop Products</h1>

  <%
    List<CategoryDTO> categories = (List<CategoryDTO>) request.getAttribute("categories");
    Map<Integer, List<ProductDTO>> productsByCategory = (Map<Integer, List<ProductDTO>>) request.getAttribute("productsByCategory");

    if (categories != null && !categories.isEmpty()) {
      for (CategoryDTO category : categories) {
  %>
  <div class="category-section">
    <h2><%= category.getName() %></h2>

    <div class="row g-4">
      <%
        List<ProductDTO> products = productsByCategory.get(category.getId());
        if (products != null && !products.isEmpty()) {
          for (ProductDTO product : products) {
      %>
      <div class="col-md-3">
        <div class="card shadow-sm">
          <img src="https://via.placeholder.com/150" class="card-img-top" alt="<%= product.getName() %>">
          <div class="card-body">
            <h5 class="card-title text-truncate"><%= product.getName() %></h5>
            <p class="card-text fw-bold">Price: Rs.<%= product.getPrice() %></p>
            <p class="card-text">Available Qty: <%= product.getQty() %></p>

            <form action="customer-product" method="post">
              <input type="hidden" name="productId" value="<%= product.getId() %>">
              <div class="mb-3">
                <label for="qty<%= product.getId() %>" class="form-label">Select Quantity</label>
                <input type="number" id="qty<%= product.getId() %>" name="quantity" class="form-control" min="1" max="<%= product.getQty() %>" required>
              </div>
              <button type="submit" class="btn btn-success btn-sm">Add to Cart</button>
            </form>
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
  } else {
  %>
  <div class="alert alert-warning text-center" role="alert">
    No categories available to display.
  </div>
  <%
    }
  %>
</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.7/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
