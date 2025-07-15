<%--
  Created by IntelliJ IDEA.
  User: savindu umantha
  Date: 7/11/2025
  Time: 4:35 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    </style>
</head>
<body>
<%@ include file="../WEB-INF/templates/user_header.jsp" %>

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
                        <h4>${totalTransactions}</h4>
                    </div>
                    <div class="mb-3">
                        <h6>Total Deposits</h6>
                        <h4 class="text-success">$${totalDeposits}</h4>
                    </div>
                    <div class="mb-3">
                        <h6>Total Withdrawals</h6>
                        <h4 class="text-danger">$${totalWithdrawals}</h4>
                    </div>
                    <div class="mb-3">
                        <h6>Largest Transaction</h6>
                        <h4 class="text-primary">$${largestTransaction.amount}</h4>
                        <small class="text-muted">${largestTransaction.description}</small>
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

<%@ include file="../WEB-INF/templates/user_footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Transaction detail modal loader
    document.querySelectorAll('[data-bs-target="#detailModal"]').forEach(btn => {
        btn.addEventListener('click', function() {
            const txnId = this.getAttribute('data-txn-id');
            fetch(`${pageContext.request.contextPath}/api/transactions/` + txnId)
                .then(response => response.json())
                .then(data => {
                    const details = `
                            <div class="row">
                                <div class="col-md-6">
                                    <h6>Transaction Information</h6>
                                    <table class="table table-sm">
                                        <tr>
                                            <th>Reference:</th>
                                            <td>${data.referenceNumber}</td>
                                        </tr>
                                        <tr>
                                            <th>Date:</th>
                                            <td>${data.date} at ${data.time}</td>
                                        </tr>
                                        <tr>
                                            <th>Type:</th>
                                            <td>${data.type}</td>
                                        </tr>
                                        <tr>
                                            <th>Status:</th>
                                            <td><span class="badge ${data.status == 'COMPLETED' ? 'bg-success' : 'bg-warning'}">${data.status}</span></td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-md-6">
                                    <h6>Amount Details</h6>
                                    <table class="table table-sm">
                                        <tr>
                                            <th>Amount:</th>
                                            <td class="${data.type == 'CREDIT' ? 'text-success' : 'text-danger'} fw-bold">
                                                ${data.type == 'CREDIT' ? '+' : '-'}$${data.amount}
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Account:</th>
                                            <td>${data.accountNumber} (${data.accountType})</td>
                                        </tr>
                                        <tr>
                                            <th>Balance After:</th>
                                            <td>$${data.balanceAfter}</td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="mt-3">
                                <h6>Description</h6>
                                <p>${data.description}</p>
                            </div>
                            ${data.relatedAccount ? `
                            <div class="mt-3">
                                <h6>Related Account</h6>
                                <p>${data.relatedAccount.name}<br>
                                ${data.relatedAccount.number}<br>
                                ${data.relatedAccount.bank}</p>
                            </div>` : ''}
                        `;
                    document.getElementById('transactionDetails').innerHTML = details;
                });
        });
    });

    // Print functionality
    document.getElementById('printBtn').addEventListener('click', function() {
        window.print();
    });

    // Export functionality
    document.getElementById('exportBtn').addEventListener('click', function() {
        const params = new URLSearchParams(document.getElementById('filterForm').serialize());
        window.location.href = `${pageContext.request.contextPath}/transactions/export?` + params.toString();
    });

    // Form submission with AJAX
    document.getElementById('filterForm').addEventListener('submit', function(e) {
        e.preventDefault();
        const params = new URLSearchParams(new FormData(this));
        window.location.href = `${pageContext.request.contextPath}/user/transaction_history?` + params.toString();
    });
</script>
</body>
</html>
