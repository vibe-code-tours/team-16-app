# Definition of Done

## A feature is "done" for Week 1 (Local Demo) when:

- [ ] It works end-to-end (no placeholder/mock data in the flow)
- [ ] It's tested (happy path at minimum, edge cases where critical)
- [ ] `/sync-reqs` ran if the feature scope/design changed (REQUIREMENTS.md + feature-board.md current)
- [ ] `/pr-review` passed clean with zero blocking findings before every commit
- [ ] Schema/API/auth changes got a teammate review (per `git-workflow.md`)
- [ ] It merges to `main` without breaking CI
- [ ] It works on a phone browser (360px+ width)
- [ ] The developer added a brief note to the PR describing what they built

## A feature is "done" for Week 2 (Public Demo) when:

- [ ] All Week 1 criteria are met
- [ ] Error states are handled (loading, empty, error — not just the happy path)
- [ ] UI is polished (consistent spacing, no raw text, proper typography)
- [ ] Edge cases are tested (0 questions, expired session, network failure)
- [ ] It's been demoed to at least one teammate for a walkthrough

## What "not done" looks like

- "It works on my machine" but hasn't been reviewed
- Placeholder data that looks real (other devs will mistake it for implementation)
- A feature that only works if you click in a specific order
- No tests at all (even a single happy-path test counts)

## Weekly milestones

| Week | Milestone | What to show |
|---|---|---|
| **Week 1** | Local demo | All core features functional on localhost. Login → map → quiz → mistakes → exam sim. |
| **Week 2** | Public demo | Deployed to a public URL. Polished UI, stretch goals attempted, mobile-ready. |

## Integration checkpoints

- **End of Day 3 (Week 1):** Backend serves question data, frontend renders learning map. If this isn't working, de-scope and pair up.
- **End of Day 7 (Week 1):** Full flow works locally (login through exam sim). This is the local demo gate.
- **End of Day 10 (Week 2):** Deployed to public URL. This is the public demo gate.
