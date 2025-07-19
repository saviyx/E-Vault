package lk.jiat.evault.core.model;

public enum TransactionType {
    INTERNAL, // Transfer between own accounts
    EXTERNAL, // Transfer to another person
    DEPOSIT,
    WITHDRAWAL,
    INTEREST
}