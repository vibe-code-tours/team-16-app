package com.nerdquiz.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.time.Instant;
import java.util.UUID;

public record TopicProgressResponse(
        @JsonProperty("topic_id") UUID topicId,
        String status,
        @JsonProperty("questions_answered") int questionsAnswered,
        @JsonProperty("questions_correct") int questionsCorrect,
        @JsonProperty("last_attempted_at") Instant lastAttemptedAt
) {}
