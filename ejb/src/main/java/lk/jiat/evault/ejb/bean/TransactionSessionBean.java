package lk.jiat.evault.ejb.bean;

import jakarta.ejb.*;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.jiat.evault.core.exception.InsufficientBalanceException;
import lk.jiat.evault.core.exception.InvalidParameterException;
import lk.jiat.evault.core.model.Customer;
import lk.jiat.evault.core.model.Transaction;
import lk.jiat.evault.core.model.TransactionStatus;
import lk.jiat.evault.core.model.TransactionType;
import lk.jiat.evault.core.service.CustomerService;

import java.math.BigDecimal;

@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)
public class TransactionSessionBean {

    @PersistenceContext
    private EntityManager em;

    @EJB
    private CustomerService customerService;

    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public boolean transferBetweenAccounts(Long customerId, String toAccount,
                                           BigDecimal amount, String description)
            throws InvalidParameterException, InsufficientBalanceException {

        validateParameters(customerId, amount);

        Customer source = customerService.getCustomerById(customerId);
        if (source == null) {
            throw new InvalidParameterException("Invalid customer");
        }

        BigDecimal sourceBalance = BigDecimal.valueOf(source.getBalance());

        if (sourceBalance.compareTo(amount) < 0) {
            throw new InsufficientBalanceException("Insufficient balance for this transaction");
        }

        BigDecimal newBalance = sourceBalance.subtract(amount);
        source.setBalance(newBalance.doubleValue());

        Transaction transaction = new Transaction(
                TransactionType.INTERNAL,
                amount,
                description,
                source,
                toAccount
        );
        transaction.setRecipientName("Internal (to fixed account)");
        transaction.setRecipientBank("Internal (to fixed account)");
        transaction.setStatus(TransactionStatus.COMPLETED);
        em.persist(transaction);

        em.merge(source);

        return true;
    }


    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public boolean transferToExternalAccount(Long customerId, String recipientName,
                                             String recipientAccount, String recipientBank,
                                             BigDecimal amount, String description)
            throws InvalidParameterException, InsufficientBalanceException {

        validateParameters(customerId, amount);

        Customer source = customerService.getCustomerById(customerId);
        if (source == null) {
            throw new InvalidParameterException("Invalid customer");
        }

        BigDecimal sourceBalance = BigDecimal.valueOf(source.getBalance());

        if (sourceBalance.compareTo(amount) < 0) {
            throw new InsufficientBalanceException("Insufficient balance for this transaction");
        }

        BigDecimal newBalance = sourceBalance.subtract(amount);
        source.setBalance(newBalance.doubleValue());

        Transaction transaction = new Transaction(
                TransactionType.EXTERNAL,
                amount,
                description,
                source,
                recipientAccount
        );
        transaction.setRecipientName(recipientName);
        transaction.setRecipientBank(recipientBank);
        transaction.setStatus(TransactionStatus.COMPLETED);
        em.persist(transaction);

        em.merge(source);

        return true;
    }

    private void validateParameters(Long customerId, BigDecimal amount)
            throws InvalidParameterException {
        if (customerId == null || customerId <= 0) {
            throw new InvalidParameterException("Invalid customer ID");
        }
        if (amount == null || amount.compareTo(BigDecimal.ZERO) <= 0) {
            throw new InvalidParameterException("Amount must be positive");
        }
    }



}