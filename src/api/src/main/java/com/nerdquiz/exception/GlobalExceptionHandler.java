package com.nerdquiz.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.Instant;
import java.util.HashMap;
import java.util.Map;

import com.nerdquiz.exception.QuizSessionNotFoundException;
import com.nerdquiz.exception.NoQuestionsAvailableException;
import com.nerdquiz.exception.UnauthorizedQuizAccessException;
import com.nerdquiz.exception.QuizAlreadyCompletedException;
import com.nerdquiz.exception.QuestionNotFoundException;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Map<String, Object>> handleValidationExceptions(MethodArgumentNotValidException ex) {
        Map<String, String> errors = new HashMap<>();
        ex.getBindingResult().getAllErrors().forEach(error -> {
            String fieldName = ((FieldError) error).getField();
            String errorMessage = error.getDefaultMessage();
            errors.put(fieldName, errorMessage);
        });

        return ResponseEntity.badRequest().body(Map.of(
            "type", "https://nerdquiz.com/errors/validation",
            "title", "Validation Error",
            "status", 400,
            "detail", errors.toString(),
            "instance", "/api/v1",
            "errors", errors
        ));
    }

    @ExceptionHandler(QuizSessionNotFoundException.class)
    public ResponseEntity<Map<String, Object>> handleQuizSessionNotFound(QuizSessionNotFoundException ex) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of(
            "type", "https://nerdquiz.com/errors/not-found",
            "title", "Quiz Session Not Found",
            "status", 404,
            "detail", ex.getMessage()
        ));
    }

    @ExceptionHandler(NoQuestionsAvailableException.class)
    public ResponseEntity<Map<String, Object>> handleNoQuestionsAvailable(NoQuestionsAvailableException ex) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of(
            "type", "https://nerdquiz.com/errors/not-found",
            "title", "No Questions Available",
            "status", 404,
            "detail", ex.getMessage()
        ));
    }

    @ExceptionHandler(UnauthorizedQuizAccessException.class)
    public ResponseEntity<Map<String, Object>> handleUnauthorizedQuizAccess(UnauthorizedQuizAccessException ex) {
        return ResponseEntity.status(HttpStatus.FORBIDDEN).body(Map.of(
            "type", "https://nerdquiz.com/errors/forbidden",
            "title", "Unauthorized Access",
            "status", 403,
            "detail", ex.getMessage()
        ));
    }

    @ExceptionHandler(QuizAlreadyCompletedException.class)
    public ResponseEntity<Map<String, Object>> handleQuizAlreadyCompleted(QuizAlreadyCompletedException ex) {
        return ResponseEntity.status(HttpStatus.CONFLICT).body(Map.of(
            "type", "https://nerdquiz.com/errors/conflict",
            "title", "Quiz Already Completed",
            "status", 409,
            "detail", ex.getMessage()
        ));
    }

    @ExceptionHandler(QuestionNotFoundException.class)
    public ResponseEntity<Map<String, Object>> handleQuestionNotFound(QuestionNotFoundException ex) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of(
            "type", "https://nerdquiz.com/errors/not-found",
            "title", "Question Not Found",
            "status", 404,
            "detail", ex.getMessage()
        ));
    }

    @ExceptionHandler(RuntimeException.class)
    public ResponseEntity<Map<String, Object>> handleRuntimeException(RuntimeException ex) {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of(
            "type", "https://nerdquiz.com/errors/internal",
            "title", "Internal Server Error",
            "status", 500,
            "detail", ex.getMessage() != null ? ex.getMessage() : "An unexpected error occurred"
        ));
    }

    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<Map<String, Object>> handleIllegalArgumentException(IllegalArgumentException ex) {
        return ResponseEntity.badRequest().body(Map.of(
            "type", "https://nerdquiz.com/errors/bad-request",
            "title", "Bad Request",
            "status", 400,
            "detail", ex.getMessage()
        ));
    }
}
