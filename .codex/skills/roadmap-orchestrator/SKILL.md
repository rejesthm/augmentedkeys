---
name: roadmap-orchestrator
description: Run one explicitly owner-approved AugmentedKeys milestone as a gated continuous Codex Goal. Use only when a milestone contract authorizes automatic progression across eligible tasks on a dedicated milestone branch.
---

# AugmentedKeys Roadmap Orchestrator

## Purpose

Coordinate one approved milestone from its committed task queue through `Ready for decision`, Decision Steward acceptance, guarded `main` integration, and eligible successor activation. Continue automatically only while immutable evidence and delegated authority remain valid; never convert a human-only gate into an agent decision. The Goal coordinates specialists and state; it does not implement product work itself.

This skill controls a long-running Goal. It is not a ninth specialist agent and does not replace the task-scoped Conductor.

## Required reading

Before acting, read `AGENTS.md`, `APP_SPEC.md`, `ARCHITECTURE.md`, `ROADMAP.md`, `STATE.md`, `.loop/progress.md`, `docs/orchestration/milestones/<milestone-id>_CONTRACT.md`, `docs/orchestration/milestones/<milestone-id>_LEDGER.md`, the applicable task or research queue, `gate.yaml`, `loop-budget.md`, and every control named by the selected task.

## Preflight

Stop without edits unless all conditions are true:

1. Exactly one named milestone was activated either by the owner's committed initial activation or by a committed `APPROVE_NEXT_MILESTONE` verdict for the exact successor contract.
2. The Goal objective identifies that milestone, its definition of done, and this skill.
3. The committed milestone contract identifies its exact source commit; objective; entry conditions; definition of done; ordered queue and dependencies; branch; allowed and protected paths; non-goals; verification and evidence; task-brief, ledger, and verification-artifact locations; authorized milestone-branch push; and stop conditions.
4. Every milestone entry condition is satisfied, including the exact foundation and contract commits bound by the applicable initial owner activation or successor Steward approval.
5. `main`, the milestone base, and remote ancestry are known and clean.
6. No other write task owns the selected sensitive file set.
7. The requested action is not a manual L1 Loop pass.

Create or resume only the exact milestone branch named by the contract. Before publication, use `.codex/skills/roadmap-orchestrator/scripts/validate_branch_action.sh authorize <candidate> <approved-milestone-branch> <accepted-foundation-commit>`, then let the same guard perform the constrained push. Never treat chat memory as authoritative when committed state disagrees.

## State discipline

Use only these milestone states: `Awaiting owner approval`, `Active`, `Paused for owner decision`, `Ready for decision`, and `Accepted`.

Use only these task states: `Queued`, `Eligible`, `In progress`, `In review`, `Verified`, `Blocked`, `Deferred`, and `Accepted`.

Record every state transition with date, task identifier, responsible role, source commit, evidence location, and reason. `Source commit` means the exact already-existing commit whose brief, candidate, evidence, review, or owner decision justifies the transition; it is never the self-referential commit currently writing the ledger. The Roadmap Orchestrator is the sole writer for shared milestone state. Do not update shared state while another writer owns it.

For every task, the committed ledger must also hold its exact branch, worktree path, writer, correction-round count, brief commit, candidate commit, verification-artifact path and commit, transition-evidence path and commit, reviewed integration tip, and current reason. Use explicit inactive values such as `Not created` or `Unassigned`; never leave a resumable field ambiguous.

Only the owner may reactivate a milestone paused on a human-only gate. Initial activation requires the owner's committed decision; successor activation may instead use a committed `APPROVE_NEXT_MILESTONE` verdict bound to the exact reviewed successor contract and satisfied entry conditions. A milestone moves from `Ready for decision` to `Accepted`, and its `Verified` tasks move to `Accepted`, only through a committed `APPROVE_MILESTONE` verdict.

Use these milestone transitions:

