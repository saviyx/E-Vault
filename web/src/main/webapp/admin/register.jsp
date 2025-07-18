<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Registration | E-Vault</title>
    <style>
        :root {
            --primary: #4361ee;
            --primary-light: #4895ef;
            --primary-dark: #3a0ca3;
            --secondary: #f72585;
            --dark: #212529;
            --light: #f8f9fa;
            --gray: #6c757d;
            --success: #4cc9f0;
            --danger: #f72585;
            --warning: #f8961e;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
        }

        body {
            background-color: #f5f7ff;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .register-container {
            width: 100%;
            max-width: 900px;
            background: white;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            display: grid;
            grid-template-columns: 1fr 1.5fr;
        }

        /* Visual Panel */
        .visual-panel {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            padding: 40px;
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .visual-panel::before {
            content: '';
            position: absolute;
            width: 300px;
            height: 300px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            top: -50px;
            right: -50px;
        }

        .visual-panel::after {
            content: '';
            position: absolute;
            width: 200px;
            height: 200px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            bottom: -30px;
            left: -30px;
        }

        .admin-icon {
            font-size: 3.5rem;
            margin-bottom: 20px;
            color: white;
        }

        .visual-panel h2 {
            font-size: 1.8rem;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .visual-panel p {
            opacity: 0.9;
            font-size: 0.95rem;
            line-height: 1.6;
            max-width: 300px;
        }

        .security-img {
            width: 100%;
            max-width: 250px;
            margin-top: 30px;
            filter: drop-shadow(0 5px 15px rgba(0, 0, 0, 0.2));
        }

        /* Form Panel */
        .form-panel {
            padding: 50px;
        }

        .form-header {
            margin-bottom: 30px;
        }

        .form-logo {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 15px;
        }

        .form-logo i {
            font-size: 1.8rem;
            color: var(--primary);
        }

        .form-logo span {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--dark);
        }

        .form-title {
            font-size: 1.5rem;
            color: var(--dark);
            margin-bottom: 5px;
        }

        .form-subtitle {
            color: var(--gray);
            font-size: 0.95rem;
        }

        /* Form Elements */
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group.full-width {
            grid-column: span 2;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-size: 0.9rem;
            font-weight: 600;
            color: var(--dark);
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--primary);
            outline: none;
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.2);
        }

        .form-select {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='%236c757d' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 15px center;
            background-size: 12px;
        }

        /* Password Strength */
        .password-strength {
            height: 4px;
            background: #eee;
            border-radius: 2px;
            margin-top: 8px;
            overflow: hidden;
        }

        .strength-meter {
            height: 100%;
            width: 0%;
            transition: all 0.3s ease;
        }

        .password-hint {
            font-size: 0.8rem;
            color: var(--gray);
            margin-top: 5px;
        }

        /* Terms */
        .terms-group {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            margin: 25px 0;
        }

        .terms-checkbox {
            margin-top: 3px;
        }

        .terms-text {
            font-size: 0.9rem;
            color: var(--gray);
            line-height: 1.5;
        }

        .terms-link {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
        }

        /* Submit Button */
        .submit-btn {
            width: 100%;
            padding: 14px;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .submit-btn:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.3);
        }

        /* Login Link */
        .login-link {
            text-align: center;
            margin-top: 20px;
            font-size: 0.95rem;
            color: var(--gray);
        }

        .login-link a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .register-container {
                grid-template-columns: 1fr;
            }

            .visual-panel {
                padding: 30px 20px;
            }

            .form-panel {
                padding: 30px;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .form-group.full-width {
                grid-column: span 1;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
<div class="register-container">
    <!-- Visual Panel -->
    <div class="visual-panel">
        <i class="fas fa-shield-alt admin-icon"></i>
        <h2>E-Vault Staff Registration</h2>
        <p>Register new bank staff members with appropriate access levels</p>

    </div>

    <!-- Form Panel -->
    <div class="form-panel">
        <div class="form-header">
            <div class="form-logo">
                <i class="fas fa-vault"></i>
                <span>E-Vault</span>
            </div>
            <h1 class="form-title">Register New Staff Member</h1>
            <p class="form-subtitle">Fill  details to register neew staff member</p>
        </div>

        <form action="${pageContext.request.contextPath}/admin/staff_register" method="POST">
            <div class="form-grid">
                <!-- First Name -->
                <div class="form-group">
                    <label for="firstName" class="form-label">First Name</label>
                    <input type="text" id="firstName" name="firstName" class="form-control" placeholder="John" required>
                </div>

                <!-- Last Name -->
                <div class="form-group">
                    <label for="lastName" class="form-label">Last Name</label>
                    <input type="text" id="lastName" name="lastName" class="form-control" placeholder="Doe" required>
                </div>

                <!-- Email -->
                <div class="form-group full-width">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" id="email" name="email" class="form-control" placeholder="john.doe@company.com" required>
                </div>

                <!-- Contact -->
                <div class="form-group full-width">
                    <label for="contact" class="form-label">Contact Number</label>
                    <input type="tel" id="contact" name="contact" class="form-control" placeholder="0771077618" required>
                </div>

                <!-- Role -->
                <div class="form-group full-width">
                    <label for="role" class="form-label">Choose Staff Role</label>
                    <select id="role" name="role" class="form-control form-select" required>
                        <option value="">Select Role</option>
                        <option value="customer_support">Customer Support</option>
                        <option value="financial_officer">Financial Officer</option>
                        <option value="loan_officer">Loan Officer</option>
                        <option value="teller">Teller</option>
                        <option value="it_support">IT Support</option>
                        <option value="audit_officer">Audit Officer</option>
                    </select>
                </div>

                <!-- Password -->
                <div class="form-group">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" id="password" name="password" class="form-control" placeholder="Create password" required>
                    <div class="password-strength">
                        <div class="strength-meter" id="strengthMeter"></div>
                    </div>
                    <small class="password-hint" id="passwordHint">Use 8+ characters with uppercase, numbers & symbols</small>
                </div>

                <!-- Confirm Password -->
                <div class="form-group">
                    <label for="confirmPassword" class="form-label">Confirm Password</label>
                    <input type="password" id="confirmPassword" class="form-control" placeholder="Re-enter password" required>
                </div>
            </div>

            <!-- Terms Checkbox -->
            <div class="terms-group">
                <input type="checkbox" id="terms" class="terms-checkbox" required>
                <label for="terms" class="terms-text">
                    I agree to the <a href="#" class="terms-link">Terms of Service</a> and acknowledge the
                    Staff responsibilities
                </label>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="submit-btn">
                <i class="fas fa-user-shield"></i> Register Staff
            </button>
        </form>

        <div class="login-link">
            Already have an account? <a href="../login.jsp">Sign In</a>
        </div>
    </div>
</div>

<script>
    // Password Strength Indicator
    const passwordInput = document.getElementById('password');
    const strengthMeter = document.getElementById('strengthMeter');
    const passwordHint = document.getElementById('passwordHint');

    passwordInput.addEventListener('input', function() {
        const password = this.value;
        let strength = 0;

        // Length check
        if (password.length >= 8) strength += 1;
        // Uppercase check
        if (password.match(/[A-Z]/)) strength += 1;
        // Number check
        if (password.match(/[0-9]/)) strength += 1;
        // Special character check
        if (password.match(/[^A-Za-z0-9]/)) strength += 1;

        // Update strength meter
        const width = strength * 25;
        strengthMeter.style.width = width + '%';

        // Update colors and hints
        if (strength <= 1) {
            strengthMeter.style.backgroundColor = '#f72585';
            passwordHint.textContent = 'Weak password - add uppercase, numbers & symbols';
            passwordHint.style.color = '#f72585';
        } else if (strength <= 2) {
            strengthMeter.style.backgroundColor = '#f8961e';
            passwordHint.textContent = 'Moderate password - could be stronger';
            passwordHint.style.color = '#f8961e';
        } else {
            strengthMeter.style.backgroundColor = '#4cc9f0';
            passwordHint.textContent = 'Strong password - good job!';
            passwordHint.style.color = '#4cc9f0';
        }
    });

    // Form Validation
    document.querySelector('form').addEventListener('submit', function(e) {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        const termsChecked = document.getElementById('terms').checked;

        // Password match check
        if (password !== confirmPassword) {
            e.preventDefault();
            alert('Error: Passwords do not match');
            document.getElementById('confirmPassword').focus();
            return false;
        }

        // Terms agreement check
        if (!termsChecked) {
            e.preventDefault();
            alert('You must agree to the Terms of Service');
            return false;
        }

        return true;
    });
</script>
</body>
</html>