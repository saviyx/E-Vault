package lk.jiat.evault.web.servlet;

import jakarta.ejb.EJB;
import jakarta.inject.Inject;
import jakarta.security.enterprise.AuthenticationStatus;
import jakarta.security.enterprise.SecurityContext;
import jakarta.security.enterprise.authentication.mechanism.http.AuthenticationParameters;
import jakarta.security.enterprise.credential.UsernamePasswordCredential;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.jiat.evault.core.service.CustomerService;
import lk.jiat.evault.core.exception.LoginFailedException;
import lk.jiat.evault.core.model.Customer;
import lk.jiat.evault.core.util.Encryption;

import java.io.IOException;

@WebServlet("/customer/login")
public class CustomerLogin extends HttpServlet {

    @Inject
    private SecurityContext securityContext;

    @EJB
    private CustomerService customerService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validate input parameters
        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("error", "Email and password are required");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        try {
            AuthenticationParameters parameters = AuthenticationParameters.withParams()
                    .credential(new UsernamePasswordCredential(email, Encryption.encrypt(password)));

            AuthenticationStatus status = securityContext.authenticate(request, response, parameters);

            if (status == AuthenticationStatus.SUCCESS) {
                // Get customer details after successful authentication
                Customer customer = customerService.getCustomerByEmail(email);
                if (customer == null) {
                    throw new LoginFailedException("Customer not found");
                }

                // Store in session - ensure proper session handling
                HttpSession session = request.getSession(true); // Force create new session if needed

                // Clear any existing attributes first
                session.removeAttribute("customer");
                session.removeAttribute("customerId");
                session.removeAttribute("customerEmail");
                session.removeAttribute("accountNumber");
                session.removeAttribute("name");

                // Set new attributes
                session.setAttribute("customer", customer);
                session.setAttribute("customerEmail", email);
                session.setAttribute("customerId", customer.getId());
                session.setAttribute("accountNumber", customer.getAccountNumber());
                session.setAttribute("name", customer.getFirstName() + " " + customer.getLastName());

                // Add user object for JSP display
                session.setAttribute("user", customer);

                // Debug logging
                System.out.println("Login successful for customer: " + customer.getId());
                System.out.println("Session ID: " + session.getId());
                System.out.println("Session customerId set to: " + session.getAttribute("customerId"));

                // Redirect to dashboard
                response.sendRedirect(request.getContextPath() + "/customer/dashboard.jsp");
            } else {
                throw new LoginFailedException("Invalid username or password");
            }
        } catch (LoginFailedException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace(); // Add this for debugging
            request.setAttribute("error", "Login failed: " + e.getMessage());
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}