- `Awaiting owner approval` to `Active` only through a committed owner decision bound to the accepted foundation and contract commits, or for a successor through a committed `APPROVE_NEXT_MILESTONE` verdict bound to its exact independently reviewed contract and satisfied entry-condition evidence.
- `Active` to `Paused for owner decision` only through the canonical milestone-transition evidence.
- `Paused for owner decision` to `Active` only through a committed owner decision that resolves the recorded gate.
- `Active` to `Ready for decision` only through the canonical completion package after the definition of done is satisfied.
- `Ready for decision` to `Paused for owner decision` only through a committed `PAUSE_HUMAN` verdict whose exact evidence references identify the non-delegable gate.
- `Ready for decision` to `Active` only through a committed `CORRECT` verdict that identifies exact in-contract corrections. A task may be reopened from `Verified` to `In progress` only by that same recorded verdict; it receives fresh verification and independent review.
- `Ready for decision` to `Accepted` only through a committed `APPROVE_MILESTONE` verdict for the exact milestone candidate. `Accepted` is terminal as a milestone state, but its exact accepted tip may proceed through the separately authorized integration protocol below.

Use these task transitions:

- `Queued` to `Eligible` only after the exact bounded brief is committed and its SHA is known, dependencies, inputs, path authority, and evidence requirements are satisfied, and a separate ledger commit records that brief SHA. No task work may start between the brief commit and the ledger transition commit.
- `Eligible` to `In progress` only after its bounded brief is committed and one writer is assigned.
- `In progress` to `In review` only after the candidate commit and verification artifact are committed.
- `In review` to `Verified` only after all required checks and independent review pass with no Critical or Important finding.
- `In review` to `In progress` for a correction round.
- `Queued`, `Eligible`, `In progress`, or `In review` to `Blocked` or `Deferred` only with exact evidence and reason.
- `Blocked` or `Deferred` to `Eligible` only after the recorded blocker is resolved, all eligibility conditions are rechecked, a revised bounded brief is committed when needed, and any required owner decision is recorded.
- `Verified` to `Accepted` only through the committed `APPROVE_MILESTONE` verdict during milestone decision, or to `In progress` only through the `CORRECT` verdict mapped above. `Verified` has no other agent-driven outgoing transition, and `Accepted` is terminal.

## Transition barrier

Apply the same two-commit barrier whenever newly generated milestone-branch evidence justifies a state change. First commit the exact decisive artifact mapped below and resolve its SHA. Then make a separate ledger commit that records that exact SHA and performs the state transition. No task execution, integration, or later transition may occur between those commits. Decision Steward transitions add the separate three-commit evidence-branch sequence below before this ledger/state commit; the evidence binding commit is their decisive artifact.

For a milestone transition, that second commit also updates `STATE.md`, `.loop/progress.md`, only the canonical milestone status sentence in `ROADMAP.md`, and applicable status fields in `docs/research/RESEARCH_INDEX.md` to agree with the ledger. `Ready for decision` to `Accepted` requires an exact published evidence binding whose immediately preceding verdict is `APPROVE_MILESTONE` for the current package and candidate. It changes every required `Verified` task to `Accepted`, replaces the prior ledger acceptance-binding value, records the accepted tip, and appends the dated transition. On resume, verify the source binding and all five state representations agree before proceeding; if the administrative commit is missing, finish only the exact five-path semantic transition, and if representations conflict or evidence is unverifiable, record no transition and require `PAUSE_HUMAN`. Acceptance alone does not authorize a merge, push to `main`, or a later milestone.

Use this decisive-artifact map:

