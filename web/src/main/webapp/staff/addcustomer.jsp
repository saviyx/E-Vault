<%--
  Created by IntelliJ IDEA.
  User: savindu umantha
  Date: 7/11/2025
  Time: 1:23 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Customer | E-Vault</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .customer-form {
            background-color: #f8f9fa;
            min-height: 100vh;
            padding: 2rem 0;
        }
        .form-card {
            max-width: 800px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        .form-section {
            margin-bottom: 2rem;
        }
        .section-title {
            border-bottom: 2px solid #1e3c72;
            padding-bottom: 0.5rem;
            margin-bottom: 1.5rem;
            color: #1e3c72;
        }
    </style>
</head>
<body class="customer-form">
<%@ include file="../WEB-INF/templates/staff_header.jsp" %>

<div class="container">
    <div class="form-card card mx-auto">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">
                <i class="bi bi-person-plus"></i> New Customer Registration
            </h4>
        </div>
        <div class="card-body p-4">
            <form id="customerForm" action="${pageContext.request.contextPath}/staff/customers/add" method="POST">
                <!-- Personal Information Section -->
                <div class="form-section">
                    <h5 class="section-title">Personal Information</h5>
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label for="title" class="form-label">Title</label>
                            <select class="form-select" id="title" name="title">
                                <option value="MR">Mr.</option>
                                <option value="MRS">Mrs.</option>
                                <option value="MS">Ms.</option>
                                <option value="DR">Dr.</option>
                            </select>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="firstName" class="form-label">First Name</label>
                            <input type="text" class="form-control" id="firstName" name="firstName" required>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="lastName" class="form-label">Last Name</label>
                            <input type="text" class="form-control" id="lastName" name="lastName" required>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="dob" class="form-label">Date of Birth</label>
                            <input type="date" class="form-control" id="dob" name="dob" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="gender" class="form-label">Gender</label>
                            <select class="form-select" id="gender" name="gender">
                                <option value="MALE">Male</option>
                                <option value="FEMALE">Female</option>
                                <option value="OTHER">Other</option>
                                <option value="PREFER_NOT_TO_SAY">Prefer not to say</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- Contact Information Section -->
                <div class="form-section">
                    <h5 class="section-title">Contact Information</h5>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="phone" class="form-label">Phone Number</label>
                            <input type="tel" class="form-control" id="phone" name="phone" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="address" class="form-label">Street Address</label>
                        <input type="text" class="form-control" id="address" name="address" required>
                    </div>

                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label for="city" class="form-label">City</label>
                            <input type="text" class="form-control" id="city" name="city" required>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="state" class="form-label">State/Province</label>
                            <input type="text" class="form-control" id="state" name="state" required>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="zip" class="form-label">ZIP/Postal Code</label>
                            <input type="text" class="form-control" id="zip" name="zip" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="country" class="form-label">Country</label>
                        <select class="form-select" id="country" name="country" required>
                            <option value="US">United States</option>
                            <option value="UK">United Kingdom</option>
                            <option value="CA">Canada</option>
                            <!-- More countries can be added -->
                        </select>
                    </div>
                </div>

                <!-- Identification Section -->
                <div class="form-section">
                    <h5 class="section-title">Identification</h5>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="idType" class="form-label">ID Type</label>
                            <select class="form-select" id="idType" name="idType" required>
                                <option value="PASSPORT">Passport</option>
                                <option value="DRIVERS_LICENSE">Driver's License</option>
                                <option value="NATIONAL_ID">National ID</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="idNumber" class="form-label">ID Number</label>
                            <input type="text" class="form-control" id="idNumber" name="idNumber" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="idExpiry" class="form-label">ID Expiry Date</label>
                        <input type="date" class="form-control" id="idExpiry" name="idExpiry">
                    </div>
                </div>

                <!-- Initial Account Section -->
                <div class="form-section">
                    <h5 class="section-title">Initial Account</h5>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="accountType" class="form-label">Account Type</label>
                            <select class="form-select" id="accountType" name="accountType" required>
                                <option value="SAVINGS">Savings Account</option>
                                <option value="CHECKING">Checking Account</option>
                                <option value="BUSINESS">Business Account</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="initialDeposit" class="form-label">Initial Deposit</label>
                            <div class="input-group">
                                <span class="input-group-text">$</span>
                                <input type="number" class="form-control" id="initialDeposit"
                                       name="initialDeposit" min="0" step="0.01" value="0.00">
                            </div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="debitCard" name="debitCard">
                            <label class="form-check-label" for="debitCard">
                                Issue Debit Card
                            </label>
                        </div>
                    </div>

                    <div class="mb-3">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="onlineBanking" name="onlineBanking" checked>
                            <label class="form-check-label" for="onlineBanking">
                                Enable Online Banking
                            </label>
                        </div>
                    </div>
                </div>

                <!-- Terms and Submission -->
                <div class="form-section">
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="consent" required>
                        <label class="form-check-label" for="consent">
                            I confirm that the customer has provided valid identification and consented to
                            our <a href="#" data-bs-toggle="modal" data-bs-target="#termsModal">Terms of Service</a>.
                        </label>
                    </div>

                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                        <button type="reset" class="btn btn-outline-secondary me-md-2">
                            <i class="bi bi-arrow-counterclockwise"></i> Reset
                        </button>
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-save"></i> Save Customer
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <% if (request.getParameter("success") != null) { %>
    <div class="alert alert-success mt-3 text-center">
        <i class="bi bi-check-circle-fill"></i>
        Customer added successfully! Account Number: ${param.accountNumber}
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
                <h5 class="modal-title">Bank Terms of Service</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <h6>Customer Agreement</h6>
                <p>By opening an account, customers agree to:</p>
                <ul>
                    <li>Provide accurate information</li>
                    <li>Maintain minimum balances if required</li>
                    <li>Pay applicable fees</li>
                    <li>Report unauthorized transactions immediately</li>
                </ul>
                <hr>
                <p class="small text-muted">Staff must verify all customer identification before account opening.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
<script>
    // Form validation
    document.getElementById('customerForm').addEventListener('submit', function(e) {
        const dob = new Date(document.getElementById('dob').value);
        const today = new Date();
        const minAgeDate = new Date();
        minAgeDate.setFullYear(today.getFullYear() - 18);

        if (dob > minAgeDate) {
            e.preventDefault();
            alert('Customer must be at least 18 years old');
            return false;
        }

        return true;
    });

    // Set default branch to staff's branch
    document.getElementById('branch').value = '${staff.branch}';
</script>
</body>
</html>
