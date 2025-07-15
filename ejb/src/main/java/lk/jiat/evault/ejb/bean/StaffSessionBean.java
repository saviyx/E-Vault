package lk.jiat.evault.ejb.bean;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import lk.jiat.evault.core.model.Staff;
import lk.jiat.evault.core.service.StaffService;

@Stateless
public class StaffSessionBean implements StaffService {

    @PersistenceContext
    private EntityManager em;

    @Override
    public Staff getStaffById(int id) {
        return em.find(Staff.class, id);
    }

    @Override
    public Staff getStaffByEmail(String email) {
        return em.createNamedQuery("Staff.findByEmail", Staff.class)
                .setParameter("email", email).getSingleResult();
    }

    @Override
    public void addStaff(Staff staff) {
        em.persist(staff);
    }

    @Override
    public void updateStaff(Staff staff) {
        em.merge(staff);
    }

    @Override
    public void deleteStaff(int id) {
        Staff staff = em.find(Staff.class, id);
        if (staff != null) {
            em.remove(staff);
        }
    }

    @Override
    public boolean validateStaff(String email, String password) {
        try {
            em.createQuery("SELECT s FROM Staff s WHERE s.email = :email AND s.password = :password", Staff.class)
                    .setParameter("email", email)
                    .setParameter("password", password)
                    .getSingleResult();
            return true;
        } catch (NoResultException e) {
            return false;
        }
    }


}
