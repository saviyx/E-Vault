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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f0 100%);
            min-height: 100vh;
        }
        .portal-section {
            padding: 4rem 0;
        }
        .portal-card {
            border-radius: 15px;
            overflow: hidden;
            transition: all 0.3s ease;
            border: none;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
            height: 100%;
        }
        .portal-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
        }
        .card-header {
            padding: 1.5rem;
            text-align: center;
            color: white;
            border-bottom: none;
        }
        .admin-header {
            background: linear-gradient(135deg, #d53369 0%, #daae51 100%);
        }
        .staff-header {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
        }
        .customer-header {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
        }
        .card-body {
            padding: 2rem;
            display: flex;
            flex-direction: column;
        }
        .portal-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }
        .btn-portal {
            width: 100%;
            padding: 0.75rem;
            font-weight: 600;
            border: none;
            color: white;
            margin-top: auto;
        }
        .btn-admin {
            background-color: #d53369;
        }
        .btn-staff {
            background-color: #11998e;
        }
        .btn-customer {
            background-color: #1e3c72;
        }
        .btn-portal:hover {
            opacity: 0.9;
            color: white;
        }
        .welcome-banner {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            padding: 2rem;
            border-radius: 15px;
            margin-bottom: 3rem;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        .login-container {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            margin-top: 2rem;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark" style="background-color: #1e3c72;">
    <div class="container">
        <a class="navbar-brand" href="#">
            <i class="bi bi-shield-lock"></i> E-Vault
        </a>
        <div class="navbar-nav ms-auto">
            <a href="register.jsp" class="nav-link">Register</a>
        </div>
    </div>
</nav>

<div class="container portal-section">
    <div class="welcome-banner text-center">
        <h1 class="display-4 fw-bold">Welcome to E-Vault</h1>
        <p class="lead">Secure banking portal for all users</p>
    </div>

    <div class="row">
        <!-- Admin Portal Card -->
        <div class="col-md-4">
            <div class="portal-card">
                <div class="card-header admin-header">
                    <i class="bi bi-person-gear portal-icon"></i>
                    <h3>Admin Portal</h3>
                </div>
                <div class="card-body">
                    <p class="text-muted">
                        System administrators can manage user accounts, configure system settings,
                        and oversee all banking operations through this secure portal.
                    </p>
                    <a href="admin-login.jsp" class="btn btn-admin btn-portal mt-3">
                        <i class="bi bi-box-arrow-in-right"></i> Admin Login
                    </a>
                </div>
            </div>
        </div>

        <!-- Staff Portal Card -->
        <div class="col-md-4">
            <div class="portal-card">
                <div class="card-header staff-header">
                    <i class="bi bi-person-badge portal-icon"></i>
                    <h3>Staff Portal</h3>
                </div>
                <div class="card-body">
                    <p class="text-muted">
                        Bank staff members can access customer accounts, process transactions,
                        and provide banking services through this dedicated interface.
                    </p>
                    <a href="staff-login.jsp" class="btn btn-staff btn-portal mt-3">
                        <i class="bi bi-box-arrow-in-right"></i> Staff Login
                    </a>
                </div>
            </div>
        </div>

        <!-- Customer Portal Card -->
        <div class="col-md-4">
            <div class="portal-card">
                <div class="card-header customer-header">
                    <i class="bi bi-person portal-icon"></i>
                    <h3>Customer Portal</h3>
                </div>
                <div class="card-body">
                    <p class="text-muted">
                        Customers can securely access their accounts, make transactions,
                        view statements, and manage their finances anytime, anywhere.
                    </p>
                    <a href="#customer-login" class="btn btn-customer btn-portal mt-3">
                        <i class="bi bi-box-arrow-in-right"></i> Customer Login
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Customer Login Form (only shown for customer portal) -->
    <div id="customer-login" class="login-container">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <h2 class="text-center mb-4"><i class="bi bi-person"></i> Customer Login</h2>
                <form action="login" method="post">
                    <input type="hidden" name="userType" value="customer">
                    <div class="mb-3">
                        <label for="username" class="form-label">Username</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="rememberMe">
                        <label class="form-check-label" for="rememberMe">Remember me</label>
                    </div>
                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-customer btn-portal">
                            <i class="bi bi-box-arrow-in-right"></i> Login
                        </button>
                    </div>
                    <div class="mt-3 text-center">
                        <a href="register.jsp" class="text-decoration-none">Create account</a> |
                        <a href="forgot-password.jsp" class="text-decoration-none">Forgot password?</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<footer class="bg-dark text-white py-4 mt-5">
    <div class="container text-center">
        <p>&copy; 2023 E-Vault Banking System. All rights reserved.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Hide login form initially
    document.getElementById('customer-login').style.display = 'none';

    // Show login form when customer login button is clicked
    document.querySelector('a[href="#customer-login"]').addEventListener('click', function(e) {
        e.preventDefault();
        document.getElementById('customer-login').style.display = 'block';
        window.scrollTo({
            top: document.getElementById('customer-login').offsetTop - 20,
            behavior: 'smooth'
        });
    });
</script>
</body>
</html>