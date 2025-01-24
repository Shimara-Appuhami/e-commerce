<%--
  Created by IntelliJ IDEA.
  User: shima
  Date: 1/24/2025
  Time: 1:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.List" %>
<%@ page import="lk.ijse.ecommerce.dto.UserDTO" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center mb-4">User Management</h1>

    <!-- Form to Add New User -->
    <form action="UserServlet" method="POST" class="mb-4">
        <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input type="text" id="username" name="username" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" id="password" name="password" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" id="email" name="email" class="form-control">
        </div>
        <div class="mb-3">
            <label for="role" class="form-label">Role</label>
            <input type="text" id="role" name="role" class="form-control">
        </div>
        <div class="mb-3 form-check">
            <input type="checkbox" id="active" name="active" class="form-check-input">
            <label for="active" class="form-check-label">Active</label>
        </div>
        <button type="submit" class="btn btn-success">Add User</button>
    </form>

    <!-- Display User List -->
    <h2 class="mb-4">User List</h2>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Email</th>
            <th>Role</th>
            <th>Status</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<UserDTO> userList = (List<UserDTO>) request.getAttribute("userList");
            if (userList != null && !userList.isEmpty()) {
                for (UserDTO user : userList) {
        %>
        <tr>
            <td><%= user.getId() %></td>
            <td><%= user.getUsername() %></td>
            <td><%= user.getEmail() %></td>
            <td><%= user.getRole() %></td>
            <td><%= user.isActive() ? "Active" : "Inactive" %></td>
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
