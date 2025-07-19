<%--
  Created by IntelliJ IDEA.
  User: savindu umantha
  Date: 7/10/2025
  Time: 10:12 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | E-Vault</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-color: #1e3c72;
            --secondary-color: #2a5298;
        }
        body {
            background-color: #f8f9fa;
        }
        .sidebar {
            background-color: var(--primary-color);
            color: white;
            height: 100vh;
            position: fixed;
            width: 250px;
            padding-top: 20px;
        }
        .sidebar .nav-link {
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 5px;
            border-radius: 5px;
            padding: 10px 15px;
        }
        .sidebar .nav-link:hover, .sidebar .nav-link.active {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
        }
        .sidebar .nav-link i {
            margin-right: 10px;
        }
        .main-content {
            margin-left: 250px;
            padding: 20px;
        }
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .account-card {
            border-left: 4px solid var(--primary-color);
        }
        .quick-action {
            text-align: center;
            padding: 15px;
            border-radius: 10px;
            background-color: white;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: all 0.3s;
            cursor: pointer;
        }
        .quick-action:hover {
            background-color: var(--primary-color);
            color: white;
            transform: translateY(-3px);
        }
        .quick-action i {
            font-size: 24px;
            margin-bottom: 10px;
        }
        .navbar {
            background-color: white !important;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
<div class="sidebar">
    <div class="text-center mb-4">
        <h4>E-Vault</h4>
    </div>
    <ul class="nav flex-column">
        <li class="nav-item">
            <a class="nav-link active" href="dashboard.jsp">
                <i class="bi bi-speedometer2"></i> Dashboard
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="account.jsp">
                <i class="bi bi-wallet2"></i> Accounts
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="transfer.jsp">
                <i class="bi bi-arrow-left-right"></i> Transfers
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="transaction_history.jsp">
                <i class="bi bi-clock-history"></i> Transaction History
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="scheduled-transfers.jsp">
                <i class="bi bi-graph-up"></i> Schedule Transfer
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="bi bi-gear"></i> Settings
            </a>
        </li>
        <li class="nav-item mt-4">
            <a class="nav-link" href="Logout">
                <i class="bi bi-box-arrow-left"></i> Logout
            </a>
        </li>
    </ul>
</div>

<div class="main-content">
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <div class="d-flex align-items-center">
                <button class="btn btn-outline-secondary me-3 d-lg-none" id="sidebarToggle">
                    <i class="bi bi-list"></i>
                </button>
                <h5 class="mb-0">Dashboard</h5>
            </div>
            <div class="d-flex align-items-center">
                <div class="dropdown me-3">
                    <button class="btn btn-light dropdown-toggle" type="button" id="notificationsDropdown" data-bs-toggle="dropdown">
                        <i class="bi bi-bell"></i>
                        <span class="badge bg-danger rounded-pill">3</span>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><h6 class="dropdown-header">Notifications</h6></li>
                        <li><a class="dropdown-item" href="#">New transaction received</a></li>
                        <li><a class="dropdown-item" href="#">Scheduled payment processed</a></li>
                        <li><a class="dropdown-item" href="#">Account statement ready</a></li>
                    </ul>
                </div>
                <div class="dropdown">
                    <button class="btn btn-light dropdown-toggle" type="button" id="profileDropdown" data-bs-toggle="dropdown">
                        <i class="bi bi-person-circle me-1"></i>
                        <span>${sessionScope.user.firstName} ${sessionScope.user.lastName}</span>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="#"><i class="bi bi-person me-2"></i> Profile</a></li>
                        <li><a class="dropdown-item" href="#"><i class="bi bi-gear me-2"></i> Settings</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="Logout"><i class="bi bi-box-arrow-left me-2"></i> Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>

    <div class="container-fluid mt-4">
        <div class="row">
            <div class="col-md-6 mb-4">
                <div class="card account-card">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="card-title mb-0">Primary Account</h5>
                            <span class="badge bg-primary">Active</span>
                        </div>
                        <h3 class="card-text mb-4">$12,456.78</h3>
                        <div class="d-flex justify-content-between">
                            <small class="text-muted">Account Number: ****3456</small>
                            <small class="text-muted">Savings Account</small>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mb-4">
                <div class="card account-card">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="card-title mb-0">Credit Card</h5>
                            <span class="badge bg-success">Paid</span>
                        </div>
                        <h3 class="card-text mb-4">$2,345.67</h3>
                        <div class="d-flex justify-content-between">
                            <small class="text-muted">Card Number: ****7890</small>
                            <small class="text-muted">VISA Platinum</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Quick Actions</h5>
                        <div class="row text-center">
                            <div class="col-md-3 mb-3">
                                <div class="quick-action">
                                    <i class="bi bi-send"></i>
                                    <p>Transfer Money</p>
                                </div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <div class="quick-action">
                                    <i class="bi bi-cash-coin"></i>
                                    <p>Pay Bills</p>
                                </div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <div class="quick-action">
                                    <i class="bi bi-calendar-plus"></i>
                                    <p>Schedule Payment</p>
                                </div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <div class="quick-action">
                                    <i class="bi bi-download"></i>
                                    <p>Request Statement</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-8 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Recent Transactions</h5>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>Date</th>
                                    <th>Description</th>
                                    <th>Amount</th>
                                    <th>Status</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>Oct 15, 2023</td>
                                    <td>Grocery Store</td>
                                    <td class="text-danger">-$125.67</td>
                                    <td><span class="badge bg-success">Completed</span></td>
                                </tr>
                                <tr>
                                    <td>Oct 14, 2023</td>
                                    <td>Salary Deposit</td>
                                    <td class="text-success">+$3,456.00</td>
                                    <td><span class="badge bg-success">Completed</span></td>
                                </tr>
                                <tr>
                                    <td>Oct 12, 2023</td>
                                    <td>Utility Bill Payment</td>
                                    <td class="text-danger">-$87.23</td>
                                    <td><span class="badge bg-success">Completed</span></td>
                                </tr>
                                <tr>
                                    <td>Oct 10, 2023</td>
                                    <td>Online Shopping</td>
                                    <td class="text-danger">-$56.89</td>
                                    <td><span class="badge bg-success">Completed</span></td>
                                </tr>
                                <tr>
                                    <td>Oct 8, 2023</td>
                                    <td>Interest Earned</td>
                                    <td class="text-success">+$12.34</td>
                                    <td><span class="badge bg-success">Completed</span></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Spending Overview</h5>
                        <div id="spendingChart" style="height: 250px;"></div>
                        <div class="mt-3">
                            <div class="d-flex justify-content-between mb-2">
                                <span>Food & Dining</span>
                                <span>$345.67</span>
                            </div>
                            <div class="progress mb-3" style="height: 8px;">
                                <div class="progress-bar bg-danger" role="progressbar" style="width: 45%"></div>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Shopping</span>
                                <span>$234.56</span>
                            </div>
                            <div class="progress mb-3" style="height: 8px;">
                                <div class="progress-bar bg-warning" role="progressbar" style="width: 30%"></div>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Utilities</span>
                                <span>$123.45</span>
                            </div>
                            <div class="progress mb-3" style="height: 8px;">
                                <div class="progress-bar bg-info" role="progressbar" style="width: 15%"></div>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Entertainment</span>
                                <span>$89.12</span>
                            </div>
                            <div class="progress" style="height: 8px;">
                                <div class="progress-bar bg-success" role="progressbar" style="width: 10%"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    // Toggle sidebar on mobile
    document.getElementById('sidebarToggle').addEventListener('click', function() {
        document.querySelector('.sidebar').classList.toggle('d-none');
    });

    // Initialize spending chart
    const ctx = document.getElementById('spendingChart').getContext('2d');
    const spendingChart = new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ['Food & Dining', 'Shopping', 'Utilities', 'Entertainment', 'Others'],
            datasets: [{
                data: [45, 30, 15, 7, 3],
                backgroundColor: [
                    '#dc3545',
                    '#ffc107',
                    '#0dcaf0',
                    '#198754',
                    '#6c757d'
                ],
                borderWidth: 0
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'bottom'
                }
            }
        }
    });

    // Quick action click handlers
    document.querySelectorAll('.quick-action').forEach(action => {
        action.addEventListener('click', function() {
            const actionText = this.querySelector('p').textContent;
            alert(`You clicked on ${actionText}`);
        });
    });
</script>
</body>
</html>