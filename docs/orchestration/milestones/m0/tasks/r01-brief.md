# R01 — Mobile audio candidates and measurement requirements

## Objective and authority

Produce an evidence-backed comparison of mobile audio architecture candidates and Flutter/native boundaries, plus a reproducible proposal for later physical-device latency evaluation. This answers research question R01; it does not choose an engine, implement a spike, or claim suitability from unperformed tests.

- Milestone: M0, Active through OD-001.
- Accepted foundation: `b1b0c1edd5e42d3ea791f665c22954834e962d05`.
- Accepted contract source: `0d86705ca130fcc3bdb73a9acf3f21fd803912dd`.
- Owner decision: `e9eb4043ec4009dc88c20f7b6c3f9d658f18f48c`.
- Contract: `docs/orchestration/milestones/M0_CONTRACT.md`.
- Canonical milestone ledger at brief preparation: `79a9e0c27154266ab5e0acc0de60c79fce941bc4` (all ten tasks Queued; activation approval evidence `577ec8d07934110a1da5c214e38455c2e4356ab1`).
- Research dependencies: none. R02 and R06 depend on verified R01; this task must not preselect their candidate.
- Inputs: APP_SPEC, ARCHITECTURE (undecided boundaries), ROADMAP M0, RESEARCH_INDEX question 1, TEST_STRATEGY, DEVICE_MATRIX, REALTIME_SAFETY, AGENTS, gate.yaml, loop-budget.md and roadmap-orchestrator skill.
- Eligibility requires the exact brief commit followed by the separate ledger/index transition. Assignment evidence and a separate In-progress transition must precede task execution.

## Why

The product is a planned live-keyboard platform for Android and iOS/iPadOS phones and tablets. Its Flutter shell and passing host-side checks establish neither audio capability nor low latency. R01 must identify what can be learned from documentation and what needs a separately approved experiment.

## Ownership and exact files

- Assigned accountable role: existing configured Conductor; may synthesize research documentation, never product code.
- Initial writer: one configured Conductor for R01 only; read-only specialists may supply attributed findings.
- Task branch: `task/m0-r01-audio-architecture`.
- Task worktree: `/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-r01-audio-architecture`.
- Writer may create only `docs/research/MOBILE_AUDIO_ARCHITECTURE.md` and `docs/research/LOW_LATENCY_RESEARCH.md`.
- Roadmap Orchestrator alone owns shared state and canonical task evidence: this brief, `docs/orchestration/milestones/m0/evidence/r01-verification.md`, `r01-transitions.md`, and allowlisted review/provenance records.
- No other writer owns either output. No concurrent product/research write task is authorized.
- All protected paths remain unchanged. Read-only browsing of primary sources is permitted; no package, code, SDK, asset, or hardware adoption or operation.

## Scope and acceptance criteria

1. Cover both Apple and Android phones and tablets, with current official Flutter, Apple and Android sources. Date each source access and identify API/version/repository revision when available; explicitly mark unversioned live documentation.
2. Compare at least platform-native render graphs, a portable native DSP/control boundary, and existing cross-platform hosting/engine candidates at a documentary level. Explain differences, unknowns, portability costs, and lifecycle/error concerns without selecting a winner or importing desktop assumptions.
3. Distinguish Flutter UI/control traffic from a future native real-time rendering boundary. Discuss platform channels and FFI as control/integration mechanisms, not proof of hard real-time callback suitability.
4. Apply the existing callback prohibitions and identify bounded data transfer, ownership, prepare/swap/retire, overload, interruption, route-change, and shutdown questions that a later spike must test. Proposed techniques are candidates, not architecture decisions.
5. State facts with primary citations; label inference, recommendation for future evaluation, disagreement, unknown/missing evidence, and owner decisions separately. Do not fabricate disagreement if sources simply address different boundaries.
6. Define distinct latency quantities: touch/MIDI-to-audible output, software scheduling/queue contribution, output latency, and audio round trip. Any frames/sample-rate calculation is nominal buffer duration, never measured total latency.
7. Propose a reproducible future procedure with named measurement boundary, instrument/method, calibration and clock alignment/error, workload/warmup/run duration/repetitions, raw artifact retention, latency distribution/tails/jitter, underruns/callback timing, and CPU/memory/thermal/soak/lifecycle observations. Missing exact hardware and numeric acceptance budgets remain explicit owner choices; do not pretend a proposal is an approved executable procedure.
8. Carry all required mobile device categories forward without inventing selected models or OS support commitments. Distinguish built-in, wired/USB and wireless route questions; treat route-specific performance as unknown until measured.
9. Include a compact candidate-to-evidence/gap matrix, future bounded-spike questions, risks and owner decisions in the architecture report. Include an evidence-record template in the latency report with every TEST_STRATEGY field.
10. No candidate is adopted or rejected as technically unsuitable without the required evidence. Unmeasured documentary uncertainty is explicit; an actual decision requiring hardware, licensing resolution or scope expansion stops at its owner gate.

