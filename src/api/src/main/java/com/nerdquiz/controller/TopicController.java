package com.nerdquiz.controller;

import com.nerdquiz.dto.TopicResponse;
import com.nerdquiz.service.TopicService;
import com.nerdquiz.util.UuidUtil;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/topics")
public class TopicController {

    private final TopicService topicService;

    public TopicController(TopicService topicService) {
        this.topicService = topicService;
    }

    @GetMapping
    public ResponseEntity<List<TopicResponse>> getLearningMap(Authentication authentication) {
        Optional<UUID> userId = UuidUtil.tryParse(authentication == null ? null : authentication.getName());
        return ResponseEntity.ok(topicService.getLearningMap(userId.orElse(null)));
    }
}
