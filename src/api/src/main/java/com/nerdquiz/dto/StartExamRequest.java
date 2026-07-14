package com.nerdquiz.dto;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;

public record StartExamRequest(
    @Min(1) @Max(100) Integer questionCount,
    String difficulty
) {}
