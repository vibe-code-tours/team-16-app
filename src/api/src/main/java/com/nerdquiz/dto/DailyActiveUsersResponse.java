package com.nerdquiz.dto;

public record DailyActiveUsersResponse(
    String date,
    long activeUsers
) {}
