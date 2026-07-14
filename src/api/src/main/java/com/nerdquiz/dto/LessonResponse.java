package com.nerdquiz.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.JsonNode;

import java.util.UUID;

public record LessonResponse(
        UUID id,
        @JsonProperty("subtopic_id") UUID subtopicId,
        String title,
        String slug,
        String summary,
        @JsonProperty("content_blocks") JsonNode contentBlocks,
        @JsonProperty("estimated_minutes") Integer estimatedMinutes,
        @JsonProperty("xp_reward") Integer xpReward,
        @JsonProperty("display_order") Integer displayOrder,
        Boolean published,
        String status
) {}
