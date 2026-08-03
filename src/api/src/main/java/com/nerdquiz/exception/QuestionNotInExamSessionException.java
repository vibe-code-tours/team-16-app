package com.nerdquiz.exception;

public class QuestionNotInExamSessionException extends RuntimeException {
    public QuestionNotInExamSessionException() {
        super("Question does not belong to this exam session");
    }
}
