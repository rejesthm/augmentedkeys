# AugmentedKeys Decision Steward Design

Date: 2026-09-01
Status: Owner-approved design; decision-evidence topology corrected in Task 2 fix round 1

## Decision summary

AugmentedKeys will add a ninth durable project agent named `decision_steward`. The Steward may approve completed milestones, authorize guarded fast-forward integration into `main`, and approve activation of the next committed milestone contract without returning to the owner for routine approval.

The authority is policy-bound rather than unlimited. It applies only to reversible, evidence-backed work inside the committed roadmap and milestone contract. The Steward cannot approve credentials or secrets, spending or legal commitments, public releases or store submissions, destructive or irreversible external actions, missing evidence, unresolved Critical or Important findings, or work outside the approved product scope.

## Goals

- Remove routine owner approval pauses between verified tasks and milestones.
- Give one independent role responsibility for milestone acceptance, `main` integration authorization, and successor-milestone activation.
- Bind every decision to immutable commits, review evidence, and an exact target `main` base.
- Resolve runtime gate G01 with permission-isolated top-level sessions.
- Preserve truthful performance, licensing, security, and scope gates.

## Non-goals

- No product-core, audio, MIDI, UI, native-host, dependency, or asset implementation.
- No release, deployment, signing, store submission, paid-service action, credential use, legal conclusion, or destructive cleanup.
- No force-push, automatic conflict resolution, automatic rebase, or bypass of branch protection.
- No claim that agent governance improves application latency, audio continuity, or runtime quality.
- No permanently running background process. The role is invoked when a decision package is ready.

## Authority model

The Decision Steward may issue these verdicts:

- `APPROVE_MILESTONE`: accept an exact completed milestone tip.
- `APPROVE_MAIN_INTEGRATION`: authorize one exact guarded fast-forward of that accepted tip into one exact `main` base.
- `APPROVE_NEXT_MILESTONE`: activate one exact, committed, independently reviewed successor contract whose entry conditions pass.
- `CORRECT`: return exact blocking findings for correction and fresh review.
- `PAUSE_HUMAN`: stop at a non-delegable human boundary.

The Steward may resolve an in-scope technical or architecture choice only when the active milestone contract explicitly authorizes that decision, the evidence and ADR are complete, applicable QA and licensing/security reviews pass, and the choice does not expand roadmap scope. M0's existing exclusions remain binding until its contract is validly superseded.

## Non-delegable human boundaries

The owner remains the authority for:

- credentials, secrets, signing identities, entitlements, and external accounts;
- purchases, paid services, financial commitments, and legal agreements or conclusions;
- public releases, deployment, store submission, or public communication;
- destructive or difficult-to-reverse actions and irreversible external changes;
- missing or conflicting evidence, unresolved Critical or Important findings, and requests to weaken a gate;
- product scope outside the committed roadmap or a change to the safety policy itself.

## Independence and evidence

The Steward is read-only and never implements, edits, commits, merges, or pushes. It reviews an immutable decision package after independent QA/Performance, applicable Licensing/Security, and Final Code Review. The controller records the Steward's verdict verbatim with provenance; the Steward never reviews its own work.

Every approval binds:

- the milestone contract commit;
- the milestone completion-package commit;
- the exact reviewed milestone candidate SHA;
- all required review artifact SHAs;
- the exact local and remote `main` SHA targeted for integration;
- the successor contract SHA when next-milestone activation is requested;
- the applicable limitations and rollback procedure.

Any changed SHA invalidates the verdict and requires a fresh decision.

## G01-safe runtime topology

Nested mixed-permission custom agents are prohibited because the three recorded G01 experiments showed that children inherit the parent session's effective sandbox.

```text
Program controller (sole shared-state writer and handoff mediator)
├── independent read-only top-level sessions
│   ├── Researcher
│   ├── QA/Performance Verifier
│   ├── Licensing/Security Reviewer
│   ├── Final Code Reviewer
│   └── Decision Steward
└── independent workspace-write top-level sessions
    ├── Conductor
    ├── Flutter Builder
    ├── Apple Specialist
    └── Android Specialist
```

The Conductor selects the roles needed for a task, but the program controller launches each role in the matching top-level permission session and relays only bounded briefs, exact commits, and evidence identifiers. A read-only role is never launched beneath a workspace-write parent, and a write role is never launched beneath a read-only parent.

## Continuous milestone flow

1. The Roadmap Orchestrator completes and verifies all contracted tasks.
2. Independent reviewers approve the exact milestone candidate with no Critical or Important finding.
3. The controller assembles the immutable completion and integration package.
4. The Decision Steward returns a verdict bound to the package's exact SHAs.
5. For approval, the controller records the verdict and the milestone becomes `Accepted` through the existing two-commit evidence barrier.
6. A deterministic guard verifies clean refs, exact SHAs, `main` equality with `origin/main`, fast-forward ancestry, and the recorded Steward approval.
7. The guard fast-forwards and pushes only `refs/heads/main:refs/heads/main`, then proves local and remote hashes match.
8. If a committed, independently reviewed successor contract exists and its entry conditions pass, the Steward may approve its activation and the Orchestrator continues.
9. Otherwise the workflow pauses with the exact missing contract, evidence, or human-only boundary.

