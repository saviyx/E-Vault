<%--
  Created by IntelliJ IDEA.
  User: savindu umantha
  Date: 7/11/2025
  Time: 1:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Dashboard | E-Vault</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --sidebar-width: 250px;
            --primary-color: #1e3c72;
        }
        .staff-sidebar {
            background-color: var(--primary-color);
            color: white;
            height: 100vh;
            position: fixed;
            width: var(--sidebar-width);
        }
        .staff-main {
            margin-left: var(--sidebar-width);
            padding: 20px;
        }
        .staff-navbar {
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
        .badge-position {
            font-size: 0.75rem;
            text-transform: uppercase;
        }
    </style>
</head>
<body>
<div class="staff-sidebar">
    <div class="text-center p-4">
        <h4>E-Vault Staff</h4>
        <div class="mt-3">
            <div class="d-flex justify-content-center mb-3">
                <div class="bg-white rounded-circle p-1" style="width: 80px; height: 80px;">
                    <i class="bi bi-person-badge text-primary" style="font-size: 3rem;"></i>
                </div>
            </div>
            <h6>${staff.firstName} ${staff.lastName}</h6>
            <div class="badge bg-light text-primary badge-position mt-1">
                ${staff.position} | ${staff.branch}
            </div>
            <small class="text-muted d-block mt-1">ID: ${staff.staffId}</small>
        </div>
    </div>
    <ul class="nav flex-column">
        <li class="nav-item">
            <a class="nav-link active" href="#">
                <i class="bi bi-speedometer2 me-2"></i> Dashboard
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/staff/customers">
                <i class="bi bi-people me-2"></i> Customer Management
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/staff/add-customer">
                <i class="bi bi-person-plus me-2"></i> Add New Customer
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/staff/transactions">
                <i class="bi bi-arrow-left-right me-2"></i> Process Transactions
            </a>
        </li>
        <c:if test="${staff.position == 'MANAGER'}">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/staff/reports">
                    <i class="bi bi-graph-up me-2"></i> Branch Reports
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/staff/approvals">
                    <i class="bi bi-check-circle me-2"></i> Approvals
                </a>
            </li>
        </c:if>
        <li class="nav-item mt-4">
            <a class="nav-link" href="${pageContext.request.contextPath}/staff/logout">
                <i class="bi bi-box-arrow-left me-2"></i> Logout
            </a>
        </li>
    </ul>
</div>

<div class="staff-main">
    <nav class="navbar navbar-expand-lg staff-navbar">
        <div class="container-fluid">
            <h5 class="mb-0">Staff Dashboard</h5>
            <div class="d-flex align-items-center">
                <div class="dropdown me-3">
                    <button class="btn btn-light dropdown-toggle" type="button" id="notificationsDropdown" data-bs-toggle="dropdown">
                        <i class="bi bi-bell"></i>
                        <span class="badge bg-danger rounded-pill">${unreadNotifications}</span>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><h6 class="dropdown-header">Staff Notifications</h6></li>
                        <c:forEach items="${notifications}" var="notification">
                            <li><a class="dropdown-item ${notification.read ? '' : 'fw-bold'}" href="#">
                                <i class="bi bi-${notification.icon} me-2"></i>
                                    ${notification.message}
                            </a></li>
                        </c:forEach>
                    </ul>
                </div>
                <span class="badge bg-primary">${staff.position}</span>
            </div>
        </div>
    </nav>

    <div class="container-fluid mt-4">
        <!-- Quick Actions -->
        <div class="row mb-4">
            <div class="col-md-3 mb-3">
                <div class="stat-card card h-100">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="card-title text-muted">Today's Customers</h6>
                                <h3 class="mb-0">${todayCustomers}</h3>
                            </div>
                            <i class="bi bi-people-fill text-primary" style="font-size: 2rem;"></i>
                        </div>
                        <a href="${pageContext.request.contextPath}/staff/customers?filter=today"
                           class="stretched-link"></a>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stat-card card h-100">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="card-title text-muted">Pending Approvals</h6>
                                <h3 class="mb-0">${pendingApprovals}</h3>
                            </div>
                            <i class="bi bi-clock-history text-warning" style="font-size: 2rem;"></i>
                        </div>
                        <c:if test="${pendingApprovals > 0}">
                            <a href="${pageContext.request.contextPath}/staff/approvals"
                               class="stretched-link"></a>
                        </c:if>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stat-card card h-100">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="card-title text-muted">Today's Transactions</h6>
                                <h3 class="mb-0">${todayTransactions}</h3>
                            </div>
                            <i class="bi bi-cash-stack text-success" style="font-size: 2rem;"></i>
                        </div>
                        <a href="${pageContext.request.contextPath}/staff/transactions?filter=today"
                           class="stretched-link"></a>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stat-card card h-100">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="card-title text-muted">Alerts</h6>
                                <h3 class="mb-0">${alertsCount}</h3>
                            </div>
                            <i class="bi bi-exclamation-triangle-fill text-danger" style="font-size: 2rem;"></i>
                        </div>
                        <c:if test="${alertsCount > 0}">
                            <a href="${pageContext.request.contextPath}/staff/alerts"
                               class="stretched-link"></a>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Activity -->
        <div class="row">
            <div class="col-md-8">
                <div class="card mb-4">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Recent Customer Activities</h5>
                        <a href="${pageContext.request.contextPath}/staff/customers" class="btn btn-sm btn-outline-primary">
                            View All
                        </a>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>Time</th>
                                    <th>Customer</th>
                                    <th>Activity</th>
                                    <th>Account</th>
                                    <th>Staff</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${recentActivities}" var="activity">
                                    <tr>
                                        <td>${activity.time}</td>
                                        <td>${activity.customerName}</td>
                                        <td>
                                                    <span class="badge bg-${activity.type == 'NEW_ACCOUNT' ? 'success' : 'primary'}">
                                                            ${activity.type}
                                                    </span>
                                        </td>
                                        <td>${activity.accountNumber}</td>
                                        <td>${activity.staffName}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="mb-0">Quick Actions</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-grid gap-2">
                            <a href="${pageContext.request.contextPath}/staff/add-customer"
                               class="btn btn-primary mb-2">
                                <i class="bi bi-person-plus me-2"></i> Add New Customer
                            </a>
                            <a href="${pageContext.request.contextPath}/staff/transactions/new"
                               class="btn btn-outline-primary mb-2">
                                <i class="bi bi-cash-coin me-2"></i> Process Transaction
                            </a>
                            <a href="${pageContext.request.contextPath}/staff/accounts/open"
                               class="btn btn-outline-primary mb-2">
                                <i class="bi bi-bank me-2"></i> Open New Account
                            </a>
                            <c:if test="${staff.position == 'MANAGER'}">
                                <a href="${pageContext.request.contextPath}/staff/reports"
                                   class="btn btn-outline-success mb-2">
                                    <i class="bi bi-graph-up me-2"></i> Generate Reports
                                </a>
                            </c:if>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">Branch Status</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <h6>Customers Served Today</h6>
                            <div class="progress mb-2" style="height: 8px;">
                                <div class="progress-bar" style="width: ${customersPercentage}%"></div>
                            </div>
                            <small class="text-muted">${todayCustomers} of ${dailyTarget} target</small>
                        </div>
                        <div class="mb-3">
                            <h6>Transaction Volume</h6>
                            <div class="progress mb-2" style="height: 8px;">
                                <div class="progress-bar bg-success" style="width: ${txnPercentage}%"></div>
                            </div>
                            <small class="text-muted">$${todayTransactionAmount} processed</small>
                        </div>
                        <div class="alert alert-info">
                            <i class="bi bi-info-circle me-2"></i>
                            <small>Next system maintenance: ${nextMaintenance}</small>
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
