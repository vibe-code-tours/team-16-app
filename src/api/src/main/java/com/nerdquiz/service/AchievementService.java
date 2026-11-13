package com.nerdquiz.service;

import com.nerdquiz.dto.AchievementResponse;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.function.ToIntFunction;

/**
 * Derives achievement unlock state on read from existing tables.
 * The catalogue is fixed in code; nothing is persisted.
 */
@Service
public class AchievementService {

    private static final int EXAM_PASS_PERCENTAGE = 60;

    /**
     * Loads every counter in one round trip. The user id and pass mark are bound
     * once and reused by each scalar subquery. Missing profile rows count as zero.
     */
    private static final String STATS_QUERY = """
        WITH target AS (SELECT CAST(? AS uuid) AS user_id, CAST(? AS numeric) AS exam_pass_percentage)
        SELECT
            (SELECT COUNT(*) FROM quiz_sessions qs
              WHERE qs.user_id = t.user_id AND qs.status = 'completed') AS quizzes_completed,
            (SELECT COUNT(*) FROM quiz_sessions qs
              WHERE qs.user_id = t.user_id AND qs.status = 'completed'
                AND qs.question_count > 0 AND qs.score >= qs.question_count) AS perfect_quizzes,
            (SELECT COALESCE(MAX(GREATEST(up.longest_streak, up.streak_count)), 0) FROM user_profiles up
              WHERE up.id = t.user_id) AS longest_streak,
            (SELECT COALESCE(MAX(up.total_xp), 0) FROM user_profiles up
              WHERE up.id = t.user_id) AS total_xp,
            (SELECT COUNT(*) FROM user_lesson_progress ulp
              WHERE ulp.user_id = t.user_id AND ulp.status = 'completed') AS lessons_completed,
            (SELECT COUNT(*) FROM exam_sessions es
              WHERE es.user_id = t.user_id AND es.status IN ('completed', 'expired')
                AND es.score_percentage >= t.exam_pass_percentage) AS exams_passed,
            (SELECT COUNT(*) FROM user_mistakes um
              WHERE um.user_id = t.user_id AND um.reviewed = true) AS mistakes_reviewed
        FROM target t
        """;

    private static final RowMapper<UserAchievementStats> STATS_ROW_MAPPER = (rs, rowNum) ->
            new UserAchievementStats(
                    rs.getInt("quizzes_completed"),
                    rs.getInt("perfect_quizzes"),
                    rs.getInt("longest_streak"),
                    rs.getInt("total_xp"),
                    rs.getInt("lessons_completed"),
                    rs.getInt("exams_passed"),
                    rs.getInt("mistakes_reviewed")
            );

    private static final List<AchievementDefinition> CATALOGUE = List.of(
            new AchievementDefinition("first-quiz", "First Steps", "Complete your first quiz",
                    "🎯", UserAchievementStats::quizzesCompleted, 1),
            new AchievementDefinition("quiz-10", "Quiz Regular", "Complete 10 quizzes",
                    "📚", UserAchievementStats::quizzesCompleted, 10),
            new AchievementDefinition("perfect-quiz", "Flawless", "Answer every question correctly in a quiz",
                    "💯", UserAchievementStats::perfectQuizzes, 1),
            new AchievementDefinition("streak-3", "Warming Up", "Reach a 3-day streak",
                    "🔥", UserAchievementStats::longestStreak, 3),
            new AchievementDefinition("streak-7", "On Fire", "Reach a 7-day streak",
                    "⚡", UserAchievementStats::longestStreak, 7),
            new AchievementDefinition("streak-30", "Unstoppable", "Reach a 30-day streak",
                    "🏆", UserAchievementStats::longestStreak, 30),
            new AchievementDefinition("xp-100", "XP Rookie", "Earn 100 XP",
                    "⭐", UserAchievementStats::totalXp, 100),
            new AchievementDefinition("xp-500", "XP Pro", "Earn 500 XP",
                    "🌟", UserAchievementStats::totalXp, 500),
            new AchievementDefinition("xp-1000", "XP Legend", "Earn 1000 XP",
                    "👑", UserAchievementStats::totalXp, 1000),
            new AchievementDefinition("lessons-5", "Bookworm", "Complete 5 lessons",
                    "📖", UserAchievementStats::lessonsCompleted, 5),
            new AchievementDefinition("first-exam-pass", "Exam Ready", "Pass your first exam simulation",
                    "🎓", UserAchievementStats::examsPassed, 1),
            new AchievementDefinition("mistakes-10", "Gardener", "Review 10 mistakes in the Mistake Garden",
                    "🌱", UserAchievementStats::mistakesReviewed, 10)
    );

    private final JdbcTemplate jdbcTemplate;

    public AchievementService(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    /**
     * Returns the full achievement catalogue with unlock state for the given user.
     *
     * @param userId authenticated user id, taken from the JWT
     */
    @Transactional(readOnly = true)
    public List<AchievementResponse> getAchievements(UUID userId) {
        UserAchievementStats stats = Optional
                .ofNullable(jdbcTemplate.queryForObject(
                        STATS_QUERY, STATS_ROW_MAPPER, userId, EXAM_PASS_PERCENTAGE))
                .orElse(UserAchievementStats.EMPTY);
        return evaluate(stats);
    }

    /**
     * Applies the unlock rules to a set of counters. Pure function, no I/O.
     */
    static List<AchievementResponse> evaluate(UserAchievementStats stats) {
        return CATALOGUE.stream()
                .map(definition -> definition.toResponse(stats))
                .toList();
    }

    /** Counters the unlock rules are evaluated against. */
    record UserAchievementStats(
            int quizzesCompleted,
            int perfectQuizzes,
            int longestStreak,
            int totalXp,
            int lessonsCompleted,
            int examsPassed,
            int mistakesReviewed
    ) {
        static final UserAchievementStats EMPTY = new UserAchievementStats(0, 0, 0, 0, 0, 0, 0);
    }

    private record AchievementDefinition(
            String id,
            String title,
            String description,
            String icon,
            ToIntFunction<UserAchievementStats> metric,
            int target
    ) {
        AchievementResponse toResponse(UserAchievementStats stats) {
            int value = Math.max(0, metric.applyAsInt(stats));
            return new AchievementResponse(
                    id, title, description, icon,
                    value >= target,
                    Math.min(value, target),
                    target
            );
        }
    }
}
