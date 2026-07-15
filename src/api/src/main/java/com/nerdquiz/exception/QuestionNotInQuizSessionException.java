package com.nerdquiz.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.BAD_REQUEST)
public class QuestionNotInQuizSessionException extends RuntimeException {
    public QuestionNotInQuizSessionException() {
        super("Question does not belong to this quiz session");
    }
}
