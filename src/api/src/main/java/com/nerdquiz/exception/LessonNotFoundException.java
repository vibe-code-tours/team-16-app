package com.nerdquiz.exception;

public class LessonNotFoundException extends RuntimeException {
    public LessonNotFoundException() {
        super("Lesson not found");
    }
}
