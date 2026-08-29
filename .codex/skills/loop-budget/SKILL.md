---
name: loop-budget
description: Enforce the AugmentedKeys manual L1 report-only run limit and token budget before and after a requested project loop.
---

# AugmentedKeys Loop Budget Guard

1. Read `loop-budget.md` and the dated entries in `loop-run-log.md`.
2. Exit if a manual loop already ran today.
3. Exit if the requested run would exceed 25,000 tokens.
4. Exit on repeated failure or scope expansion.
5. Never increase or edit the budget during a loop pass.
6. Record any permitted run outcome only in `STATE.md`, `.loop/progress.md`, and `loop-run-log.md`.

Auto-fix and auto-merge are disabled. The loop must remain report-only.
