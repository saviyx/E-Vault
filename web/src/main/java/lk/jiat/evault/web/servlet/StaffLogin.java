package lk.jiat.evault.web.servlet;

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
import lk.jiat.evault.core.exception.LoginFailedException;
import lk.jiat.evault.core.util.Encryption;

import java.io.IOException;

@WebServlet("/staff/staff_login")
public class StaffLogin extends HttpServlet {

    @Inject
    private SecurityContext securityContext;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        AuthenticationParameters parameters = AuthenticationParameters.withParams()
                .credential(new UsernamePasswordCredential(email, Encryption.encrypt(password)));

        AuthenticationStatus status = securityContext.authenticate(request, response, parameters);
        System.out.println("authentication parameters: " + parameters);

        if (status == AuthenticationStatus.SUCCESS) {
            System.out.println("Authentication successful");
            response.sendRedirect(request.getContextPath() + "/staff/dashbord.jsp");
        } else {
            System.out.println("Authentication failed");
            throw new LoginFailedException("Invalid username or password");
        }

    }
}
