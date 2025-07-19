<%
    System.out.println("transfer.jsp - Session: " + (session != null ? session.getId() : "null"));
    System.out.println("transfer.jsp - customerId: " + session.getAttribute("customerId"));
    System.out.println("transfer.jsp - customer: " + session.getAttribute("customer"));
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transfers | E-Vault</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-color: #1e3c72;
            --secondary-color: #2a5298;
            --success-color: #28a745;
            --danger-color: #dc3545;
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
        .navbar {
            background-color: white !important;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .transfer-card {
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .nav-pills .nav-link.active {
            background-color: var(--primary-color);
        }
        .transfer-tab-content {
            display: none;
        }
        .transfer-tab-content.active {
            display: block;
        }
        .alert-message {
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
        }
        .alert-success {
            background-color: rgba(40, 167, 69, 0.1);
            color: var(--success-color);
            border-left: 4px solid var(--success-color);
        }
        .alert-error {
            background-color: rgba(220, 53, 69, 0.1);
            color: var(--danger-color);
            border-left: 4px solid var(--danger-color);
        }
        .amount-input {
            position: relative;
        }
        .amount-input .currency-symbol {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            font-weight: 600;
            color: var(--dark);
        }
        .amount-input .form-control {
            padding-left: 2.5rem;
        }
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
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
            <a class="nav-link" href="account.jsp">
                <i class="bi bi-wallet2"></i> Accounts
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link active" href="transfer.jsp">
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
                <h5 class="mb-0">Transfers</h5>
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
            <div class="col-md-8">
                <!-- Alert Messages -->
                <c:if test="${not empty success}">
                    <div class="alert-message alert-success">
                        <i class="bi bi-check-circle"></i> ${success}
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert-message alert-error">
                        <i class="bi bi-exclamation-circle"></i> ${error}
                    </div>
                </c:if>

                <div class="card transfer-card mb-4">
                    <div class="card-body">
                        <!-- Transfer Type Tabs -->
                        <ul class="nav nav-tabs mb-4" id="transferTypeTabs">
                            <li class="nav-item">
                                <a class="nav-link active" data-bs-toggle="tab" href="#internal">Between My Accounts</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" data-bs-toggle="tab" href="#external">To Another Person</a>
                            </li>
                        </ul>

                        <!-- Tab Content -->
                        <div class="tab-content">
                            <!-- Internal Transfer Form -->
                            <div class="tab-pane fade show active" id="internal">
                                <form id="internalTransferForm" action="${pageContext.request.contextPath}/customer/transaction" method="post">
                                    <input type="hidden" name="transferType" value="internal">

                                    <div class="mb-3">
                                        <label class="form-label">From Account</label>
                                        <div class="form-control bg-light">
                                            Savings Account (****3456) - $12,456.78
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="toAccount" class="form-label">To Account</label>
                                        <select id="toAccount" name="toAccount" class="form-select" required>
                                            <option value="">Select account</option>
                                            <option value="checking">Checking Account (****7890)</option>
                                            <option value="savings">Fixed Deposit Account (****5678)</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="amount" class="form-label">Amount</label>
                                        <div class="amount-input">
                                            <span class="currency-symbol">$</span>
                                            <input type="number" name="amount" id="amount" class="form-control" placeholder="0.00" min="1" step="0.01" required>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="description" class="form-label">Description (Optional)</label>
                                        <input type="text" name="description" id="description" class="form-control" placeholder="e.g. Rent payment, Gift, etc.">
                                    </div>

                                    <button type="submit" class="btn btn-primary w-100">Transfer Money</button>
                                </form>
                            </div>

                            <!-- External Transfer Form -->
                            <div class="tab-pane fade" id="external">
                                <div class="alert alert-info">
                                    <i class="bi bi-info-circle me-2"></i> External transfers may take 1-3 business days to process.
                                </div>
                                <form id="externalTransferForm" action="${pageContext.request.contextPath}/customer/transaction" method="post">
                                    <input type="hidden" name="transferType" value="external">

                                    <div class="mb-3">
                                        <label class="form-label">From Account</label>
                                        <div class="form-control bg-light">
                                            Savings Account (****3456) - $12,456.78
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="recipientBank" class="form-label">Recipient Bank</label>
                                        <select id="recipientBank" name="recipientBank" class="form-select" required>
                                            <option value="">Select bank</option>
                                            <option value="evault">E-Vault Bank</option>
                                            <option value="bankofamerica">Bank of America</option>
                                            <option value="wellsfargo">Wells Fargo</option>
                                            <option value="citibank">Citibank</option>
                                            <option value="usbank">U.S. Bank</option>
                                            <option value="other">Other Bank</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="recipientName" class="form-label">Recipient Name</label>
                                        <input type="text" name="recipientName" id="recipientName" class="form-control" placeholder="Enter recipient's full name" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="recipientAccount" class="form-label">Account Number</label>
                                        <input type="text" name="recipientAccount" id="recipientAccount" class="form-control" placeholder="Enter recipient's account number" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="amountExternal" class="form-label">Amount</label>
                                        <div class="amount-input">
                                            <span class="currency-symbol">$</span>
                                            <input type="number" name="amount" id="amountExternal" class="form-control" placeholder="0.00" min="1" step="0.01" required>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="descriptionExternal" class="form-label">Description (Optional)</label>
                                        <input type="text" name="description" id="descriptionExternal" class="form-control" placeholder="e.g. Rent payment, Gift, etc.">
                                    </div>

                                    <button type="submit" class="btn btn-primary w-100">Transfer Money</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card transfer-card">
                    <div class="card-body">
                        <h6 class="card-title mb-3">Transfer Limits</h6>
                        <div class="mb-3">
                            <p class="mb-1"><strong>Per Transaction Limit:</strong></p>
                            <p>$10,000.00</p>
                        </div>
                        <div class="mb-3">
                            <p class="mb-1"><strong>Daily Limit:</strong></p>
                            <p>$25,000.00</p>
                        </div>
                        <div class="mb-3">
                            <p class="mb-1"><strong>Monthly Limit:</strong></p>
                            <p>$100,000.00</p>
                        </div>
                        <hr>
                        <h6 class="card-title mb-3">Recent Transfers</h6>
                        <div class="list-group">
                            <a href="#" class="list-group-item list-group-item-action">
                                <div class="d-flex w-100 justify-content-between">
                                    <small class="text-muted">Today, 14:30</small>
                                </div>
                                <p class="mb-1">To Checking Account</p>
                                <small class="text-danger">-$500.00</small>
                            </a>
                            <a href="#" class="list-group-item list-group-item-action">
                                <div class="d-flex w-100 justify-content-between">
                                    <small class="text-muted">Yesterday</small>
                                </div>
                                <p class="mb-1">To John Smith</p>
                                <small class="text-danger">-$200.00</small>
                            </a>
                            <a href="#" class="list-group-item list-group-item-action">
                                <div class="d-flex w-100 justify-content-between">
                                    <small class="text-muted">Oct 10, 2023</small>
                                </div>
                                <p class="mb-1">From Salary Deposit</p>
                                <small class="text-success">+$3,456.00</small>
                            </a>
                        </div>
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

    // Form validation and submission handling
    document.querySelectorAll('form').forEach(form => {
        form.addEventListener('submit', function(e) {
            // Validate form
            const inputs = this.querySelectorAll('input[required], select[required]');
            let isValid = true;

            inputs.forEach(input => {
                if (!input.value) {
                    input.style.borderColor = 'var(--danger-color)';
                    input.style.animation = 'shake 0.5s';
                    isValid = false;

                    input.addEventListener('animationend', () => {
                        input.style.animation = '';
                    });
                }
            });

            if (!isValid) {
                e.preventDefault();
            } else {
                const submitButton = this.querySelector('button[type="submit"]');
                submitButton.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Processing...';
                submitButton.disabled = true;
            }
        });
    });
</script>
</body>
</html>