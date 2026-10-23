# CT02 Baseline Reconciliation Proposal

Status: proposal only; independently reviewed activation package not yet created

Authority: [CT02 brief](BASELINE_RECONCILIATION_BRIEF.md) at `e3fc991e9ccc4a0c23b668c4b5443bc0864cb2d6`

Machine-readable source record: [BASELINE_SOURCE_MANIFEST.json](BASELINE_SOURCE_MANIFEST.json)

## Reading acknowledgment and decision scope

The Conductor read the required planning checkout sources at `e3fc991e9ccc4a0c23b668c4b5443bc0864cb2d6`, the accepted CT01 candidate `53bb29d4a5f2ca9172b1a2d9f726459badbe9d95`, CT01 acceptance evidence `dbecf073ef6ef078e20c62d2e64a1ecaef9c6fdd`, governance source `4a9a4aa05f47935c7d997c5bbf4c19fc7c1a77a9`, research source `8fdb7444ed80675269f38f90f84b362f90c9af23`, the applicable M0 contract and ledger from both histories, the [Decision Steward policy](DECISION_POLICY.md), the retained Researcher advisory, and the CT02 draft contents before handback. The controller subsequently corrected the execution-parent proposal as documented below; independent review covers the final committed candidate.

The user outcome is a trustworthy baseline from which the team can continue toward the playable worship app without discarding verified research or weakening governance. CT02 may propose documentation actions only. It does not merge histories, change M0 state, activate a contract, resume R03, amend the research queue, choose architecture, adopt a dependency or asset, operate hardware, publish externally, or implement product code.

Known gaps are the unresolved executable binding for the retained governance contract, the absence of a combined committed candidate and independent reviews, the nonblocking R01 provenance-label Minor, and the lack of runtime, device, audio/MIDI, latency, licensing-clearance, and product-implementation evidence. The current planning checkout remains the executable source of truth and records M0 as paused.

## Source facts and chronology

The sources share exact ancestor `80843d3d0cbbdf8031aaa6406cf71b4d21ab5cac`.

- Governance source `4a9a4aa05f47935c7d997c5bbf4c19fc7c1a77a9` contains the stricter Decision Steward, append-only decision-evidence, guarded main-integration, and top-level permission-isolation controls. Its state snapshot is earlier: M0 paused, R01 blocked, and R02-R10 queued.
- Research source `8fdb7444ed80675269f38f90f84b362f90c9af23` contains later G01, R01, and R02 evidence. It predates the governance source's Decision Steward and integration controls, so its policy files are stale snapshots rather than preferred controls.
- CT01 candidate `53bb29d4a5f2ca9172b1a2d9f726459badbe9d95` overlays the governance line with the accepted playable-first planning direction and continuing decision-team context. Acceptance evidence at `dbecf073ef6ef078e20c62d2e64a1ecaef9c6fdd` records independent QA, Licensing/Security, and Final Code Review approval with zero findings.
- CT02 brief `e3fc991e9ccc4a0c23b668c4b5443bc0864cb2d6` authorizes only this proposal and manifest.

The research chronology remains factual evidence:

1. OD-004 at `82dc35ac2042ab4697b322dabd1fb03c61a5ae5a` authorized the bounded role-isolation correction.
2. G01 validation was recorded at `ec4e76345519973d09a4dbeff6d043e6477e67bc`, corrected evidence at `5bfbdb5139c4f1936a59ba78c6b1125d8b7cb7db`, and independent approval at `88fe4ece13bfedd8b67eaa8882c5adf020654418`.
3. OD-005 at `5e870b5dc39aee60a8d8a32ca78d1e55dc980cea` reactivated the research line under contract source `13b864f09ca083d10910bcffa4432b81c040bda9`.
4. R01 and R02 then completed documentary research and were integrated on that research line. R03-R10 stayed queued.

Recognizing these commits as history does not activate the retained governance contract. The current retained M0 contract's latest content-changing commit is `b0122f7030331d3e86af28a779075349fc9e74ff`; OD-005 binds the different research contract source `13b864f09ca083d10910bcffa4432b81c040bda9`. A fresh exact-commit activation decision is therefore required before the combined baseline can become executable. The owner need not re-decide whether G01, R01, or R02 happened; the remaining owner-only choice is whether to reactivate M0 on the exact reconciled candidate under the retained contract.

