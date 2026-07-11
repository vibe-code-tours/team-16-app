package com.nerdquiz.exception;

public class QuestionNotFoundException extends RuntimeException {

    public QuestionNotFoundException(String message) {
        super(message);
    }

    public QuestionNotFoundException() {
        super("Question not found");
    }
}