## Main integration safety

Main integration uses a separate guard rather than widening the milestone-branch publisher. The guard must refuse dirty worktrees, an unexpected branch, a moved or divergent `main`, a non-fast-forward candidate, stale decision evidence, missing review evidence, tags, force operations, and ambiguous remotes. It never rebases, resolves conflicts, deletes branches, or performs discretionary file edits.

## Owner-approved decision-evidence topology

The controller records canonical decision evidence on the dedicated append-only branch `governance/decision-evidence` in one isolated controller-owned worktree. The branch is separate from `main`, every milestone branch, every task branch, and product work. Only the program controller writes it; the Decision Steward and all reviewers remain read-only. It is never rebased, force-pushed, rewritten, deleted, used for product work, or published by a raw push.

The only permitted content is canonical evidence below `docs/orchestration/decisions/**` plus the minimal binding ledger defined by this design. Each decision uses three ordered, single-path fast-forward commits; no stage may co-commit another decision artifact:

1. an immutable action package binding the exact milestone, contract, reviewed candidate, completion package, required independent review artifacts, any prior acceptance binding, target `main`, optional successor contract and entry evidence, finding counts, limitations, and recovery procedure;
2. an immutable verbatim Decision Steward verdict with session provenance and the exact package commit;
3. a canonical binding commit that identifies the package and verdict as current and records `Accepted`, `Pending`, `Integrated`, `Refused`, or `PARTIAL` state as applicable.

A later `CORRECT` or `PAUSE_HUMAN` sequence supersedes the prior binding. An unconsumed package or verdict advances the evidence branch beyond its current binding and blocks integration. An older approval is never replayable.

The dedicated evidence publication guard may create `governance/decision-evidence` once from the exact recorded governance base. The direct-child creation commit adds an immutable canonical file containing that same base, preventing a caller from substituting a later base; every subsequent commit has exactly one parent. The guard rejects merges, deletion, immutable-file rewrites, and noncanonical content, and thereafter may only fast-forward its explicit `refs/heads/governance/decision-evidence:refs/heads/governance/decision-evidence` refspec. It requires a clean checked-out evidence branch, one unambiguous `origin`, exact ancestry, and local/remote equality after publication. A failed push refuses only after proving the remote stayed at its prior SHA or remained absent; otherwise it returns `PARTIAL`. It never widens the milestone publisher.

The main-integration guard consumes the exact evidence binding commit and requires local and remote `governance/decision-evidence` to equal it. Before mutation it proves that the binding is the branch tip and latest binding change; status is `Accepted` with integration `Pending`; every package, verdict, and binding commit changes only its exact stage path; both acceptance and integration verdict artifacts have exact controller/Steward-session/calendar-valid UTC provenance; the verdict is `APPROVE_MAIN_INTEGRATION`; the prior milestone-acceptance package, `APPROVE_MILESTONE` verdict, and binding are their own ordered sequence still current at the final evidence-binding tip; every canonical package, completion, and review artifact is a readable regular blob at its recorded 40-hex commit and belongs to accepted milestone history; Critical and Important findings are zero; local and remote `main` equal the recorded target; and the candidate is a fast-forward.

Local hooks are disabled for guarded merge and push operations. A nonzero merge or confirmed rejected push returns ordinary refusal only after restoring and proving the complete pre-integration branch refs, exact symbolic-versus-detached `HEAD` representation, index, worktree/untracked status, pseudorefs, evidence tip, and remote state. Proved local/remote equality at the candidate and unchanged approval binding succeeds even when the transport result was uncertain. Any unproved restoration or externally moved main/evidence state returns `PARTIAL`; the controller appends a non-replayable integration-result and binding sequence on the evidence branch and requires `PAUSE_HUMAN`. The guard never guesses, replays, force-updates, rebases, resolves conflicts, deletes, tags, or signs.

## State and recovery

Decision artifacts and integration reports are append-only canonical evidence on `governance/decision-evidence`. The milestone ledger records the evidence binding commit, acceptance package commit, Steward verdict commit, accepted milestone tip, original `main` base, integrated local and remote `main` SHA, successor contract SHA, and activation result.

On interruption, resume from committed state. If the target SHA, decision SHA, or remote `main` changed, repeat the affected review and decision instead of guessing or replaying a stale approval.

## Acceptance criteria

The setup is accepted only when:

1. `decision_steward` is discoverable as the ninth project agent and is read-only.
2. Its skill and policy define the exact verdicts, evidence bindings, and human-only stops.
3. Runtime evidence proves the separate read-only and workspace-write top-level handoffs and refuses mixed nesting.
4. The Roadmap Orchestrator can consume a Steward verdict without letting the Steward edit shared state.
5. Evidence-publication and main-integration guard tests prove success only for exact clean fast-forward cases; refusal for stale, superseded, divergent, dirty, unapproved, missing-artifact, wrong-binding, unconsumed, hostile-hook, or direct-push cases; confirmed-rejection restoration; and non-replayable `PARTIAL` recovery for ambiguous or externally moved results.
6. The next milestone cannot start without a committed, independently reviewed contract and satisfied entry conditions.
7. Existing G01 failures remain preserved as historical evidence.
8. Repository checks and independent final review pass with no Critical or Important finding.
