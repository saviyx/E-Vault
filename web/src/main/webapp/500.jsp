<%--
  Created by IntelliJ IDEA.
  User: savindu umantha
  Date: 7/11/2025
  Time: 12:06 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 - Server Error | E-Vault</title>
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
            color: #dc3545;
        }
    </style>
</head>
<body>
<div class="error-container text-center">
    <div class="error-icon">
        <i class="bi bi-exclamation-octagon-fill"></i>
    </div>
    <h1 class="display-4">500 - Server Error</h1>
    <p class="lead">Something went wrong on our end. Please try again later.</p>

    <% if (exception != null) { %>
    <div class="alert alert-danger mt-4" style="max-width: 600px;">
        <h5>Error Details:</h5>
        <p><%= exception.getClass().getName() %></p>
        <p><%= exception.getMessage() %></p>
        <small class="text-muted">
            <%
                for (StackTraceElement element : exception.getStackTrace()) {
                    out.print(element + "<br>");
                }
            %>
        </small>
    </div>
    <% } %>

    <div class="mt-4">
        <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary">
            <i class="bi bi-house-door"></i> Return Home
        </a>
        <a href="mailto:support@evault.com" class="btn btn-outline-secondary ms-2">
            <i class="bi bi-envelope"></i> Contact Support
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</body>
</html>