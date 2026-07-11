package com.nerdquiz.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

import java.util.UUID;

public record SubmitAnswerRequest(
    UUID questionId,
    @NotBlank @Pattern(regexp = "^[a-d]$", message = "Answer must be a, b, c, or d") String answer
) {}
