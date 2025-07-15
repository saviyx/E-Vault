<%--
  Created by IntelliJ IDEA.
  User: savindu umantha
  Date: 7/10/2025
  Time: 10:14 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Reports | E-Vault</title>
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
    .report-card {
      border-radius: 10px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      transition: transform 0.3s;
    }
    .report-card:hover {
      transform: translateY(-5px);
    }
    .chart-container {
      height: 300px;
      position: relative;
    }
    .nav-pills .nav-link.active {
      background-color: var(--primary-color);
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
      <a class="nav-link" href="../customer/dashboard.jsp">
        <i class="bi bi-speedometer2"></i> Dashboard
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="../customer/account.jsp">
        <i class="bi bi-wallet2"></i> Accounts
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="../customer/transfer.jsp">
        <i class="bi bi-arrow-left-right"></i> Transfers
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">
        <i class="bi bi-clock-history"></i> Transaction History
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link active" href="report.jsp">
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
        <h5 class="mb-0">Reports</h5>
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
        <div class="card report-card">
          <div class="card-body">
            <ul class="nav nav-pills mb-4" id="reportTabs" role="tablist">
              <li class="nav-item" role="presentation">
                <button class="nav-link active" id="spending-tab" data-bs-toggle="pill" data-bs-target="#spending" type="button">Spending Analysis</button>
              </li>
              <li class="nav-item" role="presentation">
                <button class="nav-link" id="income-tab" data-bs-toggle="pill" data-bs-target="#income" type="button">Income Report</button>
              </li>
              <li class="nav-item" role="presentation">
                <button class="nav-link" id="savings-tab" data-bs-toggle="pill" data-bs-target="#savings" type="button">Savings Progress</button>
              </li>
              <li class="nav-item" role="presentation">
                <button class="nav-link" id="custom-tab" data-bs-toggle="pill" data-bs-target="#custom" type="button">Custom Report</button>
              </li>
            </ul>
            <div class="tab-content" id="reportTabsContent">
              <div class="tab-pane fade show active" id="spending" role="tabpanel">
                <div class="row">
                  <div class="col-md-8 mb-4">
                    <div class="card">
                      <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                          <h6 class="card-title mb-0">Spending by Category</h6>
                          <div class="dropdown">
                            <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="spendingPeriodDropdown" data-bs-toggle="dropdown">
                              Last 30 Days
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                              <li><a class="dropdown-item" href="#">Last 7 Days</a></li>
                              <li><a class="dropdown-item" href="#">Last 30 Days</a></li>
                              <li><a class="dropdown-item" href="#">Last 90 Days</a></li>
                              <li><a class="dropdown-item" href="#">This Year</a></li>
                            </ul>
                          </div>
                        </div>
                        <div class="chart-container">
                          <canvas id="spendingChart"></canvas>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="col-md-4 mb-4">
                    <div class="card">
                      <div class="card-body">
                        <h6 class="card-title mb-3">Top Spending Categories</h6>
                        <div class="mb-3">
                          <div class="d-flex justify-content-between mb-1">
                            <span>Food & Dining</span>
                            <span>$345.67</span>
                          </div>
                          <div class="progress" style="height: 8px;">
                            <div class="progress-bar bg-danger" role="progressbar" style="width: 45%"></div>
                          </div>
                        </div>
                        <div class="mb-3">
                          <div class="d-flex justify-content-between mb-1">
                            <span>Shopping</span>
                            <span>$234.56</span>
                          </div>
                          <div class="progress" style="height: 8px;">
                            <div class="progress-bar bg-warning" role="progressbar" style="width: 30%"></div>
                          </div>
                        </div>
                        <div class="mb-3">
                          <div class="d-flex justify-content-between mb-1">
                            <span>Utilities</span>
                            <span>$123.45</span>
                          </div>
                          <div class="progress" style="height: 8px;">
                            <div class="progress-bar bg-info" role="progressbar" style="width: 15%"></div>
                          </div>
                        </div>
                        <div class="mb-3">
                          <div class="d-flex justify-content-between mb-1">
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
                <div class="row">
                  <div class="col-12">
                    <div class="card">
                      <div class="card-body">
                        <h6 class="card-title mb-3">Monthly Spending Trend</h6>
                        <div class="chart-container">
                          <canvas id="monthlyTrendChart"></canvas>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="tab-pane fade" id="income" role="tabpanel">
                <div class="row">
                  <div class="col-md-6 mb-4">
                    <div class="card">
                      <div class="card-body">
                        <h6 class="card-title mb-3">Income Sources</h6>
                        <div class="chart-container">
                          <canvas id="incomeSourcesChart"></canvas>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="col-md-6 mb-4">
                    <div class="card">
                      <div class="card-body">
                        <h6 class="card-title mb-3">Income vs Expenses</h6>
                        <div class="chart-container">
                          <canvas id="incomeVsExpensesChart"></canvas>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-12">
                    <div class="card">
                      <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                          <h6 class="card-title mb-0">Income History</h6>
                          <div class="dropdown">
                            <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="incomePeriodDropdown" data-bs-toggle="dropdown">
                              Last 12 Months
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                              <li><a class="dropdown-item" href="#">Last 3 Months</a></li>
                              <li><a class="dropdown-item" href="#">Last 6 Months</a></li>
                              <li><a class="dropdown-item" href="#">Last 12 Months</a></li>
                              <li><a class="dropdown-item" href="#">Last 2 Years</a></li>
                            </ul>
                          </div>
                        </div>
                        <div class="table-responsive">
                          <table class="table table-hover">
                            <thead>
                            <tr>
                              <th>Date</th>
                              <th>Source</th>
                              <th>Amount</th>
                              <th>Account</th>
                              <th>Description</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                              <td>Oct 15, 2023</td>
                              <td>Salary</td>
                              <td class="text-success">+$3,456.00</td>
                              <td>Primary Savings</td>
                              <td>Monthly salary</td>
                            </tr>
                            <tr>
                              <td>Sep 15, 2023</td>
                              <td>Salary</td>
                              <td class="text-success">+$3,456.00</td>
                              <td>Primary Savings</td>
                              <td>Monthly salary</td>
                            </tr>
                            <tr>
                              <td>Aug 15, 2023</td>
                              <td>Salary</td>
                              <td class="text-success">+$3,456.00</td>
                              <td>Primary Savings</td>
                              <td>Monthly salary</td>
                            </tr>
                            <tr>
                              <td>Jul 15, 2023</td>
                              <td>Salary</td>
                              <td class="text-success">+$3,456.00</td>
                              <td>Primary Savings</td>
                              <td>Monthly salary</td>
                            </tr>
                            <tr>
                              <td>Jun 15, 2023</td>
                              <td>Salary</td>
                              <td class="text-success">+$3,456.00</td>
                              <td>Primary Savings</td>
                              <td>Monthly salary</td>
                            </tr>
                            </tbody>
                          </table>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="tab-pane fade" id="savings" role="tabpanel">
                <div class="row">
                  <div class="col-md-8 mb-4">
                    <div class="card">
                      <div class="card-body">
                        <h6 class="card-title mb-3">Savings Progress</h6>
                        <div class="chart-container">
                          <canvas id="savingsProgressChart"></canvas>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="col-md-4 mb-4">
                    <div class="card">
                      <div class="card-body">
                        <h6 class="card-title mb-3">Savings Goals</h6>
                        <div class="mb-4">
                          <div class="d-flex justify-content-between mb-1">
                            <span>Emergency Fund</span>
                            <span>$2,500/$5,000</span>
                          </div>
                          <div class="progress" style="height: 10px;">
                            <div class="progress-bar" role="progressbar" style="width: 50%;"></div>
                          </div>
                        </div>
                        <div class="mb-4">
                          <div class="d-flex justify-content-between mb-1">
                            <span>Vacation</span>
                            <span>$800/$2,000</span>
                          </div>
                          <div class="progress" style="height: 10px;">
                            <div class="progress-bar" role="progressbar" style="width: 40%;"></div>
                          </div>
                        </div>
                        <div class="mb-4">
                          <div class="d-flex justify-content-between mb-1">
                            <span>New Car</span>
                            <span>$3,200/$15,000</span>
                          </div>
                          <div class="progress" style="height: 10px;">
                            <div class="progress-bar" role="progressbar" style="width: 21%;"></div>
                          </div>
                        </div>
                        <button class="btn btn-primary w-100 mt-3" data-bs-toggle="modal" data-bs-target="#newGoalModal">
                          <i class="bi bi-plus-circle me-1"></i> Add New Goal
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-12">
                    <div class="card">
                      <div class="card-body">
                        <h6 class="card-title mb-3">Recent Savings Transactions</h6>
                        <div class="table-responsive">
                          <table class="table table-hover">
                            <thead>
                            <tr>
                              <th>Date</th>
                              <th>From Account</th>
                              <th>To Account</th>
                              <th>Amount</th>
                              <th>Goal</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                              <td>Oct 15, 2023</td>
                              <td>Primary Savings</td>
                              <td>Vacation Fund</td>
                              <td class="text-danger">-$200.00</td>
                              <td>Vacation</td>
                            </tr>
                            <tr>
                              <td>Oct 1, 2023</td>
                              <td>Checking Account</td>
                              <td>Emergency Fund</td>
                              <td class="text-danger">-$300.00</td>
                              <td>Emergency</td>
                            </tr>
                            <tr>
                              <td>Sep 15, 2023</td>
                              <td>Primary Savings</td>
                              <td>Car Fund</td>
                              <td class="text-danger">-$500.00</td>
                              <td>New Car</td>
                            </tr>
                            <tr>
                              <td>Sep 1, 2023</td>
                              <td>Checking Account</td>
                              <td>Emergency Fund</td>
                              <td class="text-danger">-$300.00</td>
                              <td>Emergency</td>
                            </tr>
                            <tr>
                              <td>Aug 15, 2023</td>
                              <td>Primary Savings</td>
                              <td>Vacation Fund</td>
                              <td class="text-danger">-$200.00</td>
                              <td>Vacation</td>
                            </tr>
                            </tbody>
                          </table>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="tab-pane fade" id="custom" role="tabpanel">
                <div class="row">
                  <div class="col-md-4 mb-4">
                    <div class="card">
                      <div class="card-body">
                        <h6 class="card-title mb-3">Create Custom Report</h6>
                        <form>
                          <div class="mb-3">
                            <label for="reportType" class="form-label">Report Type</label>
                            <select class="form-select" id="reportType">
                              <option>Transaction History</option>
                              <option>Spending Analysis</option>
                              <option>Income Report</option>
                              <option>Savings Progress</option>
                              <option>Net Worth</option>
                            </select>
                          </div>
                          <div class="mb-3">
                            <label for="dateRange" class="form-label">Date Range</label>
                            <select class="form-select" id="dateRange">
                              <option>Last 7 Days</option>
                              <option>Last 30 Days</option>
                              <option>Last 90 Days</option>
                              <option>Last 12 Months</option>
                              <option>Custom Range</option>
                            </select>
                          </div>
                          <div class="mb-3" id="customDateRange" style="display: none;">
                            <div class="row">
                              <div class="col-md-6 mb-2">
                                <label for="startDate" class="form-label">Start Date</label>
                                <input type="date" class="form-control" id="startDate">
                              </div>
                              <div class="col-md-6">
                                <label for="endDate" class="form-label">End Date</label>
                                <input type="date" class="form-control" id="endDate">
                              </div>
                            </div>
                          </div>
                          <div class="mb-3">
                            <label for="accounts" class="form-label">Accounts</label>
                            <select class="form-select" id="accounts" multiple>
                              <option selected>All Accounts</option>
                              <option>Primary Savings</option>
                              <option>Checking Account</option>
                              <option>Vacation Fund</option>
                              <option>Emergency Fund</option>
                              <option>Car Fund</option>
                            </select>
                          </div>
                          <div class="mb-3">
                            <label for="categories" class="form-label">Categories</label>
                            <select class="form-select" id="categories" multiple>
                              <option selected>All Categories</option>
                              <option>Food & Dining</option>
                              <option>Shopping</option>
                              <option>Utilities</option>
                              <option>Entertainment</option>
                              <option>Income</option>
                              <option>Transfer</option>
                            </select>
                          </div>
                          <div class="d-grid">
                            <button type="submit" class="btn btn-primary">Generate Report</button>
                          </div>
                        </form>
                      </div>
                    </div>
                  </div>
                  <div class="col-md-8 mb-4">
                    <div class="card">
                      <div class="card-body">
                        <div class="text-center py-5">
                          <i class="bi bi-file-earmark-text" style="font-size: 3rem; color: #6c757d;"></i>
                          <h5 class="mt-3">No Report Generated</h5>
                          <p class="text-muted">Configure and generate a custom report using the options on the left</p>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- New Goal Modal -->
<div class="modal fade" id="newGoalModal" tabindex="-1" aria-labelledby="newGoalModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="newGoalModalLabel">Create New Savings Goal</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form>
          <div class="mb-3">
            <label for="goalName" class="form-label">Goal Name</label>
            <input type="text" class="form-control" id="goalName" placeholder="e.g., Vacation, Emergency Fund">
          </div>
          <div class="mb-3">
            <label for="targetAmount" class="form-label">Target Amount</label>
            <div class="input-group">
              <span class="input-group-text">$</span>
              <input type="number" class="form-control" id="targetAmount" placeholder="0.00" min="0.01" step="0.01">
            </div>
          </div>
          <div class="mb-3">
            <label for="targetDate" class="form-label">Target Date (Optional)</label>
            <input type="date" class="form-control" id="targetDate">
          </div>
          <div class="mb-3">
            <label for="fundingAccount" class="form-label">Funding Account</label>
            <select class="form-select" id="fundingAccount">
              <option selected disabled>Select account</option>
              <option>Primary Savings (****3456)</option>
              <option>Checking Account (****7890)</option>
            </select>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        <button type="button" class="btn btn-primary">Create Goal</button>
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

  // Show/hide custom date range
  document.getElementById('dateRange').addEventListener('change', function() {
    const customDateRange = document.getElementById('customDateRange');
    if (this.value === 'Custom Range') {
      customDateRange.style.display = 'block';
    } else {
      customDateRange.style.display = 'none';
    }
  });

  // Initialize charts
  const spendingCtx = document.getElementById('spendingChart').getContext('2d');
  const spendingChart = new Chart(spendingCtx, {
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
          position: 'right'
        }
      }
    }
  });

  const monthlyTrendCtx = document.getElementById('monthlyTrendChart').getContext('2d');
  const monthlyTrendChart = new Chart(monthlyTrendCtx, {
    type: 'line',
    data: {
      labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct'],
      datasets: [{
        label: 'Spending',
        data: [1200, 1900, 1500, 1800, 2100, 1900, 2300, 2000, 1800, 1600],
        borderColor: '#dc3545',
        backgroundColor: 'rgba(220, 53, 69, 0.1)',
        fill: true,
        tension: 0.3
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          display: false
        }
      },
      scales: {
        y: {
          beginAtZero: true
        }
      }
    }
  });

  const incomeSourcesCtx = document.getElementById('incomeSourcesChart').getContext('2d');
  const incomeSourcesChart = new Chart(incomeSourcesCtx, {
    type: 'pie',
    data: {
      labels: ['Salary', 'Freelance', 'Investments', 'Other'],
      datasets: [{
        data: [80, 10, 5, 5],
        backgroundColor: [
          '#1e3c72',
          '#2a5298',
          '#4b6cb7',
          '#6c8fd6'
        ],
        borderWidth: 0
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          position: 'right'
        }
      }
    }
  });

  const incomeVsExpensesCtx = document.getElementById('incomeVsExpensesChart').getContext('2d');
  const incomeVsExpensesChart = new Chart(incomeVsExpensesCtx, {
    type: 'bar',
    data: {
      labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'],
      datasets: [
        {
          label: 'Income',
          data: [3456, 3456, 3456, 3456, 3456, 3456, 3456, 3456, 3456],
          backgroundColor: '#198754',
          borderWidth: 0
        },
        {
          label: 'Expenses',
          data: [2100, 1900, 2300, 2000, 2200, 1800, 2500, 2100, 1900],
          backgroundColor: '#dc3545',
          borderWidth: 0
        }
      ]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      scales: {
        x: {
          stacked: false,
        },
        y: {
          stacked: false,
          beginAtZero: true
        }
      }
    }
  });

  const savingsProgressCtx = document.getElementById('savingsProgressChart').getContext('2d');
  const savingsProgressChart = new Chart(savingsProgressCtx, {
    type: 'line',
    data: {
      labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct'],
      datasets: [
        {
          label: 'Emergency Fund',
          data: [1000, 1200, 1400, 1600, 1800, 2000, 2200, 2400, 2500, 2500],
          borderColor: '#1e3c72',
          backgroundColor: 'rgba(30, 60, 114, 0.1)',
          fill: true,
          tension: 0.3
        },
        {
          label: 'Vacation',
          data: [200, 300, 400, 500, 600, 700, 800, 800, 800, 800],
          borderColor: '#198754',
          backgroundColor: 'rgba(25, 135, 84, 0.1)',
          fill: true,
          tension: 0.3
        },
        {
          label: 'New Car',
          data: [0, 500, 1000, 1500, 2000, 2500, 3000, 3200, 3200, 3200],
          borderColor: '#0dcaf0',
          backgroundColor: 'rgba(13, 202, 240, 0.1)',
          fill: true,
          tension: 0.3
        }
      ]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      scales: {
        y: {
          beginAtZero: true
        }
      }
    }
  });
</script>
</body>
</html>
