package com.nerdquiz.exception;

public class DuplicateExamAnswerException extends RuntimeException {
    public DuplicateExamAnswerException() {
        super("This exam question has already been answered");
    }
}
