package com.nerdquiz.exception;

public class UserProfileNotFoundException extends RuntimeException {
    public UserProfileNotFoundException() {
        super("User profile not found");
    }
}