## Evidence that must remain exact

### R01

- Brief: `b50e58e187f60b20ab9f12c7306af63a3cba3a9e`.
- Reviewed candidate: `09266fdc17e137db44495d85c6b42cf296efb89c`.
- Finalized verification: `1c3d4618b1cbf2c583f2c4950800edaab58ee185`.
- Specialist approvals: `80e0f6f973ef94bc0cfe415b9017c3fde3c7d395`.
- Final Code Review: `ae9467e526da68a09d208e7cf530abc89287efa3`.
- Reviewed integration tip: `63081f5f50b03c9337f9f10032a94373f214aaa0`.
- Guarded publication state tip: `6eabee4dd99c3761b68e52fe81a9e8e8738b600c`.
- Retained limitation: one nonblocking provenance-label Minor; no architecture, dependency, device, or performance approval.

### R02

- Brief: `8652877b5d87706739076da4bdc69a72fd9c01ba`.
- Reviewed candidate: `8b39e5572f481af21d5fba598c1abf0fe8dc5dec`.
- Finalized verification: `c7952ea12d19a6c42abc3d19425a694448256b76`.
- Specialist approvals: `c62346d3098233a5f3d4a29d932493bcfb28e80b`.
- Final Code Review: `9b9f6150d40826e32044ccda41235ee1548054ea`.
- Reviewed integration tip: `f7e2670ee7c9d12d47467e13139420a347b8cc29`.
- Guarded publication record: `22bf9f15b503bc11a3238638b1f4aacea26df922`; published state tip `14004c5059a772943fc6949034d656c1d357b0e8`.
- Retained limitation: documentary UAPMD evaluation only; no adoption, build, benchmark, device result, or license clearance.

## Target baseline

The target is a new isolated `task/ct03-baseline-reconciliation` candidate whose parent is research tip `8fdb7444ed80675269f38f90f84b362f90c9af23`. Bring the accepted governance and CT01 content forward as exact file imports. Do not merge or rewrite either source history. This choice preserves the research history in candidate ancestry and leaves a possible fast-forward from the existing `milestone/m0-research` tip; it does not authorize that integration.

1. Retain all 30 research evidence additions and three chronology extensions in place, with their exact research bytes and modes.
2. Import 14 governance-only paths plus the governance Conductor, Roadmap Orchestrator and M0 contract blobs unchanged.
3. Import eight accepted CT01 overlay paths, using the later acceptance-evidence version for `CONTINUATION_SETUP_EVIDENCE.md`.
4. Synthesize only `STATE.md`, `.loop/progress.md`, and `M0_LEDGER.md`, preserving both histories and every failure. The combined candidate remains paused; historical research activation remains a recorded fact; R01/R02 stay Verified and R03-R10 stay Queued.
5. Preserve the exact M0 contract, objective, queue, dependencies, definition of done and safety gates. No activation follows from documentary recognition or review alone.
6. Obtain independent reviews, then present the exact foundation, contract, candidate, branch-integration action and evidence for the required owner reactivation decision. Revalidate every contract entry condition before any state barrier or integration.

Controller correction after Conductor handback: the original proposal built on the divergent planning branch and implied that owner reactivation plus a state barrier was sufficient. Local ref inspection proved the existing research tip is not its ancestor. The corrected proposal uses the research tip as parent and explicitly retains foundation, branch and activation gates. Original drafts and handback remain preserved in controller evidence. No branch has been moved.

## Retained governance-only controls

Fourteen paths changed only on the governance line after the common ancestor. They will be imported unchanged from the accepted governance source into the research-descended CT03 candidate. The JSON manifest records each full source commit, Git mode, object type, blob id, and SHA-256.

