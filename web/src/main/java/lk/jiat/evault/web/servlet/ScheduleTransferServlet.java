package lk.jiat.evault.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.jiat.evault.core.model.Customer;
import lk.jiat.evault.core.model.ScheduledTransfer;
import lk.jiat.evault.core.model.TransferFrequency;
import lk.jiat.evault.core.service.ScheduledTransferService;

import lk.jiat.evault.core.service.CustomerService;
import lk.jiat.evault.core.exception.InvalidParameterException;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;

@WebServlet(name = "ScheduleTransferServlet", urlPatterns = "/customer/schedule-transfer")
public class ScheduleTransferServlet extends HttpServlet {

    @EJB
    private ScheduledTransferService scheduledTransferService;

    @EJB
    private CustomerService customerService;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Long customerId = (Long) session.getAttribute("customerId");
        if (customerId == null) {
            session.setAttribute("error", "Session expired. Please login again.");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            // Get the customer from the database
            Customer customer = customerService.getCustomerById(customerId);
            if (customer == null) {
                throw new InvalidParameterException("Customer not found");
            }

            ScheduledTransfer transfer = new ScheduledTransfer();
            transfer.setCustomer(customer);
            transfer.setAmount(new BigDecimal(request.getParameter("amount")));
            transfer.setDescription(request.getParameter("description"));
            transfer.setFrequency(TransferFrequency.valueOf(request.getParameter("frequency")));
            transfer.setStartDate(LocalDate.parse(request.getParameter("startDate")));

            String endDateParam = request.getParameter("endDate");
            if (endDateParam != null && !endDateParam.isEmpty()) {
                transfer.setEndDate(LocalDate.parse(endDateParam));
            }

            transfer.setNextExecutionDate(transfer.getStartDate());
            transfer.setActive(true);

            String transferType = request.getParameter("transferType");
            if ("internal".equals(transferType)) {
                transfer.setRecipientAccount(request.getParameter("toAccount"));
                transfer.setRecipientName("Internal Transfer");
                transfer.setRecipientBank("Internal");
            } else {
                transfer.setRecipientAccount(request.getParameter("recipientAccount"));
                transfer.setRecipientName(request.getParameter("recipientName"));
                transfer.setRecipientBank(request.getParameter("recipientBank"));
            }

            scheduledTransferService.createScheduledTransfer(transfer);

            session.setAttribute("success", "Transfer scheduled successfully!");
        } catch (Exception e) {
            session.setAttribute("error", "Failed to schedule transfer: " + e.getMessage());
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/customer/scheduled-transfers.jsp");
    }
}