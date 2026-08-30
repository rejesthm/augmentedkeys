# AugmentedKeys Roadmap

Milestone status is recorded in each milestone section below. Milestone titles describe planned scope, not delivered capability.

## Gated milestone execution

One explicit owner approval may activate one long-running Roadmap Orchestrator Goal for one milestone. The Goal may progress through eligible tasks on the approved milestone branch under `AGENTS.md` and `.codex/skills/roadmap-orchestrator/SKILL.md`. It must stop for non-delegable gates, milestone integration, and the next milestone. This is goal-driven project governance, not scheduled, heartbeat, release, or deployment automation.

## M0  Research & Architecture

Status: Paused for owner decision. Objective: establish evidence-backed requirements, research controls, measurement methods, licensing review, and architecture decision process. Entry condition: approved foundation scope and accepted `docs/orchestration/milestones/M0_CONTRACT.md`. Evidence gate: every contracted M0 task is verified and the owner reviews the complete milestone package. Excluded work: product-core implementation, architecture selection or adoption, dependencies, scheduled or heartbeat automation, and deployment. The owner-approved gated Goal workflow is permitted as governance only; activating M0 still requires explicit owner approval of the displayed foundation and contract commits.

## M1  Audio/MIDI Foundation

Status: not started. Objective: plan and validate the minimum audio and MIDI foundation after M0 decisions. Entry condition: approved evidence-backed architecture decision. Evidence gate: approved implementation scope and relevant objective verification plan. Excluded work: multi-layer patch behavior, plugin hosting, sound-library delivery, and release claims.

## M2  Multi-Layer Patch

Status: not started. Objective: plan and validate multi-layer patch capability. Entry condition: M1 evidence gate and approved patch scope. Evidence gate: objective behavior, continuity, and relevant device evidence. Excluded work: final patch engine breadth, songs/setlists, plugin hosting, and release claims.

## M3  Patch Engine

Status: not started. Objective: plan and validate the patch engine. Entry condition: M2 evidence gate and approved engine scope. Evidence gate: objective patch-loading, switching, and continuity evidence. Excluded work: song/setlist workflow, plugin hosting, and release claims.

## M4  Song + Setlist

Status: not started. Objective: plan and validate song and setlist workflows. Entry condition: M3 evidence gate and approved workflow scope. Evidence gate: objective workflow, persistence, and relevant device evidence. Excluded work: professional MIDI breadth, plugin hosting, and release claims.

## M5  Professional MIDI

Status: not started. Objective: plan and validate professional MIDI workflows and control. Entry condition: M4 evidence gate and approved MIDI scope. Evidence gate: objective controller and device-coverage evidence. Excluded work: plugin hosting, built-in sound-library delivery, and release claims.

## M6  Plugin Hosting

Status: not started. Objective: research, decide, and validate plugin hosting where approved per platform. Entry condition: approved platform-specific evidence and ADRs. Evidence gate: objective platform-specific evidence; no equivalence between Apple and Android ecosystems is assumed. Excluded work: claiming cross-platform plugin parity, sound-library completion, and release claims.

## M7  Built-In Sound Library

Status: not started. Objective: plan and validate an original, licensed built-in sound library. Entry condition: approved sound format, content scope, and license ledger entries. Evidence gate: objective quality, loading, continuity, and licensing evidence. Excluded work: unreviewed assets and release claims.

## M8  Advanced Performance

Status: not started. Objective: plan and validate advanced live-performance workflows. Entry condition: prior milestone evidence and approved feature scope. Evidence gate: objective live-workflow, accessibility, and device evidence. Excluded work: production-release claims.

## M9  Production Hardening

Status: not started. Objective: establish production reliability, performance, security, and operational evidence. Entry condition: approved feature scope and measurement budgets. Evidence gate: objective physical-device, long-duration, regression, and security evidence. Excluded work: release-candidate declaration.

## M10 Release Candidate

Status: not started. Objective: prepare a release candidate only after all required evidence is accepted. Entry condition: M9 gate and owner-approved release scope. Evidence gate: complete objective evidence, relevant device coverage, licensing review, and explicit owner approval. Excluded work: unattended release, signing, store submission, or deployment without separate approval.
