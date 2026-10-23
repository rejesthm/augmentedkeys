# M0 Decision Steward Decisions

This milestone-branch file is the status and recovery index for future M0 Decision Steward activity. Canonical runtime packages, verdicts, and current bindings live only under `docs/orchestration/decisions/m0/` on the dedicated append-only `governance/decision-evidence` branch. The program controller alone writes and publishes that branch from its isolated worktree; the Steward and reviewers remain read-only.

## Initial status at creation

- Decision-evidence branch: `Not created`
- Decision-evidence governance base: `Not yet recorded`
- Current evidence binding: `Not yet decided`
- Milestone decision: `Not yet decided`
- Main integration decision: `Not yet decided`
- Successor activation decision: `Not yet decided`
- Steward decision commit: `Not yet decided`
- Accepted milestone tip: `Not yet decided`
- Recorded target `main`: `Not yet decided`
- Successor contract commit: `Not yet decided`
- Reason: M0 remains `Paused for owner decision` on G01 pending successful permission-isolated runtime evidence, required independent reviews, and valid reactivation.

Future status entries are appended as numbered `DS-NNN` sections after a canonical evidence sequence is published. Each records the exact package, verdict, binding, local/remote evidence tip, controller recorder, Steward role/session, timestamp, consumed state transition, and recovery status. Never rewrite this initial snapshot or a later status entry. Each canonical decision sequence is three ordered commits—immutable package, verbatim Steward verdict, current binding—and a later binding supersedes every earlier approval. A changed bound SHA requires affected fresh review and a new sequence.
