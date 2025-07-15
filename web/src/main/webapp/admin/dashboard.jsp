<%--
  Created by IntelliJ IDEA.
  User: savindu umantha
  Date: 7/11/2025
  Time: 12:26 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | E-Vault</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --sidebar-width: 250px;
            --primary-color: #1e3c72;
        }
        .admin-sidebar {
            background-color: var(--primary-color);
            color: white;
            height: 100vh;
            position: fixed;
            width: var(--sidebar-width);
        }
        .admin-main {
            margin-left: var(--sidebar-width);
            padding: 20px;
        }
        .admin-navbar {
            background-color: white !important;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .stat-card {
            border-left: 4px solid var(--primary-color);
            transition: transform 0.3s;
        }
        .stat-card:hover {
            transform: translateY(-5px);
        }
        .nav-link.active {
            background-color: rgba(255, 255, 255, 0.1);
        }
    </style>
</head>
<body>
<div class="admin-sidebar">
    <div class="text-center p-4">
        <h4>E-Vault Admin</h4>
        <div class="mt-3">
            <div class="d-flex justify-content-center mb-3">
                <div class="bg-white rounded-circle p-1" style="width: 80px; height: 80px;">
                    <i class="bi bi-person-fill text-primary" style="font-size: 3rem;"></i>
                </div>
            </div>
            <h6>${admin.firstName} ${admin.lastName}</h6>
            <small class="text-muted">${admin.role}</small>
        </div>
    </div>
    <ul class="nav flex-column">
        <li class="nav-item">
            <a class="nav-link active" href="#">
                <i class="bi bi-speedometer2 me-2"></i> Dashboard
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                <i class="bi bi-people me-2"></i> User Management
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/accounts">
                <i class="bi bi-bank2 me-2"></i> Account Oversight
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/transactions">
                <i class="bi bi-arrow-left-right me-2"></i> Transaction Monitor
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/reports">
                <i class="bi bi-graph-up me-2"></i> Financial Reports
            </a>
        </li>
        <li class="nav-item mt-4">
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/logout">
                <i class="bi bi-box-arrow-left me-2"></i> Logout
            </a>
        </li>
    </ul>
</div>

<div class="admin-main">
    <nav class="navbar navbar-expand-lg admin-navbar">
        <div class="container-fluid">
            <h5 class="mb-0">Admin Dashboard</h5>
            <div class="d-flex align-items-center">
                <div class="dropdown me-3">
                    <button class="btn btn-light dropdown-toggle" type="button" id="notificationsDropdown" data-bs-toggle="dropdown">
                        <i class="bi bi-bell"></i>
                        <span class="badge bg-danger rounded-pill">3</span>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><h6 class="dropdown-header">Admin Alerts</h6></li>
                        <li><a class="dropdown-item" href="#">Suspicious login attempt</a></li>
                        <li><a class="dropdown-item" href="#">New user registration</a></li>
                        <li><a class="dropdown-item" href="#">System maintenance scheduled</a></li>
                    </ul>
                </div>
                <span class="badge bg-primary">ADMIN</span>
            </div>
        </div>
    </nav>

    <div class="container-fluid mt-4">
        <!-- Stats Cards -->
        <div class="row mb-4">
            <div class="col-md-3 mb-3">
                <div class="stat-card card h-100">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="card-title text-muted">Total Users</h6>
                                <h3 class="mb-0">1,248</h3>
                            </div>
                            <i class="bi bi-people-fill text-primary" style="font-size: 2rem;"></i>
                        </div>
                        <div class="mt-3">
                                <span class="text-success">
                                    <i class="bi bi-arrow-up"></i> 12.5%
                                </span>
                            <span class="text-muted ms-2">vs last month</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stat-card card h-100">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="card-title text-muted">Active Accounts</h6>
                                <h3 class="mb-0">2,567</h3>
                            </div>
                            <i class="bi bi-bank2 text-primary" style="font-size: 2rem;"></i>
                        </div>
                        <div class="mt-3">
                                <span class="text-success">
                                    <i class="bi bi-arrow-up"></i> 8.3%
                                </span>
                            <span class="text-muted ms-2">vs last month</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stat-card card h-100">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="card-title text-muted">Today's Transactions</h6>
                                <h3 class="mb-0">$1.2M</h3>
                            </div>
                            <i class="bi bi-cash-stack text-primary" style="font-size: 2rem;"></i>
                        </div>
                        <div class="mt-3">
                                <span class="text-danger">
                                    <i class="bi bi-arrow-down"></i> 3.2%
                                </span>
                            <span class="text-muted ms-2">vs yesterday</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stat-card card h-100">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="card-title text-muted">Pending Actions</h6>
                                <h3 class="mb-0">14</h3>
                            </div>
                            <i class="bi bi-exclamation-triangle-fill text-warning" style="font-size: 2rem;"></i>
                        </div>
                        <div class="mt-3">
                                <span class="text-danger">
                                    <i class="bi bi-arrow-up"></i> 5
                                </span>
                            <span class="text-muted ms-2">new today</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Activity -->
        <div class="row">
            <div class="col-md-8 mb-4">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Recent Transactions</h5>
                        <div class="dropdown">
                            <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="timeRangeDropdown" data-bs-toggle="dropdown">
                                Last 24 Hours
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="#">Last 24 Hours</a></li>
                                <li><a class="dropdown-item" href="#">Last 7 Days</a></li>
                                <li><a class="dropdown-item" href="#">Last 30 Days</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>Time</th>
                                    <th>Account</th>
                                    <th>Type</th>
                                    <th>Amount</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>10:23 AM</td>
                                    <td>****3456</td>
                                    <td>Transfer</td>
                                    <td>$1,200.00</td>
                                    <td><span class="badge bg-success">Completed</span></td>
                                    <td><button class="btn btn-sm btn-outline-primary">Details</button></td>
                                </tr>
                                <tr>
                                    <td>09:45 AM</td>
                                    <td>****7890</td>
                                    <td>Withdrawal</td>
                                    <td>$500.00</td>
                                    <td><span class="badge bg-success">Completed</span></td>
                                    <td><button class="btn btn-sm btn-outline-primary">Details</button></td>
                                </tr>
                                <tr>
                                    <td>09:12 AM</td>
                                    <td>****5678</td>
                                    <td>Deposit</td>
                                    <td>$2,450.00</td>
                                    <td><span class="badge bg-warning">Pending</span></td>
                                    <td><button class="btn btn-sm btn-outline-primary">Details</button></td>
                                </tr>
                                <tr>
                                    <td>08:30 AM</td>
                                    <td>****9012</td>
                                    <td>Transfer</td>
                                    <td>$750.00</td>
                                    <td><span class="badge bg-danger">Flagged</span></td>
                                    <td><button class="btn btn-sm btn-outline-danger">Review</button></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">System Status</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-4">
                            <h6>Database</h6>
                            <div class="progress mb-2" style="height: 8px;">
                                <div class="progress-bar bg-success" style="width: 65%"></div>
                            </div>
                            <small class="text-muted">65% capacity</small>
                        </div>
                        <div class="mb-4">
                            <h6>Server Load</h6>
                            <div class="progress mb-2" style="height: 8px;">
                                <div class="progress-bar bg-warning" style="width: 42%"></div>
                            </div>
                            <small class="text-muted">42% utilization</small>
                        </div>
                        <div class="mb-4">
                            <h6>Security Alerts</h6>
                            <div class="alert alert-warning p-2 mb-2">
                                <i class="bi bi-shield-exclamation me-2"></i>
                                <small>2 new login attempts from unusual locations</small>
                            </div>
                            <div class="alert alert-danger p-2">
                                <i class="bi bi-shield-lock me-2"></i>
                                <small>1 account locked due to suspicious activity</small>
                            </div>
                        </div>
                        <div class="text-center">
                            <button class="btn btn-outline-primary">
                                <i class="bi bi-arrow-clockwise me-2"></i>Run System Check
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</body>
</html>