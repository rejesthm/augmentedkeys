---
name: roadmap-orchestrator
description: Run one explicitly owner-approved AugmentedKeys milestone as a gated continuous Codex Goal. Use only when a milestone contract authorizes automatic progression across eligible tasks on a dedicated milestone branch.
---

# AugmentedKeys Roadmap Orchestrator

## Purpose

Coordinate one approved milestone from its committed task queue to `Ready for owner review`. Continue automatically between eligible tasks, but never convert an owner gate into an agent decision. The Goal coordinates specialists and state; it does not implement product work itself.

This skill controls a long-running Goal. It is not a ninth specialist agent and does not replace the task-scoped Conductor.

## Required reading

Before acting, read `AGENTS.md`, `APP_SPEC.md`, `ARCHITECTURE.md`, `ROADMAP.md`, `STATE.md`, `.loop/progress.md`, `docs/orchestration/milestones/<milestone-id>_CONTRACT.md`, `docs/orchestration/milestones/<milestone-id>_LEDGER.md`, the applicable task or research queue, `gate.yaml`, `loop-budget.md`, and every control named by the selected task.

## Preflight

Stop without edits unless all conditions are true:

1. The owner explicitly approved exactly one named milestone.
2. The Goal objective identifies that milestone, its definition of done, and this skill.
3. The committed milestone contract identifies its exact source commit; objective; entry conditions; definition of done; ordered queue and dependencies; branch; allowed and protected paths; non-goals; verification and evidence; task-brief, ledger, and verification-artifact locations; authorized milestone-branch push; and stop conditions.
4. Every milestone entry condition is satisfied, including the exact owner-approved foundation and contract commits.
5. `main`, the milestone base, and remote ancestry are known and clean.
6. No other write task owns the selected sensitive file set.
7. The requested action is not a manual L1 Loop pass.

Create or resume only the exact milestone branch named by the contract. Before publication, use `.codex/skills/roadmap-orchestrator/scripts/validate_branch_action.sh authorize <candidate> <approved-milestone-branch> <accepted-foundation-commit>`, then let the same guard perform the constrained push. Never treat chat memory as authoritative when committed state disagrees.

## State discipline

Use only these milestone states: `Awaiting owner approval`, `Active`, `Paused for owner decision`, `Ready for owner review`, and `Accepted`.

Use only these task states: `Queued`, `Eligible`, `In progress`, `In review`, `Verified`, `Blocked`, `Deferred`, and `Accepted`.

Record every state transition with date, task identifier, responsible role, source commit, evidence location, and reason. `Source commit` means the exact already-existing commit whose brief, candidate, evidence, review, or owner decision justifies the transition; it is never the self-referential commit currently writing the ledger. The Roadmap Orchestrator is the sole writer for shared milestone state. Do not update shared state while another writer owns it.

For every task, the committed ledger must also hold its exact branch, worktree path, writer, correction-round count, brief commit, candidate commit, verification-artifact path and commit, transition-evidence path and commit, reviewed integration tip, and current reason. Use explicit inactive values such as `Not created` or `Unassigned`; never leave a resumable field ambiguous.

Only the owner may move a milestone from `Awaiting owner approval` to `Active`, from `Ready for owner review` to `Accepted`, or reactivate a milestone paused on an owner gate. Only the owner may move a task from `Verified` to `Accepted` during milestone review.

Use these milestone transitions:

- `Awaiting owner approval` to `Active` only through a committed owner decision bound to the accepted foundation and contract commits.
- `Active` to `Paused for owner decision` only through the canonical milestone-transition evidence.
- `Paused for owner decision` to `Active` only through a committed owner decision that resolves the recorded gate.
- `Active` to `Ready for owner review` only through the canonical completion package after the definition of done is satisfied.
- `Ready for owner review` to `Active` only through a committed owner correction decision that identifies exact in-contract corrections. A task may be reopened from `Verified` to `In progress` only by that same owner decision; it receives fresh verification and independent review.
- `Ready for owner review` to `Accepted` only through a committed owner decision. `Accepted` is terminal.

Use these task transitions:

- `Queued` to `Eligible` only after the exact bounded brief is committed and its SHA is known, dependencies, inputs, path authority, and evidence requirements are satisfied, and a separate ledger commit records that brief SHA. No task work may start between the brief commit and the ledger transition commit.
- `Eligible` to `In progress` only after its bounded brief is committed and one writer is assigned.
- `In progress` to `In review` only after the candidate commit and verification artifact are committed.
- `In review` to `Verified` only after all required checks and independent review pass with no Critical or Important finding.
- `In review` to `In progress` for a correction round.
- `Queued`, `Eligible`, `In progress`, or `In review` to `Blocked` or `Deferred` only with exact evidence and reason.
- `Blocked` or `Deferred` to `Eligible` only after the recorded blocker is resolved, all eligibility conditions are rechecked, a revised bounded brief is committed when needed, and any required owner decision is recorded.
- `Verified` to `Accepted` only through a committed owner decision during milestone review, or to `In progress` only through the owner correction decision mapped above. `Verified` has no agent-driven outgoing transition, and `Accepted` is terminal.

