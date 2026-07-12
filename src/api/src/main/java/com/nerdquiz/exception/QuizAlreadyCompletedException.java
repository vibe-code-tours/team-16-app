package com.nerdquiz.exception;

public class QuizAlreadyCompletedException extends RuntimeException {

    public QuizAlreadyCompletedException(String message) {
        super(message);
    }

    public QuizAlreadyCompletedException() {
        super("Quiz already completed");
    }
}
