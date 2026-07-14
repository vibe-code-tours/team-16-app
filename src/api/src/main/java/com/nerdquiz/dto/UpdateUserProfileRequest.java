package com.nerdquiz.dto;

public record UpdateUserProfileRequest(
    String displayName,
    String avatarUrl
) {}
