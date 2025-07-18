package lk.jiat.evault.core.model;

import jakarta.persistence.*;
import lk.jiat.evault.core.exception.InsufficientBalanceException;

import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(name = "customers")

@NamedQueries({
        @NamedQuery(
                name = "Customer.findByEmail", query = "select c from Customer c where c.email=:email"
        ),
        @NamedQuery(
                name = "Customer.findByEmailAndPassword", query = "select c from Customer c where" +
                " c.email=:email and c.password=:password"
        )
})

public class Customer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    private long id;
    private String firstName;
    private String lastName;
    private Date birthDate;
    private Date accountOpeningDate;
    private String gender;
    @Column(unique = true)
    private String email;
    private String password;
    private String contact;
    private String address;
    private String city;
    private String state;
    @Enumerated(EnumType.STRING)
    private UserType userType;

    private String accountType;
    @Column(unique = true, length = 10)
    private String accountNumber;
    @Column(nullable = false, columnDefinition = "DECIMAL(15,2) DEFAULT 0.00")
    private Double balance;
    @Column(nullable = false, columnDefinition = "DECIMAL(15,2) DEFAULT 0.00")
    private Double fixedBalance;
    private String idType;
    private String idNumber;

    public void deductBalance(BigDecimal amount) throws InsufficientBalanceException {
        BigDecimal currentBalance = BigDecimal.valueOf(this.balance);
        if (currentBalance.compareTo(amount) < 0) {
            throw new InsufficientBalanceException("Insufficient balance");
        }
        this.balance = currentBalance.subtract(amount).doubleValue();
    }

    public void addBalance(BigDecimal amount) {
        BigDecimal currentBalance = BigDecimal.valueOf(this.balance);
        this.balance = currentBalance.add(amount).doubleValue();
    }


    public Customer(String firstName, String lastName, Date birthDate, String gender,
                    String email, String password, String contact, String address,
                    String city, String state, String accountType, String idType,
                    String idNumber, String accountNumber, Double balance) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.birthDate = birthDate;
        this.gender = gender;
        this.email = email;
        this.password = password;
        this.contact = contact;
        this.address = address;
        this.city = city;
        this.state = state;
        this.accountType = accountType;
        this.idType = idType;
        this.idNumber = idNumber;
        this.accountNumber = accountNumber;
        this.balance = balance;
        this.fixedBalance = 0.0;
        this.accountOpeningDate = new Date(); // Set current date
        this.userType = UserType.CUSTOMER; // Assuming you have this enum
    }

    public Customer() {

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

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public Date getAccountOpeningDate() {
        return accountOpeningDate;
    }

    public void setAccountOpeningDate(Date accountOpeningDate) {
        this.accountOpeningDate = accountOpeningDate;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public UserType getUserType() {
        return userType;
    }

    public void setUserType(UserType userType) {
        this.userType = userType;
    }

    public String getAccountType() {
        return accountType;
    }

    public void setAccountType(String accountType) {
        this.accountType = accountType;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public Double getBalance() {
        return balance;
    }

    public void setBalance(Double balance) {
        this.balance = balance;
    }

    public Double getFixedBalance() {
        return fixedBalance;
    }

    public void setFixedBalance(Double fixedBalance) {
        this.fixedBalance = fixedBalance;
    }


    public String getIdType() {
        return idType;
    }

    public void setIdType(String idType) {
        this.idType = idType;
    }

    public String getIdNumber() {
        return idNumber;
    }

    public void setIdNumber(String idNumber) {
        this.idNumber = idNumber;
    }


}
