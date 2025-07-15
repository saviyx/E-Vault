<%--
  Created by IntelliJ IDEA.
  User: savindu umantha
  Date: 7/11/2025
  Time: 12:23 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login | E-Vault</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .admin-login {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            height: 100vh;
        }
        .login-card {
            width: 100%;
            max-width: 400px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }
        .form-control {
            border-radius: 5px;
            padding: 12px 15px;
        }
        .admin-icon {
            font-size: 3rem;
            color: #1e3c72;
        }
    </style>
</head>
<body class="admin-login">
<div class="container d-flex justify-content-center align-items-center h-100">
    <div class="login-card card">
        <div class="card-body p-4">
            <div class="text-center mb-4">
                <div class="admin-icon mb-3">
                    <i class="bi bi-shield-lock"></i>
                </div>
                <h3>Admin Portal</h3>
                <p class="text-muted">Enter your credentials</p>
            </div>

            <form action="${pageContext.request.contextPath}/admin/auth" method="POST">
                <div class="mb-3">
                    <label for="adminId" class="form-label">Admin ID</label>
                    <input type="text" class="form-control" id="adminId" name="adminId"
                           placeholder="Enter admin ID" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password"
                           placeholder="Enter password" required>
                </div>
                <div class="mb-3 form-check">
                    <input type="checkbox" class="form-check-input" id="rememberMe">
                    <label class="form-check-label" for="rememberMe">Remember me</label>
                </div>
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary btn-lg">
                        <i class="bi bi-box-arrow-in-right"></i> Login
                    </button>
                </div>
            </form>

            <div class="text-center mt-3">
                <a href="${pageContext.request.contextPath}/admin/forgot-password"
                   class="text-decoration-none small">Forgot password?</a>
            </div>

            <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger mt-3">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                <%= request.getParameter("error") %>
            </div>
            <% } %>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</body>
</html>
