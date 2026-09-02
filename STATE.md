# AugmentedKeys State

## Current milestone

M0 — Research & Architecture

Milestone state: `Active`

## Milestone orchestration

The M0 Goal belongs to Codex task `01a04c45-76d8-7ef0-9cb4-101dbe82a224`; milestone execution is active after source-backed G01 correction validation and independent approval.

- Milestone branch: `milestone/m0-research`.
- Milestone worktree: `/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-research`.
- Accepted foundation: `b1b0c1edd5e42d3ea791f665c22954834e962d05`.
- Accepted contract-changing commit: `13b864f09ca083d10910bcffa4432b81c040bda9`.
- Owner activation decision: `e9eb4043ec4009dc88c20f7b6c3f9d658f18f48c`, OD-001 in `docs/orchestration/milestones/m0/evidence/owner-decisions.md`.
- Owner reactivation decision: `5e870b5dc39aee60a8d8a32ca78d1e55dc980cea`, OD-005 in `docs/orchestration/milestones/m0/evidence/owner-decisions.md`.
- Canonical recovery state: `docs/orchestration/milestones/M0_LEDGER.md`.
- Historical pause evidence: `998fb53884f986154e1238ea3d76539adc565b70`, MT-001 in `docs/orchestration/milestones/m0/evidence/milestone-transitions.md`.

## High priority

1. R01 is `In review` in correction round 1 at corrected candidate `ef640cf0644b41de99302441ff539d7293443b57` and verification evidence `dca892713555f229887fd8522e47e3533fe1d10c`.
2. Run fresh QA/Performance and Licensing/Security reviews through separate role-isolated read-only relays. Run Final Code Review only if both return zero Critical and zero Important findings.
3. Use only the validated role-isolated relay topology; do not retry a nested mixed-permission launch.
4. Stop at non-delegable owner gates and at the completed M0 package; do not begin M1.

## Watch list

- The Roadmap Orchestrator owns only this approved M0 milestone.
- Only guarded publication of `milestone/m0-research` is authorized; no task-branch or `main` publication, main integration, or PR.
- Only the contract's allowlisted research, evidence, and state paths may change.
- Architecture/ADRs, dependencies/assets, credentials, hardware, licensing uncertainty, destructive work, releases, unsupported evidence, and unresolved Critical or Important findings remain owner-gated.
- No product-core, UI, native-host, or device work is authorized.
- Smoothness and low latency require real-device measurement; research and setup checks are not performance evidence.

## Last run

OD-005 keeps M0 active under the validated role-isolated topology. The same Conductor produced corrected candidate `ef640cf0644b41de99302441ff539d7293443b57`; exact verification evidence is `dca892713555f229887fd8522e47e3533fe1d10c`, and T08 at `aa5a97222a5fd2c7b46a7a8912fd9be6a5bafc01` moves R01 into fresh review. R02–R10 remain Queued. No product/core change, dependency action, hardware action, performance measurement, integration, publication, or manual L1 Loop occurred.
