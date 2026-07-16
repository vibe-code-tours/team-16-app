package com.nerdquiz.dto;

import jakarta.validation.constraints.Pattern;

public record FinishExamRequest(
    @Pattern(regexp = "completed|expired|abandoned", message = "Status must be completed, expired, or abandoned")
    String status
) {}
