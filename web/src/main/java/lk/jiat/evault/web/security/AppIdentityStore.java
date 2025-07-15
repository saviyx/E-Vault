package lk.jiat.evault.web.security;

import jakarta.ejb.EJB;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.security.enterprise.credential.Credential;
import jakarta.security.enterprise.credential.UsernamePasswordCredential;
import jakarta.security.enterprise.identitystore.CredentialValidationResult;
import jakarta.security.enterprise.identitystore.IdentityStore;
import lk.jiat.evault.core.model.Admin;
import lk.jiat.evault.core.model.Customer;
import lk.jiat.evault.core.model.Staff;
import lk.jiat.evault.core.service.AdminService;
import lk.jiat.evault.core.service.CustomerService;
import lk.jiat.evault.core.service.StaffService;

import java.util.Set;

@ApplicationScoped
public class AppIdentityStore implements IdentityStore {

    @EJB
    private CustomerService customerService;
    @EJB
    private AdminService adminService;
    @EJB
    private StaffService staffService;

    @Override
    public CredentialValidationResult validate(Credential credential) {
        if (credential instanceof UsernamePasswordCredential) {
            UsernamePasswordCredential upc = (UsernamePasswordCredential) credential;
            String email = upc.getCaller();
            String password = upc.getPasswordAsString();

            System.out.println("[DEBUG] Login attempt: " + email + " / " + password);

            try {
                if (adminService.validateAdmin(email, password)) {
                    Admin admin = adminService.getAdminByEmail(email);
                    return new CredentialValidationResult(admin.getEmail(), Set.of(admin.getUserType().name()));
                }
            } catch (Exception e) {
                System.out.println("[ERROR] Admin validation failed: " + e.getMessage());
                e.printStackTrace();
            }

            try {
                if (staffService.validateStaff(email, password)) {
                    Staff staff = staffService.getStaffByEmail(email);
                    return new CredentialValidationResult(staff.getEmail(), Set.of(staff.getUserType().name()));
                }
            } catch (Exception e) {
                System.out.println("[ERROR] Staff validation failed: " + e.getMessage());
                e.printStackTrace();
            }

            try {
                if (customerService.validate(email, password)) {
                    Customer customer = customerService.getCustomerByEmail(email);
                    return new CredentialValidationResult(customer.getEmail(), Set.of(customer.getUserType().name()));
                }
            } catch (Exception e) {
                System.out.println("[ERROR] Customer validation failed: " + e.getMessage());
                e.printStackTrace();
            }
        }

        return CredentialValidationResult.INVALID_RESULT;
    }





}
