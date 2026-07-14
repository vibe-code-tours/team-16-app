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

    public UserService(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Transactional
    public int updateUserStreak(UUID userId) {
        List<Integer> updatedStreaks = jdbcTemplate.query(
            """
            WITH profile AS (
                SELECT
                    id,
                    COALESCE(streak_count, 0) AS current_streak,
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
                    END AS new_streak
                FROM profile
            )
            UPDATE public.user_profiles AS user_profiles
            SET streak_count = computed.new_streak,
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

        return updatedStreaks.getFirst();
    }
}
