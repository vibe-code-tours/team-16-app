# NerdQuiz Database Schema

> Source: `supabase/migrations/001_initial_schema.sql`

## AUTH_USERS

| Column | Type | Constraint |
|---|---|---|
| id | uuid | PK |

## PROFILES

| Column | Type | Constraint |
|---|---|---|
| user_id | uuid | PK, FK → auth.users |
| display_name | text | |
| avatar_url | text | |
| timezone | text | |
| created_at | datetime | |
| updated_at | datetime | |

## TOPICS

| Column | Type | Constraint |
|---|---|---|
| id | uuid | PK |
| name | text | |
| slug | text | UK |
| description | text | |
| display_order | int | |
| published | bool | |

## SUBTOPICS

| Column | Type | Constraint |
|---|---|---|
| id | uuid | PK |
| topic_id | uuid | FK → topics |
| name | text | |
| slug | text | |
| display_order | int | |
| published | bool | |

## LESSONS

| Column | Type | Constraint |
|---|---|---|
| id | uuid | PK |
| subtopic_id | uuid | FK → subtopics |
| title | text | |
| slug | text | |
| content_blocks | json | |
| estimated_minutes | int | |
| xp_reward | int | |
| published | bool | |

## LESSON_PREREQUISITES

| Column | Type | Constraint |
|---|---|---|
| lesson_id | uuid | PK, FK → lessons |
| prerequisite_lesson_id | uuid | PK, FK → lessons |

## USER_LESSON_PROGRESS

| Column | Type | Constraint |
|---|---|---|
| user_id | uuid | PK, FK → auth.users |
| lesson_id | uuid | PK, FK → lessons |
| status | text | |
| started_at | datetime | |
| completed_at | datetime | |
| updated_at | datetime | |

## QUESTIONS

| Column | Type | Constraint |
|---|---|---|
| id | uuid | PK |
| subtopic_id | uuid | FK → subtopics |
| exam_session | text | |
| subject | text | |
| question_number | int | |
| question_text | text | |
| content_blocks | json | |
| choices | json | |
| correct_answer | text | |
| answer_key | json | |
| images | json | |
| ref_doc | json | |
| difficulty_score | decimal | |
| published | bool | |

## QUESTION_SUBTOPICS

| Column | Type | Constraint |
|---|---|---|
| question_id | uuid | PK, FK → questions |
| subtopic_id | uuid | PK, FK → subtopics |
| is_primary | bool | |
| confidence | decimal | |
| classification_source | text | |

## QUIZ_SESSIONS

| Column | Type | Constraint |
|---|---|---|
| id | uuid | PK |
| user_id | uuid | FK → auth.users |
| subtopic_id | uuid | FK → subtopics |
| lesson_id | uuid | FK → lessons |
| quiz_type | text | |
| question_count | int | |
| completed_question_count | int | |
| target_difficulty | decimal | |
| score | int | |
| xp_earned | int | |
| status | text | |

## QUIZ_SESSION_QUESTIONS

| Column | Type | Constraint |
|---|---|---|
| quiz_session_id | uuid | PK, FK → quiz_sessions |
| question_id | uuid | FK → questions |
| sequence_number | int | PK |

## QUIZ_ANSWERS

| Column | Type | Constraint |
|---|---|---|
| id | uuid | PK |
| quiz_session_id | uuid | FK → quiz_sessions |
| question_id | uuid | FK → questions |
| sequence_number | int | |
| user_answer | text | |
| is_correct | bool | |
| response_time_ms | int | |
| difficulty_at_answer | decimal | |

## EXAMS

| Column | Type | Constraint |
|---|---|---|
| id | uuid | PK |
| exam_session | text | |
| subject | text | |
| title | text | |
| question_count | int | |
| time_limit_minutes | int | |
| initial_hearts | int | |
| published | bool | |

## EXAM_QUESTIONS

| Column | Type | Constraint |
|---|---|---|
| exam_id | uuid | PK, FK → exams |
| question_id | uuid | FK → questions |
| sequence_number | int | PK |