- `Queued` to `Eligible`: the exact contracted brief. The brief records satisfied dependencies, inputs, path authority, evidence requirements, and any prerequisite owner-decision commit.
- `Eligible` to `In progress`: the exact task transition-evidence file. It records the brief commit, assigned writer, exact task branch, exact worktree, and starting milestone tip.
- `In progress` to `In review`: the exact verification artifact. It records the candidate commit, commands, environment, results, limitations, and review requirements.
- `In review` to `In progress`: the exact task transition-evidence file. It records the review-output source, blocking findings, correction round, writer, branch, and prior candidate.
- `In review` to `Verified`: the finalized verification artifact. It records the reviewed candidate, every required review output, verdict and finding counts, affected re-verification, evidence-honesty check, and limitations.
- `Queued`, `Eligible`, `In progress`, or `In review` to `Blocked` or `Deferred`: the exact task transition-evidence file. It records the current source commits, blocker or deferral evidence, attempts, preserved branch/worktree, dependency impact, and owner decision needed.
- `Blocked` or `Deferred` to `Eligible`: the exact task transition-evidence file. It records the prior blocker, resolution evidence, rechecked eligibility, revised brief commit when applicable, and prerequisite owner-decision commit.
- `Verified` to `Accepted`, `Ready for decision` to `Active` or `Paused for owner decision`, milestone acceptance, or successor activation: the exact current Decision Steward binding commit on `governance/decision-evidence`. Its package and verdict record Steward session provenance, every bound SHA, correction scope or human gate when applicable, and remaining exclusions. Initial activation and reactivation from a human-only pause still use the exact owner-decision file.
- `Active` to `Paused for owner decision`: the exact canonical milestone-transition evidence. It records the blocking gate, affected tasks, attempts, preserved branches/worktrees, dependency impact, and requested owner decision.
- `Active` to `Ready for decision`: the exact canonical completion package. It records the definition-of-done check, every task and evidence commit, local and remote milestone hashes, reviews, limitations, deferred risks, proposed integration action, recorded `main` base, and optional successor contract package.

If execution is interrupted after a decisive-artifact commit but before its ledger commit, use the map above to inspect that exact brief, verification, task-transition, milestone-transition, completion-package, owner-decision, or current Decision Steward binding. Finish the pending transition only when one clean, unconsumed artifact commit maps unambiguously from the current state to one permitted next state and references every prerequisite commit; otherwise require `PAUSE_HUMAN` and stop without mutation. This barrier applies to every task and milestone transition above. The program controller alone writes and publishes governance evidence; the Decision Steward and reviewers remain read-only.

## Resume rules

Resume from the committed ledger before selecting new work and apply the interrupted-transition rule above before creating new evidence. First inspect the canonical milestone-transition, completion-package, and owner-decision paths, then inspect the local and remote `governance/decision-evidence` tips, the current binding, and every later unconsumed decision commit. Continue only when the evidence tips are equal, the binding is the branch tip, and its package/verdict sequence maps unambiguously from the current state to one permitted next state. A later `CORRECT`, `PAUSE_HUMAN`, result, or replacement binding supersedes the old approval; never replay an older binding. Re-resolve every bound SHA; a changed candidate, contract, completion package, review artifact, target `main`, successor contract, or entry-condition artifact requires affected fresh verification, fresh independent review, a fresh Steward verdict, and a new binding. If a task is still `Queued` but its exact contracted brief or transition-evidence path already contains one clean unconsumed commit, validate it and finish the pending ledger transition rather than creating a duplicate. For `Eligible`, confirm the committed brief and task branch before starting. For `In progress`, recover the exact branch, worktree, writer, and candidate commit; pause if any is missing or inconsistent. For `In review`, continue from the recorded candidate and verification artifact. For `Verified`, integrate only the exact reviewed commit when it is not already the milestone tip, unless a current correction verdict explicitly reopens it. Never execute a task body twice merely because chat context was lost.

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

Never publish a task branch within this workflow. Keep this milestone-branch guard milestone-only; it never authorizes `main`. Never force-push, rebase, resolve conflicts, open a pull request, auto-merge, delete branches or worktrees, create or publish tags, sign, release, deploy, or submit to a store. `main` may change only through the separate protocol below.

## Exact review chronology and candidate identities

Freeze completion candidate `C`, then have the controller launch fresh independent reviews. Record each review as its own add-only canonical review commit on `governance/decision-evidence`; each must precede and be an ancestor of its consuming package, and none may be an ancestor of `C`. Publish only complete evidence sequences through the reviewed evidence guard.

