package lk.jiat.evault.core.exception;

import jakarta.ejb.ApplicationException;

@ApplicationException(rollback = true)
public class InvalidParameterException extends RuntimeException {
    public InvalidParameterException(String message) {
        super(message);
    }
}