## EXAM_SESSIONS

| Column | Type | Constraint |
|---|---|---|
| id | uuid | PK |
| user_id | uuid | FK → auth.users |
| exam_id | uuid | FK → exams |
| total_questions | int | |
| correct_answers | int | |
| score_percentage | decimal | |
| initial_hearts | int | |
| hearts_remaining | int | |
| time_limit_minutes | int | |
| expires_at | datetime | |
| status | text | |

## EXAM_ANSWERS

| Column | Type | Constraint |
|---|---|---|
| id | uuid | PK |
| exam_session_id | uuid | FK → exam_sessions |
| question_id | uuid | FK → questions |
| sequence_number | int | |
| user_answer | text | |
| is_correct | bool | |
| response_time_ms | int | |

## EXAM_HEART_EVENTS

| Column | Type | Constraint |
|---|---|---|
| id | uuid | PK |
| exam_session_id | uuid | FK → exam_sessions |
| question_id | uuid | FK → questions |
| delta | int | |
| reason | text | |
| created_at | datetime | |

## USER_STATS

| Column | Type | Constraint |
|---|---|---|
| user_id | uuid | PK, FK → auth.users |
| total_xp | int | |
| current_streak | int | |
| longest_streak | int | |
| last_active_date | date | |
| quizzes_completed | int | |
| exams_completed | int | |
| total_questions_answered | int | |
| total_correct | int | |

## XP_EVENTS

| Column | Type | Constraint |
|---|---|---|
| id | uuid | PK |
| user_id | uuid | FK → auth.users |
| amount | int | |
| event_type | text | |
| source_id | uuid | |
| idempotency_key | text | UK |
| created_at | datetime | |

## USER_DAILY_ACTIVITY

| Column | Type | Constraint |
|---|---|---|
| user_id | uuid | PK, FK → auth.users |
| activity_date | date | PK |
| questions_answered | int | |
| xp_earned | int | |

## USER_SUBTOPIC_MASTERY

| Column | Type | Constraint |
|---|---|---|
| user_id | uuid | PK, FK → auth.users |
| subtopic_id | uuid | PK, FK → subtopics |
| mastery_score | decimal | |
| ability_score | decimal | |
| questions_seen | int | |
| questions_correct | int | |
| last_practiced_at | datetime | |
| updated_at | datetime | |

## MISTAKES

| Column | Type | Constraint |
|---|---|---|
| id | uuid | PK |
| user_id | uuid | FK → auth.users |
| question_id | uuid | FK → questions |
| source | text | |
| source_session_id | uuid | |
| last_user_answer | text | |
| mistake_count | int | |
| review_count | int | |
| first_missed_at | datetime | |
| last_missed_at | datetime | |
| next_review_at | datetime | |
| resolved_at | datetime | |

## MISTAKE_REVIEWS

| Column | Type | Constraint |
|---|---|---|
| id | uuid | PK |
| mistake_id | uuid | FK → mistakes |
| user_answer | text | |
| is_correct | bool | |
| confidence | int | |
| reviewed_at | datetime | |

## FLASHCARDS

| Column | Type | Constraint |
|---|---|---|
| id | uuid | PK |
| subtopic_id | uuid | FK → subtopics |
| source_question_id | uuid | FK → questions |
| front_blocks | json | |
| back_blocks | json | |
| published | bool | |

## USER_FLASHCARD_STATE

| Column | Type | Constraint |
|---|---|---|
| user_id | uuid | PK, FK → auth.users |
| flashcard_id | uuid | PK, FK → flashcards |
| due_at | datetime | |
| interval_days | decimal | |
| ease_factor | decimal | |
| repetitions | int | |
| last_rating | int | |
| last_reviewed_at | datetime | |

## FLASHCARD_REVIEWS

| Column | Type | Constraint |
|---|---|---|
| id | uuid | PK |
| user_id | uuid | FK → auth.users |
| flashcard_id | uuid | FK → flashcards |
| rating | int | |
| previous_interval_days | decimal | |
| next_interval_days | decimal | |
| reviewed_at | datetime | |
