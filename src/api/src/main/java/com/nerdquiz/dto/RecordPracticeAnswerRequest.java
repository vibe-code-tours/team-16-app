package com.nerdquiz.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;

import java.util.UUID;

public record RecordPracticeAnswerRequest(
    @NotNull UUID questionId,
    @NotBlank @Pattern(regexp = "^[a-d]$", message = "Selected label must be a, b, c, or d") String selectedLabel
) {}
