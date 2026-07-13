#!/usr/bin/env bash
# Claude Code PreToolUse hook — intercepts `git commit` commands.
# Ensures /pr-review and /sync-reqs run before every commit.
set -euo pipefail

INPUT=$(cat)

# Extract the command from the JSON input
COMMAND=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('command',''))" 2>/dev/null || echo "")

# git commit → /pr-review only
if [[ "$COMMAND" =~ ^git[[:space:]]+commit ]]; then
  cat <<'EOF'
{
  "decision": "block",
  "reason": "⛔ Before committing, run /pr-review on staged changes.\n\nWorkflow: git add <files> → /pr-review → fix findings → git commit\n\nThe review is your green light to commit."
}
EOF
  exit 0
fi

# git push → /pr-review + /sync-reqs
if [[ "$COMMAND" =~ ^git[[:space:]]+push ]]; then
  cat <<'EOF'
{
  "decision": "block",
  "reason": "⛔ Before pushing, run both:\n\n  1. /pr-review   — automated code review on staged changes\n  2. /sync-reqs   — sync REQUIREMENTS.md, feature-board.md, and ADRs if scope changed\n\nOnly push after both pass clean.\n\nWorkflow: git add <files> → /pr-review → fix findings → git commit → /sync-reqs → git push"
}
EOF
  exit 0
fi

# Allow all other commands
echo '{"decision": "allow"}'
