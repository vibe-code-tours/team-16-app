package com.nerdquiz.exception;

public class ExamQuestionSequenceMismatchException extends RuntimeException {
    public ExamQuestionSequenceMismatchException() {
        super("Sequence number does not match the issued exam question");
    }
}
