package com.nerdquiz.controller;

import com.nerdquiz.dto.LessonProgressResponse;
import com.nerdquiz.service.LessonProgressService;
import com.nerdquiz.util.UuidUtil;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;
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
        Optional<UUID> userId = UuidUtil.tryParse(authentication.getName());
        if (userId.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.ok(lessonProgressService.getProgress(userId.get(), lessonId));
    }

    @PostMapping("/complete")
    public ResponseEntity<LessonProgressResponse> markComplete(
            Authentication authentication,
            @PathVariable UUID lessonId) {
        Optional<UUID> userId = UuidUtil.tryParse(authentication.getName());
        if (userId.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.ok(lessonProgressService.markComplete(userId.get(), lessonId));
    }
}
