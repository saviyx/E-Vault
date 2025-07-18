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
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

@WebServlet("/staff/add_customer")
public class AddCustomer extends HttpServlet {

    @EJB
    private CustomerService customerService;

    private static final int MAX_ATTEMPTS = 100;
    private static final int ACCOUNT_NUMBER_LENGTH = 10;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            String accountNumber = generateUniqueAccountNumber();
            if (accountNumber == null) {
                throw new ServletException("Failed to generate unique account number");
            }

            // Parse the birth date from string to Date
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date birthDate = sdf.parse(request.getParameter("dateOfBirth"));

            String email = request.getParameter("email");

            // Create the customer with all required fields
            Customer customer = new Customer(
                    request.getParameter("firstName"),
                    request.getParameter("lastName"),
                    birthDate,
                    request.getParameter("gender"),
                    request.getParameter("email"),
                    Encryption.encrypt(request.getParameter("password")),
                    request.getParameter("phone"),
                    request.getParameter("address"),
                    request.getParameter("city"),
                    request.getParameter("state"),
                    request.getParameter("accountType"),
                    request.getParameter("idType"),
                    request.getParameter("idNumber"),
                    accountNumber,
                    Double.parseDouble(request.getParameter("initialDeposit"))
            );

            customerService.addCustomer(customer);
            response.sendRedirect(request.getContextPath() + "/staff/dashboard.jsp");




        } catch (Exception e) {
            e.printStackTrace(); // Add this to see errors in logs
            request.setAttribute("error", "Error registering customer: " + e.getMessage());
            request.getRequestDispatcher("/staff/addcustomer.jsp").forward(request, response);
        }
    }

    private String generateUniqueAccountNumber() {
        Random random = new Random();
        int attempts = 0;

        while (attempts < MAX_ATTEMPTS) {
            String accountNumber = generateRandomAccountNumber(random);
            if (!customerService.doesAccountNumberExist(accountNumber)) {
                return accountNumber;
            }
            attempts++;
        }
        return null;
    }

    private String generateRandomAccountNumber(Random random) {
        StringBuilder sb = new StringBuilder(ACCOUNT_NUMBER_LENGTH);
        sb.append(random.nextInt(9) + 1); // First digit 1-9
        for (int i = 1; i < ACCOUNT_NUMBER_LENGTH; i++) {
            sb.append(random.nextInt(10));
        }
        return sb.toString();
    }
}