| Path | Proposed action |
| --- | --- |
| `.codex/agents/decision-steward.toml` | Retain the independent read-only Decision Steward role unchanged. |
| `.codex/skills/decision-steward/SKILL.md` | Retain exact-SHA verdict and owner-boundary rules unchanged. |
| `.codex/skills/roadmap-orchestrator/scripts/test_validate_decision_evidence.sh` | Retain the decision-evidence guard tests unchanged. |
| `.codex/skills/roadmap-orchestrator/scripts/test_validate_main_integration.sh` | Retain the main-integration guard tests unchanged. |
| `.codex/skills/roadmap-orchestrator/scripts/validate_decision_evidence.sh` | Retain the append-only evidence publication guard unchanged. |
| `.codex/skills/roadmap-orchestrator/scripts/validate_main_integration.sh` | Retain the exact-approved main integration guard unchanged. |
| `docs/orchestration/DECISION_POLICY.md` | Retain immutable-package and exact-binding policy unchanged. |
| `docs/orchestration/decisions/README.md` | Retain the canonical decision-evidence schema and recovery protocol unchanged. |
| `docs/orchestration/milestones/m0/evidence/decision-steward-decisions.md` | Retain the M0 decision index unchanged. |
| `docs/orchestration/milestones/m0/evidence/main-integration.md` | Retain the M0 main-integration index unchanged. |
| `docs/superpowers/plans/2026-09-01-augmentedkeys-decision-steward.md` | Retain governance design history unchanged. |
| `docs/superpowers/plans/2026-09-02-claude-agent-parity.md` | Retain role-parity design history unchanged. |
| `docs/superpowers/specs/2026-09-01-augmentedkeys-decision-steward-design.md` | Retain governance specification history unchanged. |
| `docs/superpowers/specs/2026-09-02-claude-agent-parity-design.md` | Retain role-parity specification history unchanged. |

Their absence from the research source is a stale research snapshot, not a deletion instruction. Together with the 41 paths below, this accounts for all 55 paths changed on either source since the common ancestor.

## Research-divergent path action map

The JSON manifest is normative for each path's full source commit, Git mode, object type, blob id, and SHA-256. The table below supplies the proposed action for all 41 research-divergent paths.

| Path | Classification | Proposed action |
| --- | --- | --- |
| `.codex/agents/conductor.toml` | material policy divergence | Import exact governance-source bytes and mode into research-descended candidate. |
| `.codex/skills/roadmap-orchestrator/SKILL.md` | material policy divergence | Import exact governance-source bytes and mode into research-descended candidate. |
| `.loop/progress.md` | stale snapshot requiring synthesis | Synthesize both recorded histories; combined candidate paused, historical research-line activation preserved; R01/R02 Verified. |
| `AGENTS.md` | material policy divergence with ct01 overlay | Import accepted CT01 overlay bytes and mode; ROADMAP remains paused in combined candidate. |
| `ROADMAP.md` | stale snapshot with ct01 product overlay | Import accepted CT01 overlay bytes and mode; ROADMAP remains paused in combined candidate. |
| `STATE.md` | stale snapshot requiring synthesis | Synthesize both recorded histories; combined candidate paused, historical research-line activation preserved; R01/R02 Verified. |
| `docs/orchestration/milestones/M0_CONTRACT.md` | material policy divergence | Import exact governance-source bytes and mode into research-descended candidate. |
| `docs/orchestration/milestones/M0_LEDGER.md` | chronology and policy synthesis | Synthesize both recorded histories; combined candidate paused, historical research-line activation preserved; R01/R02 Verified. |
| `docs/orchestration/milestones/m0/evidence/g01-role-isolated-review.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/orchestration/milestones/m0/evidence/g01-role-isolated-validation.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/orchestration/milestones/m0/evidence/owner-decisions.md` | chronology extension | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/orchestration/milestones/m0/evidence/r01-correction-round2-provenance.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/orchestration/milestones/m0/evidence/r01-correction-round3-provenance.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/orchestration/milestones/m0/evidence/r01-final-review-round2.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/orchestration/milestones/m0/evidence/r01-final-review-round3.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/orchestration/milestones/m0/evidence/r01-researcher-correction-round1.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/orchestration/milestones/m0/evidence/r01-researcher-pass1.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/orchestration/milestones/m0/evidence/r01-review-correction-round1.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/orchestration/milestones/m0/evidence/r01-review-correction-round2.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/orchestration/milestones/m0/evidence/r01-review-correction-round3.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/orchestration/milestones/m0/evidence/r01-review-round1.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/orchestration/milestones/m0/evidence/r01-transitions.md` | chronology extension | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/orchestration/milestones/m0/evidence/r01-verification-round1-raw.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/orchestration/milestones/m0/evidence/r01-verification-round2-raw.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/orchestration/milestones/m0/evidence/r01-verification-round3-raw.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/orchestration/milestones/m0/evidence/r01-verification.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/orchestration/milestones/m0/evidence/r02-conductor-pass1.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/orchestration/milestones/m0/evidence/r02-correction-round1-provenance.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/orchestration/milestones/m0/evidence/r02-final-review-round1.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/orchestration/milestones/m0/evidence/r02-publication.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/orchestration/milestones/m0/evidence/r02-researcher-pass1.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/orchestration/milestones/m0/evidence/r02-review-round0.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/orchestration/milestones/m0/evidence/r02-review-round1.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/orchestration/milestones/m0/evidence/r02-transitions.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/orchestration/milestones/m0/evidence/r02-verification.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/orchestration/milestones/m0/tasks/g01-role-isolated-correction.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/orchestration/milestones/m0/tasks/r02-brief.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/research/LOW_LATENCY_RESEARCH.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/research/MOBILE_AUDIO_ARCHITECTURE.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/research/RESEARCH_INDEX.md` | chronology extension | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |
| `docs/research/UAPMD_EVALUATION.md` | additive research evidence | Retain research-source bytes and mode unchanged in place; preserve all failures and exact research evidence. |

