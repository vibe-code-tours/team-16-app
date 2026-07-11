---
name: sync-reqs
description: Sync feature changes from staged code to REQUIREMENTS.md, feature-board.md, and create ADRs when needed
---

# Skill: Sync Requirements

Run this after building or modifying a feature when the change affects scope, design,
or requirements. It keeps `REQUIREMENTS.md`, `feature-board.md`, and `docs/decisions/`
in sync with what was actually built.

Run **before** `/pr-review` and commit.

## Procedure

### 1. Detect what changed

Run `git diff --staged` and `git diff --staged --name-only` to see what files changed
and how. If the diff is empty, tell the developer nothing is staged and stop.

Identify the **type of change**:

| Change type | Example | Reference file |
|---|---|---|
| New feature | Built the Mistake Garden from scratch | [references/requirements.md](references/requirements.md) + [references/feature-board.md](references/feature-board.md) + possibly [references/adr.md](references/adr.md) |
| Feature modified | Added "retry question" to Mistake Garden | [references/requirements.md](references/requirements.md) + [references/feature-board.md](references/feature-board.md) |
| Scope cut | Dropped flashcards from Week 1 | [references/requirements.md](references/requirements.md) + [references/feature-board.md](references/feature-board.md) |
| Scope added | Adding Subject-B extraction earlier | [references/requirements.md](references/requirements.md) + [references/feature-board.md](references/feature-board.md) |
| Design/architecture change | Switching from REST to WebSocket for exam timer | [references/adr.md](references/adr.md) + architecture-boundaries |
| Bug fix / polish | Fixed streak timezone bug | None (no requirement change) |

If the change is a **bug fix, refactor, or polish** with no scope/design impact, say
"No requirement sync needed — this is a code-only change" and stop.

### 2. Read current documents

Read these files to understand the current state before proposing changes:

- `docs/REQUIREMENTS.md`
- `docs/gsd/feature-board.md`
- `docs/decisions/` — scan filenames to know the latest ADR number
- `docs/gsd/architecture-boundaries.md` — if the change affects shared constraints

### 3. Apply updates

Load the relevant reference files based on step 1 and follow their procedures:

- **REQUIREMENTS.md** → [references/requirements.md](references/requirements.md)
- **feature-board.md** → [references/feature-board.md](references/feature-board.md)
- **ADR** → [references/adr.md](references/adr.md)

### 4. Report what was updated

Show the developer exactly what changed:

```
✅ Requirements synced:

📄 REQUIREMENTS.md
  - [Feature X] moved from Week 2 → Week 1 (simplified scope)
  - [Feature Y] added to "Out of scope" (deferred to post-demo)

📋 feature-board.md
  - [Feature X] status: Not started → Done, owner: Aung

📝 ADR-0007 created: <title>
  - <one-line summary of the decision>
```

If nothing needed updating (bug fix, refactor), say so clearly.

## Reference files

- **[references/requirements.md](references/requirements.md)** — how to update REQUIREMENTS.md by change type
- **[references/feature-board.md](references/feature-board.md)** — how to update feature-board.md
- **[references/adr.md](references/adr.md)** — when and how to create Architecture Decision Records

## Important

- **Don't invent requirements.** Only update what the code change actually affects.
- **Keep it lean.** One line per change in REQUIREMENTS.md — not paragraphs.
- **Ask, don't assume.** If the change is ambiguous (is this a new feature or a
  modification?), ask the developer before updating.
- **ADR is optional.** Only create one if the change is a real architectural fork. Not
  every feature needs an ADR.
