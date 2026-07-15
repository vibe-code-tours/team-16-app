package com.nerdquiz.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.util.UUID;

public record RecordPracticeAnswerRequest(
    @NotNull UUID questionId,
    @NotBlank String selectedLabel
) {}
