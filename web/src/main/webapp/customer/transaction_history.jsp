<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction History | E-Vault</title>
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
        .transaction-card {
            border-left: 3px solid var(--primary-color);
            transition: all 0.3s;
        }
        .transaction-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .credit {
            border-left-color: #28a745 !important;
        }
        .debit {
            border-left-color: #dc3545 !important;
        }
        .filter-section {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .pagination .page-item.active .page-link {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
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
            <a class="nav-link active" href="${contextPath}/customer/transaction-history">
                <i class="bi bi-clock-history"></i> Transaction History
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${contextPath}/customer/scheduled-transfers">
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
                <h5 class="mb-0">Transaction History</h5>
            </div>
            <div class="d-flex align-items-center">
                <div class="dropdown me-3">
                    <button class="btn btn-light dropdown-toggle" type="button" id="notificationsDropdown" data-bs-toggle="dropdown">
                        <i class="bi bi-bell"></i>
                        <span class="badge bg-danger rounded-pill">3</span>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><h6 class="dropdown-header">Notifications</h6></li>
                        <li><a class="dropdown-item" href="#">New transaction</a></li>
                        <li><a class="dropdown-item" href="#">Transfer completed</a></li>
                        <li><a class="dropdown-item" href="#">Deposit received</a></li>
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
            <div class="col-lg-3">
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">Filter Transactions</h5>
                    </div>
                    <div class="card-body">
                        <form id="filterForm">
                            <div class="mb-3">
                                <label class="form-label">Account</label>
                                <select class="form-select" name="account">
                                    <option value="">All Accounts</option>
                                    <option value="SAV-3456">Savings (****3456)</option>
                                    <option value="CHK-7890">Checking (****7890)</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Transaction Type</label>
                                <select class="form-select" name="type">
                                    <option value="">All Types</option>
                                    <option value="DEPOSIT">Deposit</option>
                                    <option value="WITHDRAWAL">Withdrawal</option>
                                    <option value="TRANSFER">Transfer</option>
                                    <option value="PAYMENT">Payment</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Date Range</label>
                                <div class="input-group mb-2">
                                    <span class="input-group-text">From</span>
                                    <input type="date" class="form-control" name="fromDate">
                                </div>
                                <div class="input-group">
                                    <span class="input-group-text">To</span>
                                    <input type="date" class="form-control" name="toDate">
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Amount Range</label>
                                <div class="input-group mb-2">
                                    <span class="input-group-text">Min</span>
                                    <input type="number" class="form-control" name="minAmount" placeholder="0.00">
                                </div>
                                <div class="input-group">
                                    <span class="input-group-text">Max</span>
                                    <input type="number" class="form-control" name="maxAmount" placeholder="Any">
                                </div>
                            </div>

                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-funnel"></i> Apply Filters
                                </button>
                                <button type="reset" class="btn btn-outline-secondary">
                                    <i class="bi bi-arrow-counterclockwise"></i> Reset
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">Quick Stats</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <h6>Total Transactions</h6>
                            <h4>${totalTransactions != null ? totalTransactions : 0}</h4>
                        </div>
                        <div class="mb-3">
                            <h6>Total Deposits</h6>
                            <h4 class="text-success">$${totalDeposits != null ? totalDeposits : '0.00'}</h4>
                        </div>
                        <div class="mb-3">
                            <h6>Total Withdrawals</h6>
                            <h4 class="text-danger">$${totalWithdrawals != null ? totalWithdrawals : '0.00'}</h4>
                        </div>
                        <div class="mb-3">
                            <h6>Largest Transaction</h6>
                            <h4 class="text-primary">$${largestTransaction != null ? largestTransaction.amount : '0.00'}</h4>
                            <small class="text-muted">${largestTransaction != null ? largestTransaction.description : 'N/A'}</small>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-9">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center bg-primary text-white">
                        <h5 class="mb-0">Transaction History</h5>
                        <div>
                            <button class="btn btn-sm btn-light me-2" id="printBtn">
                                <i class="bi bi-printer"></i> Print
                            </button>
                            <button class="btn btn-sm btn-light" id="exportBtn">
                                <i class="bi bi-download"></i> Export
                            </button>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead class="table-light">
                                <tr>
                                    <th>Date</th>
                                    <th>Description</th>
                                    <th>Account</th>
                                    <th class="text-end">Amount</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${transactions}" var="txn">
                                    <tr class="transaction-card ${txn.type == 'CREDIT' ? 'credit' : 'debit'}">
                                        <td>
                                            <div class="fw-bold">${txn.date}</div>
                                            <small class="text-muted">${txn.time}</small>
                                        </td>
                                        <td>
                                            <div>${txn.description}</div>
                                            <small class="text-muted">Ref: ${txn.referenceNumber}</small>
                                        </td>
                                        <td>
                                            <span class="badge bg-secondary">${txn.accountNumber}</span>
                                        </td>
                                        <td class="text-end fw-bold ${txn.type == 'CREDIT' ? 'text-success' : 'text-danger'}">
                                                ${txn.type == 'CREDIT' ? '+' : '-'}$${txn.amount}
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${txn.status == 'COMPLETED'}">
                                                    <span class="badge bg-success">Completed</span>
                                                </c:when>
                                                <c:when test="${txn.status == 'PENDING'}">
                                                    <span class="badge bg-warning">Pending</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger">${txn.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <button class="btn btn-sm btn-outline-primary"
                                                    data-bs-toggle="modal"
                                                    data-bs-target="#detailModal"
                                                    data-txn-id="${txn.id}">
                                                <i class="bi bi-eye"></i> Details
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <nav aria-label="Transaction pagination">
                            <ul class="pagination justify-content-center">
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="?page=${currentPage - 1}">Previous</a>
                                </li>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="?page=${i}">${i}</a>
                                    </li>
                                </c:forEach>
                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="?page=${currentPage + 1}">Next</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Transaction Detail Modal -->
<div class="modal fade" id="detailModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Transaction Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body" id="transactionDetails">
                <!-- Dynamic content will be loaded here -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="receiptBtn">
                    <i class="bi bi-receipt"></i> Download Receipt
                </button>
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

    // Transaction detail modal loader
    document.querySelectorAll('[data-bs-target="#detailModal"]').forEach(btn => {
        btn.addEventListener('click', function() {
            const txnId = this.getAttribute('data-txn-id');
            fetch('${contextPath}/api/transactions/' + txnId)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    let relatedAccountHtml = '';
                    if (data.relatedAccount) {
                        relatedAccountHtml = `
                            <div class="mt-3">
                                <h6>Related Account</h6>
                                <p>${data.relatedAccount.name || 'N/A'}<br>
                                ${data.relatedAccount.number || 'N/A'}<br>
                                ${data.relatedAccount.bank || 'N/A'}</p>
                            </div>`;
                    }

                    const details = `
                        <div class="row">
                            <div class="col-md-6">
                                <h6>Transaction Information</h6>
                                <table class="table table-sm">
                                    <tr>
                                        <th>Reference:</th>
                                        <td>${data.referenceNumber || 'N/A'}</td>
                                    </tr>
                                    <tr>
                                        <th>Date:</th>
                                        <td>${data.date || 'N/A'} at ${data.time || 'N/A'}</td>
                                    </tr>
                                    <tr>
                                        <th>Type:</th>
                                        <td>${data.type || 'N/A'}</td>
                                    </tr>
                                    <tr>
                                        <th>Status:</th>
                                        <td><span class="badge ${data.status == 'COMPLETED' ? 'bg-success' : 'bg-warning'}">${data.status || 'N/A'}</span></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-md-6">
                                <h6>Amount Details</h6>
                                <table class="table table-sm">
                                    <tr>
                                        <th>Amount:</th>
                                        <td class="${data.type == 'CREDIT' ? 'text-success' : 'text-danger'} fw-bold">
                                            ${data.type == 'CREDIT' ? '+' : '-'}$${data.amount || '0.00'}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Account:</th>
                                        <td>${data.accountNumber || 'N/A'} (${data.accountType || 'N/A'})</td>
                                    </tr>
                                    <tr>
                                        <th>Balance After:</th>
                                        <td>$${data.balanceAfter || '0.00'}</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="mt-3">
                            <h6>Description</h6>
                            <p>${data.description || 'No description available'}</p>
                        </div>
                        ${relatedAccountHtml}
                    `;
                    document.getElementById('transactionDetails').innerHTML = details;
                })
                .catch(error => {
                    console.error('Error fetching transaction details:', error);
                    document.getElementById('transactionDetails').innerHTML =
                        '<div class="alert alert-danger">Failed to load transaction details. Please try again.</div>';
                });
        });
    });

    // Print functionality
    document.getElementById('printBtn').addEventListener('click', function() {
        window.print();
    });

    // Export functionality
    document.getElementById('exportBtn').addEventListener('click', function() {
        const form = document.getElementById('filterForm');
        const params = new URLSearchParams(new FormData(form));
        window.location.href = '${contextPath}/transactions/export?' + params.toString();
    });

    // Form submission with AJAX
    document.getElementById('filterForm').addEventListener('submit', function(e) {
        e.preventDefault();
        const form = document.getElementById('filterForm');
        const params = new URLSearchParams(new FormData(form));
        window.location.href = '${contextPath}/customer/transaction-history?' + params.toString();
    });
</script>
</body>
</html>