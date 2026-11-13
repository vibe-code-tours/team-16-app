package com.nerdquiz.controller;

import com.nerdquiz.dto.DailyActivityResponse;
import com.nerdquiz.service.UserDailyActivityService;
import com.nerdquiz.util.UuidUtil;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

/**
 * Daily activity history for the authenticated user.
 */
@RestController
@RequestMapping("/api/v1/me")
@Validated
public class UserActivityController {

    private static final String DEFAULT_ACTIVITY_DAYS = "7";

    private final UserDailyActivityService activityService;

    public UserActivityController(UserDailyActivityService activityService) {
        this.activityService = activityService;
    }

    /**
     * Returns one entry per day for the last {@code days} days, oldest first, with zeros for idle days.
     */
    @GetMapping("/activity")
    public ResponseEntity<List<DailyActivityResponse>> getActivity(
            Authentication authentication,
            @RequestParam(defaultValue = DEFAULT_ACTIVITY_DAYS)
            @Min(UserDailyActivityService.MIN_ACTIVITY_DAYS)
            @Max(UserDailyActivityService.MAX_ACTIVITY_DAYS) int days
    ) {
        Optional<UUID> userId = UuidUtil.tryParse(authentication.getName());
        if (userId.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.ok(activityService.getRecentActivity(userId.get(), days));
    }
}
