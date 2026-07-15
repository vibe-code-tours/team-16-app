package com.nerdquiz.service;

import com.nerdquiz.dto.AdminStatsResponse;
import com.nerdquiz.dto.TopicEngagementResponse;
import com.nerdquiz.exception.AdminAccessDeniedException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class AdminService {

    private static final Logger log = LoggerFactory.getLogger(AdminService.class);

    private final JdbcTemplate jdbcTemplate;

    public AdminService(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public AdminStatsResponse getStats(UUID userId) {
        verifyAdminRole(userId);

        long totalUsers = jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM user_profiles",
            Long.class
        );

        long activeToday = jdbcTemplate.queryForObject(
            "SELECT COUNT(DISTINCT user_id) FROM user_daily_activity WHERE activity_date = CURRENT_DATE",
            Long.class
        );

        long activeThisWeek = jdbcTemplate.queryForObject(
            "SELECT COUNT(DISTINCT user_id) FROM user_daily_activity WHERE activity_date >= CURRENT_DATE - INTERVAL '7 days'",
            Long.class
        );

        long totalQuizAttempts = jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM quiz_sessions WHERE status = 'completed'",
            Long.class
        );

        long totalExamAttempts = jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM exam_sessions WHERE status = 'completed'",
            Long.class
        );

        List<TopicEngagementResponse> topicEngagement = jdbcTemplate.query(
            """
            SELECT
              t.name AS topic_name,
              COUNT(qs.id) AS quiz_count,
              COALESCE(AVG(qs.score), 0) AS avg_score
            FROM quiz_sessions qs
            JOIN subtopics s ON qs.subtopic_id = s.id
            JOIN topics t ON s.topic_id = t.id
            WHERE qs.status = 'completed'
            GROUP BY t.id, t.name, t.display_order
            ORDER BY t.display_order
            """,
            (rs, rowNum) -> new TopicEngagementResponse(
                rs.getString("topic_name"),
                rs.getLong("quiz_count"),
                rs.getDouble("avg_score")
            )
        );

        log.debug("Admin stats computed for user {}: {} total users, {} active today",
                userId, totalUsers, activeToday);

        return new AdminStatsResponse(
            totalUsers,
            activeToday,
            activeThisWeek,
            totalQuizAttempts,
            totalExamAttempts,
            topicEngagement
        );
    }

    private void verifyAdminRole(UUID userId) {
        String role = jdbcTemplate.queryForObject(
            "SELECT role FROM user_profiles WHERE id = ?",
            String.class,
            userId
        );

        if (!"admin".equals(role)) {
            throw new AdminAccessDeniedException();
        }
    }
}
