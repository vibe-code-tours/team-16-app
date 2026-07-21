package com.nerdquiz.controller;

import com.nerdquiz.dto.FinishExamRequest;
import com.nerdquiz.dto.FinishExamResponse;
import com.nerdquiz.dto.StartExamRequest;
import com.nerdquiz.dto.StartExamResponse;
import com.nerdquiz.dto.SubmitExamAnswerRequest;
import com.nerdquiz.dto.SubmitExamAnswerResponse;
import com.nerdquiz.service.ExamService;
import com.nerdquiz.util.UuidUtil;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/exams")
public class ExamController {

    private final ExamService examService;

    public ExamController(ExamService examService) {
        this.examService = examService;
    }

    @PostMapping("/start")
    public ResponseEntity<StartExamResponse> startExam(
            Authentication authentication,
            @Valid @RequestBody StartExamRequest request) {
        Optional<UUID> userId = UuidUtil.tryParse(authentication.getName());
        if (userId.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.ok(examService.startExam(userId.get(), request));
    }

    @PostMapping("/{sessionId}/answers")
    public ResponseEntity<SubmitExamAnswerResponse> submitAnswer(
            Authentication authentication,
            @PathVariable UUID sessionId,
            @Valid @RequestBody SubmitExamAnswerRequest request) {
        Optional<UUID> userId = UuidUtil.tryParse(authentication.getName());
        if (userId.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.ok(examService.submitAnswer(userId.get(), sessionId, request));
    }

    @PostMapping("/{sessionId}/finish")
    public ResponseEntity<FinishExamResponse> finishExam(
            Authentication authentication,
            @PathVariable UUID sessionId,
            @Valid @RequestBody FinishExamRequest request) {
        Optional<UUID> userId = UuidUtil.tryParse(authentication.getName());
        if (userId.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.ok(examService.finishExam(userId.get(), sessionId, request));
    }
}
