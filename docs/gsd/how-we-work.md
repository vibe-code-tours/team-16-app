# How We Work — GSD (Get Stuff Done)

## The approach

We don't write full specs before coding. Each developer owns their feature end-to-end:

1. **You get a feature goal** — a one-line description of what to build
2. **You figure out the details** — use AI tools, research, think
3. **You plan your approach** — schema, API, components
4. **You build it** — with AI assistance
5. **You sync docs** — `/sync-reqs` to update REQUIREMENTS.md + feature-board.md
6. **You review & commit** — `/pr-review` → fix findings → commit
7. **You sync with the team** — short check-ins to avoid conflicts

## Expectations

- **Be resourceful** — don't wait for someone to hand you answers
- **Use AI tools** — Claude Code, ChatGPT, Copilot
- **Make decisions** — if unclear, decide and move forward
- **Communicate** — if your decision affects someone else, sync first
- **Keep docs current** — run `/sync-reqs` when scope or design changes

## Communication

- Daily standup: 15 min — what did you do, what's blocking you
- Slack/Discord for quick questions
- Automated review (`/pr-review`) is the primary quality gate; teammate review only for schema/API/auth changes

## Key docs

| Document | Purpose |
|---|---|
| [Feature Board](feature-board.md) | Who owns what |
| [Architecture Boundaries](architecture-boundaries.md) | Shared constraints (API, DB, auth) |
| [Decision Log](decision-log.md) | Open votes pending team decision |
| [Definition of Done](definition-of-done.md) | What "done" means per week |
| `docs/decisions/` | ADRs for resolved architectural decisions |
