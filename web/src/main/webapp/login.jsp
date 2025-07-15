<%--
  Created by IntelliJ IDEA.
  User: savindu umantha
  Date: 7/10/2025
  Time: 7:36 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | E-Vault</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .login-container {
            max-width: 400px;
            margin: 5rem auto;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .btn-e-vault {
            background-color: #1e3c72;
            color: white;
            width: 100%;
        }
        .btn-e-vault:hover {
            background-color: #2a5298;
            color: white;
        }
        .form-floating label {
            color: #6c757d;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">E-Vault</a>
    </div>
</nav>

<div class="container">
    <div class="login-container bg-white">
        <h2 class="text-center mb-4">Login to Your Account</h2>

        <% if(request.getParameter("error") != null) { %>
        <div class="alert alert-danger" role="alert">
            Invalid username or password. Please try again.
        </div>
        <% } %>

        <form action="Login" method="POST">
            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="username" name="username" placeholder="Username" required>
                <label for="username">Username</label>
            </div>
            <div class="form-floating mb-3">
                <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                <label for="password">Password</label>
            </div>
            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="rememberMe">
                <label class="form-check-label" for="rememberMe">Remember me</label>
            </div>
            <button type="submit" class="btn btn-e-vault btn-lg mb-3">Login</button>
            <div class="text-center">
                <a href="#" class="text-decoration-none">Forgot password?</a>
            </div>
        </form>
    </div>
</div>

<footer class="bg-dark text-white py-4 mt-5">
    <div class="container text-center">
        <p>&copy; 2023 E-Vault Banking System. All rights reserved.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Simple client-side validation
    document.querySelector('form').addEventListener('submit', function(e) {
        const username = document.getElementById('username').value;
        const password = document.getElementById('password').value;

        if(username.trim() === '' || password.trim() === '') {
            e.preventDefault();
            alert('Please fill in all fields');
        }
    });
</script>
</body>
</html>
