<%--
  Created by IntelliJ IDEA.
  User: shima
  Date: 1/23/2025
  Time: 11:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="lk.ijse.ecommerce.dto.ProductDTO" %>
<%@ page import="lk.ijse.ecommerce.dto.CategoryDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Product</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
<header class="navbar">
    <div class="logo">TEMU</div>
</header>
<main class="container">
    <h1>Update Product</h1>

    <%
        ProductDTO product = (ProductDTO) request.getAttribute("product");
        List<CategoryDTO> categories = (List<CategoryDTO>) request.getAttribute("categories");


    %>


    <form action="product-update" method="post">
        <input type="hidden" name="product_id" value="<%= product != null ? product.getId() : "" %>">

        <div class="form-group">
            <label for="product_name">Product Name</label>
            <input type="text" id="product_name" name="product_name"
                   value="<%= product != null ? product.getName() : "" %>"
                   class="form-control" required>
        </div>

        <div class="form-group">
            <label for="product_price">Product Price</label>
            <input type="text" id="product_price" name="product_price"
                   value="<%= product != null ? product.getPrice() : "" %>"
                   class="form-control" required>
        </div>

        <div class="form-group">
            <label for="product_qty">Product Quantity</label>
            <input type="number" id="product_qty" name="product_qty"
                   value="<%= product != null ? product.getQty() : "" %>"
                   class="form-control" required>
        </div>

        <div class="form-group">
            <label for="category_id">Category</label>
            <select id="category_id" name="category_id" class="form-control" required>
                <option value="">Select a category</option>
                <%
                    if (categories != null) {
                        for (CategoryDTO category : categories) {
                            boolean selected = product != null && category.getId() == product.getCategory_id();
                %>
                <option value="<%= category.getId() %>" <%= selected ? "selected" : "" %>>
                    <%= category.getName() %>
                </option>
                <%
                        }
                    }
                %>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">Update Product</button>
    </form>
</main>
</body>
</html>