## Transition barrier

Apply the same two-commit barrier whenever newly generated evidence justifies a state change. First commit the exact decisive artifact mapped below and resolve its SHA. Then make a separate ledger commit that records that exact SHA and performs the state transition. No task execution, integration, or later transition may occur between those commits.

For a milestone transition, that second commit also updates `STATE.md`, `.loop/progress.md`, and only the canonical M0 status sentence (the leading `Status:` sentence in the M0 section) in `ROADMAP.md` to agree with the ledger. This includes `Ready for owner review` to `Accepted` only when the first commit contains the explicit owner acceptance decision. On resume, verify the source decision and all four state representations agree before proceeding; if the second commit is missing, finish it as one scoped commit, and if the representations conflict, pause. Acceptance does not authorize a merge, push to `main`, or a later milestone.

Use this decisive-artifact map:

- `Queued` to `Eligible`: the exact contracted brief. The brief records satisfied dependencies, inputs, path authority, evidence requirements, and any prerequisite owner-decision commit.
- `Eligible` to `In progress`: the exact task transition-evidence file. It records the brief commit, assigned writer, exact task branch, exact worktree, and starting milestone tip.
- `In progress` to `In review`: the exact verification artifact. It records the candidate commit, commands, environment, results, limitations, and review requirements.
- `In review` to `In progress`: the exact task transition-evidence file. It records the review-output source, blocking findings, correction round, writer, branch, and prior candidate.
- `In review` to `Verified`: the finalized verification artifact. It records the reviewed candidate, every required review output, verdict and finding counts, affected re-verification, evidence-honesty check, and limitations.
- `Queued`, `Eligible`, `In progress`, or `In review` to `Blocked` or `Deferred`: the exact task transition-evidence file. It records the current source commits, blocker or deferral evidence, attempts, preserved branch/worktree, dependency impact, and owner decision needed.
- `Blocked` or `Deferred` to `Eligible`: the exact task transition-evidence file. It records the prior blocker, resolution evidence, rechecked eligibility, revised brief commit when applicable, and prerequisite owner-decision commit.
- `Verified` to `Accepted` or owner-requested `In progress`, milestone activation/reactivation, `Ready for owner review` to `Active`, or milestone acceptance: the exact owner-decision file. It records the owner's decision, accepted commits, correction scope when applicable, and remaining exclusions.
- `Active` to `Paused for owner decision`: the exact canonical milestone-transition evidence. It records the blocking gate, affected tasks, attempts, preserved branches/worktrees, dependency impact, and requested owner decision.
- `Active` to `Ready for owner review`: the exact canonical completion package. It records the definition-of-done check, every task and evidence commit, local and remote milestone hashes, reviews, limitations, deferred risks, and proposed integration action.

If execution is interrupted after a decisive-artifact commit but before its ledger commit, use the map above to inspect that exact brief, verification, task-transition, milestone-transition, completion-package, or owner-decision path. Finish the pending transition only when one clean, unconsumed artifact commit maps unambiguously from the current state to one permitted next state and references every prerequisite commit; otherwise pause for owner decision. This barrier applies to every task and milestone transition above. Owner decisions must first be committed at the contract's exact owner-decision path.

## Resume rules

Resume from the committed ledger before selecting new work and apply the interrupted-transition rule above before creating new evidence. First inspect the canonical milestone-transition, completion-package, and owner-decision paths for one clean unconsumed commit. If a task is still `Queued` but its exact contracted brief or transition-evidence path already contains one clean unconsumed commit, validate it and finish the pending ledger transition rather than creating a duplicate. For `Eligible`, confirm the committed brief and task branch before starting. For `In progress`, recover the exact branch, worktree, writer, and candidate commit; pause if any is missing or inconsistent. For `In review`, continue from the recorded candidate and verification artifact. For `Verified`, integrate only the exact reviewed commit when it is not already the milestone tip, unless a committed owner correction decision explicitly reopens it. Never execute a task body twice merely because chat context was lost.

## Task selection

Select the highest-priority `Queued` task only when its dependencies, path authority, inputs, and required evidence are satisfied. Write and commit its bounded brief at the exact contract path with objective, scope, non-goals, allowed files, owner, acceptance criteria, verification, evidence, and stop conditions. Resolve that brief commit, then make a separate ledger commit that records the exact SHA and moves `Queued` to `Eligible`. Treat the two commits as one guarded transition barrier: do not launch work until both exist, and use the resume rule above if interrupted between them.

Do not reorder tasks across a dependency, alter milestone outcomes, invent a missing task, or expand the approved queue. If the highest-priority task is blocked, select another independent eligible task only when doing so cannot invalidate or prejudge the blocker.

## Delegation

