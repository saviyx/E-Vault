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

//@ServletSecurity(@HttpConstraint(rolesAllowed = {"ADMIN"}))
@WebServlet("/admin/staff_register")
public class StaffRegister extends HttpServlet {

    @EJB
    private StaffService staffService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String role = request.getParameter("role");

       //System.out.println(firstName + " " + lastName + " " + email + " " + password + " " + phone);

        String encriptedPassword = Encryption.encrypt(password);
        Staff staff = new Staff(firstName, lastName, email, phone, encriptedPassword, role);

        staffService.addStaff(staff);
        response.sendRedirect(request.getContextPath() +  "/admin/dashbord.jsp");


    }
}