## CT01 overlay

The manifest separately records eight CT01 paths at reviewed candidate `53bb29d4a5f2ca9172b1a2d9f726459badbe9d95`, the final evidence-only update at `dbecf073ef6ef078e20c62d2e64a1ecaef9c6fdd`, and the CT02 brief at `e3fc991e9ccc4a0c23b668c4b5443bc0864cb2d6`. These paths are not attributed to governance source `4a9a4aa05f47935c7d997c5bbf4c19fc7c1a77a9` or research source `8fdb7444ed80675269f38f90f84b362f90c9af23`.

The product direction in `APP_SPEC.md`, `ROADMAP.md`, and the worship design remains planning authority only. It cannot silently amend the current M0 queue or definition of done.

## Next execution task: CT03 factual baseline construction

After this CT02 candidate passes independent review, the controller prepares and commits the exact CT03 brief described below before dispatching its sole writer. CT02 is a proposal, not executable import authority.

### CT03 writer allowlist

The exact future brief must bind the accepted CT02 candidate/evidence commits, research parent and source manifest before a writer starts. The manifest's `execution_proposal.content_paths` is the complete 28-path product-independent content allowlist:

- 14 exact governance-only imports;
- three exact governance control imports: Conductor role, Roadmap Orchestrator skill and M0 contract;
- eight exact CT01 overlay imports, with the final acceptance evidence taking precedence;
- three synthesized state/history paths: `STATE.md`, `.loop/progress.md`, and `M0_LEDGER.md`.

Every exact import must match its source blob, SHA-256 and Git mode. All other existing research files, including all R01/R02 outputs, verification, failures and transitions, remain byte-for-byte unchanged. No new governance behavior, architecture, product code, dependency, asset, ADR, permission or native-platform change is authorized.

The controller separately owns six documentation artifacts listed in the manifest: exact accepted CT02 brief/proposal/manifest/review evidence copies, the committed CT03 construction brief, and subsequent CT03 evidence. The CT03 brief must pin the exact source commits for these artifacts; unresolved placeholders cannot be executable authority. The task branch and isolated worktree must start at the stated research parent. A reviewed commit sequence must import required operating controls and shared context before any role acts under them; the brief must identify how the existing accepted controller rules govern that initial preparation.

