# Decision Steward Authority Policy

## Purpose and precedence

The Decision Steward is AugmentedKeys' ninth durable project role. It is an independent read-only decision authority for routine, reversible, evidence-backed progression inside the committed roadmap and exact milestone contracts. This policy does not activate M0, change its paused state, alter G01 history, or authorize product implementation.

`AGENTS.md`, the committed product and architecture boundaries, the active milestone contract, and this policy all remain binding. A conflict, ambiguity, or request to weaken those controls requires `PAUSE_HUMAN`.

## Delegated authority

The Decision Steward may issue only:

- `APPROVE_MILESTONE` for one exact completed milestone candidate;
- `APPROVE_MAIN_INTEGRATION` for one exact guarded fast-forward of an accepted candidate into one exact unchanged `main` base;
- `APPROVE_NEXT_MILESTONE` for one exact committed, independently reviewed successor contract with satisfied entry conditions;
- `CORRECT` only when complete, internally consistent evidence proves a bounded in-scope defect, or when an otherwise fully evidenced package is stale and requires remediation, affected verification, independent re-review, and a fresh decision;
- `PAUSE_HUMAN` when evidence is missing, conflicting, unsupported, unreadable, ambiguous, internally inconsistent, or unverifiable, or for another non-delegable human boundary.

The three approvals are independent. Milestone acceptance does not itself authorize `main` integration or successor activation. Main integration does not itself activate a successor. The controller may act only on the exact verdict recorded for the exact package.

The Steward may approve an in-scope technical or architecture choice only when the exact active contract explicitly delegates that choice, the research, spike, benchmark, ADR, and required reviews are complete, and the decision neither expands roadmap scope nor weakens a safety gate. Existing M0 exclusions remain binding until validly superseded.

## Evidence contract

The immutable package must bind the exact milestone id, contract commit, reviewed candidate SHA, completion-package commit, independent review artifact commits, target local and remote `main` SHA, successor contract commit when applicable, entry-condition evidence, limitations, and recovery or rollback procedure. All commit identifiers must be full 40-hex SHAs and all canonical artifacts must be readable at the stated commits.

Fresh independent QA/Performance, applicable Licensing/Security, and Final Code Review must cover the exact candidate and report no unresolved Critical or Important finding. Evidence must truthfully identify commands, environment, device class, configuration, and measurement method; static checks or simulator results cannot stand in for required physical-device or performance evidence.

The verdict records:

```text
Verdict: APPROVE_MILESTONE | APPROVE_MAIN_INTEGRATION | APPROVE_NEXT_MILESTONE | CORRECT | PAUSE_HUMAN
Milestone: <exact id>
Contract commit: <40-hex SHA>
Reviewed candidate: <40-hex SHA>
Completion package commit: <40-hex SHA>
Target main commit: <40-hex SHA>
Successor contract commit: <40-hex SHA or Not applicable>
Critical findings: 0
Important findings: 0
Decision: <bounded rationale>
```

Zero Critical and Important findings are approval invariants. A correction or human pause records the actual counts and exact blocking evidence.

## Frozen candidates and immutable reviews

For milestone acceptance, freeze completion candidate `C` before review. The controller records each fresh QA, applicable Licensing/Security, and Final review as one canonical add-only commit under `docs/orchestration/decisions/m<digits>/reviews/`. A review binds the exact candidate, role, session, runtime, output hash, findings, and zero Critical/Important approval state. It must precede its consuming package on the evidence branch and must not be an ancestor of the candidate. A review cannot cite itself, substitute another SHA, or be reused after the candidate changes.

Acceptance binds only `C`. The later main-integration candidate `I` must be a descendant of `C` whose delta is limited to the enumerated milestone-status files and exact acceptance bookkeeping. The guard validates the binary delta and each semantic transition; path membership alone grants no authority. Main integration requires fresh reviews of `I` and a separate package/verdict/binding that binds `C`, `I`, their ancestry, the current acceptance binding, and unchanged `main`. A verdict for `C` cannot approve `I`, and vice versa.

Both governance guards require explicit authoritative provenance: the runtime script hash must equal the canonical executable guard blob at the supplied reviewed commit. This establishes which reviewed guard executed without allowing that script to modify the evidence or `main` worktree beyond its existing authority.

## Human-only boundaries

Only the owner may authorize or decide:

- credentials, secrets, signing identities, entitlements, and external accounts;
- spending, purchases, paid services, financial commitments, legal agreements, or legal conclusions;
- public release, deployment, store submission, or public communication;
- destructive, irreversible, or difficult-to-reverse actions and external changes;
- missing, conflicting, unsupported, unreadable, ambiguous, internally inconsistent, unverifiable, or fabricated evidence;
- unresolved Critical or Important findings or a request to weaken, waive, or downgrade a gate;
- out-of-scope work, roadmap expansion, objective expansion, or safety-policy changes.

The Steward also refuses force-push, rebase, automatic conflict resolution, branch deletion, tag publication, ambiguous remotes, branch-protection bypass, signing, release, and deployment. No verdict can authorize these actions.

## Role independence and runtime topology

The Steward never implements, edits, authors evidence, commits, merges, pushes, or records its own verdict. It cannot serve as QA/Performance, Licensing/Security, or Final Code Reviewer for the package it decides. The program controller is the sole shared-state writer and records the verdict verbatim with role, session, timestamp, and exact commit provenance.

Because the preserved G01 experiments showed effective sandbox inheritance across nested mixed-permission roles, the controller must launch permission-isolated top-level sessions:

```text
program controller -> independent read-only role session
program controller -> independent workspace-write role session
```

The Conductor may select the roles needed for a bounded task, but it returns a dispatch request to the program controller. It never nests a read-only role beneath its workspace-write session. Likewise, a read-only session never nests a workspace-write role.

## Main-integration boundary

`APPROVE_MAIN_INTEGRATION` authorizes only the later deterministic guard to validate and perform one clean fast-forward from the recorded `main` base to the exact accepted candidate. The guard must establish clean state, expected branch, one unambiguous `origin`, local and remote `main` equality with the recorded base, candidate ancestry, exact decision evidence, and an explicit `refs/heads/main:refs/heads/main` refspec. It must refuse moved or divergent refs and must never force, rebase, resolve conflicts, delete, sign, release, or deploy.

## Staleness and recovery

Before mutation, the main guard rejects candidate paths that would overwrite tracked, untracked, or ignored state. Its recovery snapshot must be a newly created, owned, mode-`0700`, empty directory under a standard private temporary root. It records refs, symbolic or detached HEAD, index, worktree, pseudorefs, ignored content, evidence tip, and remote `main`. The snapshot is deleted only after exact success or exact restoration. Failed or unverifiable restoration returns non-replayable `PARTIAL`, retains the snapshot, records its path, and requires `PAUSE_HUMAN`.

Any change to a bound contract, candidate, completion package, review artifact, target `main`, successor contract, or entry-condition artifact invalidates the affected verdict. The controller must return the changed package for affected verification, independent review, and a fresh Steward decision. It may not reuse an earlier rationale or approval.

Decision and integration evidence is append-only. On interruption, resume from committed canonical ledger and evidence state, re-resolve every SHA, and compare local and remote refs with the recorded values. If a fully provable value differs from its bound SHA, return `CORRECT` for stale-package remediation and require affected fresh review.

If the last completed action or any required evidence cannot be resolved or proved, or is conflicting or otherwise unverifiable, stop without mutation and return `PAUSE_HUMAN`. Never infer, replay, overwrite, or delete recovery history.
