<%--
  Created by IntelliJ IDEA.
  User: savindu umantha
  Date: 7/11/2025
  Time: 12:06 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Failed | E-Vault</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .auth-container {
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #f8f9fa;
        }
        .auth-card {
            width: 100%;
            max-width: 400px;
            padding: 2rem;
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .alert-icon {
            font-size: 2.5rem;
            color: #dc3545;
        }
    </style>
</head>
<body>
<div class="auth-container">
    <div class="auth-card card">
        <div class="card-body text-center">
            <div class="alert-icon mb-3">
                <i class="bi bi-shield-lock"></i>
            </div>
            <h2 class="card-title mb-3">Login Failed</h2>

            <div class="alert alert-danger">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                Invalid username or password. Please try again.
            </div>

            <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-warning mt-3">
                <small>
                    <i class="bi bi-info-circle-fill me-2"></i>
                    <%= request.getParameter("error") %>
                </small>
            </div>
            <% } %>

            <div class="d-grid gap-2 mt-4">
                <a href="${pageContext.request.contextPath}/login.jsp"
                   class="btn btn-primary">
                    <i class="bi bi-arrow-left-circle"></i> Back to Login
                </a>
                <a href="${pageContext.request.contextPath}/register.jsp"
                   class="btn btn-outline-secondary">
                    <i class="bi bi-person-plus"></i> Create Account
                </a>
            </div>

            <div class="mt-4 text-center">
                <a href="${pageContext.request.contextPath}/forgot-password.jsp"
                   class="text-decoration-none">
                    Forgot Password?
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</body>
</html>