package com.nerdquiz.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;

import java.util.UUID;

public record SubmitAnswerRequest(
    @NotNull UUID questionId,
    @NotBlank @Pattern(regexp = "^[a-i]$", message = "Answer must be a single letter from a to i") String answer
) {}
