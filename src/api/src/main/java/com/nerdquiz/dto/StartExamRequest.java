package com.nerdquiz.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

public record StartExamRequest(
    @NotBlank String examSession,
    @NotBlank @Pattern(regexp = "^[AB]$", message = "Subject must be A or B") String subject
) {}