After a current `APPROVE_MILESTONE` binding accepts `C`, create at most one administrative descendant `I`. Its exact delta contains all and only `ROADMAP.md`, `STATE.md`, `.loop/progress.md`, `docs/orchestration/milestones/M0_LEDGER.md`, and status fields in `docs/research/RESEARCH_INDEX.md`. Validate complete bytes, terminal newlines, canonical `100644` modes, unique required fields, current identifiers/statuses, every R01–R10 `Verified` to `Accepted` transition, the replaced binding and accepted tip, eleven calendar-valid dated ledger rows for R01–R10 and M0, and preservation of unrelated bytes. Freeze `I`, obtain and record fresh reviews of `I`, then create a distinct main-integration package/verdict/binding exclusively on the evidence branch. Do not update shared milestone state with that approval after `I` freezes. The sequence names both `C` and `I`, their exact delta, current acceptance binding, fresh reviews, and unchanged `main`. Never substitute, collapse, or reuse approval between those identities.

Run each guard only with the required provenance environment naming the reviewed guard commit and SHA-256; runtime bytes must match the canonical executable blob at that commit even when invoked from a separate evidence or `main` worktree. Before reading contents or mutation, require a sterile integration worktree: refuse tracked changes, untracked/ignored paths, empty directories, unsafe tab/newline names, symlinks or symlink ancestors, directories in place of files, FIFOs, sockets, and other special state. No credential-copy authority exists. Retain the validated private metadata snapshot unless success or complete restoration, including absence of newly created state, is proved. A `PARTIAL` result is non-replayable, retains actual recovery evidence, and requires its own result binding and human direction.

## Milestone acceptance, main integration, and successor activation

The program controller maintains `governance/decision-evidence` in a dedicated isolated controller-owned worktree. Only the controller writes it; the Steward and reviewers remain read-only. Record the governance base in the ledger, then make its direct-child creation commit add only the same SHA at immutable `docs/orchestration/decisions/governance-base.md`. Keep every later commit single-parent; never use the branch for product work, merge, rebase, force-push, rewrite, delete, tag, or sign it. Reviews are individual add-only single-path commits. Each decision is exactly three ordered single-path commits: package, verbatim verdict with controller/Steward/session/time provenance, then current binding. Each attempted main integration is followed by a single-path result and result binding. Metadata is parsed only before the canonical begin marker. Review and guard output bodies are one canonical base64 line with required encoding, decoded-byte-length, and SHA-256 fields; validation binds the exact decoded bytes without terminal-newline normalization, even when decoded content resembles metadata or delimiters. Approval reviews have zero blocking findings. Negative packages preserve rejected evidence, explicitly missing evidence, or a `HUMAN_GATE` reason with all technically approving reviews; the human-gate form maps only to `PAUSE_HUMAN` and denied authorization. Approval package, verdict, and binding repeat the action-specific completion, `C`/`I`/acceptance-binding, or successor/entry-condition bounds; unsupported future approval kinds never authorize. Results bind consumed approval, guard output/hash, pre/post refs, recovery, and replay status. Co-committed or incomplete artifacts are invalid. Every changed path and referenced artifact is a canonical readable `100644` blob; a corrected tip cannot sanitize invalid history. Publish only complete sequences through the authoritative reviewed evidence guard with identical arguments and required guard-commit/hash provenance. A later decision or result binding supersedes the old binding, and a consumed approval is never replayable.

At `Ready for decision`, the controller commits the immutable milestone-acceptance package, launches the Decision Steward in an independent read-only session with that exact package and `docs/orchestration/DECISION_POLICY.md`, commits its exact verdict with session provenance, then commits and publishes the canonical acceptance binding. Only a current binding whose immediate verdict is `APPROVE_MILESTONE` may be consumed by the separate ledger/state transition to `Accepted`. A current `CORRECT` or `PAUSE_HUMAN` binding instead permits only its mapped state transition. When technical reviews approve but the existing pause still requires owner acceptance, use the explicit `HUMAN_GATE` negative schema and retain the zero-finding reviews; do not invent a rejection. Missing, conflicting, ambiguous, unreadable, internally inconsistent, superseded, or unverifiable evidence requires `PAUSE_HUMAN`; do not infer or repair evidence.

