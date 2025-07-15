<%--
  Created by IntelliJ IDEA.
  User: savindu umantha
  Date: 7/11/2025
  Time: 1:21 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Registration | E-Vault</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .staff-register {
            background-color: #f8f9fa;
            min-height: 100vh;
            padding: 2rem 0;
        }
        .register-card {
            max-width: 600px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        .security-level {
            height: 8px;
            margin-top: 5px;
        }
    </style>
</head>
<body class="staff-register">
<div class="container">
    <div class="register-card card mx-auto">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">
                <i class="bi bi-person-plus"></i> Staff Registration
            </h4>
        </div>
        <div class="card-body p-4">
            <form action="${pageContext.request.contextPath}/staff/register" method="POST" id="registrationForm">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="firstName" class="form-label">First Name</label>
                        <input type="text" class="form-control" id="firstName" name="firstName" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="lastName" class="form-label">Last Name</label>
                        <input type="text" class="form-control" id="lastName" name="lastName" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label">Bank Email</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>

                <div class="mb-3">
                    <label for="branch" class="form-label">Branch</label>
                    <select class="form-select" id="branch" name="branch" required>
                        <option value="">Select Branch</option>
                        <option value="HEAD_OFFICE">Head Office</option>
                        <option value="MAIN_BRANCH">Main Branch</option>
                        <option value="NORTH_BRANCH">North Branch</option>
                        <option value="SOUTH_BRANCH">South Branch</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="position" class="form-label">Position</label>
                    <select class="form-select" id="position" name="position" required>
                        <option value="">Select Position</option>
                        <option value="TELLER">Teller</option>
                        <option value="CUSTOMER_SERVICE">Customer Service</option>
                        <option value="MANAGER">Branch Manager</option>
                        <option value="OPERATIONS">Operations</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="staffId" class="form-label">Staff ID</label>
                    <input type="text" class="form-control" id="staffId" name="staffId"
                           pattern="[A-Z]{2}\d{5}" title="Format: AB12345" required>
                    <small class="text-muted">Format: AB12345 (2 letters + 5 digits)</small>
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                    <div class="progress security-level">
                        <div class="progress-bar" id="passwordStrength" role="progressbar"></div>
                    </div>
                    <small id="passwordHelp" class="text-muted"></small>
                </div>

                <div class="mb-3">
                    <label for="confirmPassword" class="form-label">Confirm Password</label>
                    <input type="password" class="form-control" id="confirmPassword" required>
                </div>

                <div class="mb-3 form-check">
                    <input type="checkbox" class="form-check-input" id="terms" required>
                    <label class="form-check-label" for="terms">
                        I agree to the bank's <a href="#" data-bs-toggle="modal" data-bs-target="#termsModal">Staff Policy</a>
                    </label>
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary btn-lg">
                        <i class="bi bi-person-check"></i> Register Staff
                    </button>
                </div>
            </form>
        </div>
    </div>

    <% if (request.getParameter("success") != null) { %>
    <div class="alert alert-success mt-3 text-center">
        <i class="bi bi-check-circle-fill"></i>
        Staff registration successful! Awaiting manager approval.
    </div>
    <% } %>

    <% if (request.getParameter("error") != null) { %>
    <div class="alert alert-danger mt-3 text-center">
        <i class="bi bi-exclamation-triangle-fill"></i>
        <%= request.getParameter("error") %>
    </div>
    <% } %>
</div>

<!-- Terms Modal -->
<div class="modal fade" id="termsModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Bank Staff Policy</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <h6>Confidentiality Agreement</h6>
                <p>As a bank staff member, you agree to:</p>
                <ul>
                    <li>Maintain strict confidentiality of all customer information</li>
                    <li>Never share your login credentials</li>
                    <li>Report any suspicious activity immediately</li>
                    <li>Comply with all banking regulations and internal policies</li>
                </ul>
                <hr>
                <p class="small text-muted">Violations may result in termination and legal action.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">I Understand</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
<script>
    // Password strength checker
    document.getElementById('password').addEventListener('input', function() {
        const password = this.value;
        const strengthBar = document.getElementById('passwordStrength');
        const helpText = document.getElementById('passwordHelp');

        let strength = 0;
        if (password.length >= 10) strength += 1;
        if (password.match(/[A-Z]/)) strength += 1;
        if (password.match(/[0-9]/)) strength += 1;
        if (password.match(/[^A-Za-z0-9]/)) strength += 1;

        const width = strength * 25;
        strengthBar.style.width = width + '%';

        if (strength <= 1) {
            strengthBar.className = 'progress-bar bg-danger';
            helpText.textContent = 'Weak - Not acceptable for staff';
        } else if (strength <= 2) {
            strengthBar.className = 'progress-bar bg-warning';
            helpText.textContent = 'Moderate - Must include numbers and capitals';
        } else {
            strengthBar.className = 'progress-bar bg-success';
            helpText.textContent = 'Strong password';
        }
    });

    // Form validation
    document.getElementById('registrationForm').addEventListener('submit', function(e) {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if (password !== confirmPassword) {
            e.preventDefault();
            alert('Passwords do not match!');
            return false;
        }

        if (password.length < 10 || !password.match(/[A-Z]/) || !password.match(/[0-9]/)) {
            e.preventDefault();
            alert('Password must be at least 10 characters with at least one capital letter and one number');
            return false;
        }

        return true;
    });
</script>
</body>
</html>
