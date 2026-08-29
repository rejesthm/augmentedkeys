---
name: loop-constraints
description: Load and enforce the binding AugmentedKeys L1 report-only constraints before any project loop triage.
---

# AugmentedKeys Loop Constraints Enforcer

1. Read `loop-constraints.md`, `gate.yaml`, `LOOP.md`, and `loop-budget.md` before triage.
2. Treat every listed rule and protected path as binding.
3. Stop if the request exceeds L1 report-only scope or conflicts with a gate.
4. Permit writes only to `STATE.md`, `.loop/progress.md`, and `loop-run-log.md`.
5. Request owner direction for every stop or escalation condition.

Do not infer permission to fix, commit, push, merge, or automate from a request to run the loop.
