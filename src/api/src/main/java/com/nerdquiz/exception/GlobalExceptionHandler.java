package com.nerdquiz.exception;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.HashMap;
import java.util.Map;

@RestControllerAdvice
public class GlobalExceptionHandler {

    private static final Logger log = LoggerFactory.getLogger(GlobalExceptionHandler.class);

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

    @ExceptionHandler(ExamSessionNotFoundException.class)
    public ResponseEntity<Map<String, Object>> handleExamSessionNotFound(ExamSessionNotFoundException ex) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of(
            "type", "https://nerdquiz.com/errors/not-found",
            "title", "Exam Session Not Found",
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

    @ExceptionHandler(LessonNotFoundException.class)
    public ResponseEntity<Map<String, Object>> handleLessonNotFound(LessonNotFoundException ex) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of(
            "type", "https://nerdquiz.com/errors/not-found",
            "title", "Lesson Not Found",
            "status", 404,
            "detail", ex.getMessage()
        ));
    }

    @ExceptionHandler(MistakeNotFoundException.class)
    public ResponseEntity<Map<String, Object>> handleMistakeNotFound(MistakeNotFoundException ex) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of(
            "type", "https://nerdquiz.com/errors/not-found",
            "title", "Mistake Not Found",
            "status", 404,
            "detail", ex.getMessage()
        ));
    }

    @ExceptionHandler(UserProfileNotFoundException.class)
    public ResponseEntity<Map<String, Object>> handleUserProfileNotFound(UserProfileNotFoundException ex) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of(
            "type", "https://nerdquiz.com/errors/not-found",
            "title", "User Profile Not Found",
            "status", 404,
            "detail", ex.getMessage()
        ));
    }

    @ExceptionHandler(AdminAccessDeniedException.class)
    public ResponseEntity<Map<String, Object>> handleAdminAccessDenied(AdminAccessDeniedException ex) {
        return ResponseEntity.status(HttpStatus.FORBIDDEN).body(Map.of(
            "type", "https://nerdquiz.com/errors/forbidden",
            "title", "Admin Access Required",
            "status", 403,
            "detail", ex.getMessage()
        ));
    }

    @ExceptionHandler(DuplicateAnswerException.class)
    public ResponseEntity<Map<String, Object>> handleDuplicateAnswer(DuplicateAnswerException ex) {
        return ResponseEntity.status(HttpStatus.CONFLICT).body(Map.of(
            "type", "https://nerdquiz.com/errors/conflict",
            "title", "Duplicate Answer",
            "status", 409,
            "detail", ex.getMessage()
        ));
    }

    @ExceptionHandler(QuestionNotInQuizSessionException.class)
    public ResponseEntity<Map<String, Object>> handleQuestionNotInQuizSession(QuestionNotInQuizSessionException ex) {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of(
            "type", "https://nerdquiz.com/errors/bad-request",
            "title", "Question Not In Quiz Session",
            "status", 400,
            "detail", ex.getMessage()
        ));
    }

    @ExceptionHandler(RuntimeException.class)
    public ResponseEntity<Map<String, Object>> handleRuntimeException(RuntimeException ex) {
        log.error("Unhandled exception: {}", ex.getMessage(), ex);
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of(
            "type", "https://nerdquiz.com/errors/internal",
            "title", "Internal Server Error",
            "status", 500,
            "detail", "An unexpected error occurred"
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
