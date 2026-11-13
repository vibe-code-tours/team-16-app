package com.nerdquiz.dto;

import java.time.LocalDate;

public record DailyActivityResponse(
    LocalDate date,
    int questionsAnswered,
    int xpEarned
) {}
