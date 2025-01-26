<%--
  Created by IntelliJ IDEA.
  User: shima
  Date: 1/26/2025
  Time: 8:43 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.List" %>
<%@ page import="lk.ijse.ecommerce.dto.UserDTO" %>
<%
    // Get the list of users from the request
    List<UserDTO> users = (List<UserDTO>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa; /* Light background for better contrast */
        }
        h1 {
            color: #343a40; /* Darker text for better readability */
            font-weight: bold;
        }
        .table {
            background-color: #fff;
            border-radius: 8px;
            overflow: hidden;
        }
        .table thead {
            background-color: #343a40;
            color: #fff;
        }
        .table tbody tr:hover {
            background-color: #f1f1f1; /* Highlight row on hover */
        }
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }
        .btn-success, .btn-danger {
            border-radius: 20px; /* Rounded buttons for a modern look */
        }
        .btn-secondary {
            background-color: #6c757d;
            border: none;
            color: #fff;
            font-size: 16px;
            padding: 10px 20px;
            border-radius: 30px;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center mb-4">Customer Management</h1>
    <table class="table table-bordered table-hover">
        <thead>
        <tr>
            <th>User ID</th>
            <th>Username</th>
            <th>Email</th>
            <th>Role</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% if (users != null && !users.isEmpty()) { %>
        <% for (UserDTO user : users) { %>
        <tr>
            <td><%= user.getId() %></td>
            <td><%= user.getUsername() %></td>
            <td><%= user.getEmail() %></td>
            <td><%= user.getRole() %></td>
            <td><%= user.isActive()? "Active" : "Inactive" %></td>
            <td>
                <form action="user-update" method="post" style="display:inline;">
                    <input type="hidden" name="userId" value="<%= user.getId() %>">
                    <button type="submit" name="action" value="activate" class="btn btn-success">
                        <i class="bi bi-check-circle"></i> Activate
                    </button>
                </form>
                <form action="user-update" method="post" style="display:inline;">
                    <input type="hidden" name="userId" value="<%= user.getId() %>">
                    <button type="submit" name="action" value="deactivate" class="btn btn-danger">
                        <i class="bi bi-x-circle"></i> Deactivate
                    </button>
                </form>
            </td>
        </tr>
        <% } %>
        <% } else { %>
        <tr>
            <td colspan="6" class="text-center">No users found.</td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <div class="text-center">
        <a href="customer-dashboard.jsp" class="btn btn-secondary mt-3">Back</a>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.js"></script>
</body>
</html>
