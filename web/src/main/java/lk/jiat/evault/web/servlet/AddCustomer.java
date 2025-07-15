package lk.jiat.evault.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.evault.core.model.Customer;
import lk.jiat.evault.core.service.CustomerService;
import lk.jiat.evault.core.util.Encryption;

import java.io.IOException;

@WebServlet("/staff/add_customer")
public class AddCustomer extends HttpServlet {

    @EJB
    private CustomerService customerService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String dob = request.getParameter("birthDate");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String contact  = request.getParameter("contact");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String accountType = request.getParameter("accountType");
        String accountNumber = request.getParameter("accountNumber");
        Double balance = Double.parseDouble(request.getParameter("balance"));

        String encriptedPassword = Encryption.encrypt(password);
        Customer customer = new Customer(firstName, lastName, dob, gender, email, encriptedPassword, contact
                , address, city, state, accountType, accountNumber, balance);

        customerService.addCustomer(customer);
        response.sendRedirect("/staff/dashbord.jsp");

    }
}
