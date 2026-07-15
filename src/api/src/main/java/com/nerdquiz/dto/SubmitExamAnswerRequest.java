package com.nerdquiz.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.util.UUID;

public record SubmitExamAnswerRequest(
    @NotNull UUID questionId,
    @NotNull @Min(1) Integer sequenceNumber,
    @NotBlank String answer,
    @Min(0) Integer responseTimeMs
) {}
