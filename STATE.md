# AugmentedKeys State

## Current milestone

M0 — Research & Architecture

Milestone state: `Paused for owner decision`

## Milestone orchestration

The M0 Goal belongs to Codex task `01a04c45-76d8-7ef0-9cb4-101dbe82a224`; milestone execution is paused on runtime permission gate G01.

- Milestone branch: `milestone/m0-research`.
- Milestone worktree: `/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-research`.
- Accepted foundation: `b1b0c1edd5e42d3ea791f665c22954834e962d05`.
- Accepted contract-changing commit: `0d86705ca130fcc3bdb73a9acf3f21fd803912dd`.
- Owner activation decision: `e9eb4043ec4009dc88c20f7b6c3f9d658f18f48c`, OD-001 in `docs/orchestration/milestones/m0/evidence/owner-decisions.md`.
- Canonical recovery state: `docs/orchestration/milestones/M0_LEDGER.md`.
- Pause evidence: `998fb53884f986154e1238ea3d76539adc565b70`, MT-001 in `docs/orchestration/milestones/m0/evidence/milestone-transitions.md`.

## High priority

1. R01 is Blocked on runtime permission gate G01, recorded in `411e9ff73b1390ed1c95c24c8c09cc284c63645e`; its run is stopped and task branch unchanged.
2. OD-003's approved project-only sandbox experiment also failed G01: the relay became read-only, but so did the configured Conductor. Evidence and rollback: `39fa64bfe4fc34e99207148fd6d1465cf0eb98ee`; candidate `2c1a3d7d235120d96d8cca36d6908afad007d806`; restored configuration `c0aa7967d2b7bc9f783a8bd2c339ffe3598f62fc`.
3. Do not try another nested mixed-permission launch. Three correction designs failed; a role-isolated orchestration redesign requires owner-approved governance scope before implementation.
4. Stop at non-delegable owner gates and at the completed M0 package; do not begin M1.

## Watch list

- The Roadmap Orchestrator owns only this approved M0 milestone.
- Only guarded publication of `milestone/m0-research` is authorized; no task-branch or `main` publication, main integration, or PR.
- Only the contract's allowlisted research, evidence, and state paths may change.
- Architecture/ADRs, dependencies/assets, credentials, hardware, licensing uncertainty, destructive work, releases, unsupported evidence, and unresolved Critical or Important findings remain owner-gated.
- No product-core, UI, native-host, or device work is authorized.
- Smoothness and low latency require real-device measurement; research and setup checks are not performance evidence.

## Last run

The owner accepted the foundation and authorized M0 through OD-001. Activation bookkeeping passed independent correction review. M0 remains Paused for owner decision through MT-001; R01 is Blocked and R02–R10 remain Queued. OD-002's launch-only approaches made the Researcher workspace-write. OD-003's project read-only default made the relay read-only but also made the configured Conductor read-only, so the chain stopped before Researcher/reviewer dispatch. The exact candidate was reverted and project configuration matches the pre-OD-003 content. No research task or manual L1 Loop has been completed; no report candidate or core change was produced. Branches, stopped writer identity and evidence are preserved locally.
