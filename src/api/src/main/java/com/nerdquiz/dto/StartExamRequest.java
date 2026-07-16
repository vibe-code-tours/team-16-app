package com.nerdquiz.dto;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.Size;

public record StartExamRequest(
    @Min(1) @Max(100) Integer questionCount,
    @Size(max = 20) String difficulty
) {}