Give one bounded task to the existing Conductor. The Conductor may select only specialists that materially improve that task and may run at most three spawned specialists concurrently.

Parallelize independent read-heavy work. Permit only one active write task and one writer per sensitive file set. Every write task uses the contract's `task/<milestone-id>-<task-id>-<short-slug>` branch in an isolated worktree created from the current milestone branch.

Keep the implementer available through review when possible so findings return to the same writer. The Conductor's authority ends when the task is verified, blocked, or stopped.

## Verification and review

Require the exact task-specific verification and every applicable repository gate. Research must use current primary sources and separate fact, inference, recommendation, disagreement, missing evidence, and owner decision. Implementation must use test-first development when behavior is testable.

Require QA/Performance review for command, environment, device, measurement, regression, real-time, latency, and evidence claims. Require Licensing/Security review for dependencies, assets, permissions, privacy, credentials, redistribution, commercial use, or supply-chain changes. Always require fresh independent Final Code Review.

Do not integrate a task while a Critical or Important finding remains. Before integration, commit a verification artifact at the contract's canonical evidence path containing the exact candidate commit, commands, environment, results, reviewers, findings, limitations, and evidence locations. A changed task after review requires affected verification and fresh re-review.

## Correction limit

Return blocking findings to the same writer for at most five correction rounds. Each round reruns the complete affected verification and receives fresh independent review.

After five failed rounds, mark the task `Blocked`, preserve its branch and worktree, record exact evidence, and consider another independent eligible task. Never weaken tests, delete findings, widen scope, invent evidence, or bypass a gate. Never delete a branch or worktree containing material unintegrated work.

## Task integration

After approval, integrate the task sequentially into the milestone branch, using fast-forward integration when ancestry permits. Update committed state only after the reviewed task commit and its verification artifact are committed at the milestone-branch tip.

Before pushing, run `.codex/skills/roadmap-orchestrator/scripts/validate_branch_action.sh authorize <candidate> <approved-milestone-branch> <accepted-foundation-commit>`. Then run its `push` mode with the same arguments; the guard must push only the explicit `refs/heads/<approved>:refs/heads/<approved>` refspec and prove the remote hash equals the exact authorized local SHA. Afterward, run `verify` with the same arguments. Never run a separate raw `git push` in this workflow.

Never publish a task branch within this workflow. Never push or merge `main`, force-push, open a pull request, auto-merge, sign, release, deploy, or submit to a store. A different publication workflow requires a separately approved design outside this Goal.

## Mandatory owner gates

Pause before:

- a new milestone or integration into `main`;
- architecture or ADR selection, adoption, or material change;
- a dependency, package, framework, asset, font, icon, sound, sample, patch, DSP, or plugin action;
- missing or conflicting license evidence;
- credentials, secrets, signing identities, entitlements, paid services, or external accounts;
- requesting or operating an unapproved physical device, MIDI controller, or audio interface;
- a path outside the milestone allowlist;
- a destructive or difficult-to-reverse action;
- an external action other than the authorized milestone-branch push;
- unresolved Critical or Important findings;
- evidence missing its environment or measurement method;
- a change to milestone objective, definition of done, queue semantics, or safety gates.

When a gate blocks the current task, continue only with a safe independent eligible task. Otherwise set the milestone to `Paused for owner decision` and present one concrete decision request with blocker, attempts, preserved state, options, and impact.

Scheduled tasks and heartbeat automation are prohibited for this workflow.

## Evidence honesty

Never infer smoothness, reliability, audio continuity, callback safety, device compatibility, or low latency from code inspection, Flutter tests, builds, simulators, or emulators alone. Record exact environment, configuration, device, controller, interface, measurement method, result, and limitations for every performance claim.

Do not represent planned or researched capabilities as implemented.

## Milestone completion

Set the milestone to `Ready for owner review` only when every contracted task is `Verified` or `Accepted`, or when the owner has explicitly approved a contract change that removes a blocked or deferred task from the definition of done. Commit the canonical completion package first, then record its exact commit in a separate ledger transition. If no task is currently eligible but a task is `Eligible`, `In progress`, or `In review`, resume it. If a `Blocked` or `Deferred` task prevents the definition of done, commit the canonical milestone-transition evidence first, then set the milestone to `Paused for owner decision` in a separate ledger commit.

At valid completion, present completed, verified, blocked, and deferred tasks; branch and local/remote hashes; commits and changed files; research, tests, builds, measurements, and review verdicts; dependency, licensing, security, and permission changes; actual device evidence; limitations and missing evidence; and the proposed `main` integration action with rollback considerations.

Do not mark the milestone `Accepted`, integrate `main`, or start the next milestone. Those actions require explicit owner approval.

## Manual Loop separation

The manual L1 Loop remains report-only. It may inspect state and recommend one next task but may not invoke this skill, launch agents, create milestone or task branches, commit, push, merge, or schedule automation. No scheduled task or heartbeat may invoke the Roadmap Orchestrator.