The controller owns local commits and verifies the 28 content paths plus explicit controller artifacts, source bytes/modes, ancestry, chronology, full diff, required guard tests and handback. CT03 prepares a candidate only: it cannot move the existing milestone branch, change its executable state, push, merge, cherry-pick, rebase, delete branches or modify either source worktree. Independent reviewers evaluate both the research-parent diff and the governing-source equivalence, since absence of product edits alone does not prove control preservation.

### CT03 independent review

1. QA/Performance Verifier, independent `read-only`: reproduce all manifest entries, compare chronology and statuses, confirm no device/performance claim, and verify every CT03 acceptance condition.
2. Licensing/Security Reviewer, independent `read-only`: confirm retained governance and owner gates, no dependency/asset/license adoption, no secret or permission change, and no policy downgrade.
3. Final Code Reviewer, independent `read-only`, after the first two reviews: evaluate the exact committed CT03 candidate, full source-to-target diff, literal reviews, cross-file consistency, and evidence honesty.

Any Critical or Important finding requires bounded correction, affected checks, and fresh review. No Decision Steward review is requested because M0 is incomplete and no milestone/integration/successor package exists.

## Activation after CT03

Passing CT03 reviews leaves the combined candidate paused. Before requesting owner approval, the controller must finish and show a concrete activation package containing:

- exact reconciled candidate, research parent, target milestone branch/base, and proof the candidate descends from that unchanged base;
- exact accepted foundation `main` commit, plus fresh live evidence that local `main` and `origin/main` equal it (the local tracking ref alone is insufficient);
- retained contract content commit `b0122f7030331d3e86af28a779075349fc9e74ff`, reviewed candidate bytes and all CT03 review/evidence commits;
- proof that R01/R02 evidence and G01 failures are preserved, runtime role isolation and integration guards satisfy the setup requirements, and R03-R10 remain queued;
- exact guarded milestone-integration/publication sequence, state-barrier sequence, allowed paths, commit ownership, rollback limits and reconciliation of the existing research Goal ownership.

The existing contract's entry conditions remain binding, including that no Roadmap Orchestrator Goal or write task is active, foundation equality, a clean exact resumable milestone branch, and a committed reactivation decision. This continuation Goal may coordinate preparation; it must not create a competing M0 Goal or assume an older Goal has stopped without checking its authoritative state. A failed or unprovable entry condition stops activation and is reported with concrete evidence.

Owner reactivation must bind the displayed foundation, exact candidate, retained contract and exact permitted branch action. A status change alone does not authorize moving a branch or satisfy entry conditions. The owner need not re-decide that G01/R01/R02 happened. The actual decision concerns the new executable binding and its concrete integration action. No new owner question is requested by CT02 while that package is incomplete.

Only after all conditions and the required owner decision pass may the exact approved integration and existing state barrier run. Preserve the current research branch until then. The barrier may synchronize the ledger, state, progress and leading M0 roadmap sentence to Active; it cannot accept M0, integrate main, activate M1 or broaden the queue. R03 still requires its own exact committed brief.

## Separate worship-first contract question

The accepted product direction proposes prioritizing built-in playback, basic wired MIDI, the first-version sound engine/content/licensing work, and deferring broader plugin and competitor research. Those changes affect the M0 queue, dependencies, outputs, and definition of done. They are not part of factual reconciliation or CT03.

A later contract-amendment task must enumerate every proposed queue/output/dependency/definition-of-done change, preserve R01/R02, keep R08-R10 queued unless the exact amendment explicitly changes them, receive independent QA, Licensing/Security, and Final Code Review, and obtain the required exact owner decision. It may delegate routine product decisions inside the amended contract, but it must preserve the owner approval step for high-risk architecture, all license/dependency gates, physical-device procedures, and Decision Steward milestone/integration/successor authority.

## Limitations and rollback

This proposal verifies repository lineage, hashes, and recorded documentary evidence only. It does not refresh external research sources or establish app behavior, sound quality, architecture suitability, license clearance, hardware compatibility, latency, continuity, or performance.

Rollback of CT02 removes only the proposal and manifest through a later reviewed reversal. Rollback of a future CT03 must revert only its exact local documentation commits; it must not delete or rewrite either source branch, raw evidence, failed probes, task branches, or reviewed candidates.
