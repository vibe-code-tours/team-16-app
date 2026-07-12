# Creating Architecture Decision Records (ADRs)

When and how to create ADRs in `docs/decisions/`.

## Table of contents

- [When to create an ADR](#when-to-create-an-adr)
- [When NOT to create an ADR](#when-not-to-create-an-adr)
- [How to create an ADR](#how-to-create-an-adr)

## When to create an ADR

Create an ADR when the change involves an **architectural decision**:

- New technology or library adopted
- New integration pattern (e.g., REST → WebSocket)
- Change to auth flow
- Change to database approach
- New API endpoint structure
- New shared dependency
- Anything touching `docs/gsd/architecture-boundaries.md` constraints

## When NOT to create an ADR

Don't create an ADR for:

- Purely UI-level decisions (component structure, animation choices)
- Bug fixes
- Refactors with no design change
- Features that follow existing patterns

Not every feature needs an ADR. Only create one when the change is a real architectural fork.

## How to create an ADR

1. Determine the next ADR number from existing files in `docs/decisions/`
2. Create `docs/decisions/NNNN-<slug>.md` using the Y-statement format from ADR-0001:

```markdown
# ADR-NNNN: <title>

## Status

Accepted

## Context

<what situation are we in?>

## Decision

In the context of **<situation>**, facing **<concern>**, we chose **<option>**
to achieve **<benefit>**, accepting **<tradeoff>**.

## Consequences

- <what becomes easier>
- <what becomes harder>
- <what risks are introduced>
```

3. Also update `docs/gsd/architecture-boundaries.md` if the change affects shared
   constraints (new API endpoint, new table, new route, changed auth flow)
