package lk.jiat.evault.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.jiat.evault.core.model.Staff;
import lk.jiat.evault.core.service.StaffService;

import java.io.IOException;
import java.security.Principal;

@WebServlet("/staff/dashboard")
public class StaffDashboard extends HttpServlet {

    @EJB
    private StaffService staffService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the logged-in user's email from security context
        Principal principal = request.getUserPrincipal();
        if (principal == null) {
            response.sendRedirect(request.getContextPath() + "/staff/login.jsp");
            return;
        }

        String email = principal.getName();

        try {
            // Get staff information
            Staff staff = staffService.getStaffByEmail(email);

            // Set staff object in session so it's available across requests
            HttpSession session = request.getSession();
            session.setAttribute("staff", staff);

            // Set mock data for dashboard (you'll replace with real data later)
            request.setAttribute("todayCustomers", 25);
            request.setAttribute("pendingApprovals", 8);
            request.setAttribute("todayTransactions", 150);
            request.setAttribute("alertsCount", 3);
            request.setAttribute("unreadNotifications", 5);

            // Forward to dashboard JSP
            request.getRequestDispatcher("/staff/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading dashboard");
        }
    }
}