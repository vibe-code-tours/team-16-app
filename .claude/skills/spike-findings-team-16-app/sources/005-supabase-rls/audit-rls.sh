#!/bin/bash
# Spike 005: Supabase RLS Audit Script
#
# Audits migration files for Row Level Security configuration.
# Checks that all user-data tables have RLS enabled and proper policies.
#
# Run: bash audit-rls.sh

PROJECT_ROOT="$(cd ../../.. && pwd)"
MIGRATIONS_DIR="$PROJECT_ROOT/supabase/migrations"
PASS=0
FAIL=0
WARN=0

check() {
  local desc="$1" result="$2"
  if [ "$result" = "pass" ]; then
    echo "  ✓ $desc"
    PASS=$((PASS + 1))
  elif [ "$result" = "warn" ]; then
    echo "  ⚠ $desc"
    WARN=$((WARN + 1))
  else
    echo "  ✗ $desc"
    FAIL=$((FAIL + 1))
  fi
}

echo ""
echo "━━━ Spike 005: Supabase RLS Audit ━━━"
echo ""
echo "Project root: $PROJECT_ROOT"
echo "Migrations: $MIGRATIONS_DIR"
echo ""

# --- Check 1: Migrations directory exists ---
echo "Test 1: Migrations directory"
if [ -d "$MIGRATIONS_DIR" ]; then
  MIGRATION_COUNT=$(ls "$MIGRATIONS_DIR"/*.sql 2>/dev/null | wc -l)
  check "Migrations directory exists ($MIGRATION_COUNT SQL files)" "pass"
else
  check "Migrations directory exists" "fail"
  echo ""
  echo "━━━ Audit stopped: no migrations directory ━━━"
  exit 1
fi

# --- Check 2: RLS enabled on tables ---
echo ""
echo "Test 2: RLS ENABLE TABLE policies"

# User-data tables that SHOULD have RLS
USER_TABLES=("user_profiles" "user_lesson_progress" "user_mistakes" "quiz_sessions" "quiz_answers" "exam_sessions" "exam_answers" "user_xp" "user_streaks")

for table in "${USER_TABLES[@]}"; do
  # Check if table is created in any migration
  TABLE_EXISTS=$(grep -ril "CREATE TABLE.*$table" "$MIGRATIONS_DIR"/*.sql 2>/dev/null | head -1)
  if [ -z "$TABLE_EXISTS" ]; then
    check "Table '$table' — not found in migrations (may not exist yet)" "warn"
    continue
  fi

  # Check if RLS is enabled
  RLS_ENABLED=$(grep -ril "ALTER TABLE.*$table.*ENABLE ROW LEVEL SECURITY\|ENABLE ROW LEVEL SECURITY.*$table" "$MIGRATIONS_DIR"/*.sql 2>/dev/null | head -1)
  if [ -n "$RLS_ENABLED" ]; then
    check "Table '$table' — RLS enabled ✓" "pass"
  else
    check "Table '$table' — RLS NOT enabled ✗" "fail"
  fi
done

# --- Check 3: Public tables (should have read-only access) ---
echo ""
echo "Test 3: Public table access"

PUBLIC_TABLES=("questions" "topics" "topic_categories" "lessons" "exam_sessions_metadata")

for table in "${PUBLIC_TABLES[@]}"; do
  TABLE_EXISTS=$(grep -ril "CREATE TABLE.*$table" "$MIGRATIONS_DIR"/*.sql 2>/dev/null | head -1)
  if [ -z "$TABLE_EXISTS" ]; then
    check "Public table '$table' — not found (may not exist yet)" "warn"
    continue
  fi

  # Check for public read policy
  PUBLIC_POLICY=$(grep -ril "CREATE POLICY.*$table.*SELECT\|CREATE POLICY.*$table.*ALL.*true\|FOR ALL.*$table.*USING.*true" "$MIGRATIONS_DIR"/*.sql 2>/dev/null | head -1)
  if [ -n "$PUBLIC_POLICY" ]; then
    check "Public table '$table' — has public read policy ✓" "pass"
  else
    check "Public table '$table' — no public read policy (may block legitimate access)" "warn"
  fi
done

# --- Check 4: RLS policies use auth.uid() ---
echo ""
echo "Test 4: RLS policies use auth.uid()"

POLICY_COUNT=$(grep -ril "CREATE POLICY" "$MIGRATIONS_DIR"/*.sql 2>/dev/null | wc -l)
AUTH_UID_COUNT=$(grep -ril "auth.uid()" "$MIGRATIONS_DIR"/*.sql 2>/dev/null | wc -l)

if [ "$POLICY_COUNT" -gt 0 ]; then
  echo "  Found $POLICY_COUNT migration files with CREATE POLICY"
  echo "  Found $AUTH_UID_COUNT migration files referencing auth.uid()"
  if [ "$AUTH_UID_COUNT" -gt 0 ]; then
    check "At least some policies use auth.uid() for user matching ✓" "pass"
  else
    check "No policies use auth.uid() — may not restrict by user" "fail"
  fi
else
  check "No CREATE POLICY statements found in migrations" "warn"
fi

# --- Check 5: Service role key separation ---
echo ""
echo "Test 5: Service role key separation"

# Check that service role key is not in frontend code
FRONTEND_DIR="$PROJECT_ROOT/src/web"
if [ -d "$FRONTEND_DIR" ]; then
  SERVICE_KEY_IN_FRONTEND=$(grep -ril "SERVICE_ROLE\|service_role\|serviceRole" "$FRONTEND_DIR/src/" 2>/dev/null | head -1)
  if [ -z "$SERVICE_KEY_IN_FRONTEND" ]; then
    check "No service role key in frontend code ✓" "pass"
  else
    check "SERVICE ROLE KEY found in frontend code: $SERVICE_KEY_IN_FRONTEND ✗" "fail"
  fi
else
  check "Frontend directory not found" "warn"
fi

# Check that anon key is used (not service role) in Supabase client
ANON_KEY_USAGE=$(grep -ril "SUPABASE_ANON_KEY\|VITE_SUPABASE_ANON_KEY\|anon" "$FRONTEND_DIR/src/" 2>/dev/null | wc -l)
if [ "$ANON_KEY_USAGE" -gt 0 ]; then
  check "Frontend uses anon key (not service role) ✓" "pass"
else
  check "Could not verify anon key usage in frontend" "warn"
fi

# --- Check 6: RLS not disabled anywhere ---
echo ""
echo "Test 6: RLS not disabled"

DISABLE_RLS=$(grep -ril "DISABLE ROW LEVEL SECURITY\|FORCE ROW LEVEL SECURITY" "$MIGRATIONS_DIR"/*.sql 2>/dev/null | head -1)
if [ -z "$DISABLE_RLS" ]; then
  check "No DISABLE ROW LEVEL SECURITY found ✓" "pass"
else
  check "RLS DISABLED in: $DISABLE_RLS ✗" "fail"
fi

# --- Summary ---
echo ""
echo "━━━ Audit Results: $PASS passed, $FAIL failed, $WARN warnings ━━━"
echo ""

if [ "$FAIL" -gt 0 ]; then
  echo "⚠ Security issues found — review failed checks above"
  exit 1
elif [ "$WARN" -gt 0 ]; then
  echo "⚠ Warnings found — review above, may need manual verification"
  exit 0
else
  echo "✓ All checks passed"
  exit 0
fi
