# R02 — Objective UAPMD evaluation

## Objective and authority

Produce an evidence-backed, version-specific evaluation of UAPMD against the documented AugmentedKeys requirements and a small set of relevant alternatives. This task decides only whether UAPMD should remain a candidate for later bounded spikes and ADR comparison; it does not adopt, integrate, build, benchmark, or reject an engine as technically unsuitable without the required evidence.

- Milestone: M0, Active through OD-005 at `5e870b5dc39aee60a8d8a32ca78d1e55dc980cea`.
- Accepted foundation: `b1b0c1edd5e42d3ea791f665c22954834e962d05`.
- Accepted contract source: `13b864f09ca083d10910bcffa4432b81c040bda9`.
- Contract: `docs/orchestration/milestones/M0_CONTRACT.md`.
- Dependency: R01 is Verified through finalized verification `1c3d4618b1cbf2c583f2c4950800edaab58ee185`; exact reviewed research candidate `09266fdc17e137db44495d85c6b42cf296efb89c` is integrated at `63081f5f50b03c9337f9f10032a94373f214aaa0`.
- Starting milestone tip before this brief: `6eabee4dd99c3761b68e52fe81a9e8e8738b600c`; guarded remote `milestone/m0-research` matched this tip after authorize/push/verify.
- Inputs: `APP_SPEC.md`, `ARCHITECTURE.md`, `ROADMAP.md`, `STATE.md`, `.loop/progress.md`, `AGENTS.md`, `gate.yaml`, `loop-budget.md`, `docs/research/RESEARCH_INDEX.md`, `docs/research/MOBILE_AUDIO_ARCHITECTURE.md`, `docs/research/LOW_LATENCY_RESEARCH.md`, `docs/testing/TEST_STRATEGY.md`, `docs/testing/DEVICE_MATRIX.md`, `docs/architecture/REALTIME_SAFETY.md`, `docs/research/LICENSE_LEDGER.md`, and `.codex/skills/roadmap-orchestrator/SKILL.md`.

## Why

UAPMD is named as an undecided candidate and publicly describes a cross-platform, multi-format plugin-host/sequencer engine with MIDI 2.0 work. Those descriptions do not prove that it satisfies AugmentedKeys' mobile, reliability, real-time, lifecycle, licensing, maintenance, or integration needs. R02 must replace name recognition and broad claims with traceable facts, explicit gaps, and bounded future questions.

## Ownership and exact files

- Accountable writer: one configured Conductor assigned after the separate `Eligible` to `In progress` transition; the Conductor may synthesize research but may not implement product work.
- Read-only Researcher supplies primary-source findings. QA/Performance, Licensing/Security, and Final Code Reviewer remain independent reviewers.
- Task branch: `task/m0-r02-uapmd`.
- Task worktree: `/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-r02-uapmd`.
- Writer may create only `docs/research/UAPMD_EVALUATION.md`.
- Roadmap Orchestrator alone owns shared state and canonical task evidence: this brief, `docs/orchestration/milestones/m0/evidence/r02-verification.md`, `r02-transitions.md`, and allowlisted review/provenance records.
- No concurrent writer may edit the contracted output or sensitive state files.

## Scope and acceptance criteria

1. Establish UAPMD's exact official repository identity, inspected revision or release, access date, documented license identity, maintained components, platform claims, build prerequisites, and current project status from original sources. Mark moving, unversioned, unavailable, archived, experimental, incomplete, or internally inconsistent material explicitly.
2. Derive a traceable evaluation matrix from AugmentedKeys requirements and the Verified R01 boundaries: Android phones/tablets, iPhone/iPad, offline playing, reliability before features, hard real-time callback prohibitions, lifecycle/routing/error ownership, bounded control transfer, and future measurable latency/continuity requirements.
3. Describe UAPMD's documented component and data-flow boundaries at a documentary level, including audio rendering, plugin hosting, MIDI/MIDI 2.0, sequencing, platform adapters, language/ABI surfaces, state or persistence responsibilities, and any external projects it depends on. Separate repository fact from inference.
4. Evaluate Apple and Android paths independently. Identify what UAPMD documents for iOS/iPadOS and AUv3, and separately for Android and AAP/AAP-JUCE; do not infer ecosystem parity, store viability, OS support, device coverage, or production readiness.
5. Compare UAPMD with a deliberately small baseline consisting of platform-native ownership plus a portable native DSP/control boundary and the relevant documentary candidates carried from R01. Compare only decision-relevant dimensions; do not turn R02 into the detailed R03/R04 hosting studies or repeat R01 wholesale.
6. Audit evidence for real-time behavior, threading, allocation, locks, I/O, logging, graph mutation, lifecycle, interruption, route change, plugin failure, teardown, and recovery. Absence of evidence is a gap, not proof of safety or unsafety.
7. Audit documentary maturity and maintainability signals: release/revision recency, issue and test evidence when decision-relevant, supported toolchains/platforms, examples, CI or reproducible build instructions, API stability, diagnostics, and bus/format/error contracts. Repository activity alone is not suitability evidence.
8. Identify dependency, transitive-component, asset, permission, privacy, credential, redistribution, commercial-use, patent, trademark, and supply-chain questions without giving legal advice. Record only authoritative license facts that are necessary to understand the candidate; defer item-by-item adoption clearance to R07.
9. Provide a fact/inference/recommendation/disagreement/missing-evidence structure, a weighted or explicitly unweighted criteria matrix with rationale, candidate strengths and risks, disqualifier hypotheses, smallest future spikes, required physical-device measurements, and exact owner decisions. Numeric scoring must explain weights and uncertainty and must not manufacture precision.
10. End with one evidence-bounded disposition: `retain for later spike comparison`, `insufficient evidence—research gap`, or `documented mismatch with a named requirement`. The disposition is a research recommendation only; it is not architecture selection, dependency approval, license clearance, or implementation authorization.

