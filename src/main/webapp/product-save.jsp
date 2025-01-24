<%@ page import="java.util.List" %>
<%@ page import="lk.ijse.ecommerce.dto.CategoryDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
</head>
<body>
<div class="container">
    <div class="form-container">
        <h2 class="form-title">Add New Product</h2>
        <form action="product-save" method="post">
            <!-- Product Name -->
            <div class="mb-3">
                <label for="productName" class="form-label">Product Name</label>
                <input type="text" class="form-control" id="productName" name="name" placeholder="Enter product name" required>
            </div>

            <!-- Description -->
            <div class="mb-3">
                <label for="productDescription" class="form-label">Description</label>
                <textarea class="form-control" id="productDescription" name="description" rows="3" placeholder="Enter product description" required></textarea>
            </div>

            <!-- Price -->
            <div class="mb-3">
                <label for="productPrice" class="form-label">Price ($)</label>
                <input type="number" class="form-control" id="productPrice" name="price" step="0.01" placeholder="Enter product price" required>
            </div>

            <!-- Stock -->
            <div class="mb-3">
                <label for="productQty" class="form-label">Qty</label>
                <input type="number" class="form-control" id="productQty" name="qty" placeholder="Enter Qty quantity" required>
            </div>

            <!-- Category -->
            <div class="mb-3">
                <label for="productCategory" class="form-label">Category</label>
                <select class="form-select" id="productCategory" name="productCategory" required>
                    <option value="" disabled selected>Select a category</option>
                    <%
                        List<CategoryDTO> categories = (List<CategoryDTO>) request.getAttribute("categories");
                        if (categories != null) {
                            for (CategoryDTO category : categories) {
                    %>
                    <option value="<%= category.getId() %>"><%= category.getName() %></option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>

            <!-- Submit Button -->
            <div class="d-grid">
                <button type="submit" class="btn btn-primary">Save Product</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
