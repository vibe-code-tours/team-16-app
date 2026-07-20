package com.nerdquiz.controller;

import com.nerdquiz.dto.AdminStatsResponse;
import com.nerdquiz.dto.AdminUserDetailResponse;
import com.nerdquiz.dto.AdminUserListResponse;
import com.nerdquiz.dto.UpdateUserRoleRequest;
import com.nerdquiz.service.AdminService;
import com.nerdquiz.util.UuidUtil;
import jakarta.validation.Valid;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;
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
        Optional<UUID> userId = UuidUtil.tryParse(authentication.getName());
        if (userId.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }
        AdminStatsResponse stats = adminService.getStats(userId.get());
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
        Optional<UUID> userId = UuidUtil.tryParse(authentication.getName());
        if (userId.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }
        AdminUserListResponse users = adminService.getUsers(userId.get(), search, role, filter, sort, order, page, pageSize);
        return ResponseEntity.ok(users);
    }

    @GetMapping("/users/{id}")
    public ResponseEntity<AdminUserDetailResponse> getUserDetail(
            Authentication authentication,
            @PathVariable UUID id
    ) {
        Optional<UUID> userId = UuidUtil.tryParse(authentication.getName());
        if (userId.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }
        AdminUserDetailResponse user = adminService.getUserDetail(userId.get(), id);
        return ResponseEntity.ok(user);
    }

    @PatchMapping("/users/{id}/role")
    public ResponseEntity<Void> updateUserRole(
            Authentication authentication,
            @PathVariable UUID id,
            @Valid @RequestBody UpdateUserRoleRequest request
    ) {
        Optional<UUID> userId = UuidUtil.tryParse(authentication.getName());
        if (userId.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }
        adminService.updateUserRole(userId.get(), id, request.role());
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/users/{id}/deactivate")
    public ResponseEntity<Void> deactivateUser(
            Authentication authentication,
            @PathVariable UUID id
    ) {
        Optional<UUID> userId = UuidUtil.tryParse(authentication.getName());
        if (userId.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }
        adminService.deactivateUser(userId.get(), id);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/users/{id}/reset-streak")
    public ResponseEntity<Void> resetUserStreak(
            Authentication authentication,
            @PathVariable UUID id
    ) {
        Optional<UUID> userId = UuidUtil.tryParse(authentication.getName());
        if (userId.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }
        adminService.resetUserStreak(userId.get(), id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/users/export")
    public ResponseEntity<String> exportUsers(
            Authentication authentication,
            @RequestParam(required = false) String search,
            @RequestParam(required = false) String role,
            @RequestParam(required = false) String filter
    ) {
        Optional<UUID> userId = UuidUtil.tryParse(authentication.getName());
        if (userId.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }
        String csv = adminService.exportUsers(userId.get(), search, role, filter);
        return ResponseEntity.ok()
            .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=users-export.csv")
            .contentType(MediaType.TEXT_PLAIN)
            .body(csv);
    }
}
