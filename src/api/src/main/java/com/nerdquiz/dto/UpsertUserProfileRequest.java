package com.nerdquiz.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record UpsertUserProfileRequest(
    @NotBlank @Email String email,
    @NotBlank @Size(max = 100) String displayName,
    @Size(max = 500) String avatarUrl
) {}
