<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Customer | E-Vault</title>
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

        /* Sidebar Styles - Copied from dashboard.jsp */
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

        /* Registration Form Styles - Keep from original addcustomer.jsp */
        .registration-form {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 2rem;
        }

        .form-header {
            margin-bottom: 2rem;
            border-bottom: 1px solid #eee;
            padding-bottom: 1rem;
        }

        .form-header h2 {
            color: var(--primary);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--dark);
        }

        .form-control {
            width: 100%;
            padding: 0.8rem 1rem;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1rem;
            transition: border 0.3s;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary);
        }

        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
        }

        .btn {
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background-color: #5a4bc9;
        }

        .btn-outline {
            background: transparent;
            border: 1px solid var(--primary);
            color: var(--primary);
        }

        .btn-outline:hover {
            background: rgba(108, 92, 231, 0.1);
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            margin-top: 2rem;
        }

        .section-title {
            margin-bottom: 1.5rem;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        /* Responsive Styles - Combined from both files */
        @media (max-width: 1200px) {
            .sidebar {
                width: 240px;
            }
            .main-content {
                margin-left: 240px;
            }
        }

        @media (max-width: 992px) {
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
            .form-row {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .search-bar {
                width: 200px;
            }
        }

        @media (max-width: 576px) {
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
<!-- Sidebar-->
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
            <a href="dashboard.jsp" class="nav-link">
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
            <a href="${pageContext.request.contextPath}/staff/addcustomer.jsp" class="nav-link active">
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
    <!-- Topbar - Updated to match dashboard.jsp -->
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

    <!-- Content Area - Keep the form from original addcustomer.jsp -->
    <div class="content-area">
        <div class="registration-form">
            <div class="form-header">
                <h2><i class="fas fa-user-plus"></i> New Customer Registration</h2>
                <p>Fill in all required details to create a new customer account with banking services</p>
            </div>

            <form action="${pageContext.request.contextPath}/staff/add_customer" method="POST">
                <!-- Personal Information Section -->
                <div class="section-header">
                    <h3 class="section-title"><i class="fas fa-user-circle"></i> Personal Information</h3>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="firstName">First Name *</label>
                        <input type="text" id="firstName" name="firstName" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="lastName">Last Name *</label>
                        <input type="text" id="lastName" name="lastName" class="form-control" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="dateOfBirth">Date of Birth *</label>
                        <input type="date" id="dateOfBirth" name="dateOfBirth" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="gender">Gender</label>
                        <select id="gender" name="gender" class="form-control">
                            <option value="">Select Gender</option>
                            <option value="MALE">Male</option>
                            <option value="FEMALE">Female</option>
                            <option value="OTHER">Other</option>
                        </select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="email">Email Address *</label>
                        <input type="email" id="email" name="email" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Password *</label>
                        <input type="text" id="password" name="password" class="form-control" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="phone">Phone Number *</label>
                        <input type="tel" id="phone" name="phone" class="form-control" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="address">Street Address *</label>
                    <input type="text" id="address" name="address" class="form-control" required>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="city">City *</label>
                        <input type="text" id="city" name="city" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="state">State/Province *</label>
                        <input type="text" id="state" name="state" class="form-control" required>
                    </div>
                </div>

                <!-- Bank Account Information Section -->
                <div class="section-header">
                    <h3 class="section-title"><i class="fas fa-university"></i> Bank Account Information</h3>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="accountType">Account Type *</label>
                        <select id="accountType" name="accountType" class="form-control" required>
                            <option value="">Select Account Type</option>
                            <option value="CHECKING">Checking Account</option>
                            <option value="SAVINGS">Savings Account</option>
                            <option value="BUSINESS">Business Account</option>
                            <option value="JOINT">Joint Account</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="initialDeposit">Initial Deposit Amount *</label>
                        <input type="number" id="initialDeposit" name="initialDeposit" class="form-control" min="0" step="0.01" required>
                    </div>
                </div>

                <!-- Identification Section -->
                <div class="section-header">
                    <h3 class="section-title"><i class="fas fa-id-card"></i> Identification</h3>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="idType">ID Type *</label>
                        <select id="idType" name="idType" class="form-control" required>
                            <option value="">Select ID Type</option>
                            <option value="PASSPORT">Passport</option>
                            <option value="DRIVERS_LICENSE">Driver's License</option>
                            <option value="NATIONAL_ID">National ID</option>
                            <option value="OTHER">Other Government ID</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="idNumber">ID Number *</label>
                        <input type="text" id="idNumber" name="idNumber" class="form-control" required>
                    </div>
                </div>

                <div class="form-actions">
                    <button type="button" class="btn btn-outline" onclick="location.href='dashboard.jsp'">
                        <i class="fas fa-arrow-left"></i> Cancel
                    </button>
                    <button type="reset" class="btn btn-outline">
                        <i class="fas fa-redo"></i> Reset
                    </button>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Register Customer
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Form validation for date of birth (must be at least 18 years old)
    document.getElementById('dateOfBirth').addEventListener('change', function() {
        const dob = new Date(this.value);
        const today = new Date();
        let age = today.getFullYear() - dob.getFullYear();
        const monthDiff = today.getMonth() - dob.getMonth();

        if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < dob.getDate())) {
            age--;
        }

        if (age < 18) {
            alert('Customer must be at least 18 years old');
            this.value = '';
        }
    });

    // Initialize form fields with default values if needed
    document.addEventListener('DOMContentLoaded', function() {
        // Set today's date as maximum for date of birth
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('dateOfBirth').setAttribute('max', today);
    });
</script>
</body>
</html>