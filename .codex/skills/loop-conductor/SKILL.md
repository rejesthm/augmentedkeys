---
name: loop-conductor
description: Coordinate a manual AugmentedKeys M0 project-health pass. Use when asked to review project state, run the current loop, select the next task, or assess milestone readiness. Report only; do not implement product code or make protected changes.
---

# AugmentedKeys Loop Conductor

1. Read `AGENTS.md`, `APP_SPEC.md`, `ARCHITECTURE.md`, `ROADMAP.md`, `STATE.md`, `.loop/progress.md`, `LOOP.md`, `loop-budget.md`, `loop-constraints.md`, and `gate.yaml`.
2. Confirm that the active milestone and user-approved objective agree across project memory.
3. Stop if the requested action exceeds L1 report-only scope.
4. Inspect repository status and run only the verification commands allowed by `AGENTS.md` and `LOOP.md`.
5. Separate observed facts, command evidence, inferences, recommendations, blockers, and missing evidence.
6. Update only `STATE.md`, `.loop/progress.md`, and `loop-run-log.md`.
7. Recommend exactly one next highest-priority task from the approved milestone.
8. Do not launch agents, schedule automation, edit code/configuration, change dependencies, make architecture decisions, commit, push, merge, sign, release, or deploy.
9. End by requesting owner approval for the proposed next task.
