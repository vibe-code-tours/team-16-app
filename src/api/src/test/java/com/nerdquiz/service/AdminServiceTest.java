package com.nerdquiz.service;

import com.nerdquiz.dto.*;
import com.nerdquiz.exception.AdminAccessDeniedException;
import com.nerdquiz.exception.UserProfileNotFoundException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.ArgumentMatchers;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import java.util.Collections;
import java.util.List;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class AdminServiceTest {

    private JdbcTemplate jdbcTemplate;
    private AdminService adminService;

    private UUID adminId;
    private UUID targetUserId;

    @BeforeEach
    void setUp() {
        adminId = UUID.randomUUID();
        targetUserId = UUID.randomUUID();

        // Create mock with a default answer that handles ALL queryForObject overloads
        // by inspecting the arguments, bypassing Mockito's overload resolution issues
        jdbcTemplate = mock(JdbcTemplate.class, invocation -> {
            if ("queryForObject".equals(invocation.getMethod().getName())) {
                for (Object arg : invocation.getArguments()) {
                    if (arg instanceof Class<?> type) {
                        if (type == Long.class) return 0L;
                        if (type == Double.class) return 0.0;
                        if (type == Integer.class) return 0;
                        if (type == String.class) return "admin";
                    }
                }
            }
            if ("query".equals(invocation.getMethod().getName())) {
                return Collections.emptyList();
            }
            if ("update".equals(invocation.getMethod().getName())) {
                return 1;
            }
            return null;
        });
        adminService = new AdminService(jdbcTemplate);
    }

    private void mockAdminRole() {
        when(jdbcTemplate.queryForObject(
                anyString(), eq(String.class), any(UUID.class)
        )).thenReturn("admin");
    }

    private void mockNonAdminRole() {
        when(jdbcTemplate.queryForObject(
                anyString(), eq(String.class), any(UUID.class)
        )).thenReturn("user");
    }

    /** Checks if any queryForObject or query invocation had a SQL string containing the given fragment. */
    private boolean hasQueryWithFragment(String fragment) {
        return mockingDetails(jdbcTemplate).getInvocations().stream()
                .filter(inv -> "queryForObject".equals(inv.getMethod().getName())
                        || "query".equals(inv.getMethod().getName()))
                .map(inv -> inv.getArgument(0, String.class))
                .anyMatch(sql -> sql.contains(fragment));
    }

    // ========== Admin role verification ==========

    @Test
    void getStats_NonAdminRole_ThrowsAdminAccessDenied() {
        mockNonAdminRole();

        assertThrows(AdminAccessDeniedException.class,
                () -> adminService.getStats(adminId));
    }

    @Test
    void getStats_AdminRole_ReturnsStats() {
        mockAdminRole();
        doReturn(0L).when(jdbcTemplate).queryForObject(anyString(), eq(Long.class));
        doReturn(0.0).when(jdbcTemplate).queryForObject(anyString(), eq(Double.class));
        doReturn(Collections.emptyList()).when(jdbcTemplate)
                .query(anyString(), any(RowMapper.class));

        AdminStatsResponse response = adminService.getStats(adminId);

        assertNotNull(response);
        assertEquals(0, response.totalUsers());
        assertEquals(0, response.activeToday());
        assertEquals(0, response.activeThisWeek());
        assertEquals(0, response.totalQuizAttempts());
        assertEquals(0, response.totalExamAttempts());
        assertEquals(0, response.totalQuizSessions());
        assertEquals(0, response.totalExamSessions());
        assertEquals(0.0, response.avgQuizScore());
        assertEquals(0.0, response.avgExamScore());
        assertEquals(0, response.examPassRate());
        assertEquals(0, response.quizCompletionRate());
        assertTrue(response.topicEngagement().isEmpty());
        assertTrue(response.dailyActiveUsers().isEmpty());
    }

    @Test
    void getStats_EmptyDb_ReturnsZeroes() {
        mockAdminRole();
        doReturn(0L).when(jdbcTemplate).queryForObject(anyString(), eq(Long.class));
        doReturn(0.0).when(jdbcTemplate).queryForObject(anyString(), eq(Double.class));
        doReturn(Collections.emptyList()).when(jdbcTemplate)
                .query(anyString(), any(RowMapper.class));

        AdminStatsResponse response = adminService.getStats(adminId);

        assertEquals(0, response.totalUsers());
        assertEquals(0, response.activeToday());
        assertEquals(0, response.activeThisWeek());
        assertEquals(0, response.totalQuizAttempts());
        assertEquals(0, response.totalExamAttempts());
        assertEquals(0, response.totalQuizSessions());
        assertEquals(0, response.totalExamSessions());
        assertEquals(0.0, response.avgQuizScore());
        assertEquals(0.0, response.avgExamScore());
        assertEquals(0, response.examPassRate());
        assertEquals(0, response.quizCompletionRate());
    }

    @Test
    void getStats_WithData_ReturnsCorrectValues() {
        mockAdminRole();

        // totalUsers
        doReturn(10L).when(jdbcTemplate).queryForObject(
                argThat(sql -> sql.contains("FROM user_profiles") && !sql.contains("DISTINCT")),
                eq(Long.class));

        // activeToday
        doReturn(3L).when(jdbcTemplate).queryForObject(
                argThat(sql -> sql.contains("DISTINCT user_id") && !sql.contains("INTERVAL")),
                eq(Long.class));

        // activeThisWeek
        doReturn(7L).when(jdbcTemplate).queryForObject(
                argThat(sql -> sql.contains("DISTINCT user_id") && sql.contains("INTERVAL")),
                eq(Long.class));

        // totalQuizAttempts
        doReturn(50L).when(jdbcTemplate).queryForObject(
                argThat(sql -> sql.contains("quiz_sessions WHERE status")),
                eq(Long.class));

        // totalExamAttempts
        doReturn(20L).when(jdbcTemplate).queryForObject(
                argThat(sql -> sql.contains("exam_sessions WHERE status")),
                eq(Long.class));

        // totalQuizSessions
        doReturn(60L).when(jdbcTemplate).queryForObject(
                argThat(sql -> sql.contains("FROM quiz_sessions") && !sql.contains("WHERE")),
                eq(Long.class));

        // totalExamSessions
        doReturn(25L).when(jdbcTemplate).queryForObject(
                argThat(sql -> sql.contains("FROM exam_sessions") && !sql.contains("WHERE")),
                eq(Long.class));

        // avgQuizScore
        doReturn(72.5).when(jdbcTemplate).queryForObject(
                argThat(sql -> sql.contains("AVG(score * 100.0 / question_count)") && !sql.contains("score_percentage")),
                eq(Double.class));

        // avgExamScore
        doReturn(68.3).when(jdbcTemplate).queryForObject(
                argThat(sql -> sql.contains("AVG(score_percentage)")),
                eq(Double.class));

        // examPassRate
        doReturn(75L).when(jdbcTemplate).queryForObject(
                argThat(sql -> sql.contains("CASE WHEN") && sql.contains("score_percentage >= 60")),
                eq(Long.class));

        // quizCompletionRate
        doReturn(80L).when(jdbcTemplate).queryForObject(
                argThat(sql -> sql.contains("CASE WHEN") && sql.contains("quiz_sessions")
                        && !sql.contains("score_percentage >= 60")),
                eq(Long.class));

        // topicEngagement
        doReturn(List.of(new TopicEngagementResponse("Fundamentals", 10, 85.0)))
                .when(jdbcTemplate).query(
                        ArgumentMatchers.<String>argThat(sql -> sql.contains("topic_name")),
                        any(RowMapper.class));

        // dailyActiveUsers
        doReturn(List.of(new DailyActiveUsersResponse("2026-07-15", 5)))
                .when(jdbcTemplate).query(
                        ArgumentMatchers.<String>argThat(sql -> sql.contains("activity_date")),
                        any(RowMapper.class));

        AdminStatsResponse response = adminService.getStats(adminId);

        assertEquals(10, response.totalUsers());
        assertEquals(3, response.activeToday());
        assertEquals(7, response.activeThisWeek());
        assertEquals(50, response.totalQuizAttempts());
        assertEquals(20, response.totalExamAttempts());
        assertEquals(60, response.totalQuizSessions());
        assertEquals(25, response.totalExamSessions());
        assertEquals(72.5, response.avgQuizScore());
        assertEquals(68.3, response.avgExamScore());
        assertEquals(75, response.examPassRate());
        assertEquals(80, response.quizCompletionRate());
        assertEquals(1, response.topicEngagement().size());
        assertEquals("Fundamentals", response.topicEngagement().get(0).topicName());
        assertEquals(1, response.dailyActiveUsers().size());
    }

    // ========== User list ==========

    @Test
    void getUsers_DefaultParams_ReturnsFirstPage() {
        mockAdminRole();

        AdminUserListResponse response = adminService.getUsers(
                adminId, null, null, null, null, null, 1, 25
        );

        assertEquals(1, response.page());
        assertEquals(25, response.pageSize());
        assertEquals(0, response.total());
        assertTrue(response.users().isEmpty());
    }

    @Test
    void getUsers_Page2_ReturnsCorrectOffset() {
        mockAdminRole();

        adminService.getUsers(adminId, null, null, null, null, null, 2, 10);

        ArgumentCaptor<Object[]> paramsCaptor = ArgumentCaptor.forClass(Object[].class);
        verify(jdbcTemplate).query(
                argThat(sql -> sql.contains("LIMIT ? OFFSET ?")),
                any(RowMapper.class),
                paramsCaptor.capture()
        );
        Object[] params = paramsCaptor.getValue();
        // offset = (page - 1) * pageSize = (2 - 1) * 10 = 10
        assertEquals(10, params[params.length - 1]);
    }

    @Test
    void getUsers_WithSearch_AddsILIKE() {
        mockAdminRole();

        adminService.getUsers(adminId, "test", null, null, null, null, 1, 25);

        assertTrue(hasQueryWithFragment("ILIKE"));
    }

    @Test
    void getUsers_WithRole_AddsFilter() {
        mockAdminRole();

        adminService.getUsers(adminId, null, "admin", null, null, null, 1, 25);

        assertTrue(hasQueryWithFragment("up.role = ?"));
    }

    @Test
    void getUsers_FilterActiveToday_AddsDateCondition() {
        mockAdminRole();

        adminService.getUsers(adminId, null, null, "active_today", null, null, 1, 25);

        assertTrue(hasQueryWithFragment("CURRENT_DATE"));
    }

    @Test
    void getUsers_FilterInactive30d_AddsInterval() {
        mockAdminRole();

        adminService.getUsers(adminId, null, null, "inactive_30d", null, null, 1, 25);

        assertTrue(hasQueryWithFragment("INTERVAL"));
    }

    @Test
    void getUsers_FilterNew7d_AddsCreatedCond() {
        mockAdminRole();

        adminService.getUsers(adminId, null, null, "new_7d", null, null, 1, 25);

        assertTrue(hasQueryWithFragment("created_at"));
    }

    @Test
    void getUsers_UnknownSort_DefaultsToLastLoginAt() {
        mockAdminRole();

        adminService.getUsers(adminId, null, null, null, "evil_injection", null, 1, 25);

        assertTrue(hasQueryWithFragment("ORDER BY up.last_login_at"));
    }

    @Test
    void getUsers_EmptyResult_ReturnsEmptyList() {
        mockAdminRole();

        AdminUserListResponse response = adminService.getUsers(
                adminId, null, null, null, null, null, 1, 25
        );

        assertTrue(response.users().isEmpty());
        assertEquals(0, response.total());
    }

    // ========== User detail ==========

    @Test
    void getUserDetail_ReturnsCompleteProfile() {
        mockAdminRole();

        AdminUserSummaryResponse summaryResponse = new AdminUserSummaryResponse(
                targetUserId, "Test User", "test@example.com", null,
                "user", "active", 150, 10, null, null
        );

        // summary query
        doReturn(summaryResponse).when(jdbcTemplate).queryForObject(
                argThat(sql -> sql.contains("WHERE up.id = ?") && sql.contains("up.id, up.display_name")),
                any(RowMapper.class),
                any(UUID.class));

        // total quizzes
        doReturn(20L).when(jdbcTemplate).queryForObject(
                argThat(sql -> sql.contains("COUNT(*)") && sql.contains("quiz_sessions")
                        && sql.contains("user_id") && !sql.contains("AND status")),
                eq(Long.class), any(UUID.class));

        // completed quizzes
        doReturn(15L).when(jdbcTemplate).queryForObject(
                argThat(sql -> sql.contains("COUNT(*)") && sql.contains("quiz_sessions")
                        && sql.contains("AND status = 'completed'")),
                eq(Long.class), any(UUID.class));

        // avg quiz score
        doReturn(75.0).when(jdbcTemplate).queryForObject(
                argThat(sql -> sql.contains("AVG(score * 100.0 / question_count)") && !sql.contains("score_percentage")),
                eq(Double.class), any(UUID.class));

        // total exams
        doReturn(8L).when(jdbcTemplate).queryForObject(
                argThat(sql -> sql.contains("COUNT(*)") && sql.contains("exam_sessions")
                        && sql.contains("user_id") && !sql.contains("AND status")),
                eq(Long.class), any(UUID.class));

        // completed exams
        doReturn(6L).when(jdbcTemplate).queryForObject(
                argThat(sql -> sql.contains("COUNT(*)") && sql.contains("exam_sessions")
                        && sql.contains("AND status = 'completed'")),
                eq(Long.class), any(UUID.class));

        // avg exam score
        doReturn(70.0).when(jdbcTemplate).queryForObject(
                argThat(sql -> sql.contains("AVG(score_percentage)")),
                eq(Double.class), any(UUID.class));

        // exam pass rate
        doReturn(83L).when(jdbcTemplate).queryForObject(
                argThat(sql -> sql.contains("CASE WHEN") && sql.contains("score_percentage >= 60")),
                eq(Long.class), any(UUID.class));

        // longest streak
        doReturn(15).when(jdbcTemplate).queryForObject(
                argThat(sql -> sql.contains("longest_streak")),
                eq(Integer.class), any(UUID.class));

        // recent activity
        doReturn(List.of(new RecentActivityResponse("quiz", "Fundamentals", 80, null)))
                .when(jdbcTemplate).query(
                        ArgumentMatchers.<String>argThat(sql -> sql.contains("'quiz' AS type")),
                        any(RowMapper.class), any(UUID.class), any(UUID.class));

        AdminUserDetailResponse response = adminService.getUserDetail(adminId, targetUserId);

        assertNotNull(response);
        assertEquals(targetUserId, response.id());
        assertEquals("Test User", response.displayName());
        assertEquals("test@example.com", response.email());
        assertEquals("user", response.role());
        assertEquals("active", response.status());
        assertEquals(150, response.totalXp());
        assertEquals(10, response.streakCount());
        assertEquals(15, response.longestStreak());
        assertEquals(20, response.totalQuizzes());
        assertEquals(15, response.completedQuizzes());
        assertEquals(75.0, response.avgQuizScore());
        assertEquals(8, response.totalExams());
        assertEquals(6, response.completedExams());
        assertEquals(70.0, response.avgExamScore());
        assertEquals(83, response.examPassRate());
        assertEquals(1, response.recentActivity().size());
        assertEquals("quiz", response.recentActivity().get(0).type());
    }

    @Test
    void getUserDetail_NotFound_ThrowsNotFound() {
        mockAdminRole();

        doReturn(null).when(jdbcTemplate).queryForObject(
                argThat(sql -> sql.contains("WHERE up.id = ?") && sql.contains("up.id, up.display_name")),
                any(RowMapper.class),
                any(UUID.class));

        assertThrows(UserProfileNotFoundException.class,
                () -> adminService.getUserDetail(adminId, targetUserId));
    }

    @Test
    void getUserDetail_NoActivity_EmptyList() {
        mockAdminRole();

        AdminUserSummaryResponse summaryResponse = new AdminUserSummaryResponse(
                targetUserId, "New User", "new@example.com", null,
                "user", "inactive", 0, 0, null, null
        );

        doReturn(summaryResponse).when(jdbcTemplate).queryForObject(
                argThat(sql -> sql.contains("WHERE up.id = ?") && sql.contains("up.id, up.display_name")),
                any(RowMapper.class),
                any(UUID.class));

        doReturn(0L).when(jdbcTemplate).queryForObject(
                argThat(sql -> sql.contains("quiz_sessions") || sql.contains("exam_sessions")),
                eq(Long.class), any(UUID.class));

        doReturn(0.0).when(jdbcTemplate).queryForObject(
                argThat(sql -> sql.contains("AVG")),
                eq(Double.class), any(UUID.class));

        doReturn(0).when(jdbcTemplate).queryForObject(
                argThat(sql -> sql.contains("longest_streak")),
                eq(Integer.class), any(UUID.class));

        doReturn(Collections.emptyList()).when(jdbcTemplate).query(
                ArgumentMatchers.<String>argThat(sql -> sql.contains("'quiz' AS type")),
                any(RowMapper.class), any(UUID.class), any(UUID.class));

        AdminUserDetailResponse response = adminService.getUserDetail(adminId, targetUserId);

        assertNotNull(response);
        assertTrue(response.recentActivity().isEmpty());
    }

    // ========== Role update ==========

    @Test
    void updateUserRole_ValidRole_UpdatesSuccessfully() {
        mockAdminRole();
        doReturn(1).when(jdbcTemplate).update(
                argThat(sql -> sql.contains("SET role")),
                eq("admin"),
                eq(targetUserId));

        assertDoesNotThrow(() -> adminService.updateUserRole(adminId, targetUserId, "admin"));
    }

    @Test
    void updateUserRole_InvalidRole_ThrowsIllegalArg() {
        mockAdminRole();

        assertThrows(IllegalArgumentException.class,
                () -> adminService.updateUserRole(adminId, targetUserId, "superadmin"));
    }

    @Test
    void updateUserRole_UserNotFound_ThrowsNotFound() {
        mockAdminRole();
        doReturn(0).when(jdbcTemplate).update(
                argThat(sql -> sql.contains("SET role")),
                eq("user"),
                eq(targetUserId));

        assertThrows(UserProfileNotFoundException.class,
                () -> adminService.updateUserRole(adminId, targetUserId, "user"));
    }

    // ========== Deactivate ==========

    @Test
    void deactivateUser_RegularUser_SetsDeactivated() {
        mockAdminRole();
        doReturn(1).when(jdbcTemplate).update(
                argThat(sql -> sql.contains("role = 'deactivated'")),
                eq(targetUserId));

        assertDoesNotThrow(() -> adminService.deactivateUser(adminId, targetUserId));
    }

    @Test
    void deactivateUser_Admin_ThrowsNotFound() {
        mockAdminRole();
        doReturn(0).when(jdbcTemplate).update(
                argThat(sql -> sql.contains("role = 'deactivated'")),
                eq(targetUserId));

        assertThrows(UserProfileNotFoundException.class,
                () -> adminService.deactivateUser(adminId, targetUserId));
    }

    @Test
    void deactivateUser_NonexistentUser_ThrowsNotFound() {
        mockAdminRole();
        doReturn(0).when(jdbcTemplate).update(
                argThat(sql -> sql.contains("role = 'deactivated'")),
                eq(targetUserId));

        assertThrows(UserProfileNotFoundException.class,
                () -> adminService.deactivateUser(adminId, targetUserId));
    }

    // ========== Reset streak ==========

    @Test
    void resetUserStreak_ResetsToZero() {
        mockAdminRole();
        doReturn(1).when(jdbcTemplate).update(
                argThat(sql -> sql.contains("streak_count = 0")),
                eq(targetUserId));

        assertDoesNotThrow(() -> adminService.resetUserStreak(adminId, targetUserId));
    }

    @Test
    void resetUserStreak_UserNotFound_ThrowsNotFound() {
        mockAdminRole();
        doReturn(0).when(jdbcTemplate).update(
                argThat(sql -> sql.contains("streak_count = 0")),
                eq(targetUserId));

        assertThrows(UserProfileNotFoundException.class,
                () -> adminService.resetUserStreak(adminId, targetUserId));
    }
}
