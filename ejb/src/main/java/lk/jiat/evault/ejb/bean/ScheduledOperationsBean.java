package lk.jiat.evault.ejb.bean;

import jakarta.ejb.*;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.jiat.evault.core.model.Customer;
import lk.jiat.evault.core.model.ScheduledTransfer;
import lk.jiat.evault.core.model.Transaction;
import lk.jiat.evault.core.model.TransactionType;
import lk.jiat.evault.core.service.CustomerService;
import lk.jiat.evault.core.service.ScheduledTransferService;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Singleton
@Startup
public class ScheduledOperationsBean {

    @EJB
    private ScheduledTransferService scheduledTransferService;

    @EJB
    private CustomerService customerService;

    @PersistenceContext
    private EntityManager em;


    // Run daily at midnight
    @Schedule(hour = "0", minute = "0", second = "0", persistent = false)
    public void dailyOperations() {
        System.out.println("Running daily scheduled operations...");

        // 1. Calculate and apply interest
        calculateDailyInterest();

        // 2. Process scheduled transfers
        processScheduledTransfers();

        // 3. Update daily balances
        updateDailyBalances();
    }

    // Run at the end of each month
    @Schedule(dayOfMonth = "Last", hour = "23", minute = "59", persistent = false)
    public void monthlyOperations() {
        System.out.println("Running monthly scheduled operations...");

        // Calculate monthly interest
        calculateMonthlyInterest();

        // Generate monthly statements
        generateMonthlyStatements();
    }

    private void processScheduledTransfers() {
        List<ScheduledTransfer> dueTransfers = scheduledTransferService.getDueScheduledTransfers();

        for (ScheduledTransfer transfer : dueTransfers) {
            try {
                // Process the transfer
                Customer customer = transfer.getCustomer();
                BigDecimal amount = transfer.getAmount();

                // Record transaction
                Transaction tx = new Transaction(
                        transfer.getRecipientBank().equals("Internal") ?
                                TransactionType.INTERNAL : TransactionType.EXTERNAL,
                        amount,
                        transfer.getDescription(),
                        customer,
                        transfer.getRecipientAccount()
                );
                tx.setRecipientName(transfer.getRecipientName());
                tx.setRecipientBank(transfer.getRecipientBank());
                em.persist(tx);

                // Update transfer status
                scheduledTransferService.processCompletedTransfer(transfer);

            } catch (Exception e) {
                System.err.println("Failed to process transfer: " + transfer.getId());
                e.printStackTrace();
            }
        }
    }

    private void calculateDailyInterest() {
        try {
            List<Customer> customers = customerService.getAllCustomers();

            for (Customer customer : customers) {
                try {
                    if (customer.getBalance() > 0 && customer.getInterestRate() != null) {
                        double dailyInterest = calculateInterest(
                                customer.getBalance(),
                                customer.getInterestRate(),
                                1
                        );

                        // Update balance
                        customer.setBalance(customer.getBalance() + dailyInterest);
                        em.merge(customer);

                        // Record transaction
                        Transaction interestTx = new Transaction(
                                TransactionType.INTEREST,
                                BigDecimal.valueOf(dailyInterest),
                                "Daily interest credit",
                                customer,
                                customer.getAccountNumber()
                        );
                        em.persist(interestTx);
                    }
                } catch (Exception e) {
                    System.err.println("Error processing interest for customer " +
                            customer.getId() + ": " + e.getMessage());
                    e.printStackTrace();
                }
            }
        } catch (Exception e) {
            System.err.println("Error in daily interest calculation: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void calculateMonthlyInterest() {
        // Similar to daily interest but for monthly calculation
        List<Customer> customers = customerService.getAllCustomers();

        for (Customer customer : customers) {
            if (customer.getBalance() > 0) {
                double monthlyInterest = calculateInterest(customer.getBalance(),
                        customer.getInterestRate(),
                        30); // Approximate 30 days

                customer.setBalance(customer.getBalance() + monthlyInterest);

                Transaction interestTx = new Transaction(
                        TransactionType.INTEREST,
                        BigDecimal.valueOf(monthlyInterest),
                        "Monthly interest credit",
                        customer,
                        customer.getAccountNumber()
                );
                em.persist(interestTx);
                em.merge(customer);
            }
        }
    }

    private void generateMonthlyStatements() {
        // Implementation for generating monthly statements
        // This would typically create PDF statements and store them
    }


    private void updateDailyBalances() {
        // Update daily balance snapshots for reporting
    }

    private double calculateInterest(double principal, double annualRate, int days) {
        return principal * (annualRate / 365) * days;
    }
}