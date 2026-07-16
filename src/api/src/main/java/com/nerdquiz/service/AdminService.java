package com.nerdquiz.service;

import com.nerdquiz.dto.AdminStatsResponse;
import com.nerdquiz.dto.AdminUserDetailResponse;
import com.nerdquiz.dto.AdminUserListResponse;
import com.nerdquiz.dto.AdminUserSummaryResponse;
import com.nerdquiz.dto.DailyActiveUsersResponse;
import com.nerdquiz.dto.RecentActivityResponse;
import com.nerdquiz.dto.TopicEngagementResponse;
import com.nerdquiz.exception.AdminAccessDeniedException;
import com.nerdquiz.exception.UserProfileNotFoundException;
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

        long totalQuizSessions = jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM quiz_sessions",
            Long.class
        );

        long totalExamSessions = jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM exam_sessions",
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

        double avgQuizScore = jdbcTemplate.queryForObject(
            "SELECT COALESCE(AVG(score * 100.0 / question_count), 0) FROM quiz_sessions WHERE status = 'completed'",
            Double.class
        );

        double avgExamScore = jdbcTemplate.queryForObject(
            "SELECT COALESCE(AVG(score_percentage), 0) FROM exam_sessions WHERE status = 'completed'",
            Double.class
        );

        long examPassRate = jdbcTemplate.queryForObject(
            """
            SELECT CASE WHEN COUNT(*) = 0 THEN 0
                   ELSE ROUND(COUNT(*) FILTER (WHERE score_percentage >= 60) * 100.0 / COUNT(*))
            END
            FROM exam_sessions WHERE status = 'completed'
            """,
            Long.class
        );

        long quizCompletionRate = jdbcTemplate.queryForObject(
            """
            SELECT CASE WHEN COUNT(*) = 0 THEN 0
                   ELSE ROUND(COUNT(*) FILTER (WHERE status = 'completed') * 100.0 / COUNT(*))
            END
            FROM quiz_sessions
            """,
            Long.class
        );

        List<DailyActiveUsersResponse> dailyActiveUsers = jdbcTemplate.query(
            """
            SELECT activity_date AS date, COUNT(DISTINCT user_id) AS active_users
            FROM user_daily_activity
            WHERE activity_date >= CURRENT_DATE - INTERVAL '30 days'
            GROUP BY activity_date
            ORDER BY activity_date
            """,
            (rs, rowNum) -> new DailyActiveUsersResponse(
                rs.getDate("date").toLocalDate().toString(),
                rs.getLong("active_users")
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
            totalQuizSessions,
            totalExamSessions,
            avgQuizScore,
            avgExamScore,
            examPassRate,
            quizCompletionRate,
            topicEngagement,
            dailyActiveUsers
        );
    }

    public AdminUserListResponse getUsers(
            UUID adminId, String search, String role, String filter,
            String sort, String order, int page, int pageSize
    ) {
        verifyAdminRole(adminId);

        String whereClause = buildUserWhereClause(search, role, filter);
        String sortColumn = sanitizeSortColumn(sort);
        String sortOrder = "desc".equalsIgnoreCase(order) ? "DESC" : "ASC";
        int offset = (page - 1) * pageSize;

        long total = jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM user_profiles up " + whereClause,
            Long.class,
            buildWhereParams(search, role, filter)
        );

        List<AdminUserSummaryResponse> users = jdbcTemplate.query(
            "SELECT up.id, up.display_name, up.email, up.avatar_url, up.role, " +
            "CASE WHEN up.last_login_at >= CURRENT_DATE THEN 'active' ELSE 'inactive' END AS status, " +
            "up.total_xp, up.streak_count, up.last_login_at, up.created_at " +
            "FROM user_profiles up " +
            whereClause +
            " ORDER BY up." + sortColumn + " " + sortOrder +
            " LIMIT ? OFFSET ?",
            (rs, rowNum) -> new AdminUserSummaryResponse(
                rs.getObject("id", UUID.class),
                rs.getString("display_name"),
                rs.getString("email"),
                rs.getString("avatar_url"),
                rs.getString("role"),
                rs.getString("status"),
                rs.getInt("total_xp"),
                rs.getInt("streak_count"),
                rs.getTimestamp("last_login_at") != null ? rs.getTimestamp("last_login_at").toInstant() : null,
                rs.getTimestamp("created_at") != null ? rs.getTimestamp("created_at").toInstant() : null
            ),
            buildWhereParamsWithLimit(search, role, filter, pageSize, offset)
        );

        log.debug("Admin user list: {} users returned (page {}, total {})", users.size(), page, total);

        return new AdminUserListResponse(users, total, page, pageSize);
    }

    public AdminUserDetailResponse getUserDetail(UUID adminId, UUID targetUserId) {
        verifyAdminRole(adminId);

        AdminUserSummaryResponse summary = jdbcTemplate.queryForObject(
            """
            SELECT up.id, up.display_name, up.email, up.avatar_url, up.role,
                   CASE WHEN up.last_login_at >= CURRENT_DATE THEN 'active' ELSE 'inactive' END AS status,
                   up.total_xp, up.streak_count, up.last_login_at, up.created_at
            FROM user_profiles up
            WHERE up.id = ?
            """,
            (rs, rowNum) -> new AdminUserSummaryResponse(
                rs.getObject("id", UUID.class),
                rs.getString("display_name"),
                rs.getString("email"),
                rs.getString("avatar_url"),
                rs.getString("role"),
                rs.getString("status"),
                rs.getInt("total_xp"),
                rs.getInt("streak_count"),
                rs.getTimestamp("last_login_at") != null ? rs.getTimestamp("last_login_at").toInstant() : null,
                rs.getTimestamp("created_at") != null ? rs.getTimestamp("created_at").toInstant() : null
            ),
            targetUserId
        );

        if (summary == null) {
            throw new UserProfileNotFoundException();
        }

        long totalQuizzes = jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM quiz_sessions WHERE user_id = ?", Long.class, targetUserId
        );
        long completedQuizzes = jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM quiz_sessions WHERE user_id = ? AND status = 'completed'", Long.class, targetUserId
        );
        double avgQuizScore = jdbcTemplate.queryForObject(
            "SELECT COALESCE(AVG(score * 100.0 / question_count), 0) FROM quiz_sessions WHERE user_id = ? AND status = 'completed'",
            Double.class, targetUserId
        );

        long totalExams = jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM exam_sessions WHERE user_id = ?", Long.class, targetUserId
        );
        long completedExams = jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM exam_sessions WHERE user_id = ? AND status = 'completed'", Long.class, targetUserId
        );
        double avgExamScore = jdbcTemplate.queryForObject(
            "SELECT COALESCE(AVG(score_percentage), 0) FROM exam_sessions WHERE user_id = ? AND status = 'completed'",
            Double.class, targetUserId
        );
        long examPassRate = jdbcTemplate.queryForObject(
            """
            SELECT CASE WHEN COUNT(*) = 0 THEN 0
                   ELSE ROUND(COUNT(*) FILTER (WHERE score_percentage >= 60) * 100.0 / COUNT(*))
            END
            FROM exam_sessions WHERE user_id = ? AND status = 'completed'
            """,
            Long.class, targetUserId
        );

        Integer longestStreak = jdbcTemplate.queryForObject(
            "SELECT COALESCE(longest_streak, 0) FROM user_profiles WHERE id = ?",
            Integer.class, targetUserId
        );

        List<RecentActivityResponse> recentActivity = jdbcTemplate.query(
            """
            SELECT 'quiz' AS type, t.name AS topic_name, qs.score, qs.completed_at
            FROM quiz_sessions qs
            JOIN subtopics s ON qs.subtopic_id = s.id
            JOIN topics t ON s.topic_id = t.id
            WHERE qs.user_id = ? AND qs.status = 'completed'
            UNION ALL
            SELECT 'exam' AS type, e.title AS topic_name, es.score_percentage::INT AS score, es.completed_at
            FROM exam_sessions es
            JOIN exams e ON es.exam_id = e.id
            WHERE es.user_id = ? AND es.status = 'completed'
            ORDER BY completed_at DESC
            LIMIT 10
            """,
            (rs, rowNum) -> new RecentActivityResponse(
                rs.getString("type"),
                rs.getString("topic_name"),
                rs.getInt("score"),
                rs.getTimestamp("completed_at") != null ? rs.getTimestamp("completed_at").toInstant() : null
            ),
            targetUserId, targetUserId
        );

        return new AdminUserDetailResponse(
            summary.id(), summary.displayName(), summary.email(), summary.avatarUrl(),
            summary.role(), summary.status(), summary.totalXp(), summary.streakCount(),
            longestStreak, summary.lastLoginAt(), summary.createdAt(),
            totalQuizzes, completedQuizzes, avgQuizScore,
            totalExams, completedExams, avgExamScore, examPassRate,
            recentActivity
        );
    }

    public void updateUserRole(UUID adminId, UUID targetUserId, String newRole) {
        verifyAdminRole(adminId);

        if (!"admin".equals(newRole) && !"user".equals(newRole) && !"deactivated".equals(newRole)) {
            throw new IllegalArgumentException("Invalid role: " + newRole);
        }

        int updated = jdbcTemplate.update(
            "UPDATE user_profiles SET role = ?, updated_at = now() WHERE id = ?",
            newRole, targetUserId
        );

        if (updated == 0) {
            throw new UserProfileNotFoundException();
        }

        log.info("Admin {} changed role of user {} to {}", adminId, targetUserId, newRole);
    }

    public void deactivateUser(UUID adminId, UUID targetUserId) {
        verifyAdminRole(adminId);

        int updated = jdbcTemplate.update(
            "UPDATE user_profiles SET role = 'deactivated', updated_at = now() WHERE id = ? AND role != 'admin'",
            targetUserId
        );

        if (updated == 0) {
            throw new UserProfileNotFoundException();
        }

        log.info("Admin {} deactivated user {}", adminId, targetUserId);
    }

    public void resetUserStreak(UUID adminId, UUID targetUserId) {
        verifyAdminRole(adminId);

        int updated = jdbcTemplate.update(
            "UPDATE user_profiles SET streak_count = 0, updated_at = now() WHERE id = ?",
            targetUserId
        );

        if (updated == 0) {
            throw new UserProfileNotFoundException();
        }

        log.info("Admin {} reset streak for user {}", adminId, targetUserId);
    }

    public String exportUsers(UUID adminId, String search, String role, String filter) {
        verifyAdminRole(adminId);

        String whereClause = buildUserWhereClause(search, role, filter);

        List<AdminUserSummaryResponse> users = jdbcTemplate.query(
            "SELECT up.id, up.display_name, up.email, up.avatar_url, up.role, " +
            "CASE WHEN up.last_login_at >= CURRENT_DATE THEN 'active' ELSE 'inactive' END AS status, " +
            "up.total_xp, up.streak_count, up.last_login_at, up.created_at " +
            "FROM user_profiles up " +
            whereClause +
            " ORDER BY up.created_at DESC",
            (rs, rowNum) -> new AdminUserSummaryResponse(
                rs.getObject("id", UUID.class),
                rs.getString("display_name"),
                rs.getString("email"),
                rs.getString("avatar_url"),
                rs.getString("role"),
                rs.getString("status"),
                rs.getInt("total_xp"),
                rs.getInt("streak_count"),
                rs.getTimestamp("last_login_at") != null ? rs.getTimestamp("last_login_at").toInstant() : null,
                rs.getTimestamp("created_at") != null ? rs.getTimestamp("created_at").toInstant() : null
            ),
            buildWhereParams(search, role, filter)
        );

        StringBuilder csv = new StringBuilder();
        csv.append("ID,Name,Email,Role,Status,XP,Streak,Last Active,Joined\n");
        for (AdminUserSummaryResponse u : users) {
            csv.append(String.format("%s,\"%s\",%s,%s,%s,%d,%d,%s,%s\n",
                u.id(),
                escapeCsv(u.displayName()),
                u.email(),
                u.role(),
                u.status(),
                u.totalXp() != null ? u.totalXp() : 0,
                u.streakCount() != null ? u.streakCount() : 0,
                u.lastLoginAt() != null ? u.lastLoginAt().toString() : "",
                u.createdAt() != null ? u.createdAt().toString() : ""
            ));
        }

        return csv.toString();
    }

    private String buildUserWhereClause(String search, String role, String filter) {
        StringBuilder where = new StringBuilder(" WHERE 1=1");

        if (search != null && !search.isBlank()) {
            where.append(" AND (up.display_name ILIKE '%' || ? || '%' OR up.email ILIKE '%' || ? || '%')");
        }
        if (role != null && !role.isBlank()) {
            where.append(" AND up.role = ?");
        }
        if (filter != null && !filter.isBlank()) {
            switch (filter) {
                case "active_today" -> where.append(" AND up.last_login_at >= CURRENT_DATE");
                case "inactive_30d" -> where.append(" AND (up.last_login_at < NOW() - INTERVAL '30 days' OR up.last_login_at IS NULL)");
                case "new_7d" -> where.append(" AND up.created_at >= NOW() - INTERVAL '7 days'");
            }
        }

        return where.toString();
    }

    private Object[] buildWhereParams(String search, String role, String filter) {
        java.util.List<Object> params = new java.util.ArrayList<>();
        if (search != null && !search.isBlank()) {
            params.add(search);
            params.add(search);
        }
        if (role != null && !role.isBlank()) {
            params.add(role);
        }
        return params.toArray();
    }

    private Object[] buildWhereParamsWithLimit(String search, String role, String filter, int limit, int offset) {
        java.util.List<Object> params = new java.util.ArrayList<>();
        if (search != null && !search.isBlank()) {
            params.add(search);
            params.add(search);
        }
        if (role != null && !role.isBlank()) {
            params.add(role);
        }
        params.add(limit);
        params.add(offset);
        return params.toArray();
    }

    private String sanitizeSortColumn(String sort) {
        return switch (sort != null ? sort : "last_login_at") {
            case "display_name", "email", "role", "last_login_at", "total_xp", "streak_count", "created_at" -> sort;
            default -> "last_login_at";
        };
    }

    private String escapeCsv(String value) {
        if (value == null) return "";
        String escaped = value.replace("\"", "\"\"");
        if (escaped.startsWith("=") || escaped.startsWith("+") || escaped.startsWith("-")
                || escaped.startsWith("@") || escaped.startsWith("\t")) {
            escaped = "'" + escaped;
        }
        return escaped;
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
