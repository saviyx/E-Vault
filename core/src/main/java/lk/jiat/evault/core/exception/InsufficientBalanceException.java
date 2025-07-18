package lk.jiat.evault.core.exception;

public class InsufficientBalanceException extends Exception {

  public InsufficientBalanceException() {
    super("Insufficient balance for this transaction");
  }

  public InsufficientBalanceException(String message) {
    super(message);
  }

  public InsufficientBalanceException(String message, Throwable cause) {
    super(message, cause);
  }
}