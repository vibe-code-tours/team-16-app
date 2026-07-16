package com.nerdquiz.dto;

import java.time.Instant;

public record RecentActivityResponse(
    String type,
    String topicName,
    Integer score,
    Instant completedAt
) {}
