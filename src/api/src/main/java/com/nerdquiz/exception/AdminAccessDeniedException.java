package com.nerdquiz.exception;

public class AdminAccessDeniedException extends RuntimeException {

    public AdminAccessDeniedException() {
        super("Admin access required");
    }
}
