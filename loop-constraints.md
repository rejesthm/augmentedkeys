# AugmentedKeys Loop Constraints

These rules are binding for every loop pass.

## Scope

- Operate only at L1 report-only during M0.
- Run only after an explicit owner request and at most once per day.
- Update only `STATE.md`, `.loop/progress.md`, and `loop-run-log.md`.
- Recommend exactly one next task from the active, owner-approved milestone.
- Request owner approval before that task begins.

## Prohibited actions

- Do not launch agents or schedule automation.
- Do not edit code, configuration, protected paths, dependencies, architecture decisions, or research conclusions.
- Do not auto-fix, commit, push, merge, sign, release, or deploy.
- Do not increase the loop budget.

## Stops

Stop for any code or configuration change, dependency action, architecture decision, failed verification, credentials or hardware need, licensing uncertainty, destructive action, repeated failure, scope expansion, or conflict with `gate.yaml`.
