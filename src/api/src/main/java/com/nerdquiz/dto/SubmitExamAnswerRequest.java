package com.nerdquiz.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;

import java.util.UUID;

public record SubmitExamAnswerRequest(
    @NotNull UUID questionId,
    @Pattern(regexp = "^[a-d]$", message = "Answer must be a, b, c, or d") String answer
) {}
