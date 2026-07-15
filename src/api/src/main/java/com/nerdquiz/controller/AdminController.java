package com.nerdquiz.controller;

import com.nerdquiz.dto.AdminStatsResponse;
import com.nerdquiz.service.AdminService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
}
