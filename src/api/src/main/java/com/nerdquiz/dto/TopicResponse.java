package com.nerdquiz.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.util.UUID;

public record TopicResponse(
        UUID id,
        String subject,
        String category,
        int order,
        String title,
        String description,
        @JsonProperty("question_count") int questionCount,
        @JsonProperty("prerequisite_topic_id") UUID prerequisiteTopicId,
        String status,
        TopicProgressResponse progress
) {}
