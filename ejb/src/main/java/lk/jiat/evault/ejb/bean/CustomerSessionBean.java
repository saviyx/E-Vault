package lk.jiat.evault.ejb.bean;

import jakarta.ejb.*;
import jakarta.persistence.EntityManager;
import jakarta.persistence.LockModeType;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import lk.jiat.evault.core.exception.InsufficientBalanceException;
import lk.jiat.evault.core.model.Customer;
import lk.jiat.evault.core.service.CustomerService;
import java.math.BigDecimal;

@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)
public class CustomerSessionBean implements CustomerService {

    @PersistenceContext
    private EntityManager em;

    @Override
    public Customer getCustomerById(Long id) {
        return em.find(Customer.class, id);
    }

    @Override
    public Customer getCustomerByEmail(String email) {
        try {
            return em.createNamedQuery("Customer.findByEmail", Customer.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void addCustomer(Customer customer) {
        em.persist(customer);
        em.flush();
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void updateCustomer(Customer customer) {
        em.merge(customer);
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void deleteCustomer(Long id) {
        Customer customer = em.find(Customer.class, id);
        if (customer != null) {
            em.remove(customer);
        }
    }

    @Override
    public boolean validate(String email, String password) {
        try {
            Customer customer = em.createNamedQuery("Customer.findByEmailAndPassword", Customer.class)
                    .setParameter("email", email)
                    .setParameter("password", password)
                    .getSingleResult();
            return customer != null;
        } catch (NoResultException e) {
            return false;
        }
    }

    @Override
    public boolean doesAccountNumberExist(String accountNumber) {
        Long count = em.createQuery(
                        "SELECT COUNT(c) FROM Customer c WHERE c.accountNumber = :accountNumber", Long.class)
                .setParameter("accountNumber", accountNumber)
                .getSingleResult();
        return count > 0;
    }

    @Override
    public Customer getCustomerByAccountNumber(String accountNumber) {
        try {
            return em.createQuery(
                            "SELECT c FROM Customer c WHERE c.accountNumber = :accountNumber", Customer.class)
                    .setParameter("accountNumber", accountNumber)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public Customer updateCustomerBalance(Long customerId, BigDecimal amount) throws InsufficientBalanceException {
        Customer customer = getCustomerWithLock(customerId);
        if (customer == null) {
            throw new IllegalArgumentException("Customer not found");
        }

        BigDecimal currentBalance = BigDecimal.valueOf(customer.getBalance());
        BigDecimal newBalance = currentBalance.add(amount);

        if (newBalance.compareTo(BigDecimal.ZERO) < 0) {
            throw new InsufficientBalanceException("Insufficient balance for this operation");
        }

        customer.setBalance(newBalance.doubleValue());
        em.merge(customer);
        return customer;
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public Customer getCustomerWithLock(Long customerId) {
        return em.find(Customer.class, customerId, LockModeType.PESSIMISTIC_WRITE);
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public boolean transferBalance(Long fromCustomerId, Long toCustomerId, BigDecimal amount)
            throws InsufficientBalanceException {
        Customer fromCustomer = getCustomerWithLock(fromCustomerId);
        Customer toCustomer = getCustomerWithLock(toCustomerId);

        if (fromCustomer == null || toCustomer == null) {
            return false;
        }

        // Deduct from source
        BigDecimal fromBalance = BigDecimal.valueOf(fromCustomer.getBalance());
        if (fromBalance.compareTo(amount) < 0) {
            throw new InsufficientBalanceException("Insufficient balance");
        }
        fromCustomer.setBalance(fromBalance.subtract(amount).doubleValue());

        // Add to destination
        BigDecimal toBalance = BigDecimal.valueOf(toCustomer.getBalance());
        toCustomer.setBalance(toBalance.add(amount).doubleValue());

        em.merge(fromCustomer);
        em.merge(toCustomer);

        return true;
    }
}