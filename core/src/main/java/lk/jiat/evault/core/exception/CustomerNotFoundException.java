package lk.jiat.evault.core.exception;

public class CustomerNotFoundException extends Exception {

    // Constructor with a custom message
    public CustomerNotFoundException(String message) {
        super(message);
    }

    // Constructor with a custom message and cause
    public CustomerNotFoundException(String message, Throwable cause) {
        super(message, cause);
    }

    // Constructor with just a cause
    public CustomerNotFoundException(Throwable cause) {
        super(cause);
    }
}