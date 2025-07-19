package lk.jiat.evault.core.model;

import jakarta.persistence.*;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "transactions")
public class Transaction implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    private TransactionType type;

    private BigDecimal amount;
    private String description;

    @Enumerated(EnumType.STRING)
    private TransactionStatus status;

    private String recipientAccount;
    private String recipientName;
    private String recipientBank;

    @Column(name = "transaction_date")
    private LocalDateTime transactionDate;

    @ManyToOne
    @JoinColumn(name = "customer_id")
    private Customer customer;

    // Constructors
    public Transaction() {
        this.transactionDate = LocalDateTime.now();
        this.status = TransactionStatus.PENDING;
    }

    public Transaction(TransactionType type, BigDecimal amount, String description,
                       Customer customer, String recipientAccount) {
        this();
        this.type = type;
        this.amount = amount;
        this.description = description;
        this.customer = customer;
        this.recipientAccount = recipientAccount;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public TransactionType getType() { return type; }
    public void setType(TransactionType type) { this.type = type; }
    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public TransactionStatus getStatus() { return status; }
    public void setStatus(TransactionStatus status) { this.status = status; }
    public String getRecipientAccount() { return recipientAccount; }
    public void setRecipientAccount(String recipientAccount) { this.recipientAccount = recipientAccount; }
    public String getRecipientName() { return recipientName; }
    public void setRecipientName(String recipientName) { this.recipientName = recipientName; }
    public String getRecipientBank() { return recipientBank; }
    public void setRecipientBank(String recipientBank) { this.recipientBank = recipientBank; }
    public LocalDateTime getTransactionDate() { return transactionDate; }
    public void setTransactionDate(LocalDateTime transactionDate) { this.transactionDate = transactionDate; }
    public Customer getCustomer() { return customer; }
    public void setCustomer(Customer customer) { this.customer = customer; }
}