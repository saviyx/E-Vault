<%--
  Created by IntelliJ IDEA.
  User: savindu umantha
  Date: 7/11/2025
  Time: 1:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Login | E-Vault</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .staff-login {
            background: linear-gradient(135deg, #2a5298 0%, #1e3c72 100%);
            height: 100vh;
        }
        .login-card {
            width: 100%;
            max-width: 400px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }
        .staff-icon {
            font-size: 3rem;
            color: #1e3c72;
        }
    </style>
</head>
<body class="staff-login">
<div class="container d-flex justify-content-center align-items-center h-100">
    <div class="login-card card">
        <div class="card-body p-4">
            <div class="text-center mb-4">
                <div class="staff-icon mb-3">
                    <i class="bi bi-person-badge"></i>
                </div>
                <h3>Staff Portal</h3>
                <p class="text-muted">Bank employees only</p>
            </div>

            <form action="${pageContext.request.contextPath}/staff/auth" method="POST">
                <div class="mb-3">
                    <label for="staffId" class="form-label">Staff ID</label>
                    <input type="text" class="form-control" id="staffId" name="staffId"
                           placeholder="Enter staff ID" required>
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

            <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger mt-3">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                <%= request.getParameter("error") %>
            </div>
            <% } %>

            <div class="text-center mt-3">
                <a href="${pageContext.request.contextPath}/staff/forgot-password"
                   class="text-decoration-none small">Forgot password?</a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</body>
</html>