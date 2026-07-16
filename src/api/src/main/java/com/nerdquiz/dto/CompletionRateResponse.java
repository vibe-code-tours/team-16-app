package com.nerdquiz.dto;

public record CompletionRateResponse(
    long completed,
    long total
) {}
