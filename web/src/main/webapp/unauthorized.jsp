<%--
  Created by IntelliJ IDEA.
  User: savindu umantha
  Date: 7/11/2025
  Time: 12:07 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Access Denied | E-Vault</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .error-container {
            height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            background-color: #f8f9fa;
        }
        .error-icon {
            font-size: 5rem;
            color: #ffc107;
        }
        .role-badge {
            font-size: 0.8rem;
        }
    </style>
</head>
<body>
<div class="error-container text-center">
    <div class="error-icon">
        <i class="bi bi-shield-x"></i>
    </div>
    <h1 class="display-4">403 - Access Denied</h1>
    <p class="lead">You don't have permission to view this page.</p>

    <div class="alert alert-warning mt-4" style="max-width: 600px;">
        <h5><i class="bi bi-person-check me-2"></i>Required Roles:</h5>
        <div class="mt-2">
            <span class="badge bg-primary role-badge me-1">ADMIN</span>
            <span class="badge bg-success role-badge">MANAGER</span>
        </div>
        <hr>
        <p class="mb-0">Your current role:
            <span class="badge bg-secondary role-badge">
                    <%= request.isUserInRole("user") ? "USER" : "GUEST" %>
                </span>
        </p>
    </div>

    <div class="mt-4">
        <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary">
            <i class="bi bi-house-door"></i> Home Page
        </a>
        <a href="javascript:history.back()" class="btn btn-outline-secondary ms-2">
            <i class="bi bi-arrow-left"></i> Go Back
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</body>
</html>