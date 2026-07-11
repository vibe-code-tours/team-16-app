package com.nerdquiz.exception;

public class UnauthorizedQuizAccessException extends RuntimeException {

    public UnauthorizedQuizAccessException(String message) {
        super(message);
    }

    public UnauthorizedQuizAccessException() {
        super("Unauthorized access to quiz session");
    }
}
