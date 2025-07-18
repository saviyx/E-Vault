package lk.jiat.evault.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.evault.core.model.Staff;
import lk.jiat.evault.core.service.StaffService;
import lk.jiat.evault.core.util.Encryption;

import java.io.IOException;
import java.util.Set;

@WebServlet("/admin/staff_register")
public class StaffRegister extends HttpServlet {

    @EJB
    private StaffService staffService;

    // Valid roles matching your select options
    private static final Set<String> VALID_ROLES = Set.of(
            "customer_support",
            "financial_officer",
            "loan_officer",
            "teller",
            "it_support",
            "audit_officer"
    );

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get parameters
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("contact");
        String role = request.getParameter("role");

        // Validate role
        if (role == null || !VALID_ROLES.contains(role)) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid staff role selected"
            );
            return;
        }

        // Encrypt and create staff
        String encryptedPassword = Encryption.encrypt(password);
        Staff staff = new Staff(
                firstName,
                lastName,
                email,
                phone,
                encryptedPassword,
                role
        );

        // Save and redirect
        staffService.addStaff(staff);
        response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
    }
}