## Explicit non-goals

No clone, checkout, submodule initialization, build, package resolution, code execution, Flutter/native/audio/MIDI/plugin implementation, benchmark, simulator/emulator/device launch, hardware request or operation, minimum-OS change, architecture/ADR edit, dependency or asset adoption, manifest/lockfile change, legal opinion, distribution approval, or performance claim. Detailed Apple hosting belongs to R03, Android hosting to R04, sound engines/formats to R06, and version-specific adoption licensing to R07.

## Evidence and verification

- Prefer the original UAPMD repository, immutable commit/tag/release objects, maintainer documentation, linked original component repositories, platform specifications, and official Apple/Android/Flutter material. Record exact URLs, access timestamps, revisions, unavailable sources, and retrieval limitations.
- Preserve raw source responses or immutable excerpts needed to support decision-driving claims, with hashes, line counts, commands or retrieval methods, and explicit mapping to report claims.
- Record exact candidate SHA, parent/base, date/time/timezone, host OS/architecture/tool versions, device/simulator status (`Not applicable` for documentary checks), configuration, result, responsible role, and artifact locations.
- Run `git diff --check <task-start-commit>..<candidate-commit>`; expected exit 0.
- Run `git diff --name-only <task-start-commit>..<candidate-commit>`; expected exactly `docs/research/UAPMD_EVALUATION.md`.
- Confirm protected product/platform/configuration/manifests/lockfiles and accepted `main` are unchanged. Do not run Flutter commands merely to imply UAPMD or audio correctness when no Flutter file changed.
- Audit every acceptance criterion explicitly and distinguish documentary checks from unperformed builds, spikes, devices, benchmarks, licensing clearance, and product-performance evidence.
- Preserve original Researcher/Conductor/reviewer replies and actual configured dispatch provenance: role, child and relay IDs, effective model/effort/sandbox, exact input commits, rollout hashes/line counts/ordinals, and limitations.
- Required independent reviews: QA/Performance for real-time, measurement, environment, device and evidence claims; Licensing/Security for dependency, license, permission, privacy, credential, redistribution and supply-chain boundaries; then fresh Final Code Review.
- Unresolved Critical or Important findings prevent verification or integration. Corrections return to the same writer for at most five rounds, with affected verification and fresh independent review each round.

## Stop conditions and rollback

Stop for any contract or constitution gate; missing or contradictory primary evidence needed for a decision-driving conclusion; architecture selection; dependency, asset, SDK, submodule or package action; credentials; license uncertainty that blocks even documentary characterization; hardware or benchmark work; allowlist expansion; unsupported real-time, compatibility or performance claim; or unresolved Critical/Important finding.

On failure, preserve the exact task branch, worktree, candidate, raw evidence and review findings. Do not reset, delete, rewrite, publish the task branch, integrate an unverified candidate, weaken criteria, or fill evidence gaps with inference.

## Required reviewers and next authority

The Conductor coordinates only R02 and loses authority when R02 becomes Verified, Blocked, or stopped. Root alone writes shared state, integrates an exact Verified candidate, and publishes only the approved milestone branch through the guard. A Verified R02 result informs later R07 and ADR work; it does not authorize UAPMD adoption, architecture selection, implementation, dependency changes, devices, benchmarks, `main` integration, or M1.
