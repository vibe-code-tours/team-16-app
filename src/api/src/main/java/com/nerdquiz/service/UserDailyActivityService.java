package com.nerdquiz.service;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

/**
 * Records daily user activity for admin dashboard statistics.
 * Uses upsert to aggregate questions answered and XP earned per user per day.
 */
@Service
public class UserDailyActivityService {

    private final JdbcTemplate jdbcTemplate;

    public UserDailyActivityService(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Transactional
    public void recordActivity(UUID userId, int questionsAnswered, int xpEarned) {
        jdbcTemplate.update(
            """
            INSERT INTO user_daily_activity (user_id, activity_date, questions_answered, xp_earned)
            VALUES (?, CURRENT_DATE, ?, ?)
            ON CONFLICT (user_id, activity_date)
            DO UPDATE SET
                questions_answered = user_daily_activity.questions_answered + EXCLUDED.questions_answered,
                xp_earned = user_daily_activity.xp_earned + EXCLUDED.xp_earned
            """,
            userId, questionsAnswered, xpEarned
        );
    }
}
