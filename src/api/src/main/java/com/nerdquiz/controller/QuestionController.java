package com.nerdquiz.controller;

import com.nerdquiz.dto.QuestionResponse;
import com.nerdquiz.service.QuestionService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/questions")
public class QuestionController {

    private final QuestionService questionService;

    public QuestionController(QuestionService questionService) {
        this.questionService = questionService;
    }

    @GetMapping("/random")
    public ResponseEntity<List<QuestionResponse>> getRandomQuestions(
            @RequestParam(defaultValue = "5") int count) {
        return ResponseEntity.ok(questionService.getRandomQuestions(count));
    }

    @GetMapping("/session/{examSession}")
    public ResponseEntity<List<QuestionResponse>> getByExamSession(
            @PathVariable String examSession,
            @RequestParam(defaultValue = "A") String subject) {
        return ResponseEntity.ok(questionService.getByExamSession(examSession, subject));
    }

    @GetMapping("/stats")
    public ResponseEntity<Map<String, Long>> getStats(
            @RequestParam String examSession,
            @RequestParam(defaultValue = "A") String subject) {
        long count = questionService.countByExamSession(examSession, subject);
        return ResponseEntity.ok(Map.of("total", count));
    }
}
