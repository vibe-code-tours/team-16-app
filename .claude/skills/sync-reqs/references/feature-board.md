# Updating feature-board.md

How to update `docs/gsd/feature-board.md` when features change.

## Procedure

Update the matching row in the feature table:

- **Status:** change from "Not started" → "In progress" → "Done" as appropriate
- **Owner:** fill in if blank
- **Notes:** add any context (e.g., "simplified for Week 1", "blocked on extraction")

If a new feature was added, add a new row to the table.

## Status values

| Status | Meaning |
|---|---|
| Not started | Feature is planned but no work done |
| In progress | Someone is actively working on it |
| Done | Feature is complete and merged |
| Blocked | Can't proceed — dependent on something else |
| Deferred | Moved to later scope |

## Rules

- Only update rows that correspond to actual code changes.
- Don't change ownership without confirming with the developer.
