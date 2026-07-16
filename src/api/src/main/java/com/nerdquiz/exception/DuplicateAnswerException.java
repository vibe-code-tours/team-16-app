package com.nerdquiz.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.CONFLICT)
public class DuplicateAnswerException extends RuntimeException {
    public DuplicateAnswerException() {
        super("This question has already been answered in this quiz session");
    }
}
