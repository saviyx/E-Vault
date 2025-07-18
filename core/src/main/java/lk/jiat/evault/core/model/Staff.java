package lk.jiat.evault.core.model;


import jakarta.persistence.*;

@Entity
@Table(name = "staff")

@NamedQueries({
        @NamedQuery(
                name = "Staff.findByEmail", query = "select s from Staff s where s.email=:email"
        ),
        @NamedQuery(
                name = "Staff.findByEmailAndPassword", query = "select s from Staff s where" +
                " s.email=:email and s.password=:password"
        )
})

public class Staff {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    private long id;
    private String firstName;
    private String lastName;
    @Column(unique = true)
    private String email;
    private String contact;
    private String password;
    private String role;
    @Enumerated(EnumType.STRING)
    private UserType userType = UserType.STAFF;
    @Enumerated(EnumType.STRING)
    private Status status = Status.ACTIVE;


    public Staff(String firstName, String lastName, String email, String phone, String encryptedPassword, String role) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.contact = phone;  // Note: mapping phone parameter to contact field
        this.password = encryptedPassword;
        this.role = role;
        this.userType = UserType.STAFF;  // Set default values
        this.status = Status.ACTIVE;     // Set default values
    }

    public Staff(String firstName, String lastName, String email, String contact, String role, String password, UserType userType, Status status) {

        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.contact = contact;
        this.role = role;
        this.password = password;
        this.userType = userType;
        this.status = status;
    }

    public Staff() {

    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public UserType getUserType() {
        return userType;
    }

    public void setUserType(UserType userType) {
        this.userType = userType;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }
}
