package lk.jiat.evault.core.service;

import jakarta.ejb.Remote;
import lk.jiat.evault.core.exception.InvalidParameterException;
import lk.jiat.evault.core.model.Transaction;

import java.math.BigDecimal;
import java.util.List;

@Remote
public interface TransactionService {
    boolean processInternalTransfer(Long customerId, String toAccount,
                                    BigDecimal amount, String description)
            throws InvalidParameterException;

    boolean processExternalTransfer(Long customerId, String recipientName,
                                    String recipientAccount, String recipientBank,
                                    BigDecimal amount, String description)
            throws InvalidParameterException;

    boolean deposit(Long customerId, BigDecimal amount, String description)
            throws InvalidParameterException;

    boolean withdraw(Long customerId, BigDecimal amount, String description)
            throws InvalidParameterException;


    List<Transaction> getTransactionsByCustomerId(Long customerId);


}