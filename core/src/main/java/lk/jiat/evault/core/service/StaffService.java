package lk.jiat.evault.core.service;

import lk.jiat.evault.core.model.Staff;

public interface StaffService {

    Staff getStaffById(int id);
    Staff getStaffByEmail(String email);

    void addStaff(Staff staff);
    void updateStaff(Staff staff);
    void deleteStaff(int id);
    boolean validateStaff(String email, String password);
}
