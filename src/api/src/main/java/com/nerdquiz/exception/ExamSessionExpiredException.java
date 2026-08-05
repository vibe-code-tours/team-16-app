package com.nerdquiz.exception;

public class ExamSessionExpiredException extends RuntimeException {
    public ExamSessionExpiredException() {
        super("Exam session has expired");
    }
}
