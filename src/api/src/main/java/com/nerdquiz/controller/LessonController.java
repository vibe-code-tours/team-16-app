package com.nerdquiz.controller;

import com.nerdquiz.dto.LessonResponse;
import com.nerdquiz.dto.QuestionResponse;
import com.nerdquiz.service.LessonService;
import com.nerdquiz.service.QuestionService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1")
public class LessonController {

    private final LessonService lessonService;
    private final QuestionService questionService;

    public LessonController(LessonService lessonService, QuestionService questionService) {
        this.lessonService = lessonService;
        this.questionService = questionService;
    }

    @GetMapping("/subtopics/{subtopicId}/lessons")
    public ResponseEntity<List<LessonResponse>> getLessons(
            @PathVariable UUID subtopicId,
            Authentication authentication) {
        UUID userId = authentication == null ? null : UUID.fromString(authentication.getName());
        return ResponseEntity.ok(lessonService.getLessonsForSubtopic(subtopicId, userId));
    }

    @PostMapping("/lessons/{lessonId}/complete")
    public ResponseEntity<Void> completeLesson(
            @PathVariable UUID lessonId,
            Authentication authentication) {
        if (authentication == null) return ResponseEntity.status(401).build();
        UUID userId = UUID.fromString(authentication.getName());
        lessonService.completeLesson(lessonId, userId);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/subtopics/{subtopicId}/quiz")
    public ResponseEntity<List<QuestionResponse>> getQuiz(
            @PathVariable UUID subtopicId,
            @RequestParam(defaultValue = "5") int count) {
        return ResponseEntity.ok(questionService.getUsableQuizForSubtopic(subtopicId, count));
    }
}
