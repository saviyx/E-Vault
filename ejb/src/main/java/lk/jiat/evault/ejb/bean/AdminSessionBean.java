package lk.jiat.evault.ejb.bean;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import lk.jiat.evault.core.model.Admin;
import lk.jiat.evault.core.service.AdminService;

@Stateless
public class AdminSessionBean implements AdminService {

   @PersistenceContext
   private EntityManager em;

    @Override
    public Admin getAdminById(int id) {
        return em.find(Admin.class, id);
    }

    @Override
    public Admin getAdminByEmail(String email) {
        try {
            return em.createQuery("SELECT a FROM Admin a WHERE a.email = :email", Admin.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }


    @Override
    public boolean validateAdmin(String email, String password) {
        try {
            em.createQuery("SELECT a FROM Admin a WHERE a.email = :email AND a.password = :password", Admin.class)
                    .setParameter("email", email)
                    .setParameter("password", password)
                    .getSingleResult();
            return true;
        } catch (NoResultException e) {
            return false;
        }
    }

}
