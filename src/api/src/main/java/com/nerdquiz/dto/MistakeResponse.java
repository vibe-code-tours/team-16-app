package com.nerdquiz.dto;

import java.time.Instant;
import java.util.UUID;

public record MistakeResponse(
    UUID id,
    UUID questionId,
    String selectedLabel,
    Instant createdAt,
    Boolean reviewed
) {}
