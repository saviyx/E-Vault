package lk.jiat.evault.core.service;

import jakarta.ejb.Remote;
import lk.jiat.evault.core.exception.InsufficientBalanceException;
import lk.jiat.evault.core.model.Customer;

import java.math.BigDecimal;
import java.util.List;

@Remote
public interface CustomerService {
    Customer getCustomerById(Long id);
    Customer getCustomerByEmail(String email);
    Customer getCustomerByAccountNumber(String accountNumber);

    // Add these new methods
    Customer updateCustomerBalance(Long customerId, BigDecimal amount) throws InsufficientBalanceException;
    Customer getCustomerWithLock(Long customerId);
    boolean transferBalance(Long fromCustomerId, Long toCustomerId, BigDecimal amount) throws InsufficientBalanceException;

    void addCustomer(Customer customer);
    void updateCustomer(Customer customer);
    void deleteCustomer(Long id);
    boolean validate(String email, String password);
    boolean doesAccountNumberExist(String accountNumber);
    List<Customer> getAllCustomers();
}
