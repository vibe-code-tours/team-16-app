package com.nerdquiz.controller;

import com.nerdquiz.dto.LessonProgressResponse;
import com.nerdquiz.service.LessonProgressService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api/v1/me/lessons/{lessonId}/progress")
public class LessonProgressController {

    private final LessonProgressService lessonProgressService;

    public LessonProgressController(LessonProgressService lessonProgressService) {
        this.lessonProgressService = lessonProgressService;
    }

    @GetMapping
    public ResponseEntity<LessonProgressResponse> getProgress(
            Authentication authentication,
            @PathVariable UUID lessonId) {
        UUID userId = UUID.fromString(authentication.getName());
        return ResponseEntity.ok(lessonProgressService.getProgress(userId, lessonId));
    }

    @PostMapping("/complete")
    public ResponseEntity<LessonProgressResponse> markComplete(
            Authentication authentication,
            @PathVariable UUID lessonId) {
        UUID userId = UUID.fromString(authentication.getName());
        return ResponseEntity.ok(lessonProgressService.markComplete(userId, lessonId));
    }
}
