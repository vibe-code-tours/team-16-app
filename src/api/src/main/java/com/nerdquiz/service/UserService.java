package com.nerdquiz.service;

import com.nerdquiz.exception.UserProfileNotFoundException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
public class UserService {

    private final JdbcTemplate jdbcTemplate;
    private final UserDailyActivityService activityService;

    public UserService(JdbcTemplate jdbcTemplate, UserDailyActivityService activityService) {
        this.jdbcTemplate = jdbcTemplate;
        this.activityService = activityService;
    }

    @Transactional
    public int updateUserStreak(UUID userId) {
        List<Integer> updatedStreaks = jdbcTemplate.query(
            """
            WITH profile AS (
                SELECT
                    id,
                    COALESCE(streak_count, 0) AS current_streak,
                    COALESCE(longest_streak, 0) AS longest_streak,
                    last_login_at::date AS last_login_date
                FROM public.user_profiles
                WHERE id = ?
                FOR UPDATE
            ),
            computed AS (
                SELECT
                    id,
                    CASE
                        WHEN last_login_date = CURRENT_DATE THEN current_streak
                        WHEN last_login_date = CURRENT_DATE - 1 THEN current_streak + 1
                        ELSE 1
                    END AS new_streak,
                    CASE
                        WHEN last_login_date = CURRENT_DATE THEN longest_streak
                        WHEN last_login_date = CURRENT_DATE - 1 THEN GREATEST(longest_streak, current_streak + 1)
                        ELSE GREATEST(longest_streak, 1)
                    END AS new_longest
                FROM profile
            )
            UPDATE public.user_profiles AS user_profiles
            SET streak_count = computed.new_streak,
                longest_streak = computed.new_longest,
                last_login_at = now()
            FROM computed
            WHERE user_profiles.id = computed.id
            RETURNING user_profiles.streak_count
            """,
            (ps) -> ps.setObject(1, userId),
            (rs, rowNum) -> rs.getInt("streak_count")
        );

        if (updatedStreaks.isEmpty()) {
            throw new UserProfileNotFoundException();
        }

        // Record daily activity on login (streak update)
        activityService.recordActivity(userId, 0, 0);

        return updatedStreaks.getFirst();
    }

    @Transactional
    public int incrementUserXp(UUID userId, int delta) {
        if (delta < 0) {
            throw new IllegalArgumentException("XP delta must be non-negative");
        }

        List<Integer> updatedXp = jdbcTemplate.query(
            """
            UPDATE public.user_profiles
            SET total_xp = COALESCE(total_xp, 0) + ?
            WHERE id = ?
            RETURNING total_xp
            """,
            (ps) -> {
                ps.setInt(1, delta);
                ps.setObject(2, userId);
            },
            (rs, rowNum) -> rs.getInt("total_xp")
        );

        if (updatedXp.isEmpty()) {
            throw new UserProfileNotFoundException();
        }

        activityService.recordActivity(userId, 0, delta);

        return updatedXp.getFirst();
    }
}
