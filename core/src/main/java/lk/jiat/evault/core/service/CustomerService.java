package lk.jiat.evault.core.service;

import jakarta.ejb.Remote;
import lk.jiat.evault.core.model.Customer;

@Remote
public interface CustomerService {
    Customer getCustomerById(Long id);
    Customer getCustomerByEmail(String email);

    void addCustomer(Customer customer);
    void updateCustomer(Customer customer);
    void deleteCustomer(Long id);
    boolean validate(String email, String password);
}
