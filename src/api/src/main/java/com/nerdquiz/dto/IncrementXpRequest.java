package com.nerdquiz.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

public record IncrementXpRequest(
    @NotNull @Min(0) Integer delta
) {}
