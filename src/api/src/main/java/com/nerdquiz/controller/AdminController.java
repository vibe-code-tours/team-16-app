package com.nerdquiz.controller;

import com.nerdquiz.dto.AdminStatsResponse;
import com.nerdquiz.dto.AdminUserDetailResponse;
import com.nerdquiz.dto.AdminUserListResponse;
import com.nerdquiz.dto.UpdateUserRoleRequest;
import com.nerdquiz.service.AdminService;
import jakarta.validation.Valid;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api/v1/admin")
public class AdminController {

    private final AdminService adminService;

    public AdminController(AdminService adminService) {
        this.adminService = adminService;
    }

    @GetMapping("/stats")
    public ResponseEntity<AdminStatsResponse> getStats(Authentication authentication) {
        UUID userId = UUID.fromString(authentication.getName());
        AdminStatsResponse stats = adminService.getStats(userId);
        return ResponseEntity.ok(stats);
    }

    @GetMapping("/users")
    public ResponseEntity<AdminUserListResponse> getUsers(
            Authentication authentication,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "25") int pageSize,
            @RequestParam(required = false) String search,
            @RequestParam(required = false) String role,
            @RequestParam(required = false) String filter,
            @RequestParam(defaultValue = "last_login_at") String sort,
            @RequestParam(defaultValue = "desc") String order
    ) {
        UUID userId = UUID.fromString(authentication.getName());
        AdminUserListResponse users = adminService.getUsers(userId, search, role, filter, sort, order, page, pageSize);
        return ResponseEntity.ok(users);
    }

    @GetMapping("/users/{id}")
    public ResponseEntity<AdminUserDetailResponse> getUserDetail(
            Authentication authentication,
            @PathVariable UUID id
    ) {
        UUID userId = UUID.fromString(authentication.getName());
        AdminUserDetailResponse user = adminService.getUserDetail(userId, id);
        return ResponseEntity.ok(user);
    }

    @PatchMapping("/users/{id}/role")
    public ResponseEntity<Void> updateUserRole(
            Authentication authentication,
            @PathVariable UUID id,
            @Valid @RequestBody UpdateUserRoleRequest request
    ) {
        UUID userId = UUID.fromString(authentication.getName());
        adminService.updateUserRole(userId, id, request.role());
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/users/{id}/deactivate")
    public ResponseEntity<Void> deactivateUser(
            Authentication authentication,
            @PathVariable UUID id
    ) {
        UUID userId = UUID.fromString(authentication.getName());
        adminService.deactivateUser(userId, id);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/users/{id}/reset-streak")
    public ResponseEntity<Void> resetUserStreak(
            Authentication authentication,
            @PathVariable UUID id
    ) {
        UUID userId = UUID.fromString(authentication.getName());
        adminService.resetUserStreak(userId, id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/users/export")
    public ResponseEntity<String> exportUsers(
            Authentication authentication,
            @RequestParam(required = false) String search,
            @RequestParam(required = false) String role,
            @RequestParam(required = false) String filter
    ) {
        UUID userId = UUID.fromString(authentication.getName());
        String csv = adminService.exportUsers(userId, search, role, filter);
        return ResponseEntity.ok()
            .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=users-export.csv")
            .contentType(MediaType.TEXT_PLAIN)
            .body(csv);
    }
}
