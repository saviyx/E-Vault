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

import java.io.IOException;

@WebServlet("/admin/admin_login")
public class AdminLogin extends HttpServlet {

    @Inject
    private SecurityContext securityContext;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        //System.out.println(email + " " + password);

        AuthenticationParameters parameters = AuthenticationParameters.withParams()
                .credential(new UsernamePasswordCredential(email, password));

        System.out.println("authentication parameters: " + parameters);

        AuthenticationStatus status = securityContext.authenticate(request, response, parameters);
        if (status == AuthenticationStatus.SUCCESS) {
            System.out.println("Authentication successful");
            response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
        } else {
            System.out.println("Authentication failed");
            throw new LoginFailedException("Invalid username or password");
        }

    }
}
