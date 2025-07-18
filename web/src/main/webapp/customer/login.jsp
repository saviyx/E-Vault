<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Login | E-Vault</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: linear-gradient(135deg, #0355cb 0%, #0cb89a 100%);
            margin: 0;
        }
        .login-container {
            width: 100%;
            max-width: 420px;
            padding: 0 15px;
        }
        .login-card {
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            border: none;
            overflow: hidden;
        }
        .card-header {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            padding: 2rem;
            text-align: center;
            border-bottom: none;
        }
        .portal-icon {
            font-size: 2.8rem;
            margin-bottom: 1rem;
            color: white;
        }
        .card-body {
            padding: 2rem;
            background: white;
        }
        .form-control {
            border-radius: 8px;
            padding: 14px 16px;
            margin-bottom: 1.5rem;
        }
        .btn-login {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            border: none;
            padding: 14px;
            width: 100%;
            border-radius: 8px;
        }
        .register-link {
            text-align: center;
            display: block;
            margin-top: 1rem;
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="login-card card">
        <div class="card-header">
            <div class="portal-icon">
                <i class="bi bi-person-circle"></i>
            </div>
            <h3>Customer Login</h3>
            <p class="mb-0">Access your account</p>
        </div>
        <div class="card-body">
            <form>
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" placeholder="Enter your username">
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" placeholder="Enter your password">
                </div>
                <div class="mb-3 form-check">
                    <input type="checkbox" class="form-check-input" id="rememberMe">
                    <label class="form-check-label" for="rememberMe">Remember me</label>
                </div>
                <button type="submit" class="btn btn-login text-white">
                    <i class="bi bi-box-arrow-in-right me-2"></i> Login
                </button>
            </form>
            <a href="#" class="register-link">Don't have an account? Register now</a>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</body>
</html>