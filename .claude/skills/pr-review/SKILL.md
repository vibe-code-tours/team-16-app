---
name: pr-review
description: Automated code review on staged changes — checks conventions, security, correctness, and test coverage
---

# Skill: PR Review

Run this before every commit to catch issues early. Reviews only what is staged
(`git diff --staged`), so stage your files first.

## Procedure

### 1. Get the staged diff

Run `git diff --staged` to get the exact changes about to be committed. If the diff
is empty, tell the developer nothing is staged and stop.

### 2. Identify which stack is affected

Check which paths are touched in the diff:

| Path prefix | Stack | Reference file |
|---|---|---|
| `src/api/**` | Spring Boot backend | [references/backend.md](references/backend.md) |
| `src/web/**` | React frontend | [references/frontend.md](references/frontend.md) |
| `supabase/**` | Database | [references/backend.md](references/backend.md) §Database |
| `docs/**` | Documentation | — |
| `.claude/**` | Tooling | — |

Always load [references/security.md](references/security.md) for security checks.

### 3. Run the review checklist

Load the relevant reference file(s) based on step 2. Check every item in those
references. Only report items that actually have problems — don't list passing checks.

### 4. Report findings

Format the output as a structured list. If no issues found:

```
✅ Review passed — no findings. Ready to commit.
```

If issues found, list them grouped by category:

```
🔴 BLOCKING (must fix before commit):
  [file:line] Finding description

🟡 WARNING (fix if possible, justify if not):
  [file:line] Finding description

ℹ️  INFO (suggestion, not blocking):
  [file:line] Finding description
```

End with a summary:

```
Review complete: N blocking, M warnings, K info
```

### 5. If blocking findings exist

The developer must fix them and re-run `/pr-review`. A commit should only happen
when there are zero blocking findings.

## Reference files

- **[references/backend.md](references/backend.md)** — Java/Spring Boot code quality and naming
- **[references/frontend.md](references/frontend.md)** — React/TypeScript code quality and naming
- **[references/security.md](references/security.md)** — Secrets, credentials, auth, data protection

## Notes

- This review covers **code quality and conventions**. It does NOT replace human review
  for architectural decisions (schema changes, new endpoints, auth flow).
- See `.claude/rules/git-workflow.md` for when a teammate review is still required.
- The review scope is limited to the staged diff — not the entire codebase.
