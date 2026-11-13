package com.nerdquiz.service;

import com.nerdquiz.exception.UserProfileNotFoundException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
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

    /**
     * Records that the user studied today (answered a quiz question, completed a lesson,
     * or finished an exam) and updates the streak. Idempotent within a calendar day:
     * the first study event of a day extends or resets the streak, later ones change nothing.
     *
     * @return the streak count after this study event
     */
    @Transactional
    public int recordStudyActivity(UUID userId) {
        StreakSnapshot snapshot = jdbcTemplate.query(
            """
            SELECT COALESCE(streak_count, 0) AS streak_count,
                   COALESCE(longest_streak, 0) AS longest_streak,
                   last_login_at::date AS last_activity_date,
                   CURRENT_DATE AS today
            FROM public.user_profiles
            WHERE id = ?
            FOR UPDATE
            """,
            (rs, rowNum) -> new StreakSnapshot(
                rs.getInt("streak_count"),
                rs.getInt("longest_streak"),
                rs.getObject("last_activity_date", LocalDate.class),
                rs.getObject("today", LocalDate.class)
            ),
            userId
        ).stream().findFirst().orElseThrow(UserProfileNotFoundException::new);

        StreakState next = nextStreak(snapshot);

        // last_login_at holds the time of the last study activity (shown to admins as "Last Active")
        jdbcTemplate.update(
            """
            UPDATE public.user_profiles
            SET streak_count = ?, longest_streak = ?, last_login_at = now()
            WHERE id = ?
            """,
            next.streakCount(), next.longestStreak(), userId
        );

        activityService.recordActivity(userId, 0, 0);

        return next.streakCount();
    }

    /**
     * Returns the user's current streak without changing it. A streak whose last study
     * activity is older than yesterday has lapsed and is reported as 0.
     */
    @Transactional(readOnly = true)
    public int getCurrentStreak(UUID userId) {
        return jdbcTemplate.query(
            """
            SELECT CASE
                       WHEN last_login_at::date >= CURRENT_DATE - 1 THEN COALESCE(streak_count, 0)
                       ELSE 0
                   END AS streak_count
            FROM public.user_profiles
            WHERE id = ?
            """,
            (rs, rowNum) -> rs.getInt("streak_count"),
            userId
        ).stream().findFirst().orElseThrow(UserProfileNotFoundException::new);
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

    /**
     * Computes the streak after a study event: same day keeps it, the day after the last
     * activity extends it, anything else (a gap or no previous activity) restarts it at 1.
     */
    static StreakState nextStreak(StreakSnapshot snapshot) {
        LocalDate lastActivity = snapshot.lastActivityDate();
        LocalDate today = snapshot.today();

        if (today.equals(lastActivity)) {
            return new StreakState(snapshot.currentStreak(), snapshot.longestStreak());
        }

        int newStreak = today.minusDays(1).equals(lastActivity) ? snapshot.currentStreak() + 1 : 1;
        return new StreakState(newStreak, Math.max(snapshot.longestStreak(), newStreak));
    }

    record StreakSnapshot(int currentStreak, int longestStreak, LocalDate lastActivityDate, LocalDate today) {
    }

    record StreakState(int streakCount, int longestStreak) {
    }
}
