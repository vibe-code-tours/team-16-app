package com.nerdquiz.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.Max;

import java.util.UUID;

public record StartQuizRequest(
    UUID subtopicId,
    @Min(1) @Max(10) Integer questionCount
) {
    public StartQuizRequest {
        if (questionCount == null) questionCount = 5;
    }
}