After milestone acceptance produces and freezes administrative candidate `I`, main integration requires fresh reviews of exact `I` and another package/verdict/binding sequence whose exact current verdict is `APPROVE_MAIN_INTEGRATION` for `I` and unchanged target `main`. Record approval only on the evidence branch; do not modify shared milestone state after the freeze. Before mutation run `.codex/skills/roadmap-orchestrator/scripts/validate_main_integration.sh authorize <milestone-branch> <integration-candidate-I> <recorded-main-base> <evidence-binding-commit>` with required authoritative guard provenance. Only if it authorizes, run `integrate` and then `verify` with identical arguments. The guard proves local/remote-equal evidence at the current binding; exact reviews/package/verdict/binding; current acceptance binding for `C`; exact `C`-to-`I` five-path semantics; readable canonical artifacts; zero blocking findings; sterile checked-out `main`; unchanged local/remote base; and fast-forward ancestry before hook-disabled `git merge --ff-only` and the explicit `refs/heads/main:refs/heads/main` push. A nonzero merge result is ordinary refusal only after exact pre-attempt refs, HEAD representation, status, pseudorefs, evidence tip, remote `main`, and sterility are restored and proved. Otherwise it is `PARTIAL` with its snapshot retained. Never run a separate raw merge or push.

After every integration attempt, the controller appends an immutable result and then a current result binding on the evidence branch and publishes them with the evidence guard. Record the exact pre/post local and remote SHAs, canonical guard argv, reviewed-guard provenance, and exact guard outputs, decision binding, environment, limitations, and recovery state. A confirmed rejection must leave both remote `main` and restored local `main` at the recorded base and refuses integration. Proved local/remote equality at the separately approved integration candidate `I` succeeds. An ambiguous result, an externally moved remote, or an unproved/restoration result is non-replayable `PARTIAL`: bind that result as current, require `PAUSE_HUMAN`, and do not retry the prior approval. Only after a proved result may a separate ledger commit record the result binding and integrated hashes.

A successor remains `Awaiting owner approval` until its exact contract is committed, independently reviewed with no unresolved Critical or Important finding, every entry condition is proved, and a separate package/verdict/binding sequence has a current `APPROVE_NEXT_MILESTONE` verdict for that exact successor. Record that binding and successor contract before the separate successor activation transition. Main integration never implies successor activation. If any bound SHA changes, repeat affected verification and review and obtain and bind a fresh verdict.

## Mandatory owner gates

Pause before:

- initial milestone activation, reactivation from a human-only pause, successor activation without exact `APPROVE_NEXT_MILESTONE`, or `main` integration without exact `APPROVE_MAIN_INTEGRATION`;
- architecture or ADR selection, adoption, or material change;
- a dependency, package, framework, asset, font, icon, sound, sample, patch, DSP, or plugin action;
- missing or conflicting license evidence;
- credentials, secrets, signing identities, entitlements, paid services, or external accounts;
- requesting or operating an unapproved physical device, MIDI controller, or audio interface;
- a path outside the milestone allowlist;
- a destructive or difficult-to-reverse action;
- an external action other than the authorized milestone-branch push, guarded append-only decision-evidence publication, or the exact guarded Steward-approved `main` integration;
- unresolved Critical or Important findings;
- evidence missing its environment or measurement method;
- a change to milestone objective, definition of done, queue semantics, or safety gates.

When a gate blocks the current task, continue only with a safe independent eligible task. Otherwise set the milestone to `Paused for owner decision` and present one concrete decision request with blocker, attempts, preserved state, options, and impact.

Scheduled tasks and heartbeat automation are prohibited for this workflow.

## Evidence honesty

Never infer smoothness, reliability, audio continuity, callback safety, device compatibility, or low latency from code inspection, Flutter tests, builds, simulators, or emulators alone. Record exact environment, configuration, device, controller, interface, measurement method, result, and limitations for every performance claim.

Do not represent planned or researched capabilities as implemented.

## Milestone completion

