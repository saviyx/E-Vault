<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Dashboard | E-Vault</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary: #6c5ce7;
            --primary-light: #a29bfe;
            --secondary: #00b894;
            --danger: #d63031;
            --warning: #fdcb6e;
            --dark: #2d3436;
            --light: #f5f6fa;
            --white: #ffffff;
            --gray: #dfe6e9;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f8f9fa;
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Styles */
        .sidebar {
            width: 280px;
            background: var(--white);
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
            position: fixed;
            height: 100vh;
            z-index: 100;
        }

        .sidebar-header {
            padding: 1.5rem;
            border-bottom: 1px solid var(--gray);
            text-align: center;
        }

        .staff-profile {
            margin-top: 1rem;
        }

        .staff-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: var(--primary);
            color: var(--white);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto;
            font-size: 2rem;
            font-weight: 600;
        }

        .staff-info {
            text-align: center;
            margin-top: 1rem;
        }

        .staff-name {
            font-weight: 600;
            color: var(--dark);
        }

        .staff-position {
            font-size: 0.85rem;
            color: var(--primary);
            margin-top: 0.25rem;
        }

        .staff-id {
            font-size: 0.75rem;
            color: #636e72;
            margin-top: 0.5rem;
        }

        .sidebar-menu {
            padding: 1rem 0;
        }

        .nav-item {
            margin: 0.25rem 1rem;
            border-radius: 8px;
            overflow: hidden;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 0.75rem 1.5rem;
            color: var(--dark);
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            background: rgba(108, 92, 231, 0.1);
            color: var(--primary);
        }

        .nav-link.active {
            background: rgba(108, 92, 231, 0.1);
            color: var(--primary);
            position: relative;
        }

        .nav-link.active::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 4px;
            background: var(--primary);
        }

        .nav-icon {
            font-size: 1.1rem;
            margin-right: 1rem;
            width: 24px;
            text-align: center;
        }

        .nav-text {
            font-weight: 500;
        }

        /* Main Content Styles */
        .main-content {
            flex: 1;
            margin-left: 280px;
        }

        /* Topbar Styles */
        .topbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 2rem;
            background: var(--white);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            position: sticky;
            top: 0;
            z-index: 10;
        }

        .search-bar {
            display: flex;
            align-items: center;
            background: var(--light);
            border-radius: 50px;
            padding: 0.5rem 1rem;
            width: 400px;
        }

        .search-bar input {
            border: none;
            background: transparent;
            padding: 0.5rem;
            width: 100%;
            outline: none;
            font-size: 0.9rem;
        }

        .search-bar i {
            color: var(--dark);
            opacity: 0.6;
        }

        .user-menu {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        .notification-bell {
            position: relative;
            color: var(--dark);
            font-size: 1.2rem;
            cursor: pointer;
        }

        .notification-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            width: 18px;
            height: 18px;
            background: var(--danger);
            color: var(--white);
            border-radius: 50%;
            font-size: 0.7rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            cursor: pointer;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--primary);
            color: var(--white);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
        }

        .user-name {
            font-weight: 500;
            color: var(--dark);
        }

        /* Content Area Styles */
        .content-area {
            padding: 2rem;
        }

        .page-title {
            font-size: 1.5rem;
            color: var(--dark);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .page-title i {
            color: var(--primary);
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: var(--white);
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            border-left: 4px solid var(--primary);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        .stat-card.pending {
            border-left-color: var(--warning);
        }

        .stat-card.transactions {
            border-left-color: var(--secondary);
        }

        .stat-card.alerts {
            border-left-color: var(--danger);
        }

        .stat-card-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .stat-card-text h3 {
            font-size: 1.8rem;
            font-weight: 600;
            color: var(--dark);
            margin-bottom: 0.25rem;
        }

        .stat-card-text p {
            font-size: 0.9rem;
            color: #636e72;
        }

        .stat-card-icon {
            font-size: 2.5rem;
            color: var(--primary);
            opacity: 0.2;
        }

        .stat-card.pending .stat-card-icon {
            color: var(--warning);
        }

        .stat-card.transactions .stat-card-icon {
            color: var(--secondary);
        }

        .stat-card.alerts .stat-card-icon {
            color: var(--danger);
        }

        /* Main Content Grid */
        .content-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 1.5rem;
        }

        /* Activity Table */
        .activity-card {
            background: var(--white);
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 1.5rem;
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .card-header h5 {
            font-size: 1.1rem;
            color: var(--dark);
            font-weight: 600;
        }

        .view-all-btn {
            background: transparent;
            border: 1px solid var(--primary);
            color: var(--primary);
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-size: 0.85rem;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .view-all-btn:hover {
            background: rgba(108, 92, 231, 0.1);
        }

        .activity-table {
            width: 100%;
            border-collapse: collapse;
        }

        .activity-table th {
            text-align: left;
            padding: 0.75rem 1rem;
            color: #636e72;
            font-weight: 500;
            font-size: 0.85rem;
            border-bottom: 1px solid var(--gray);
        }

        .activity-table td {
            padding: 0.75rem 1rem;
            border-bottom: 1px solid var(--gray);
            font-size: 0.9rem;
        }

        .activity-table tr:last-child td {
            border-bottom: none;
        }

        .activity-badge {
            padding: 0.35rem 0.75rem;
            border-radius: 50px;
            font-size: 0.75rem;
            font-weight: 500;
            background: rgba(108, 92, 231, 0.1);
            color: var(--primary);
        }

        .activity-badge.new-account {
            background: rgba(0, 184, 148, 0.1);
            color: var(--secondary);
        }

        /* Quick Actions */
        .quick-actions-card {
            background: var(--white);
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .quick-actions-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 0.75rem;
        }

        .action-btn {
            width: 100%;
            padding: 0.75rem 1rem;
            border-radius: 8px;
            border: none;
            background: var(--primary);
            color: var(--white);
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            justify-content: flex-start;
        }

        .action-btn.outline {
            background: transparent;
            border: 1px solid var(--primary);
            color: var(--primary);
        }

        .action-btn.outline:hover {
            background: rgba(108, 92, 231, 0.1);
        }

        .action-btn i {
            font-size: 1rem;
        }

        /* Branch Status */
        .branch-status-card {
            background: var(--white);
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 1.5rem;
        }

        .progress-item {
            margin-bottom: 1.5rem;
        }

        .progress-item h6 {
            font-size: 0.9rem;
            color: var(--dark);
            margin-bottom: 0.5rem;
        }

        .progress-container {
            height: 8px;
            background: var(--light);
            border-radius: 4px;
            margin-bottom: 0.5rem;
        }

        .progress-bar {
            height: 100%;
            border-radius: 4px;
            background: var(--primary);
        }

        .progress-bar.transactions {
            background: var(--secondary);
        }

        .progress-info {
            font-size: 0.8rem;
            color: #636e72;
        }

        .maintenance-alert {
            background: rgba(108, 92, 231, 0.1);
            padding: 0.75rem;
            border-radius: 8px;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-top: 1rem;
        }

        .maintenance-alert i {
            color: var(--primary);
            font-size: 1rem;
        }

        .maintenance-alert small {
            font-size: 0.8rem;
            color: var(--dark);
        }

        /* Responsive Styles */
        @media (max-width: 1200px) {
            .sidebar {
                width: 240px;
            }
            .main-content {
                margin-left: 240px;
            }
        }

        @media (max-width: 992px) {
            .content-grid {
                grid-template-columns: 1fr;
            }
            .sidebar {
                width: 80px;
            }
            .main-content {
                margin-left: 80px;
            }
            .sidebar-header, .staff-info, .nav-text {
                display: none;
            }
            .nav-item {
                margin: 0.25rem 0.5rem;
            }
            .nav-link {
                justify-content: center;
                padding: 0.75rem;
            }
            .nav-icon {
                margin-right: 0;
            }
            .search-bar {
                width: 300px;
            }
        }

        @media (max-width: 768px) {
            .stats-grid {
                grid-template-columns: 1fr 1fr;
            }
            .search-bar {
                width: 200px;
            }
        }

        @media (max-width: 576px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
            .topbar {
                flex-direction: column;
                gap: 1rem;
                padding: 1rem;
            }
            .search-bar {
                width: 100%;
            }
            .user-menu {
                width: 100%;
                justify-content: space-between;
            }
        }
    </style>
</head>
<body>
<!-- Sidebar -->
<div class="sidebar">
    <div class="sidebar-header">
        <h3>E-Vault Staff</h3>
        <div class="staff-profile">
            <div class="staff-avatar">${staff.firstName.charAt(0)}${staff.lastName.charAt(0)}</div>
            <div class="staff-info">
                <div class="staff-name">${staff.firstName} ${staff.lastName}</div>
                <div class="staff-position">${staff.position}</div>
                <div class="staff-id">ID: ${staff.staffId}</div>
            </div>
        </div>
    </div>

    <div class="sidebar-menu">
        <div class="nav-item">
            <a href="dashboard.jsp" class="nav-link active">
                <i class="fas fa-tachometer-alt nav-icon"></i>
                <span class="nav-text">Dashboard</span>
            </a>
        </div>
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/staff/customers" class="nav-link">
                <i class="fas fa-users nav-icon"></i>
                <span class="nav-text">Customer Management</span>
            </a>
        </div>
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/staff/addcustomer.jsp" class="nav-link">
                <i class="fas fa-user-plus nav-icon"></i>
                <span class="nav-text">Add New Customer</span>
            </a>
        </div>
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/staff/transactions" class="nav-link">
                <i class="fas fa-exchange-alt nav-icon"></i>
                <span class="nav-text">Process Transactions</span>
            </a>
        </div>
        <c:if test="${staff.position == 'MANAGER'}">
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/staff/reports" class="nav-link">
                    <i class="fas fa-file-invoice-dollar nav-icon"></i>
                    <span class="nav-text">Branch Reports</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/staff/approvals" class="nav-link">
                    <i class="fas fa-check-circle nav-icon"></i>
                    <span class="nav-text">Approvals</span>
                </a>
            </div>
        </c:if>
        <div class="nav-item">
            <a href="${pageContext.request.contextPath}/staff/logout" class="nav-link">
                <i class="fas fa-sign-out-alt nav-icon"></i>
                <span class="nav-text">Logout</span>
            </a>
        </div>
    </div>
</div>

<!-- Main Content -->
<div class="main-content">
    <!-- Topbar -->
    <div class="topbar">
        <div class="search-bar">
            <i class="fas fa-search"></i>
            <input type="text" placeholder="Search customers, transactions...">
        </div>

        <div class="user-menu">
            <div class="notification-bell">
                <i class="fas fa-bell"></i>
                <span class="notification-badge">${unreadNotifications}</span>
            </div>
            <div class="user-profile">
                <div class="user-avatar">${staff.firstName.charAt(0)}</div>
                <div class="user-name">${staff.firstName} ${staff.lastName}</div>
                <i class="fas fa-chevron-down"></i>
            </div>
        </div>
    </div>

    <!-- Content Area -->
    <div class="content-area">
        <h1 class="page-title">
            <i class="fas fa-tachometer-alt"></i>
            Staff Dashboard
        </h1>

        <!-- Stats Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-card-content">
                    <div class="stat-card-text">
                        <h3>${todayCustomers}</h3>
                        <p>Today's Customers</p>
                    </div>
                    <i class="fas fa-users stat-card-icon"></i>
                </div>
                <a href="${pageContext.request.contextPath}/staff/customers?filter=today" class="stretched-link"></a>
            </div>

            <div class="stat-card pending">
                <div class="stat-card-content">
                    <div class="stat-card-text">
                        <h3>${pendingApprovals}</h3>
                        <p>Pending Approvals</p>
                    </div>
                    <i class="fas fa-clock stat-card-icon"></i>
                </div>
                <c:if test="${pendingApprovals > 0}">
                    <a href="${pageContext.request.contextPath}/staff/approvals" class="stretched-link"></a>
                </c:if>
            </div>

            <div class="stat-card transactions">
                <div class="stat-card-content">
                    <div class="stat-card-text">
                        <h3>${todayTransactions}</h3>
                        <p>Today's Transactions</p>
                    </div>
                    <i class="fas fa-exchange-alt stat-card-icon"></i>
                </div>
                <a href="${pageContext.request.contextPath}/staff/transactions?filter=today" class="stretched-link"></a>
            </div>

            <div class="stat-card alerts">
                <div class="stat-card-content">
                    <div class="stat-card-text">
                        <h3>${alertsCount}</h3>
                        <p>Alerts</p>
                    </div>
                    <i class="fas fa-exclamation-triangle stat-card-icon"></i>
                </div>
                <c:if test="${alertsCount > 0}">
                    <a href="${pageContext.request.contextPath}/staff/alerts" class="stretched-link"></a>
                </c:if>
            </div>
        </div>

        <!-- Main Content Grid -->
        <div class="content-grid">
            <!-- Recent Activities -->
            <div class="activity-card">
                <div class="card-header">
                    <h5>Recent Customer Activities</h5>
                    <button class="view-all-btn" onclick="location.href='${pageContext.request.contextPath}/staff/customers'">
                        <i class="fas fa-list"></i> View All
                    </button>
                </div>
                <table class="activity-table">
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
                                    <span class="activity-badge ${activity.type == 'NEW_ACCOUNT' ? 'new-account' : ''}">
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

            <!-- Right Sidebar -->
            <div>
                <!-- Quick Actions -->
                <div class="quick-actions-card">
                    <h5>Quick Actions</h5>
                    <div class="quick-actions-grid">
                        <button class="action-btn" onclick="location.href='${pageContext.request.contextPath}/staff/add-customer'">
                            <i class="fas fa-user-plus"></i> Add New Customer
                        </button>
                        <button class="action-btn outline" onclick="location.href='${pageContext.request.contextPath}/staff/transactions/new'">
                            <i class="fas fa-exchange-alt"></i> Process Transaction
                        </button>
                        <button class="action-btn outline" onclick="location.href='${pageContext.request.contextPath}/staff/accounts/open'">
                            <i class="fas fa-university"></i> Open New Account
                        </button>
                        <c:if test="${staff.position == 'MANAGER'}">
                            <button class="action-btn outline" onclick="location.href='${pageContext.request.contextPath}/staff/reports'">
                                <i class="fas fa-file-invoice-dollar"></i> Generate Reports
                            </button>
                        </c:if>
                    </div>
                </div>

                <!-- Branch Status -->
                <div class="branch-status-card">
                    <h5>Branch Status</h5>
                    <div class="progress-item">
                        <h6>Customers Served Today</h6>
                        <div class="progress-container">
                            <div class="progress-bar" style="width: ${customersPercentage}%"></div>
                        </div>
                        <div class="progress-info">${todayCustomers} of ${dailyTarget} target</div>
                    </div>
                    <div class="progress-item">
                        <h6>Transaction Volume</h6>
                        <div class="progress-container">
                            <div class="progress-bar transactions" style="width: ${txnPercentage}%"></div>
                        </div>
                        <div class="progress-info">$${todayTransactionAmount} processed</div>
                    </div>
                    <div class="maintenance-alert">
                        <i class="fas fa-info-circle"></i>
                        <small>Next system maintenance: ${nextMaintenance}</small>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Initialize any needed JavaScript
    document.addEventListener('DOMContentLoaded', function() {
        // Add any dashboard-specific JS here
    });
</script>
</body>
</html>