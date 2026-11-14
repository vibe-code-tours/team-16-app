package com.nerdquiz.service;

import com.nerdquiz.dto.DailyActivityResponse;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

/**
 * Records and reads daily user activity (questions answered, XP earned).
 * Uses upsert to aggregate per user per day.
 */
@Service
public class UserDailyActivityService {

    public static final int MIN_ACTIVITY_DAYS = 1;
    public static final int MAX_ACTIVITY_DAYS = 30;

    private static final int QUESTIONS_PER_ANSWER = 1;

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

    /** Counts one answered question (quiz or exam) toward today's activity. */
    @Transactional
    public void recordAnsweredQuestion(UUID userId) {
        recordActivity(userId, QUESTIONS_PER_ANSWER, 0);
    }

    /**
     * Returns one entry per day for the last {@code days} days (today included), oldest first.
     * Days without activity are returned as zeros. Dates use the database's CURRENT_DATE,
     * the same clock {@link #recordActivity} writes with.
     */
    @Transactional(readOnly = true)
    public List<DailyActivityResponse> getRecentActivity(UUID userId, int days) {
        if (days < MIN_ACTIVITY_DAYS || days > MAX_ACTIVITY_DAYS) {
            throw new IllegalArgumentException(
                "days must be between " + MIN_ACTIVITY_DAYS + " and " + MAX_ACTIVITY_DAYS);
        }

        return jdbcTemplate.query(
            """
            SELECT days.activity_date,
                   COALESCE(a.questions_answered, 0) AS questions_answered,
                   COALESCE(a.xp_earned, 0) AS xp_earned
            FROM (
                SELECT CURRENT_DATE - g.day_offset AS activity_date
                FROM generate_series(0, ?) AS g(day_offset)
            ) AS days
            LEFT JOIN user_daily_activity a
                ON a.user_id = ? AND a.activity_date = days.activity_date
            ORDER BY days.activity_date ASC
            """,
            (rs, rowNum) -> new DailyActivityResponse(
                rs.getDate("activity_date").toLocalDate(),
                rs.getInt("questions_answered"),
                rs.getInt("xp_earned")
            ),
            days - 1, userId
        );
    }
}
