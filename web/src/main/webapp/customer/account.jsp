<%--
  Created by IntelliJ IDEA.
  User: savindu umantha
  Date: 7/10/2025
  Time: 10:13 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accounts | E-Vault</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-color: #1e3c72;
            --secondary-color: #2a5298;
        }
        .sidebar {
            background-color: var(--primary-color);
            color: white;
            height: 100vh;
            position: fixed;
            width: 250px;
            padding-top: 20px;
        }
        .main-content {
            margin-left: 250px;
            padding: 20px;
        }
        .account-card {
            border-left: 4px solid var(--primary-color);
            transition: transform 0.3s;
        }
        .account-card:hover {
            transform: translateY(-5px);
        }
        .navbar {
            background-color: white !important;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .tab-content {
            padding: 20px;
            background-color: white;
            border-radius: 0 0 10px 10px;
        }
        .nav-tabs .nav-link.active {
            font-weight: bold;
            border-bottom: 3px solid var(--primary-color);
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
            <a class="nav-link" href="dashboard.jsp">
                <i class="bi bi-speedometer2"></i> Dashboard
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link active" href="account.jsp">
                <i class="bi bi-wallet2"></i> Accounts
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="transfer.jsp">
                <i class="bi bi-arrow-left-right"></i> Transfers
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">
                <i class="bi bi-clock-history"></i> Transaction History
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="../admin/report.jsp">
                <i class="bi bi-graph-up"></i> Reports
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
                <h5 class="mb-0">Accounts</h5>
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
        <div class="row mb-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="card-title mb-0">Your Accounts</h5>
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#newAccountModal">
                                <i class="bi bi-plus-circle me-1"></i> Open New Account
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6 mb-4">
                <div class="card account-card h-100">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="card-title mb-0">Primary Savings</h5>
                            <div>
                                <span class="badge bg-primary me-1">Active</span>
                                <button class="btn btn-sm btn-outline-secondary">
                                    <i class="bi bi-three-dots-vertical"></i>
                                </button>
                            </div>
                        </div>
                        <h3 class="card-text mb-4">$12,456.78</h3>
                        <div class="d-flex justify-content-between mb-3">
                            <small class="text-muted">Account Number: ****3456</small>
                            <small class="text-muted">Interest Rate: 1.5%</small>
                        </div>
                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <button class="btn btn-outline-primary me-md-2">Details</button>
                            <button class="btn btn-primary">Transfer</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mb-4">
                <div class="card account-card h-100">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="card-title mb-0">Checking Account</h5>
                            <div>
                                <span class="badge bg-primary me-1">Active</span>
                                <button class="btn btn-sm btn-outline-secondary">
                                    <i class="bi bi-three-dots-vertical"></i>
                                </button>
                            </div>
                        </div>
                        <h3 class="card-text mb-4">$5,678.90</h3>
                        <div class="d-flex justify-content-between mb-3">
                            <small class="text-muted">Account Number: ****7890</small>
                            <small class="text-muted">Monthly Fee: $0</small>
                        </div>
                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <button class="btn btn-outline-primary me-md-2">Details</button>
                            <button class="btn btn-primary">Transfer</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <ul class="nav nav-tabs" id="accountTabs" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="transactions-tab" data-bs-toggle="tab" data-bs-target="#transactions" type="button">Transactions</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="statements-tab" data-bs-toggle="tab" data-bs-target="#statements" type="button">Statements</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="beneficiaries-tab" data-bs-toggle="tab" data-bs-target="#beneficiaries" type="button">Beneficiaries</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="settings-tab" data-bs-toggle="tab" data-bs-target="#settings" type="button">Account Settings</button>
                            </li>
                        </ul>
                        <div class="tab-content" id="accountTabsContent">
                            <div class="tab-pane fade show active" id="transactions" role="tabpanel">
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                        <tr>
                                            <th>Date</th>
                                            <th>Description</th>
                                            <th>Amount</th>
                                            <th>Balance</th>
                                            <th>Status</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td>Oct 15, 2023</td>
                                            <td>Grocery Store</td>
                                            <td class="text-danger">-$125.67</td>
                                            <td>$12,456.78</td>
                                            <td><span class="badge bg-success">Completed</span></td>
                                        </tr>
                                        <tr>
                                            <td>Oct 14, 2023</td>
                                            <td>Salary Deposit</td>
                                            <td class="text-success">+$3,456.00</td>
                                            <td>$12,582.45</td>
                                            <td><span class="badge bg-success">Completed</span></td>
                                        </tr>
                                        <tr>
                                            <td>Oct 12, 2023</td>
                                            <td>Utility Bill Payment</td>
                                            <td class="text-danger">-$87.23</td>
                                            <td>$9,126.45</td>
                                            <td><span class="badge bg-success">Completed</span></td>
                                        </tr>
                                        <tr>
                                            <td>Oct 10, 2023</td>
                                            <td>Online Shopping</td>
                                            <td class="text-danger">-$56.89</td>
                                            <td>$9,213.68</td>
                                            <td><span class="badge bg-success">Completed</span></td>
                                        </tr>
                                        <tr>
                                            <td>Oct 8, 2023</td>
                                            <td>Interest Earned</td>
                                            <td class="text-success">+$12.34</td>
                                            <td>$9,270.57</td>
                                            <td><span class="badge bg-success">Completed</span></td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <nav aria-label="Transaction pagination">
                                    <ul class="pagination justify-content-center">
                                        <li class="page-item disabled">
                                            <a class="page-link" href="#" tabindex="-1">Previous</a>
                                        </li>
                                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                                        <li class="page-item">
                                            <a class="page-link" href="#">Next</a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                            <div class="tab-pane fade" id="statements" role="tabpanel">
                                <div class="alert alert-info">
                                    <i class="bi bi-info-circle me-2"></i> Download your account statements for record keeping or tax purposes.
                                </div>
                                <div class="list-group">
                                    <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                                        September 2023 Statement
                                        <span class="badge bg-primary rounded-pill">PDF</span>
                                    </a>
                                    <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                                        August 2023 Statement
                                        <span class="badge bg-primary rounded-pill">PDF</span>
                                    </a>
                                    <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                                        July 2023 Statement
                                        <span class="badge bg-primary rounded-pill">PDF</span>
                                    </a>
                                    <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                                        June 2023 Statement
                                        <span class="badge bg-primary rounded-pill">PDF</span>
                                    </a>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="beneficiaries" role="tabpanel">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h6>Your Beneficiaries</h6>
                                    <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#addBeneficiaryModal">
                                        <i class="bi bi-plus me-1"></i> Add Beneficiary
                                    </button>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>Account Number</th>
                                            <th>Bank</th>
                                            <th>Nickname</th>
                                            <th>Actions</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td>John Smith</td>
                                            <td>****5678</td>
                                            <td>National Bank</td>
                                            <td>Brother</td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-primary me-1">Edit</button>
                                                <button class="btn btn-sm btn-outline-danger">Delete</button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Acme Corp</td>
                                            <td>****9012</td>
                                            <td>Global Bank</td>
                                            <td>Vendor</td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-primary me-1">Edit</button>
                                                <button class="btn btn-sm btn-outline-danger">Delete</button>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="settings" role="tabpanel">
                                <form>
                                    <div class="mb-3">
                                        <label for="accountNickname" class="form-label">Account Nickname</label>
                                        <input type="text" class="form-control" id="accountNickname" value="Primary Savings">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Account Alerts</label>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="lowBalanceAlert" checked>
                                            <label class="form-check-label" for="lowBalanceAlert">
                                                Low balance alert
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="largeTransactionAlert" checked>
                                            <label class="form-check-label" for="largeTransactionAlert">
                                                Large transaction alert
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="depositAlert">
                                            <label class="form-check-label" for="depositAlert">
                                                Deposit alert
                                            </label>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="statementDelivery" class="form-label">Statement Delivery</label>
                                        <select class="form-select" id="statementDelivery">
                                            <option selected>Electronic Only</option>
                                            <option>Paper Only</option>
                                            <option>Both</option>
                                        </select>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Save Changes</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- New Account Modal -->
<div class="modal fade" id="newAccountModal" tabindex="-1" aria-labelledby="newAccountModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="newAccountModalLabel">Open New Account</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="mb-3">
                        <label for="accountType" class="form-label">Account Type</label>
                        <select class="form-select" id="accountType">
                            <option selected disabled>Select account type</option>
                            <option>Savings Account</option>
                            <option>Checking Account</option>
                            <option>Money Market Account</option>
                            <option>Certificate of Deposit</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="initialDeposit" class="form-label">Initial Deposit</label>
                        <div class="input-group">
                            <span class="input-group-text">$</span>
                            <input type="number" class="form-control" id="initialDeposit" placeholder="0.00">
                        </div>
                    </div>
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="agreeTerms">
                        <label class="form-check-label" for="agreeTerms">I agree to the terms and conditions</label>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary">Open Account</button>
            </div>
        </div>
    </div>
</div>

<!-- Add Beneficiary Modal -->
<div class="modal fade" id="addBeneficiaryModal" tabindex="-1" aria-labelledby="addBeneficiaryModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addBeneficiaryModalLabel">Add New Beneficiary</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="mb-3">
                        <label for="beneficiaryName" class="form-label">Full Name</label>
                        <input type="text" class="form-control" id="beneficiaryName" placeholder="Enter beneficiary's full name">
                    </div>
                    <div class="mb-3">
                        <label for="accountNumber" class="form-label">Account Number</label>
                        <input type="text" class="form-control" id="accountNumber" placeholder="Enter account number">
                    </div>
                    <div class="mb-3">
                        <label for="bankName" class="form-label">Bank Name</label>
                        <input type="text" class="form-control" id="bankName" placeholder="Enter bank name">
                    </div>
                    <div class="mb-3">
                        <label for="nickname" class="form-label">Nickname (Optional)</label>
                        <input type="text" class="form-control" id="nickname" placeholder="e.g., Brother, Vendor">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary">Add Beneficiary</button>
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
</script>
</body>
</html>