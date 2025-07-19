<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scheduled Transfers | E-Vault</title>
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
        .transfer-card {
            border-left: 4px solid var(--primary-color);
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
            <a class="nav-link" href="${contextPath}/customer/dashboard">
                <i class="bi bi-speedometer2"></i> Dashboard
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${contextPath}/customer/accounts">
                <i class="bi bi-wallet2"></i> Accounts
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${contextPath}/customer/transfer">
                <i class="bi bi-arrow-left-right"></i> Transfers
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${contextPath}/customer/transaction-history">
                <i class="bi bi-clock-history"></i> Transaction History
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link active" href="${contextPath}/customer/scheduled-transfers">
                <i class="bi bi-graph-up"></i> Schedule Transfer
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${contextPath}/customer/settings">
                <i class="bi bi-gear"></i> Settings
            </a>
        </li>
        <li class="nav-item mt-4">
            <a class="nav-link" href="${contextPath}/logout">
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
                <h5 class="mb-0">Scheduled Transfers</h5>
            </div>
            <div class="d-flex align-items-center">
                <div class="dropdown me-3">
                    <button class="btn btn-light dropdown-toggle" type="button" id="notificationsDropdown" data-bs-toggle="dropdown">
                        <i class="bi bi-bell"></i>
                        <span class="badge bg-danger rounded-pill">3</span>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><h6 class="dropdown-header">Notifications</h6></li>
                        <li><a class="dropdown-item" href="#">New scheduled transfer</a></li>
                        <li><a class="dropdown-item" href="#">Upcoming payment</a></li>
                        <li><a class="dropdown-item" href="#">Transfer completed</a></li>
                    </ul>
                </div>
                <div class="dropdown">
                    <button class="btn btn-light dropdown-toggle" type="button" id="profileDropdown" data-bs-toggle="dropdown">
                        <i class="bi bi-person-circle me-1"></i>
                        <span>${sessionScope.user.firstName} ${sessionScope.user.lastName}</span>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="${contextPath}/customer/profile"><i class="bi bi-person me-2"></i> Profile</a></li>
                        <li><a class="dropdown-item" href="${contextPath}/customer/settings"><i class="bi bi-gear me-2"></i> Settings</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="${contextPath}/logout"><i class="bi bi-box-arrow-left me-2"></i> Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>

    <div class="container-fluid mt-4">
        <div class="row">
            <div class="col-md-8">
                <div class="card transfer-card">
                    <div class="card-body">
                        <h5 class="card-title">Schedule New Transfer</h5>

                        <form id="scheduleTransferForm" action="${contextPath}/customer/schedule-transfer" method="post">
                            <div class="mb-3">
                                <label class="form-label">From Account</label>
                                <div class="form-control bg-light">
                                    Savings Account (****3456) - $12,456.78
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="transferType" class="form-label">Transfer Type</label>
                                <select id="transferType" name="transferType" class="form-select" required>
                                    <option value="internal">Between My Accounts</option>
                                    <option value="external">To Another Person</option>
                                </select>
                            </div>

                            <div id="internalFields" class="transfer-fields">
                                <div class="mb-3">
                                    <label for="toAccount" class="form-label">To Account</label>
                                    <select id="toAccount" name="toAccount" class="form-select">
                                        <option value="">Select account</option>
                                        <option value="checking">Checking Account (****7890)</option>
                                        <option value="savings">Fixed Deposit Account (****5678)</option>
                                    </select>
                                </div>
                            </div>

                            <div id="externalFields" class="transfer-fields" style="display:none;">
                                <div class="mb-3">
                                    <label for="recipientBank" class="form-label">Recipient Bank</label>
                                    <select id="recipientBank" name="recipientBank" class="form-select">
                                        <option value="">Select bank</option>
                                        <option value="evault">E-Vault Bank</option>
                                        <option value="bankofamerica">Bank of America</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="recipientName" class="form-label">Recipient Name</label>
                                    <input type="text" name="recipientName" id="recipientName" class="form-control">
                                </div>
                                <div class="mb-3">
                                    <label for="recipientAccount" class="form-label">Account Number</label>
                                    <input type="text" name="recipientAccount" id="recipientAccount" class="form-control">
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="amount" class="form-label">Amount</label>
                                <div class="amount-input">
                                    <span class="currency-symbol">$</span>
                                    <input type="number" name="amount" id="amount" class="form-control" required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="description" class="form-label">Description</label>
                                <input type="text" name="description" id="description" class="form-control">
                            </div>

                            <div class="mb-3">
                                <label for="frequency" class="form-label">Frequency</label>
                                <select id="frequency" name="frequency" class="form-select" required>
                                    <option value="ONCE">One-time</option>
                                    <option value="DAILY">Daily</option>
                                    <option value="WEEKLY">Weekly</option>
                                    <option value="MONTHLY">Monthly</option>
                                </select>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="startDate" class="form-label">Start Date</label>
                                    <input type="date" name="startDate" id="startDate" class="form-control" required>
                                </div>
                                <div class="col-md-6 mb-3" id="endDateContainer">
                                    <label for="endDate" class="form-label">End Date (optional)</label>
                                    <input type="date" name="endDate" id="endDate" class="form-control">
                                </div>
                            </div>

                            <button type="submit" class="btn btn-primary">Schedule Transfer</button>
                        </form>
                    </div>
                </div>

                <div class="card transfer-card mt-4">
                    <div class="card-body">
                        <h5 class="card-title">Upcoming Scheduled Transfers</h5>
                        <table class="table">
                            <thead>
                            <tr>
                                <th>Date</th>
                                <th>Recipient</th>
                                <th>Amount</th>
                                <th>Frequency</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${scheduledTransfers}" var="transfer">
                                <tr>
                                    <td>${transfer.nextExecutionDate}</td>
                                    <td>${transfer.recipientName}</td>
                                    <td>$${transfer.amount}</td>
                                    <td>${transfer.frequency}</td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-danger">Cancel</button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Transfer Limits</h5>
                        <div class="mb-3">
                            <h6>Daily Limit</h6>
                            <div class="progress">
                                <div class="progress-bar bg-success" role="progressbar" style="width: 25%"></div>
                            </div>
                            <small>$250 of $1,000 used</small>
                        </div>
                        <div class="mb-3">
                            <h6>Monthly Limit</h6>
                            <div class="progress">
                                <div class="progress-bar bg-warning" role="progressbar" style="width: 65%"></div>
                            </div>
                            <small>$6,500 of $10,000 used</small>
                        </div>
                    </div>
                </div>

                <div class="card mt-4">
                    <div class="card-body">
                        <h5 class="card-title">Recent Scheduled Transfers</h5>
                        <ul class="list-group list-group-flush">
                            <c:forEach items="${recentScheduledTransfers}" var="transfer">
                                <li class="list-group-item">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h6>${transfer.recipientName}</h6>
                                            <small class="text-muted">${transfer.nextExecutionDate}</small>
                                        </div>
                                        <span class="text-primary">$${transfer.amount}</span>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Toggle sidebar on mobile
    document.getElementById('sidebarToggle').addEventListener('click', function() {
        document.querySelector('.sidebar').classList.toggle('d-none');
    });

    // Show/hide fields based on transfer type
    document.getElementById('transferType').addEventListener('change', function() {
        const type = this.value;
        document.querySelectorAll('.transfer-fields').forEach(el => {
            el.style.display = 'none';
        });
        document.getElementById(type + 'Fields').style.display = 'block';
    });

    // Hide end date for one-time transfers
    document.getElementById('frequency').addEventListener('change', function() {
        const endDateContainer = document.getElementById('endDateContainer');
        if (this.value === 'ONCE') {
            endDateContainer.style.display = 'none';
        } else {
            endDateContainer.style.display = 'block';
        }
    });
</script>
</body>
</html>