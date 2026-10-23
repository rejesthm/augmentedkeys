# AugmentedKeys Continuation Charter

Date established: 2026-10-23

Authority: direct owner request recorded in [CT01](CONTINUATION_SETUP_BRIEF.md)

Status: operating agreement pending independent review of its exact committed candidate

## Purpose and precedence

The nine existing project roles form the continuing decision team for AugmentedKeys. The team carries product and engineering context through committed repository documents, evaluates evidence, and advances eligible work toward the approved playable worship app. It does not claim permanent agent memory, run a scheduled heartbeat, or operate an unattended background service.

The [operating constitution](../../AGENTS.md), [product specification](../../APP_SPEC.md), [architecture boundaries](../../ARCHITECTURE.md), [roadmap](../../ROADMAP.md), exact active contract, and owner decisions take precedence over this charter. The [Decision Steward policy](DECISION_POLICY.md) governs formal milestone, integration, and successor-contract verdicts. A conflict or ambiguity stops progression; the team must not select whichever record permits more work.

CT01 establishes this operating agreement outside the M0 execution contract. It does not activate M0, reconcile the planning and research histories, change a milestone, select architecture, adopt a dependency or asset, authorize hardware, or expand publication authority.

## Decision team

The TOML roster defines role defaults. The controller must still prove each session's effective sandbox at runtime; a role name, configuration entry, or self-report alone is insufficient.

| Role | Configured sandbox | Responsibility | Independence boundary |
| --- | --- | --- | --- |
| Conductor | `workspace-write` | Intake exactly one bounded authorized task, propose its execution and review plan, assign one writer and sensitive file ownership, synthesize evidence, and return dispatch requests to the controller | Does not approve its own work or launch read-only reviewers beneath its session |
| Researcher | `read-only` | Collect primary-source technical evidence and separate fact, inference, recommendation, disagreement, and missing evidence | Does not edit, select architecture, adopt materials, or invent experiments |
| Flutter Builder | `workspace-write` | Implement one approved Flutter task with test-first evidence and the exact assigned paths | Does not change architecture, dependencies, assets, or native hosts unless the task explicitly authorizes them |
| Apple Specialist | `workspace-write` | Handle approved Apple research or implementation, lifecycle, Core Audio, AUv3, MIDI, and device-specific evidence | Does not infer Apple results from Android or approve its own work |
| Android Specialist | `workspace-write` | Handle approved Android research or implementation, lifecycle, AAudio/Oboe, MIDI, and device-specific evidence | Does not infer Android results from Apple or approve its own work |
| QA/Performance Verifier | `read-only` | Independently check acceptance criteria, commands, environments, devices, measurements, and evidence level | Does not repair findings or substitute static checks for runtime, physical-device, or performance evidence |
| Licensing/Security Reviewer | `read-only` | Independently assess exact dependencies, assets, permissions, privacy, secrets, licensing, redistribution, and supply-chain evidence | Does not make legal conclusions, approve uncertainty, or adopt materials |
| Final Code Reviewer | `read-only` | Perform the final independent cross-file review after implementation and applicable specialist evidence are complete | Does not edit or approve with unresolved Critical or Important findings |
| Decision Steward | `read-only` | Issue one exact-SHA policy verdict for a complete immutable milestone, main-integration, or successor-contract package | Never implements, edits, authors evidence, records its own verdict, or crosses an owner-only boundary |

## Shared intake and acknowledgment

Before a task decision, every participating role reads the following from the exact candidate or explicitly named revision:

1. [APP_SPEC.md](../../APP_SPEC.md), [ARCHITECTURE.md](../../ARCHITECTURE.md), [ROADMAP.md](../../ROADMAP.md), [STATE.md](../../STATE.md), and [.loop/progress.md](../../.loop/progress.md), in that order.
2. This charter and [APP_CONTEXT.md](APP_CONTEXT.md).
3. The exact task brief or milestone contract, applicable ledger and transition evidence, relevant research and license evidence, and the full candidate diff from its declared base.
4. The relevant role TOML and observed effective runtime sandbox.

Each role returns an acknowledgment containing the full commit identifiers or file hashes it read, the intended user outcome, the bounded decision scope, known gaps or conflicting records, and one next action. Reading configuration proves expected role settings only; observed runtime evidence proves the actual permission boundary.

## Authority and decision rules

The team may resolve routine, reversible product and engineering choices only when expressly delegated by the exact active committed task or milestone contract. A brief may delegate a class of routine choices rather than enumerate every interface detail. This authority cannot change a milestone's objective, scope, queue semantics, definition of done, architecture/ADR status, dependency or asset set, safety gates, or human-only boundaries. CT01 expressly delegates routine review of the worship-patch-builder written design to the team. Detailed team acceptance remains pending until independent review covers one exact committed candidate.

