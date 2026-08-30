# M0 Owner Decisions

## OD-001 — Foundation acceptance and M0 activation

- Decision date: 2026-08-30, Asia/Manila.
- Decision owner: repository owner, through the current Codex conversation.
- Responsible recorder: Roadmap Orchestrator (`/root`).
- Decision source: the owner's message immediately following the displayed foundation, contract, queue, scope, publication boundaries, definition of done, and activation request.
- Accepted foundation: `b1b0c1edd5e42d3ea791f665c22954834e962d05`.
- Accepted contract-changing commit: `0d86705ca130fcc3bdb73a9acf3f21fd803912dd`.
- Contract: `docs/orchestration/milestones/M0_CONTRACT.md`, version 1, unchanged.
- Authorized transition: M0 `Awaiting owner approval` to `Active`.

### Exact owner statement

> I accept the repository foundation and approve M0 activation using the Gated Roadmap Orchestrator.

### Authority and limits

This accepts the named repository foundation and authorizes exactly one M0 Goal, the `milestone/m0-research` branch, and eligible R01–R10 research tasks under the unchanged contract and `.codex/skills/roadmap-orchestrator/SKILL.md`. It does not authorize a different foundation, a later contract version, M1, architecture or ADR adoption, dependencies or assets, product/UI/native code, device operations, credentials/signing, releases, automation, task-branch publication, or merging/pushing `main`.

Only the contract's deterministic guard may publish the exact milestone branch. Every task requires its canonical brief, evidence, transitions, applicable specialist review, and independent final review. All non-delegable owner gates remain in force. This approval supplies no device, compatibility, reliability, audio-continuity, real-time-safety, or low-latency evidence.

### Activation preflight evidence

The controller read the operating constitution, product and architecture boundaries, roadmap, state/progress, contract, ledger, queue, gate/budget, task template, license ledger, and applicable testing/device/real-time controls. No other Goal or active specialist writer existed at preflight. All ten research tasks were `Queued`; canonical M0 decision/transition/task artifacts and the milestone branch were absent before activation setup.

Read-only checks at accepted foundation `b1b0c1edd5e42d3ea791f665c22954834e962d05` confirmed:

- Local `main` and `origin/main` both resolved to the accepted foundation; both existing worktrees were clean.
- `git ls-remote --exit-code -- git@github.com:rejesthm/augmentedkeys.git refs/heads/main` returned `b1b0c1edd5e42d3ea791f665c22954834e962d05` for `refs/heads/main`.
- `git log -1 --format=%H -- docs/orchestration/milestones/M0_CONTRACT.md` returned the accepted contract-changing commit.
- The final setup review recorded APPROVE with zero Critical, Important, and Minor findings; the separate state review also approved. Existing source-backed setup evidence is retained in `.git/worktrees/roadmap-orchestrator/roadmap-orchestrator-validation` in the repository's common Git directory.
- The M0 Goal was created in Codex task `01a04c45-76d8-7ef0-9cb4-101dbe82a224` with the exact accepted commits, full M0 definition of done, skill, boundaries, and owner gates. No token budget was requested or invented.
- `git worktree add -b milestone/m0-research /Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-research b1b0c1edd5e42d3ea791f665c22954834e962d05` created the isolated milestone checkout. The existing ignored `.worktrees/` location was verified; no separate user task or cleanup was created.

### Fresh worktree baseline

- Started: `2026-08-30T15:14:34+0800`.
- Tested commit: `b1b0c1edd5e42d3ea791f665c22954834e962d05`.
- Environment: arm64 macOS 26.6.1 (25G76), Flutter 3.44.8 stable (framework `058e0af2c2`), Dart 3.12.2.
- Device/simulator/emulator: Not applicable; host-side scaffold checks only.
- Configuration: existing repository constraints; no package upgrade, build, app launch, audio/MIDI workload, sample rate, buffer configuration, or physical-device procedure.
- `flutter pub get`: exit 0.
- `dart format --output=none --set-exit-if-changed .`: exit 0; `Formatted 2 files (0 changed)`.
- `flutter analyze`: exit 0; `No issues found!`.
- `flutter test`: exit 0; one widget test, `shows the truthful M0 foundation status`, passed.
- `git diff --check`, clean-worktree check, and unchanged accepted-HEAD check: exit 0; `M0_WORKTREE_BASELINE=PASS`.
- Warning retained: `7 packages have newer versions incompatible with dependency constraints.` The notices concern clock, matcher, material_color_utilities, meta, stack_trace, test_api, and vector_math. No versions were upgraded.
- Evidence source: exact command output retained in the current Codex conversation; this committed record identifies the commands, tested state, environment, results, warnings, and limitations.
- Recorder/reviewer of these baseline outputs: Roadmap Orchestrator (`/root`); this is not a substitute for independent research-task review.

### Two-commit barrier

This decision must be committed first. A separate next commit must record this decision commit's SHA and transition the M0 ledger, `STATE.md`, `.loop/progress.md`, and only the leading M0 status sentence in `ROADMAP.md` together to `Active`. No research or task execution may occur between those two commits. The contract itself remains unchanged; this committed owner decision supplies its activation authority.

### Evidence-retention correction — activation review round 1

The round-0 activation review rejected the bookkeeping because the fresh baseline output was not retained at a durable artifact location; it did not report a test failure. The original command and both output chunks have now been recovered from the source conversation and preserved in `docs/orchestration/milestones/m0/evidence/activation-baseline.md`, with exact source ordinals, fixed-prefix hash, environment, exit code, and warnings. This is the original 15:14:34 run, not a newly performed run. The original rejected review and its source-backed literal reply remain in `activation-review.md` and `activation-review-provenance.md` in the same evidence directory. This addendum changes no owner statement, accepted commit, authority, state transition, or performance claim; independent correction re-review is pending.
