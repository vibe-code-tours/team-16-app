package com.nerdquiz.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;

import java.util.UUID;

public record SubmitExamAnswerRequest(
    @NotNull UUID questionId,
    @NotNull @Min(1) Integer sequenceNumber,
    @NotBlank @Pattern(regexp = "^[a-d]$", message = "Answer must be a, b, c, or d") String answer,
    @NotNull @Min(0) Integer responseTimeMs
) {}
