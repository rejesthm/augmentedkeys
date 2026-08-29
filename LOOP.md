# AugmentedKeys Manual Loop

## Active loop

- Pattern: `daily-triage`
- Level: L1 report-only
- Schedule: manual only
- Trigger: an explicit owner request to run the loop

## Required inputs

Read `AGENTS.md`, `APP_SPEC.md`, `ARCHITECTURE.md`, `ROADMAP.md`, `STATE.md`, `.loop/progress.md`, `loop-budget.md`, `loop-constraints.md`, and `gate.yaml` before triage.

## Permitted work

Inspect project memory, repository status, and the verification evidence permitted by the project controls. Separate observed facts, command evidence, inferences, recommendations, blockers, and missing evidence.

The only writable outputs are:

- `STATE.md`
- `.loop/progress.md`
- `loop-run-log.md`

Recommend exactly one next task from the active, owner-approved milestone and request owner approval before any task begins.

## Early exit

If there is no material state change, record a no-op report within the writable state files and exit without proposing new work.

## Escalation and stop conditions

Stop and request owner direction before any:

- code or configuration change;
- dependency action;
- architecture decision;
- failed verification;
- credential or hardware need;
- licensing uncertainty; or
- destructive action.

Do not launch agents, schedule automation, implement fixes, commit, push, merge, sign, release, or deploy during a loop pass.
