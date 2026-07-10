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

| Change type | Example | Documents to update |
|---|---|---|
| New feature | Built the Mistake Garden from scratch | REQUIREMENTS + feature-board + possibly ADR |
| Feature modified | Added "retry question" to Mistake Garden | REQUIREMENTS + feature-board |
| Scope cut | Dropped flashcards from Week 1 | REQUIREMENTS + feature-board |
| Scope added | Adding Subject-B extraction earlier | REQUIREMENTS + feature-board |
| Design/architecture change | Switching from REST to WebSocket for exam timer | ADR + architecture-boundaries |
| Bug fix / polish | Fixed streak timezone bug | None (no requirement change) |

If the change is a **bug fix, refactor, or polish** with no scope/design impact, say
"No requirement sync needed — this is a code-only change" and stop.

### 2. Read current documents

Read these files to understand the current state before proposing changes:

- `docs/REQUIREMENTS.md`
- `docs/gsd/feature-board.md`
- `docs/decisions/` — scan filenames to know the latest ADR number
- `docs/gsd/architecture-boundaries.md` — if the change affects shared constraints

### 3. Update REQUIREMENTS.md

Based on the change type:

**New feature added:**
- Add it to the appropriate week section (Week 1 or Week 2) with a one-line "what done means"
- If it replaces something, move the old entry to "Explicitly out of scope" or mark it as modified

**Feature modified:**
- Update the "what done means" description for that feature
- If the modification changes scope (bigger or smaller), move it between Week 1/2/out-of-scope as appropriate

**Scope cut:**
- Move the feature from its current section to "Explicitly out of scope"
- Add a one-line reason (e.g., "Deferred — extraction too complex for Week 1")

**Scope added:**
- Add to the appropriate week section
- If something else needs to be cut to compensate, note the tradeoff

Keep descriptions to **one line**. Don't expand into detailed specs — this is GSD, not waterfall.

### 4. Update feature-board.md

Update the matching row in the feature table:

- **Status:** change from "Not started" → "In progress" → "Done" as appropriate
- **Owner:** fill in if blank
- **Notes:** add any context (e.g., "simplified for Week 1", "blocked on extraction")

If a new feature was added, add a new row to the table.

### 5. Create ADR if needed

If the change involves an **architectural decision** (new technology, new integration
pattern, change to auth flow, change to DB approach), create a new ADR:

1. Determine the next ADR number from existing files in `docs/decisions/`
2. Create `docs/decisions/NNNN-<slug>.md` using the Y-statement format from ADR-0001:

```
In the context of **<situation>**, facing **<concern>**, we chose **<option>**
to achieve **<benefit>**, accepting **<tradeoff>**.
```

3. Also update `docs/gsd/architecture-boundaries.md` if the change affects shared
   constraints (new API endpoint, new table, new route, changed auth flow)

**Don't create an ADR for** purely UI-level decisions (component structure, animation
choices) or bug fixes. Only for decisions that affect how multiple developers work.

### 6. Report what was updated

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

## Important

- **Don't invent requirements.** Only update what the code change actually affects.
- **Keep it lean.** One line per change in REQUIREMENTS.md — not paragraphs.
- **Ask, don't assume.** If the change is ambiguous (is this a new feature or a
  modification?), ask the developer before updating.
- **ADR is optional.** Only create one if the change is a real architectural fork. Not
  every feature needs an ADR.
