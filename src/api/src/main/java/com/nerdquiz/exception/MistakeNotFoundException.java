package com.nerdquiz.exception;

public class MistakeNotFoundException extends RuntimeException {

    public MistakeNotFoundException(String message) {
        super(message);
    }

    public MistakeNotFoundException() {
        super("Mistake not found");
    }
}
