package com.nerdquiz.dto;

public record UpsertUserProfileRequest(
    String email,
    String displayName,
    String avatarUrl
) {}
