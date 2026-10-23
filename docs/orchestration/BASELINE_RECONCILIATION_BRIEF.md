# CT02 — Reconcile the documented development baseline

Status: authorized documentation task following accepted CT01. Controller owns local commits; Conductor owns only the two proposal output files during execution.

## Outcome

Produce a reviewable path-by-path baseline reconciliation proposal that preserves Decision Steward controls and the verified R01/R02 research, without merging branches, changing executable state, or restarting research.

## Authority and limits

The owner requests continuous team-led development and approved playable-first replanning. CT01 defines the team; CT02 is the next bounded documentation task after CT01 approval. CT01 candidate `53bb29d4a5f2ca9172b1a2d9f726459badbe9d95` passed QA, Licensing/Security and Final Code Review with no findings; acceptance is recorded in `dbecf073ef6ef078e20c62d2e64a1ecaef9c6fdd`. It delegates routine choices in organizing the reconciliation proposal; it does not delegate engine/ADR/dependency adoption, milestone activation, scope expansion, or gate changes.

## Exact inputs

- Governance source: 4a9a4aa05f47935c7d997c5bbf4c19fc7c1a77a9.
- Research source: 8fdb7444ed80675269f38f90f84b362f90c9af23.
- Common ancestor: 80843d3d0cbbdf8031aaa6406cf71b4d21ab5cac.
- CT01 reviewed candidate: `53bb29d4a5f2ca9172b1a2d9f726459badbe9d95`; acceptance evidence/base for CT02: `dbecf073ef6ef078e20c62d2e64a1ecaef9c6fdd`.
- Researcher advisory report and source-blob manifest are retained under .git/decision-team-continuation/2026-10-23/.

## Required proposal

Map every changed path to its full source commit and content hash, classify additive evidence versus stale snapshot versus material policy divergence, and describe one target baseline preserving both histories and all failures. Preserve exact R01/R02 candidate, verification, review, and publication references. Distinguish factual recognition of OD-005/R01/R02 from activation of a new combined contract. Define exact review/activation steps and identify any actual remaining owner-only decision with evidence. Do not invent a human decision to reread already-proved historical facts.

Separate the original M0 fact reconciliation from the proposed worship-first queue/definition-of-done amendment. The latter must remain a separate reviewed contract question. Do not silently defer R08-R10 or mark anything complete. The proposal should state how later reviewed contract work can delegate routine product decisions and preserve the existing high-risk architecture owner step.

## Allowed outputs

A bounded committed CT02 brief, a baseline reconciliation proposal, and its source manifest under docs/orchestration/; controller-owned review evidence follows in a separate artifact. One writer, isolated worktree, controller-owned commits for this setup task, at most three independent specialists. No product or configuration edit, no merge/import/state transition, no external publication, and no hardware.

## Acceptance

An independent reviewer can reproduce each manifest entry, trace the state chronology, identify every retained governance control, distinguish a proposal from an activation, and name a concrete next authorized task. No Critical or Important finding may remain before this proposal is used by a later task.

## Exact ownership and execution

The controller commits this brief at `docs/orchestration/BASELINE_RECONCILIATION_BRIEF.md` before dispatch. The existing Conductor is the sole writer of `docs/orchestration/BASELINE_RECONCILIATION.md` and `docs/orchestration/BASELINE_SOURCE_MANIFEST.json` in the isolated `planning/worship-first-version` worktree. It must not edit any other file or mutate Git metadata. The controller verifies the handback, commits those two paths, obtains independent read-only QA and Final review (and security if policy concerns arise), then records literal reviews and provenance at `docs/orchestration/BASELINE_RECONCILIATION_EVIDENCE.md`. No nested specialist dispatch. Preserve all other work; other contributors may exist.

Reuse the completed Researcher advisory and 41-path source manifest. Check hashes against source blobs; add a separately identified CT01 overlay rather than confusing the governance source with the current planning branch. Provide a concrete path-by-path action table and proposed next-task allowlist, required reviews, activation conditions and retained owner gates. Do not recursively create additional planning tasks when one concrete proposal can define the execution boundary.

Fresh acceptance checks: exact source commits resolve; manifest blobs and SHA-256 values reproduce; all divergent research paths are accounted for; CT01 overlay is identified; Markdown links resolve; changed-path allowlist and `git diff --check` pass. Documentation checks only, no Flutter/device claims. At most five correction rounds. Stop for an unauthorized path, changed source, conflicting evidence that cannot be described accurately, or permission failure; preserve the evidence.
