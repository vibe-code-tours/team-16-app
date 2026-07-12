#!/usr/bin/env bash
# Sync-reqs check — verifies docs are updated when source code changes.
# Returns exit code 0 if in sync, 1 if docs need updating.
set -euo pipefail

STAGED=$(git diff --staged --name-only)
if [ -z "$STAGED" ]; then
  echo "✅ Nothing staged."
  exit 0
fi

FINDINGS=()

# Check if src/ files changed but docs weren't updated
SRC_CHANGED=$(echo "$STAGED" | grep -E "^(src/api/|src/web/)" | head -1 || true)
DOCS_UPDATED=$(echo "$STAGED" | grep -E "^(docs/REQUIREMENTS\.md|docs/gsd/feature-board\.md)" | head -1 || true)
DECISION_UPDATED=$(echo "$STAGED" | grep -E "^docs/decisions/" | head -1 || true)

if [ -n "$SRC_CHANGED" ] && [ -z "$DOCS_UPDATED" ]; then
  # Check if this looks like a feature change (not just a bug fix)
  FEATURE_CHANGE=$(git diff --staged --stat -- src/ 2>/dev/null | grep -E "[0-9]+ files? changed" | grep -vE ",\s*1\s+insertion" | head -1 || true)
  if [ -n "$FEATURE_CHANGE" ]; then
    FINDINGS+=("🟡 WARNING: src/ changed but docs/REQUIREMENTS.md and docs/gsd/feature-board.md were not updated")
    FINDINGS+=("   Run /sync-reqs to check if docs need updating")
  fi
fi

# Check if migration changed but feature-board wasn't
MIGRATION_CHANGED=$(echo "$STAGED" | grep -E "^supabase/migrations/" | head -1 || true)
if [ -n "$MIGRATION_CHANGED" ] && [ -z "$DOCS_UPDATED" ]; then
  FINDINGS+=("🟡 WARNING: Database migration changed — verify docs/gsd/feature-board.md is up to date")
fi

# Report
if [ ${#FINDINGS[@]} -eq 0 ]; then
  echo "✅ Docs in sync."
  exit 0
fi

echo ""
echo "═══════════════════════════════════════════"
echo "  Sync-reqs: ${#FINDINGS[@]} findings"
echo "═══════════════════════════════════════════"
echo ""
for finding in "${FINDINGS[@]}"; do
  echo "  $finding"
done
echo ""
echo "  Run /sync-reqs to update docs, then re-stage and commit."
echo "  Or skip checks: git commit --no-verify"
echo "═══════════════════════════════════════════"
echo ""

exit 0
