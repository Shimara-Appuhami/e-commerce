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
    <title>REGISTER</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f6f9;
            font-family: Arial, sans-serif;
        }

        .container {
            margin-top: 50px;
        }

        h1 {
            font-size: 2.5rem;
            color: #333;
        }

        .form-label {
            font-weight: bold;
        }

        .table th, .table td {
            vertical-align: middle;
        }

        .table-container {
            margin-top: 40px;
        }

        .btn-custom {
            background-color: #4CAF50;
            color: white;
            border-radius: 5px;
        }

        .btn-custom:hover {
            background-color: #45a049;
            color: white;
        }

        .form-control {
            border-radius: 5px;
        }

        .table-container table {
            border-radius: 8px;
            overflow: hidden;
        }

        .table-bordered {
            border: 1px solid #ddd;
        }

        .table th {
            background-color: #4CAF50;
            color: white;
        }

        .table td {
            background-color: #fff;
        }

        .table-hover tbody tr:hover {
            background-color: #f1f1f1;
        }

        .form-check-label {
            font-size: 0.9rem;
        }
        img{
            width: 40px;
            height: 40px;
            position: absolute;
            top: 30px;
        }
    </style>
</head>
<body>

<div class="container">
    <h1 class="text-center mb-4">User Management</h1>
    <a href="customer-category"><img src="img/icons8-back-to-50.png"></a>
    <form action="UserServlet" method="POST" class="mb-4">
        <a href="user-update.jsp"><button>Update</button></a>
        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" id="username" name="username" class="form-control" required>
            </div>
            <div class="col-md-6 mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" id="password" name="password" class="form-control" required>
            </div>
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
        <button type="submit" class="btn btn-custom">Add User</button>
    </form>

    <div class="table-container">
        <h2 class="mb-4">User List</h2>
        <table class="table table-bordered table-hover">
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
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
