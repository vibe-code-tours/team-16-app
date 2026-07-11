# Updating REQUIREMENTS.md

How to update `docs/REQUIREMENTS.md` based on the type of change.

## Table of contents

- [New feature added](#new-feature-added)
- [Feature modified](#feature-modified)
- [Scope cut](#scope-cut)
- [Scope added](#scope-added)

## New feature added

- Add it to the appropriate week section (Week 1 or Week 2) with a one-line "what done means"
- If it replaces something, move the old entry to "Explicitly out of scope" or mark it as modified

## Feature modified

- Update the "what done means" description for that feature
- If the modification changes scope (bigger or smaller), move it between Week 1/2/out-of-scope as appropriate

## Scope cut

- Move the feature from its current section to "Explicitly out of scope"
- Add a one-line reason (e.g., "Deferred — extraction too complex for Week 1")

## Scope added

- Add to the appropriate week section
- If something else needs to be cut to compensate, note the tradeoff

## Rules

- Keep descriptions to **one line**. Don't expand into detailed specs — this is GSD, not waterfall.
- Only update what the code change actually affects — don't invent requirements.
