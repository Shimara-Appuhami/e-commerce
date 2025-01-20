<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>E Commerce</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
<header class="navbar">
    <div class="logo">TEMU</div>
    <div class="search-bar">
        <input type="text" placeholder="Search...">
        <button>Search</button>
    </div>
    <nav class="nav-links">
        <a href="category-list">Categories</a>
        <a href="category-save.jsp"> category saves</a>
        <a href="category-update.jsp">category update</a>
        <a href="category-delete.jsp">category delete</a>

        <a href="#">Become a Sellers</a>
        <a href="#">Language</a>
    </nav>
    <div class="user-actions">
        <button>Sign In / Register</button>
        <button>Cart</button>
    </div>
</header>

<main class="main-content">
    <section class="products">
        <div class="product">
            <img src="img/sneaker.png" alt="Sneaker">
            <h3>Men's Casual Sneakers</h3>
            <p>LKR 3,003.77</p>
        </div>
        <!-- Add more product cards -->
        <div class="product">
            <img src="img/shirt.png" alt="Shirt">
            <h3>Men's Casual Shirt</h3>
            <p>LKR 2,792.80</p>
        </div>

        <!-- Add more product cards -->

    </section>
</main>
</body>
</html>