package com.nerdquiz.controller;

import com.nerdquiz.dto.LessonResponse;
import com.nerdquiz.service.LessonService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/lessons")
public class LessonController {

    private final LessonService lessonService;

    public LessonController(LessonService lessonService) {
        this.lessonService = lessonService;
    }

    @GetMapping
    public ResponseEntity<List<LessonResponse>> getLessons(
            @RequestParam UUID subtopicId) {
        return ResponseEntity.ok(lessonService.getLessonsBySubtopic(subtopicId));
    }

    @GetMapping("/{id}")
    public ResponseEntity<LessonResponse> getLesson(@PathVariable UUID id) {
        return ResponseEntity.ok(lessonService.getLessonById(id));
    }
}
