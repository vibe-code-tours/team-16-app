package com.nerdquiz.exception;

public class QuizSessionNotFoundException extends RuntimeException {

    public QuizSessionNotFoundException(String message) {
        super(message);
    }

    public QuizSessionNotFoundException() {
        super("Quiz session not found");
    }
}
