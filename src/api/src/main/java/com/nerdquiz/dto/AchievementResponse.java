package com.nerdquiz.dto;

/**
 * One achievement from the fixed catalogue, with the caller's unlock state.
 * {@code progress} is capped at {@code target}.
 */
public record AchievementResponse(
        String id,
        String title,
        String description,
        String icon,
        boolean unlocked,
        int progress,
        int target
) {
}
