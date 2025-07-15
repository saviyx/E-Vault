<%--
  Created by IntelliJ IDEA.
  User: savindu umantha
  Date: 7/9/2025
  Time: 8:38 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Vault | Secure Online Banking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .hero-section {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            padding: 5rem 0;
        }
        .feature-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: #2a5298;
        }
        .btn-e-vault {
            background-color: #1e3c72;
            color: white;
        }
        .btn-e-vault:hover {
            background-color: #2a5298;
            color: white;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#">E-Vault</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="#">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="login.jsp">Login</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="register.jsp">Register</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<section class="hero-section text-center">
    <div class="container">
        <h1 class="display-4 fw-bold">Welcome to E-Vault</h1>
        <p class="lead">Your secure digital banking solution</p>
        <div class="mt-4">
            <a href="login.jsp" class="btn btn-light btn-lg me-2">Login</a>
            <a href="register.jsp" class="btn btn-outline-light btn-lg">Register</a>
        </div>
    </div>
</section>

<section class="py-5">
    <div class="container">
        <div class="row text-center">
            <div class="col-md-4 mb-4">
                <div class="feature-icon">
                    <i class="bi bi-shield-lock"></i>
                </div>
                <h3>Bank-Level Security</h3>
                <p>256-bit encryption and multi-factor authentication to protect your accounts.</p>
            </div>
            <div class="col-md-4 mb-4">
                <div class="feature-icon">
                    <i class="bi bi-clock-history"></i>
                </div>
                <h3>24/7 Access</h3>
                <p>Manage your finances anytime, anywhere with our mobile-friendly platform.</p>
            </div>
            <div class="col-md-4 mb-4">
                <div class="feature-icon">
                    <i class="bi bi-graph-up"></i>
                </div>
                <h3>Smart Banking</h3>
                <p>Automated savings, scheduled payments, and financial insights.</p>
            </div>
        </div>
    </div>
</section>

<footer class="bg-dark text-white py-4">
    <div class="container text-center">
        <p>&copy; 2023 E-Vault Banking System. All rights reserved.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css"></script>
</body>
</html>
