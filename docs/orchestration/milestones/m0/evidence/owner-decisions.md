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

## OD-002 — Bounded G01 launch recovery

- Recorded: 2026-08-31, Asia/Manila.
- Decision owner: repository owner in the same Codex conversation.
- Responsible recorder: Roadmap Orchestrator (`/root`).
- Source: the owner's reply to the request for approval to correct and verify agent-launch permissions before research resumes.
- Exact owner statement:

> continue please. what's next?

- Interpretation stated to the owner before acting: permission for the bounded launch correction and validation; research remains paused until the permission checks pass. This is not quoted as a more specific statement than the owner actually made.
- Accepted foundation remains `b1b0c1edd5e42d3ea791f665c22954834e962d05`; accepted contract remains `0d86705ca130fcc3bdb73a9acf3f21fd803912dd`, unchanged.
- Recorded gate: G01 at `411e9ff73b1390ed1c95c24c8c09cc284c63645e`; pause evidence MT-001 at `998fb53884f986154e1238ea3d76539adc565b70`; paused state at `6da91d7520a0473127a6529bda94d54daac4dac4`.

### Bounded scope

Test a command-line-only correction which removes the live `-s workspace-write` override and supplies the parent's existing workspace-write setting through the configuration layer (`-c 'sandbox_mode="workspace-write"'`). This is a hypothesis, not a passing result. Do not edit global/project configuration, role files, skills, contract, app code or dependencies. Do not use bypass flags or broaden the required role permissions.

Use saved runtime evidence to verify the actual Conductor remains `gpt-5.6-sol` / `high` / workspace-write and each configured reader remains its declared model/effort / read-only. First test the preserved Conductor's recovery and a fresh configured Researcher with no-write diagnostic instructions. Only after that passes, validate the QA/Performance, Licensing/Security and fresh Final Code Reviewer boundaries and obtain independent recovery review. Never infer an effective permission from a TOML file or inherited context alone.

The diagnostic task permits no research-body execution, file edits by probe agents, commits by probe agents, package or asset action, hardware, permission escalation, publication, or external mutation. Root alone records allowlisted evidence and shared state. Preserve every original failure, branch, saved writer and unreviewed source note. Stop the probe if its expected permission boundary fails; do not convert a mismatch into permission to work.

### State and continuation

This decision authorizes recovery work, not a claim that G01 is resolved. M0 stays `Paused for owner decision` and R01 stays `Blocked` during diagnostics. Research can continue only after effective-permission evidence and independent review resolve G01, the owner-decision resolution is committed, and the required separate milestone/task state barriers are completed. Any necessary expansion beyond this bounded invocation correction requires new owner direction. Main integration, M1, architecture adoption, product/core/UI/native work, hardware, dependencies, automation, credentials and other existing gates remain excluded.

## OD-003 — Project-only sandbox-default correction

- Decision date: 2026-09-01, Asia/Manila.
- Decision owner: repository owner in the same Codex conversation.
- Responsible recorder: Roadmap Orchestrator (`/root`).
- Decision source: the owner's reply to the explicit request to set a read-only default in the project's `.codex/config.toml` and re-test agent permissions while leaving global settings and individual agent settings unchanged.
- Exact owner statement:

> approved

- Accepted foundation remains `b1b0c1edd5e42d3ea791f665c22954834e962d05`; accepted M0 contract remains `0d86705ca130fcc3bdb73a9acf3f21fd803912dd`, unchanged.
- Pre-correction milestone tip: `86fac7a614e40490de264b3d736e8936cd9233bd`.
- Prior recovery decision: OD-002 at `4a8349000864b2f06dbe62a287c5a4378e0bd278`; failed invocation-only evidence: `6e0f00b8ba860b53b6d9e412e25c7e06ebed4ca4`.

### Exact authority

Add only `sandbox_mode = "read-only"` as the project-level default in `.codex/config.toml`. Do not change global configuration or any individual agent file. Do not add a CLI sandbox override. First retain the existing failure as the RED baseline, then test whether the effective fresh relay is read-only, the actual configured Conductor remains `gpt-5.6-sol` / `high` / workspace-write, and its actual configured Researcher is `gpt-5.6-terra` / `high` / read-only.

If those boundaries pass, validate the applicable QA/Performance, Licensing/Security and fresh Final Code Reviewer as actual configured read-only roles and preserve their literal results and source-backed effective contexts. No diagnostic agent may edit files, commit, resume R01 research, launch hardware, change configuration/permissions, or perform an external mutation. Root alone may make the approved configuration edit and write allowlisted recovery evidence/state.

### Limits and next gate

This is a separately approved setup correction outside the M0 research allowlist. It does not change the M0 objective, queue, contract or safety gates and does not authorize another configuration file, role/skill change, global setting, product/core/UI/native code, dependency, hardware, credentials, publication, main integration or M1.

This decision authorizes correction and validation only. It is not advance acceptance that G01 is resolved and does not itself reactivate M0 or R01. M0 remains `Paused for owner decision` and R01 remains `Blocked` until the evidence passes, independent review has no unresolved Critical or Important finding, and a later committed owner reactivation decision plus the required separate milestone/task state barriers are completed.
