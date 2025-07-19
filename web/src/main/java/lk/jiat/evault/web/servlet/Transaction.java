package lk.jiat.evault.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.jiat.evault.core.exception.InsufficientBalanceException;
import lk.jiat.evault.core.exception.InvalidParameterException;
import lk.jiat.evault.ejb.bean.TransactionSessionBean;

import java.io.IOException;
import java.math.BigDecimal;

@WebServlet(name = "TransactionServlet", urlPatterns = "/customer/transaction")
public class Transaction extends HttpServlet {

    @EJB
    private TransactionSessionBean transactionSessionBean;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false); // Don't create new session

        // Debug session information
        System.out.println("Transaction servlet - Session: " + (session != null ? session.getId() : "null"));

        if (session == null) {
            System.out.println("No session found");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Try to get customer ID with multiple approaches
        Long customerId = null;
        Object customerIdObj = session.getAttribute("customerId");

        System.out.println("customerIdObj: " + customerIdObj + " (type: " +
                (customerIdObj != null ? customerIdObj.getClass().getName() : "null") + ")");

        if (customerIdObj instanceof Long) {
            customerId = (Long) customerIdObj;
        } else if (customerIdObj instanceof Integer) {
            customerId = ((Integer) customerIdObj).longValue();
        } else if (customerIdObj instanceof String) {
            try {
                customerId = Long.parseLong((String) customerIdObj);
            } catch (NumberFormatException e) {
                System.out.println("Cannot parse customerId as Long: " + customerIdObj);
            }
        }

        System.out.println("Final customerId: " + customerId);

        if (customerId == null) {
            System.out.println("Customer ID is null - redirecting to login");
            session.setAttribute("error", "Session expired. Please login again.");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String type = request.getParameter("transferType");
        String amountStr = request.getParameter("amount");
        String description = request.getParameter("description");

        System.out.println("Transaction parameters - Type: " + type + ", Amount: " + amountStr);

        try {
            // Validate amount
            BigDecimal amount = validateAndParseAmount(amountStr);

            String message;
            boolean success;

            if ("internal".equals(type)) {
                String toAccount = "Internal (to fixed account)";
                success = transactionSessionBean.transferBetweenAccounts(
                        customerId, toAccount, amount, description);
                message = formatSuccessMessage("Internal", amount, success);
                System.out.println("Internal transfer result: " + success);
            }
            else if ("external".equals(type)) {
                String recipientName = validateParameter(request.getParameter("recipientName"),
                        "Recipient name is required");
                String recipientAccount = validateParameter(request.getParameter("recipientAccount"),
                        "Recipient account is required");
                String recipientBank = validateParameter(request.getParameter("recipientBank"),
                        "Recipient bank is required");

                success = transactionSessionBean.transferToExternalAccount(
                        customerId, recipientName, recipientAccount, recipientBank, amount, description);
                message = formatSuccessMessage("External", amount, success);
                System.out.println("External transfer result: " + success);
            } else {
                throw new InvalidParameterException("Invalid transfer type");
            }

            // Set success/error messages
            if (success) {
                session.setAttribute("success", message);
                session.removeAttribute("error");
            } else {
                session.setAttribute("error", "Transfer failed. Please try again.");
                session.removeAttribute("success");
            }

        } catch (InsufficientBalanceException e) {
            System.out.println("Insufficient balance: " + e.getMessage());
            session.setAttribute("error", e.getMessage());
            session.removeAttribute("success");
        } catch (InvalidParameterException e) {
            System.out.println("Invalid parameter: " + e.getMessage());
            session.setAttribute("error", e.getMessage());
            session.removeAttribute("success");
        } catch (NumberFormatException e) {
            System.out.println("Number format error: " + e.getMessage());
            session.setAttribute("error", "Invalid amount format");
            session.removeAttribute("success");
        } catch (Exception e) {
            System.out.println("General error: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("error", "Transaction failed: " + e.getMessage());
            session.removeAttribute("success");
        }

        response.sendRedirect(request.getContextPath() + "/customer/transfer.jsp");
    }

    private BigDecimal validateAndParseAmount(String amountStr) throws InvalidParameterException {
        if (amountStr == null || amountStr.trim().isEmpty()) {
            throw new InvalidParameterException("Amount is required");
        }

        try {
            BigDecimal amount = new BigDecimal(amountStr.trim());
            if (amount.compareTo(BigDecimal.ZERO) <= 0) {
                throw new InvalidParameterException("Amount must be positive");
            }
            return amount;
        } catch (NumberFormatException e) {
            throw new InvalidParameterException("Invalid amount format");
        }
    }

    private String validateParameter(String value, String errorMessage)
            throws InvalidParameterException {
        if (value == null || value.trim().isEmpty()) {
            throw new InvalidParameterException(errorMessage);
        }
        return value.trim();
    }

    private String formatSuccessMessage(String type, BigDecimal amount, boolean success) {
        return success ? String.format("%s transfer of $%.2f completed successfully!", type, amount)
                : "Transfer failed!";
    }
}