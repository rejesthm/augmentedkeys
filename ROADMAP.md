# AugmentedKeys Roadmap

Milestone status is recorded in each milestone section below. Milestone titles describe planned scope, not delivered capability.

## First playable worship app: revised delivery direction

The owner approved prioritizing a playable first version on 2026-10-23. The [written design](docs/superpowers/specs/2026-10-23-worship-patch-builder-design.md) defines the proposed scope, acceptance checks, and research-contract changes for decision-team review; detailed team acceptance is pending. The delivery order below revises future product priorities; it does not activate a milestone, supersede an executable contract, or mark research complete.

| Delivery | User-visible result | Required evidence before advancing |
| --- | --- | --- |
| M0 rebaseline proposal | A focused path to the built-in instrument, preserving verified R01/R02 research | Reconcile the separate governance and research histories; independently review the exact contract amendment before activation. Retain essential platform, MIDI, sound-engine, and licensing research; explicitly defer broader plugin and competitor work without marking it verified. |
| M1: playable instrument | Hear approved piano, pad, and synth sounds using touch or one supported wired MIDI controller | Approved architecture after a bounded spike and benchmark; source-specific license entries; real audio and MIDI integration; physical-device results for each claimed platform |
| M2: patch builder | Blend up to four layers, adjust effects, and save/reopen a patch offline | Six original starter patches; controls audibly connected to the engine; save/restart and failure-recovery tests; maximum supported workload measured |
| M3: performance variations | Recall verse, chorus, and bridge settings and safely change patches | Held-note, sustain, tail, load-failure, and switching evidence under predeclared conditions; panic control and recovery checks |
| M4: first-version workflow | Build a setlist, reopen it, and perform in order | End-to-end offline rehearsal, accessibility, lifecycle, persistence, and physical-device verification; explicit limitations for the tested build |
| Later capabilities | Advanced MIDI, plugin hosting, larger sound library, and advanced performance | Separate milestone contracts and platform-specific evidence; these are not prerequisites for the first playable workflow |

Reliability checks accompany each delivery. M9 remains the broader production-hardening milestone, and M10 remains the release-candidate gate. An internally usable M4 build is not store-release approval.

The checked-out governance history and `milestone/m0-research` contain different M0 state records. The design records their exact inspected tips and the newer research evidence. This planning change does not reconcile those histories or override the pause recorded below.

## Gated milestone execution

One explicit owner approval may activate the first long-running Roadmap Orchestrator Goal. The Goal may progress through eligible tasks on one approved milestone branch under `AGENTS.md` and `.codex/skills/roadmap-orchestrator/SKILL.md`, then move a completed milestone to `Ready for decision`. An independent read-only Decision Steward may accept the exact reviewed milestone, separately authorize the exact guarded fast-forward into an unchanged `main`, and separately activate one exact committed and independently reviewed successor contract whose entry conditions pass. The controller records each immutable package, verbatim verdict, and current binding on the dedicated guarded append-only `governance/decision-evidence` branch; later bindings supersede old approvals. Every bound SHA change requires affected fresh review and a fresh verdict, and any ambiguous integration becomes non-replayable `PARTIAL` with `PAUSE_HUMAN`. Human-only gates still pause the workflow. This is goal-driven project governance, not scheduled, heartbeat, release, or deployment automation.

## M0  Research & Architecture

Status: Ready for decision. Objective: establish evidence-backed requirements, research controls, measurement methods, licensing review, and architecture decision process. Entry condition: approved foundation scope and accepted `docs/orchestration/milestones/M0_CONTRACT.md`. Evidence gate: every contracted M0 task is verified and the Decision Steward evaluates the immutable completion package. Excluded work: product-core implementation, architecture selection or adoption, dependencies, scheduled or heartbeat automation, and deployment. OD-007 reactivated M0 after the governance correction passed independent review; the frozen completed candidate now requires fresh whole-milestone reviews and an exact Decision Steward verdict.

## M1  Audio/MIDI Foundation

Status: not started. Revised planned objective: deliver the smallest playable built-in instrument after the required research and decisions, including approved piano, pad, and synth sound sources, touch playback, and basic wired MIDI. Entry condition: an approved successor contract, evidence-backed architecture decision, license clearance for every adopted dependency and sound source, and an approved device procedure. Evidence gate: actual playback, note/sustain lifecycle, interruption recovery, and relevant physical-device measurements. Excluded work: multi-layer patch editing, plugin hosting, broad sound-library expansion, and release claims.

## M2  Multi-Layer Patch

Status: not started. Revised planned objective: deliver a beginner-friendly builder with up to four layers, volume/brightness/reverb/delay controls, six original starter patches, and local save/reopen. Entry condition: M1 evidence gate and an approved patch, effects, content, and persistence scope. Evidence gate: real audio behavior, validation and recovery tests, persistence across restart, and supported-workload measurements. Excluded work: song/setlist organization, plugin hosting, advanced modulation, and release claims.

## M3  Patch Engine

Status: not started. Revised planned objective: deliver three named variations per patch and reliable patch loading and switching. Entry condition: M2 evidence gate and approved snapshot and continuity scope. Evidence gate: objective held-note, sustain, release-tail, load-failure, panic, and switching evidence on declared devices. Excluded work: song/setlist organization, plugin hosting, and release claims.

## M4  Song + Setlist

Status: not started. Revised planned objective: complete the first-version workflow with named songs, ordered setlists, and a performance view using the verified patch engine. Entry condition: M3 evidence gate and an approved workflow scope. Evidence gate: a complete offline create/save/restart/perform rehearsal, persistence and accessibility checks, interruption recovery, and relevant physical-device evidence. Excluded work: professional MIDI breadth, plugin hosting, cloud workflows, and public-release claims.

## M5  Professional MIDI

Status: not started. Objective: plan and validate professional MIDI workflows and control. Entry condition: M4 evidence gate and approved MIDI scope. Evidence gate: objective controller and device-coverage evidence. Excluded work: plugin hosting, built-in sound-library delivery, and release claims.

## M6  Plugin Hosting

Status: not started. Objective: research, decide, and validate plugin hosting where approved per platform. Entry condition: approved platform-specific evidence and ADRs. Evidence gate: objective platform-specific evidence; no equivalence between Apple and Android ecosystems is assumed. Excluded work: claiming cross-platform plugin parity, sound-library completion, and release claims.

## M7  Built-In Sound Library

Status: not started. Revised planned objective: expand the original, licensed built-in sound collection beyond the minimum sources and starter patches delivered with M1/M2. Entry condition: approved sound format, additional content scope, and license ledger entries. Evidence gate: objective quality, loading, continuity, and licensing evidence. Excluded work: unreviewed assets and release claims. The small first-version collection is no longer deferred until this milestone.

## M8  Advanced Performance

Status: not started. Objective: plan and validate advanced live-performance workflows. Entry condition: prior milestone evidence and approved feature scope. Evidence gate: objective live-workflow, accessibility, and device evidence. Excluded work: production-release claims.

## M9  Production Hardening

Status: not started. Objective: establish production reliability, performance, security, and operational evidence. Entry condition: approved feature scope and measurement budgets. Evidence gate: objective physical-device, long-duration, regression, and security evidence. Excluded work: release-candidate declaration.

## M10 Release Candidate

Status: not started. Objective: prepare a release candidate only after all required evidence is accepted. Entry condition: M9 gate and owner-approved release scope. Evidence gate: complete objective evidence, relevant device coverage, licensing review, and explicit owner approval. Excluded work: unattended release, signing, store submission, or deployment without separate approval.