Set the milestone to `Ready for decision` only when every contracted task is `Verified` or `Accepted`, or when the owner has explicitly approved a contract change that removes a blocked or deferred task from the definition of done. Commit the canonical completion package first, then record its exact commit in a separate ledger transition. If no task is currently eligible but a task is `Eligible`, `In progress`, or `In review`, resume it. If a `Blocked` or `Deferred` task prevents the definition of done, commit the canonical milestone-transition evidence first, then set the milestone to `Paused for owner decision` in a separate ledger commit.

At valid completion, present completed, verified, blocked, and deferred tasks; branch and local/remote hashes; commits and changed files; research, tests, builds, measurements, and review verdicts; dependency, licensing, security, and permission changes; actual device evidence; limitations and missing evidence; and the proposed `main` integration action with rollback considerations.

At `Ready for decision`, stop task execution and request an independent Decision Steward verdict. Continue only through the exact acceptance, guarded integration, and successor-activation protocol above. No Steward verdict can cross a human-only boundary.

## Manual Loop separation

The manual L1 Loop remains report-only. It may inspect state and recommend one next task but may not invoke this skill, launch agents, create milestone or task branches, commit, push, merge, or schedule automation. No scheduled task or heartbeat may invoke the Roadmap Orchestrator.

## Canonical evidence schema

A review wrapper is controller-recorded metadata around exact reviewer-authored bytes. The decoded bytes must start at byte zero with this fixed eleven-line frame: `AUGMENTEDKEYS REVIEW ATTESTATION v1`; `Reviewed candidate`; `Reviewer role`; `Reviewer session`; `Verification evidence commit`; `Verdict`; `Critical findings`; `Important findings`; `Minor findings`; `END AUGMENTEDKEYS REVIEW ATTESTATION v1`; then one empty separator line. The free-form reviewer body follows unchanged. The attestation is part of the exact decoded byte length and SHA-256. Candidate, role, session, verification commit, verdict, and all three counts must equal the wrapper metadata and the expected review role. A missing, malformed, duplicate, or mismatched attestation fails closed. Metadata-looking and delimiter-looking text after the fixed frame remains opaque reviewer output. Reviewers must return this attestation themselves; the controller may encode and record it but must never author, repair, or reinterpret it.

Every package records exactly one `Resulting milestone state`, and its verdict and binding repeat that state and the action's decisive bounds. Milestone acceptance uses `Accepted`, binds `Accepted milestone tip` to reviewed `C`, and repeats the completion package. Main integration uses `Accepted` plus `Integration state: Pending`, and repeats the exact milestone branch, accepted `C`, integration candidate `I`, administrative paths/hash/calendar date, completion package, current acceptance binding, target `main`, and reviewed main-guard commit/path/SHA-256. Successor approval uses `Accepted` plus `Successor state: Approved for activation`, and repeats the successor contract and entry evidence. A negative sequence uses `Paused for owner decision`; package, verdict, and binding repeat `Blocking evidence status`, while the package carries the exact `MISSING`, `REJECTED`, or `HUMAN_GATE` evidence. Unknown observations never substitute for a full existing candidate commit. Each guard validates the same fields and equality relationships; a consumer must accept the publisher's minimal canonical artifact unchanged.

A main-integration result records `Guard argv` as exactly `validate_main_integration.sh|integrate|<milestone-branch>|<I>|<main-base>|<approval-binding>`. It also records the consumed approval commit/path, milestone branch, `I`, main base, reviewed guard commit/canonical path/SHA-256, execution environment, limitations, interruption point, exact base64 guard-output byte length and hash, complete pre/post local, remote, and evidence refs, recovery state, snapshot path, and replay status. The result binding repeats all of those decisive fields plus result commit/path/status. Substring command matches, invented invocations, mismatched attempts, and missing provenance never consume an approval.

Sterile main-integration inspection is NUL-safe across every tracked, untracked, and ignored name, including clean tracked names. Tab or newline names fail. The worktree `.git` entry must be a nonsymlink regular file or directory. Outside that entry, only regular files and directories are allowed; symlinks, FIFOs, sockets, character or block devices, and every other special type fail before content is read. Any inspection error fails closed.
