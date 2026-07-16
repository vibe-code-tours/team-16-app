package com.nerdquiz.dto;

import java.util.List;

public record AdminUserListResponse(
    List<AdminUserSummaryResponse> users,
    long total,
    int page,
    int pageSize
) {}
