package com.nerdquiz.exception;

public class ExamSessionNotFoundException extends RuntimeException {
    public ExamSessionNotFoundException() {
        super("Exam session not found");
    }
}
