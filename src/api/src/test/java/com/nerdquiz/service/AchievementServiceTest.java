package com.nerdquiz.service;

import com.nerdquiz.dto.AchievementResponse;
import com.nerdquiz.service.AchievementService.UserAchievementStats;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.function.Function;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

class AchievementServiceTest {

    private static final int EXAM_PASS_PERCENTAGE = 60;

    private static final List<String> CATALOGUE_IDS = List.of(
            "first-quiz", "quiz-10", "perfect-quiz",
            "streak-3", "streak-7", "streak-30",
            "xp-100", "xp-500", "xp-1000",
            "lessons-5", "first-exam-pass", "mistakes-10"
    );

    private JdbcTemplate jdbcTemplate;
    private AchievementService achievementService;
    private UUID userId;

    @BeforeEach
    void setUp() {
        jdbcTemplate = mock(JdbcTemplate.class);
        achievementService = new AchievementService(jdbcTemplate);
        userId = UUID.randomUUID();
    }

    @SuppressWarnings("unchecked")
    private void mockStats(UserAchievementStats stats) {
        when(jdbcTemplate.queryForObject(anyString(), any(RowMapper.class), eq(userId), eq(EXAM_PASS_PERCENTAGE)))
                .thenReturn(stats);
    }

    private static Map<String, AchievementResponse> byId(List<AchievementResponse> achievements) {
        return achievements.stream()
                .collect(Collectors.toMap(AchievementResponse::id, Function.identity()));
    }

    private static UserAchievementStats stats(int quizzes, int perfect, int streak, int xp,
                                              int lessons, int exams, int mistakes) {
        return new UserAchievementStats(quizzes, perfect, streak, xp, lessons, exams, mistakes);
    }

    @Test
    @SuppressWarnings("unchecked")
    void getAchievements_NewUser_ReturnsFullCatalogueAllLockedWithZeroProgress() {
        mockStats(UserAchievementStats.EMPTY);

        List<AchievementResponse> achievements = achievementService.getAchievements(userId);

        assertEquals(CATALOGUE_IDS, achievements.stream().map(AchievementResponse::id).toList());
        achievements.forEach(achievement -> {
            assertFalse(achievement.unlocked(), achievement.id() + " should be locked");
            assertEquals(0, achievement.progress(), achievement.id() + " progress");
            assertTrue(achievement.target() > 0, achievement.id() + " target");
        });
        verify(jdbcTemplate, times(1))
                .queryForObject(anyString(), any(RowMapper.class), eq(userId), eq(EXAM_PASS_PERCENTAGE));
    }

    @Test
    void getAchievements_QueryReturnsNull_TreatsUserAsNew() {
        mockStats(null);

        List<AchievementResponse> achievements = achievementService.getAchievements(userId);

        assertEquals(CATALOGUE_IDS.size(), achievements.size());
        assertTrue(achievements.stream().noneMatch(AchievementResponse::unlocked));
    }

    @Test
    void evaluate_OneCompletedQuiz_UnlocksFirstQuizAndTracksTenQuizProgress() {
        Map<String, AchievementResponse> achievements =
                byId(AchievementService.evaluate(stats(1, 0, 0, 0, 0, 0, 0)));

        assertTrue(achievements.get("first-quiz").unlocked());
        assertEquals(1, achievements.get("first-quiz").progress());
        assertFalse(achievements.get("quiz-10").unlocked());
        assertEquals(1, achievements.get("quiz-10").progress());
        assertEquals(10, achievements.get("quiz-10").target());
    }

    @Test
    void evaluate_ProgressAboveTarget_CapsProgressAtTarget() {
        Map<String, AchievementResponse> achievements =
                byId(AchievementService.evaluate(stats(25, 0, 0, 0, 0, 0, 0)));

        assertTrue(achievements.get("quiz-10").unlocked());
        assertEquals(10, achievements.get("quiz-10").progress());
        assertEquals(1, achievements.get("first-quiz").progress());
    }

    @Test
    void evaluate_PerfectQuiz_UnlocksFlawless() {
        Map<String, AchievementResponse> achievements =
                byId(AchievementService.evaluate(stats(1, 1, 0, 0, 0, 0, 0)));

        assertTrue(achievements.get("perfect-quiz").unlocked());
    }

    @Test
    void evaluate_LongestStreakSeven_UnlocksThreeAndSevenButNotThirty() {
        Map<String, AchievementResponse> achievements =
                byId(AchievementService.evaluate(stats(0, 0, 7, 0, 0, 0, 0)));

        assertTrue(achievements.get("streak-3").unlocked());
        assertTrue(achievements.get("streak-7").unlocked());
        assertFalse(achievements.get("streak-30").unlocked());
        assertEquals(7, achievements.get("streak-30").progress());
    }

    @Test
    void evaluate_XpJustBelowAndAtThresholds_UnlocksOnlyReachedTiers() {
        Map<String, AchievementResponse> achievements =
                byId(AchievementService.evaluate(stats(0, 0, 0, 500, 0, 0, 0)));

        assertTrue(achievements.get("xp-100").unlocked());
        assertTrue(achievements.get("xp-500").unlocked());
        assertFalse(achievements.get("xp-1000").unlocked());
        assertEquals(500, achievements.get("xp-1000").progress());

        Map<String, AchievementResponse> belowFirstTier =
                byId(AchievementService.evaluate(stats(0, 0, 0, 99, 0, 0, 0)));
        assertFalse(belowFirstTier.get("xp-100").unlocked());
    }

    @Test
    void evaluate_LessonsExamsAndMistakes_UnlockAtTargets() {
        Map<String, AchievementResponse> achievements =
                byId(AchievementService.evaluate(stats(0, 0, 0, 0, 5, 1, 10)));

        assertTrue(achievements.get("lessons-5").unlocked());
        assertTrue(achievements.get("first-exam-pass").unlocked());
        assertTrue(achievements.get("mistakes-10").unlocked());

        Map<String, AchievementResponse> justShort =
                byId(AchievementService.evaluate(stats(0, 0, 0, 0, 4, 0, 9)));
        assertFalse(justShort.get("lessons-5").unlocked());
        assertFalse(justShort.get("first-exam-pass").unlocked());
        assertFalse(justShort.get("mistakes-10").unlocked());
        assertEquals(9, justShort.get("mistakes-10").progress());
    }
}
