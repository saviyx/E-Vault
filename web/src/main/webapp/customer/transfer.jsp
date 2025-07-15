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
    <title>Transfers | E-Vault</title>
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
        .transfer-step {
            display: none;
        }
        .transfer-step.active {
            display: block;
        }
        .progress {
            height: 8px;
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
                <div class="card transfer-card mb-4">
                    <div class="card-body">
                        <ul class="nav nav-pills mb-4" id="transferTypeTabs" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="internal-tab" data-bs-toggle="pill" data-bs-target="#internal" type="button">Internal Transfer</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="external-tab" data-bs-toggle="pill" data-bs-target="#external" type="button">External Transfer</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="scheduled-tab" data-bs-toggle="pill" data-bs-target="#scheduled" type="button">Scheduled Transfer</button>
                            </li>
                        </ul>
                        <div class="tab-content" id="transferTypeTabsContent">
                            <div class="tab-pane fade show active" id="internal" role="tabpanel">
                                <div id="transferProgress" class="mb-4">
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Step 1: Transfer Details</span>
                                        <span>Step 2: Review</span>
                                        <span>Step 3: Confirmation</span>
                                    </div>
                                    <div class="progress">
                                        <div class="progress-bar" role="progressbar" style="width: 33%;"></div>
                                    </div>
                                </div>

                                <div class="transfer-step active" id="step1">
                                    <form id="transferForm">
                                        <div class="mb-3">
                                            <label for="fromAccount" class="form-label">From Account</label>
                                            <select class="form-select" id="fromAccount" required>
                                                <option selected disabled>Select account</option>
                                                <option>Primary Savings (****3456) - $12,456.78</option>
                                                <option>Checking Account (****7890) - $5,678.90</option>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label for="toAccount" class="form-label">To Account</label>
                                            <select class="form-select" id="toAccount" required>
                                                <option selected disabled>Select account</option>
                                                <option>Primary Savings (****3456)</option>
                                                <option>Checking Account (****7890)</option>
                                                <option>John Smith (****5678) - National Bank</option>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label for="amount" class="form-label">Amount</label>
                                            <div class="input-group">
                                                <span class="input-group-text">$</span>
                                                <input type="number" class="form-control" id="amount" placeholder="0.00" min="0.01" step="0.01" required>
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <label for="description" class="form-label">Description (Optional)</label>
                                            <input type="text" class="form-control" id="description" placeholder="e.g., Rent payment">
                                        </div>
                                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                            <button type="button" class="btn btn-primary" id="nextStep1">Next</button>
                                        </div>
                                    </form>
                                </div>

                                <div class="transfer-step" id="step2">
                                    <h6 class="mb-4">Review Your Transfer</h6>
                                    <div class="card mb-3">
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <p class="mb-1"><strong>From Account:</strong></p>
                                                    <p id="reviewFromAccount">Primary Savings (****3456)</p>

                                                    <p class="mb-1"><strong>Amount:</strong></p>
                                                    <p id="reviewAmount">$0.00</p>
                                                </div>
                                                <div class="col-md-6">
                                                    <p class="mb-1"><strong>To Account:</strong></p>
                                                    <p id="reviewToAccount">Checking Account (****7890)</p>

                                                    <p class="mb-1"><strong>Description:</strong></p>
                                                    <p id="reviewDescription">-</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mb-3 form-check">
                                        <input type="checkbox" class="form-check-input" id="confirmTransfer" required>
                                        <label class="form-check-label" for="confirmTransfer">I confirm the details of this transfer are correct</label>
                                    </div>
                                    <div class="d-grid gap-2 d-md-flex justify-content-md-between">
                                        <button type="button" class="btn btn-outline-secondary" id="backStep2">Back</button>
                                        <button type="button" class="btn btn-primary" id="nextStep2">Confirm & Transfer</button>
                                    </div>
                                </div>

                                <div class="transfer-step" id="step3">
                                    <div class="text-center py-4">
                                        <div class="mb-4">
                                            <i class="bi bi-check-circle-fill text-success" style="font-size: 4rem;"></i>
                                        </div>
                                        <h4 class="mb-3">Transfer Successful!</h4>
                                        <p class="text-muted mb-4">Your transfer has been processed successfully.</p>
                                        <div class="card mb-4">
                                            <div class="card-body text-start">
                                                <p class="mb-2"><strong>Transaction ID:</strong> TXN202310156789</p>
                                                <p class="mb-2"><strong>Amount:</strong> <span id="confirmationAmount">$0.00</span></p>
                                                <p class="mb-2"><strong>From Account:</strong> <span id="confirmationFrom">Primary Savings (****3456)</span></p>
                                                <p class="mb-2"><strong>To Account:</strong> <span id="confirmationTo">Checking Account (****7890)</span></p>
                                                <p class="mb-0"><strong>Date & Time:</strong> <span id="confirmationDate">Oct 15, 2023 14:30:45</span></p>
                                            </div>
                                        </div>
                                        <div class="d-grid gap-2 d-md-flex justify-content-md-center">
                                            <button type="button" class="btn btn-outline-secondary me-md-2" id="printReceipt">Print Receipt</button>
                                            <button type="button" class="btn btn-primary" id="newTransfer">New Transfer</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="external" role="tabpanel">
                                <div class="alert alert-info">
                                    <i class="bi bi-info-circle me-2"></i> External transfers to other banks may take 1-3 business days to process.
                                </div>
                                <form>
                                    <div class="mb-3">
                                        <label for="extFromAccount" class="form-label">From Account</label>
                                        <select class="form-select" id="extFromAccount" required>
                                            <option selected disabled>Select account</option>
                                            <option>Primary Savings (****3456) - $12,456.78</option>
                                            <option>Checking Account (****7890) - $5,678.90</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="extBankName" class="form-label">Recipient Bank</label>
                                        <select class="form-select" id="extBankName" required>
                                            <option selected disabled>Select bank</option>
                                            <option>National Bank</option>
                                            <option>Global Bank</option>
                                            <option>City Bank</option>
                                            <option>Other Bank</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="extAccountNumber" class="form-label">Recipient Account Number</label>
                                        <input type="text" class="form-control" id="extAccountNumber" placeholder="Enter account number" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="extAccountName" class="form-label">Recipient Name</label>
                                        <input type="text" class="form-control" id="extAccountName" placeholder="Enter account holder's name" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="extAmount" class="form-label">Amount</label>
                                        <div class="input-group">
                                            <span class="input-group-text">$</span>
                                            <input type="number" class="form-control" id="extAmount" placeholder="0.00" min="0.01" step="0.01" required>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="extDescription" class="form-label">Description (Optional)</label>
                                        <input type="text" class="form-control" id="extDescription" placeholder="e.g., Rent payment">
                                    </div>
                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                        <button type="submit" class="btn btn-primary">Transfer</button>
                                    </div>
                                </form>
                            </div>
                            <div class="tab-pane fade" id="scheduled" role="tabpanel">
                                <div class="alert alert-info">
                                    <i class="bi bi-info-circle me-2"></i> Schedule recurring or one-time future transfers.
                                </div>
                                <form>
                                    <div class="mb-3">
                                        <label for="schFromAccount" class="form-label">From Account</label>
                                        <select class="form-select" id="schFromAccount" required>
                                            <option selected disabled>Select account</option>
                                            <option>Primary Savings (****3456) - $12,456.78</option>
                                            <option>Checking Account (****7890) - $5,678.90</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="schToAccount" class="form-label">To Account</label>
                                        <select class="form-select" id="schToAccount" required>
                                            <option selected disabled>Select account</option>
                                            <option>Primary Savings (****3456)</option>
                                            <option>Checking Account (****7890)</option>
                                            <option>John Smith (****5678) - National Bank</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="schAmount" class="form-label">Amount</label>
                                        <div class="input-group">
                                            <span class="input-group-text">$</span>
                                            <input type="number" class="form-control" id="schAmount" placeholder="0.00" min="0.01" step="0.01" required>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="schDescription" class="form-label">Description (Optional)</label>
                                        <input type="text" class="form-control" id="schDescription" placeholder="e.g., Rent payment">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Transfer Date</label>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="schDateType" id="schOneTime" checked>
                                            <label class="form-check-label" for="schOneTime">
                                                One-time transfer on:
                                            </label>
                                            <input type="date" class="form-control mt-1" id="schOneTimeDate">
                                        </div>
                                        <div class="form-check mt-2">
                                            <input class="form-check-input" type="radio" name="schDateType" id="schRecurring">
                                            <label class="form-check-label" for="schRecurring">
                                                Recurring transfer:
                                            </label>
                                            <div class="row mt-1">
                                                <div class="col-md-6">
                                                    <select class="form-select" id="schFrequency">
                                                        <option>Weekly</option>
                                                        <option selected>Monthly</option>
                                                        <option>Quarterly</option>
                                                        <option>Yearly</option>
                                                    </select>
                                                </div>
                                                <div class="col-md-6">
                                                    <select class="form-select" id="schDay">
                                                        <option>1st</option>
                                                        <option>5th</option>
                                                        <option selected>15th</option>
                                                        <option>Last day</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                        <button type="submit" class="btn btn-primary">Schedule Transfer</button>
                                    </div>
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
                                    <small class="text-muted">Oct 14, 2023</small>
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

    // Transfer wizard functionality
    const nextStep1 = document.getElementById('nextStep1');
    const nextStep2 = document.getElementById('nextStep2');
    const backStep2 = document.getElementById('backStep2');
    const newTransfer = document.getElementById('newTransfer');
    const printReceipt = document.getElementById('printReceipt');
    const steps = document.querySelectorAll('.transfer-step');
    const progressBar = document.querySelector('.progress-bar');

    nextStep1.addEventListener('click', function() {
        // Validate form
        const form = document.getElementById('transferForm');
        if (!form.checkValidity()) {
            form.reportValidity();
            return;
        }

        // Update review section
        document.getElementById('reviewFromAccount').textContent =
            document.getElementById('fromAccount').options[document.getElementById('fromAccount').selectedIndex].text.split(' - ')[0];
        document.getElementById('reviewToAccount').textContent =
            document.getElementById('toAccount').options[document.getElementById('toAccount').selectedIndex].text.split(' - ')[0];
        document.getElementById('reviewAmount').textContent =
            '$' + parseFloat(document.getElementById('amount').value).toFixed(2);
        document.getElementById('reviewDescription').textContent =
            document.getElementById('description').value || '-';

        // Move to step 2
        steps[0].classList.remove('active');
        steps[1].classList.add('active');
        progressBar.style.width = '66%';
    });

    nextStep2.addEventListener('click', function() {
        if (!document.getElementById('confirmTransfer').checked) {
            alert('Please confirm that the transfer details are correct');
            return;
        }

        // Update confirmation section
        document.getElementById('confirmationFrom').textContent =
            document.getElementById('reviewFromAccount').textContent;
        document.getElementById('confirmationTo').textContent =
            document.getElementById('reviewToAccount').textContent;
        document.getElementById('confirmationAmount').textContent =
            document.getElementById('reviewAmount').textContent;

        const now = new Date();
        document.getElementById('confirmationDate').textContent =
            now.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' }) + ' ' +
            now.toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit', second: '2-digit' });

        // Move to step 3
        steps[1].classList.remove('active');
        steps[2].classList.add('active');
        progressBar.style.width = '100%';
    });

    backStep2.addEventListener('click', function() {
        steps[1].classList.remove('active');
        steps[0].classList.add('active');
        progressBar.style.width = '33%';
    });

    newTransfer.addEventListener('click', function() {
        // Reset form
        document.getElementById('transferForm').reset();

        // Move to step 1
        steps[2].classList.remove('active');
        steps[0].classList.add('active');
        progressBar.style.width = '33%';
    });

    printReceipt.addEventListener('click', function() {
        alert('Printing receipt...');
        // In a real app, this would open the print dialog for the receipt section
    });
</script>
</body>
</html>