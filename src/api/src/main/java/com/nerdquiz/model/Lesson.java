package com.nerdquiz.model;

import jakarta.persistence.*;
import java.util.UUID;

@Entity
@Table(name = "lessons")
public class Lesson {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "subtopic_id", nullable = false)
    private UUID subtopicId;

    @Column(nullable = false)
    private String title;

    @Column(nullable = false)
    private String slug;

    @Column(columnDefinition = "TEXT")
    private String summary;

    @Column(name = "content_blocks", nullable = false, columnDefinition = "jsonb")
    private String contentBlocks = "[]";

    @Column(name = "estimated_minutes", nullable = false)
    private Integer estimatedMinutes = 3;

    @Column(name = "xp_reward", nullable = false)
    private Integer xpReward = 0;

    @Column(name = "display_order", nullable = false)
    private Integer displayOrder = 0;

    @Column(nullable = false)
    private Boolean published = false;

    public Lesson() {}

    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }

    public UUID getSubtopicId() { return subtopicId; }
    public void setSubtopicId(UUID subtopicId) { this.subtopicId = subtopicId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getSlug() { return slug; }
    public void setSlug(String slug) { this.slug = slug; }

    public String getSummary() { return summary; }
    public void setSummary(String summary) { this.summary = summary; }

    public String getContentBlocks() { return contentBlocks; }
    public void setContentBlocks(String contentBlocks) { this.contentBlocks = contentBlocks; }

    public Integer getEstimatedMinutes() { return estimatedMinutes; }
    public void setEstimatedMinutes(Integer estimatedMinutes) { this.estimatedMinutes = estimatedMinutes; }

    public Integer getXpReward() { return xpReward; }
    public void setXpReward(Integer xpReward) { this.xpReward = xpReward; }

    public Integer getDisplayOrder() { return displayOrder; }
    public void setDisplayOrder(Integer displayOrder) { this.displayOrder = displayOrder; }

    public Boolean getPublished() { return published; }
    public void setPublished(Boolean published) { this.published = published; }
}
