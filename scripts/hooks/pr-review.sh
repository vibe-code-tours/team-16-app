#!/usr/bin/env bash
# Automated PR review checks — runs on staged files before commit.
# Returns exit code 0 if clean, 1 if findings exist.
set -euo pipefail

STAGED=$(git diff --staged --name-only)
if [ -z "$STAGED" ]; then
  echo "✅ Nothing staged."
  exit 0
fi

FINDINGS=()
BLOCKING=0
WARNINGS=0

# --- Security: secrets in staged files ---
SECRET_PATTERNS=(
  'sk-[a-zA-Z0-9]{20,}'
  'api[_-]?key\s*[:=]\s*["\x27][a-zA-Z0-9]{20,}'
  'AKIA[0-9A-Z]{16}'
  'ghp_[a-zA-Z0-9]{36}'
  'xoxb-[a-zA-Z0-9-]+'
  'SUPABASE_SERVICE_ROLE_KEY\s*[:=]\s*["\x27][a-zA-Z0-9]{20,}'
  'password\s*[:=]\s*["\x27][^"\x27]{8,}'
  'client_secret\s*[:=]\s*["\x27][a-zA-Z0-9]{20,}'
  'JWT_SECRET\s*[:=]\s*["\x27][a-zA-Z0-9]{20,}'
  '-----BEGIN (RSA |EC )?PRIVATE KEY-----'
)

for file in $STAGED; do
  [ -f "$file" ] || continue
  # Skip binary files and node_modules
  [[ "$file" == node_modules/* ]] && continue
  [[ "$file" == *.gradle ]] && continue

  for pattern in "${SECRET_PATTERNS[@]}"; do
    MATCHES=$(git diff --staged -U0 "$file" 2>/dev/null | grep -iE "^\+" | grep -E "$pattern" | head -5 || true)
    if [ -n "$MATCHES" ]; then
      FINDINGS+=("🔴 BLOCKING: $file — possible hardcoded secret")
      BLOCKING=$((BLOCKING + 1))
      break
    fi
  done
done

# --- Security: .env files ---
for file in $STAGED; do
  if [[ "$file" == .env ]] || [[ "$file" == .env.* ]]; then
    FINDINGS+=("🔴 BLOCKING: $file — .env file must not be committed")
    BLOCKING=$((BLOCKING + 1))
  fi
done

# --- Security: service role key in frontend ---
for file in $STAGED; do
  if [[ "$file" == src/web/* ]]; then
    MATCHES=$(git diff --staged -U0 "$file" 2>/dev/null | grep -iE "^\+" | grep -i "SERVICE_ROLE" | head -3 || true)
    if [ -n "$MATCHES" ]; then
      FINDINGS+=("🔴 BLOCKING: $file — SUPABASE_SERVICE_ROLE_KEY in frontend code")
      BLOCKING=$((BLOCKING + 1))
    fi
  fi
done

# --- Backend: check for common issues ---
for file in $STAGED; do
  [[ "$file" == src/api/*.java ]] || continue

  # @Autowired on fields
  MATCHES=$(git diff --staged -U0 "$file" 2>/dev/null | grep -E "^\+.*@Autowired" | grep -v "constructor" | head -3 || true)
  if [ -n "$MATCHES" ]; then
    FINDINGS+=("🟡 WARNING: $file — use constructor injection, not @Autowired on fields")
    WARNINGS=$((WARNINGS + 1))
  fi

  # Generic Exception catch
  MATCHES=$(git diff --staged -U0 "$file" 2>/dev/null | grep -E "^\+.*catch\s*\(\s*Exception\s" | head -3 || true)
  if [ -n "$MATCHES" ]; then
    FINDINGS+=("🟡 WARNING: $file — catch specific exceptions, not generic Exception")
    WARNINGS=$((WARNINGS + 1))
  fi
done

# --- Frontend: check for common issues ---
for file in $STAGED; do
  [[ "$file" == src/web/*.tsx ]] || continue

  # Inline styles
  MATCHES=$(git diff --staged -U0 "$file" 2>/dev/null | grep -E '^\+.*style=\{\{' | head -3 || true)
  if [ -n "$MATCHES" ]; then
    FINDINGS+=("🟡 WARNING: $file — use Tailwind classes, not inline style={{}")
    WARNINGS=$((WARNINGS + 1))
  fi

  # any type
  MATCHES=$(git diff --staged -U0 "$file" 2>/dev/null | grep -E "^\+.*:\s*any\b" | grep -v "//.*any" | head -3 || true)
  if [ -n "$MATCHES" ]; then
    FINDINGS+=("🟡 WARNING: $file — avoid 'any' type, use explicit types")
    WARNINGS=$((WARNINGS + 1))
  fi
done

# --- Database: check naming conventions ---
for file in $STAGED; do
  [[ "$file" == supabase/migrations/*.sql ]] || continue

  # CamelCase table names
  MATCHES=$(git diff --staged -U0 "$file" 2>/dev/null | grep -iE "^\+.*CREATE\s+TABLE\s+" | grep -E "[A-Z][a-z]+[A-Z]" | head -3 || true)
  if [ -n "$MATCHES" ]; then
    FINDINGS+=("🟡 WARNING: $file — table names should be snake_case, not camelCase")
    WARNINGS=$((WARNINGS + 1))
  fi
done

# --- Report ---
if [ ${#FINDINGS[@]} -eq 0 ]; then
  echo "✅ Review passed — no findings."
  exit 0
fi

echo ""
echo "═══════════════════════════════════════════"
echo "  PR Review: ${#FINDINGS[@]} findings"
echo "═══════════════════════════════════════════"
echo ""
for finding in "${FINDINGS[@]}"; do
  echo "  $finding"
done
echo ""
echo "  🔴 $BLOCKING blocking | 🟡 $WARNINGS warnings"
echo ""
echo "  Fix findings, then run: git add <files> && git commit"
echo "  Or skip checks: git commit --no-verify"
echo "═══════════════════════════════════════════"
echo ""

if [ $BLOCKING -gt 0 ]; then
  exit 1
fi
exit 0
