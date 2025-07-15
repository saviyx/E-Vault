package lk.jiat.evault.core.service;

import lk.jiat.evault.core.model.Admin;

public interface AdminService {
    Admin getAdminById(int id);
    Admin getAdminByEmail(String email);

    boolean validateAdmin(String email, String password);
}