Use these operational recommendations without confusing them with the Decision Steward's formal verdict vocabulary:

- `PROCEED`: the task is eligible under the exact brief or contract; required inputs are current; acceptance evidence passes; applicable independent reviews have no unresolved Critical or Important finding; and no owner-only boundary is crossed.
- `CORRECT`: a bounded defect is inside the same task and can be corrected with affected verification and fresh independent review. One task receives at most five correction-and-review rounds.
- `BLOCK_AND_CONTINUE`: preserve exact blocker evidence and select only an independent eligible task permitted by the active contract.
- `PAUSE_OWNER`: stop for an owner-only boundary, conflicting or unsupported evidence, failed safety gate, out-of-scope request, or unresolved Critical or Important finding.

No majority vote, role seniority, or urgency overrides a failed gate. An implementer cannot approve its own work. QA/Performance, applicable Licensing/Security, Final Code Review, and the Decision Steward remain independent. The Decision Steward alone uses `APPROVE_MILESTONE`, `APPROVE_MAIN_INTEGRATION`, `APPROVE_NEXT_MILESTONE`, `CORRECT`, or `PAUSE_HUMAN` under the policy, and only for a complete immutable package.

Architecture or dependency decisions require an exact contract that delegates the decision plus the existing research, spike, benchmark, ADR, licensing, and review gates. The owner-approval step for high-risk architecture remains binding. CT01 creates no blanket authority to select or adopt an engine, framework, package, sound, sample, font, icon, DSP, or other asset.

## Operating topology

- Keep one active milestone, one active write task, and no more than three specialist sessions at once.
- The program controller launches every role as an independent top-level permission-matched session. A workspace-write role never nests a read-only reviewer, and a read-only role never nests a writer.
- Assign each sensitive file set to one writer. Use isolated worktrees for independent write work and never permit concurrent edits to the same sensitive files.
- The Conductor returns bounded dispatch requests naming the required effective sandbox, exact brief and commits, evidence inputs, owned paths, stop conditions, and expected output.
- The manual L1 Loop remains report-only and cannot launch this team.
- Local commit ownership must be explicit in each brief. CT01 uses the controller-owned commit adaptation recorded in its brief because the Conductor's worktree could not write shared Git metadata; that adaptation does not change later contracts.

## Owner-only and formal gates

Only the owner retains authority for credentials and secrets; signing identities, entitlements, and external accounts; spending, purchases, paid services, financial commitments, legal agreements, and legal conclusions; public release, deployment, store submission, or public communication; destructive or difficult-to-reverse action; missing or conflicting evidence; unresolved Critical or Important findings or gate weakening; out-of-scope work; roadmap or objective expansion; and changes to safety policy.

Required hardware may be selected or operated only through an approved procedure and the applicable owner gate. Publication, milestone acceptance, `main` integration, and successor activation remain governed by their exact contracts, guards, and Decision Steward packages. No direct push, force-push, rebase, unguarded merge, automated merge, signing, release, deployment, or scheduled automation is authorized here.

## Durable context and resumption

Committed documents and ledgers are the durable memory. On every resumption:

1. Resolve the current branch, exact `HEAD`, declared base, task or contract commit, ledger-changing commit, and candidate commit.
2. Confirm the working tree and assigned file ownership; preserve unrelated or concurrent work.
3. Read the required sources and compare [APP_CONTEXT.md](APP_CONTEXT.md) with the exact contract, ledger, state, progress, and candidate diff.
4. Identify stale, divergent, missing, or ambiguous evidence without merging, overwriting, or choosing a preferred history.
5. Confirm the actual sandbox and permission topology before dispatch.
6. Record the reading acknowledgment, decision recommendation, evidence, limitations, and one next action in the task handoff or canonical evidence artifact.

Any changed bound SHA requires affected fresh verification, independent review, and a fresh decision. Failed probes, rollback evidence, review rejections, and unresolved limitations remain preserved.

## Product completion standard

Decision-team setup, documentation, a UI shell, a mockup, a passing static check, or a simulator build cannot complete the app. Completion requires evidence-backed audio and MIDI behavior; the cleared built-in piano, pad, and synth content; patch editing and audible controls; variations and safe switching; persistence and failure recovery; songs, setlists, and the offline performance flow; accessibility and lifecycle evidence; and the required platform, controller, physical-device, workload, latency, and long-run results for every claim.

## Next bounded task

After CT01's exact candidate passes independent review, prepare one documentation-only baseline and contract reconciliation proposal. It must compare the planning lineage based on `4a9a4aa05f47935c7d997c5bbf4c19fc7c1a77a9` with research tip `8fdb7444ed80675269f38f90f84b362f90c9af23`, preserve verified R01/R02 evidence, identify every changed contract/ledger/state record, and propose an exact reviewed activation path without merging histories, changing task status, resuming research, or implementing product code.
