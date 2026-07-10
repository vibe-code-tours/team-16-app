# Git workflow

Applies to: all files

## Branching

- `main` — production-ready, never push directly.
- `feature/<name>` — one feature per branch, named clearly: `feature/mistake-garden`, `feature/exam-simulation`.
- `fix/<name>` — bug fixes.
- Branch from `main`, merge back via PR.

## Code review (automated)

Run `/pr-review` on your staged changes **before every commit**. This is the primary
quality gate — it checks conventions, security, correctness, and test coverage against
the rules in `.claude/rules/`.

**Workflow:**

```
git add <files>
/sync-reqs             # update REQUIREMENTS.md + feature-board.md if scope changed
/pr-review             # Claude reviews staged diff + doc sync
# fix any findings
git commit             # only commit after review passes clean
git push
gh pr create           # open PR
```

- **No findings → commit.** The review is your green light.
- **Findings exist → fix them first**, then re-run `/pr-review` until clean.
- Don't commit code with unresolved review findings.
- The `/pr-review` output replaces the need for a manual teammate review on routine changes.

**When a teammate review IS still needed:**
- Changes to the database schema (new migrations, column changes)
- New or modified API endpoints
- Auth flow changes
- New shared dependencies
- Anything touching `docs/gsd/architecture-boundaries.md` constraints

For these, open the PR and tag the relevant person — the automated review caught the
code quality; the human review catches the architectural impact.

## Pull requests

- One logical change per PR — don't bundle unrelated work.
- Fill in the PR template: what changed, why, how to test.
- Squash merge to keep `main` history clean.

## Commits

- Write clear commit messages: `feat: add mistake garden review flow`, `fix: correct streak calculation on timezone boundary`.
- Conventional commits preferred (`feat:`, `fix:`, `docs:`, `chore:`, `refactor:`, `test:`).
- Don't commit generated files (`node_modules/`, `build/`, `.gradle/`).
- Don't commit `.env` or real secrets — ever.

## Conflict resolution

- Pull `main` into your feature branch before opening a PR if it's been a while.
- Resolve conflicts locally, don't use GitHub's merge editor for anything non-trivial.

## Code ownership

- Check `CODEOWNERS` for who reviews what.
- If your change touches a domain you don't own, tag the owner for review.
