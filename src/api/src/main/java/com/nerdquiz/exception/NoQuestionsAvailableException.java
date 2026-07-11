package com.nerdquiz.exception;

public class NoQuestionsAvailableException extends RuntimeException {

    public NoQuestionsAvailableException(String message) {
        super(message);
    }

    public NoQuestionsAvailableException() {
        super("No questions available");
    }
}
