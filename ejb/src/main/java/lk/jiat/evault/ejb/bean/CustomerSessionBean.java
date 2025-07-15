package lk.jiat.evault.ejb.bean;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.jiat.evault.core.model.Customer;
import lk.jiat.evault.core.service.CustomerService;

import java.util.List;

@Stateless
public class CustomerSessionBean implements CustomerService {

    @PersistenceContext
    private EntityManager em;


    @Override
    public Customer getCustomerById(Long id) {
        return em.find(Customer.class, id);
    }

    @Override
    public Customer getCustomerByEmail(String email) {
        return em.createNamedQuery("Customer.findByEmail", Customer.class)
                .setParameter("email", email).getSingleResult();
    }

    @Override
    public void addCustomer(Customer customer) {
        em.persist(customer);
    }

    @Override
    public void updateCustomer(Customer customer) {
        em.merge(customer);
    }

    @Override
    public void deleteCustomer(Long id) {
        em.remove(em.find(Customer.class, id));
    }

    @Override
    public boolean validate(String email, String password) {
        try {
            List<Customer> customers = em.createQuery(
                            "SELECT c FROM Customer c WHERE c.email = :email AND c.password = :password", Customer.class)
                    .setParameter("email", email)
                    .setParameter("password", password)
                    .getResultList();

            return !customers.isEmpty();
        } catch (Exception e) {
            System.out.println("[ERROR] validate() failed: " + e.getMessage());
            return false;
        }
    }


}
