package com.nerdquiz.exception;

public class LessonNotFoundException extends RuntimeException {

    public LessonNotFoundException(String message) {
        super(message);
    }

    public LessonNotFoundException() {
        super("Lesson not found");
    }
}