## Explicit non-goals

No Flutter UI, Dart/native/audio/MIDI/plugin/sampler implementation; no benchmark execution; no simulator/emulator/device launch; no hardware request or operation; no minimum-OS change; no architecture/ADR edit; no dependency, package, asset, sample, patch, SDK or engine adoption; no legal advice or distribution approval. UAPMD detailed evaluation belongs to R02; platform hosting details to R03/R04; sound formats to R06; version-specific license assessment to R07. Existing candidate mention is not approval.

## Evidence and verification

Documentation-only verification is proportional to scope; do not rerun Flutter commands merely to imply research or audio correctness. The unchanged baseline has its own retained artifact.

- Record tested candidate full SHA, exact procedure, date/time/timezone, host OS/architecture/tool versions, device/simulator status (Not applicable for documentary checks), configuration, result, artifact location and responsible reviewer.
- Run `git diff --check <task-start-commit>..<candidate-commit>`: expected exit 0.
- Run `git diff --name-only <task-start-commit>..<candidate-commit>`: expected exactly the two writer outputs.
- Confirm protected code/config/manifests/lockfile and accepted main remain unchanged; record exact commands and resolved refs.
- Independently open cited primary sources and audit all decision-driving claims, API boundaries and versions. Record unavailable sources as unavailable, not as verified.
- Check all acceptance criteria and required evidence fields explicitly; distinguish static documentation checks from physical performance.
- Preserve original specialist/final replies and actual configured dispatch provenance (role, child ID, effective configuration, exact candidate and source location). Do not replace a reviewer verdict with a coordinator summary.
- Root commits the candidate after checking the writer diff, then commits canonical verification evidence and the separate In-review ledger/index transition before final integration.
- Required QA/Performance and Licensing/Security reviews, followed by a fresh independent Final Code Review. Unresolved Critical/Important findings prevent integration. A correction returns to the same writer, with its evidence/state barrier, affected verification and fresh review; maximum five correction rounds.
- Finalized verification evidence precedes the separate Verified transition. Preserve all branches, candidates, failed reviews and limitations.

## Stop conditions and rollback

Stop for any contract/constitution gate, missing or contradictory source evidence needed to support a conclusion, unsupported performance claim, unapproved hardware/credential/dependency/license action, allowlist expansion, or unresolved Critical/Important finding. Report exactly what remains unknown; do not select an engine by assumption.

On failure, preserve the task branch/worktree, candidate, original findings and canonical evidence. Keep accepted main unchanged; do not reset, delete, rewrite history, publish the task branch or integrate an unapproved candidate. Root may select a safe independent task only under the milestone contract.

## Required reviewers and next authority

Conductor coordinates only R01; Researcher provides read-only documentary investigation. QA/Performance verifies the proposed measurement/evidence boundaries; Licensing/Security checks candidate/asset/permission/adoption boundaries; Final Code Reviewer independently checks the whole R01 brief, candidate, evidence and preceding reviews. Root alone advances milestone state. Verified research unlocks consideration of a separately owner-approved architecture spike, not permission to implement it.
