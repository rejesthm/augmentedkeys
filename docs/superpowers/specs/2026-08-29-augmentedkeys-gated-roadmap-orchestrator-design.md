# AugmentedKeys Gated Roadmap Orchestrator Design

Date: 2026-08-29
Status: Owner-approved design; implementation not yet started

## Decision summary

AugmentedKeys will use a goal-driven Roadmap Orchestrator to continue automatically through the eligible tasks of one owner-approved milestone. The owner approves work once at milestone entry rather than at every routine task boundary. Verified task changes accumulate on a dedicated milestone branch. The orchestrator never merges that branch into `main` and never begins the next milestone without a new owner approval.

The Roadmap Orchestrator is the long-running Codex Goal, not a ninth project subagent. The existing eight project agents remain bounded specialists. A project-local `roadmap-orchestrator` skill will hold the durable workflow and safety contract used by each milestone Goal.

## Context

The repository currently authorizes the Conductor for one owner-approved task and ends that authority at the task boundary. M0 also excludes automation. Those constraints were appropriate for foundation setup but do not permit the newly approved continuous milestone workflow.

Implementation of this design will make a narrow governance change: one milestone approval may authorize automatic progression across eligible tasks inside that milestone. It will not authorize architecture adoption, dependencies or assets, credentials, hardware actions, releases, destructive actions, or integration into `main`.

Official Codex guidance supports long-running Goals with explicit outcomes, constraints, verification, and preserved approval boundaries. It also supports bounded subagent delegation and recommends avoiding overlapping write ownership.

References:

- https://learn.chatgpt.com/docs/long-running-work
- https://learn.chatgpt.com/docs/agent-configuration/subagents
- https://learn.chatgpt.com/docs/automations

## Goals

- Continue through eligible tasks within one approved milestone without requesting routine per-task approval.
- Keep one durable controller responsible for milestone state, ordering, branch safety, and user-facing decisions.
- Preserve bounded task execution through the existing Conductor and specialist agents.
- Require independent verification and review before any task is integrated into the milestone branch.
- Preserve honest evidence, especially for low latency, reliability, simulator, emulator, and physical-device claims.
- Pause at every material owner, safety, legal, architecture, dependency, hardware, external-action, and milestone boundary.
- Leave `main` unchanged until the owner reviews and approves the complete milestone.

## Non-goals

- No unrestricted autopilot from M0 through M10.
- No ninth specialist agent.
- No scheduled or heartbeat automation in the initial version.
- No automatic pull request, merge to `main`, release, deployment, store submission, signing, or force-push.
- No product-core implementation as part of the orchestrator setup.
- No architecture, dependency, package, asset, sound, sample, DSP, plugin, or licensing decision.
- No claim that this workflow proves application smoothness, audio continuity, real-time safety, or low latency.

## Agent architecture

The authority chain is:

```text
Owner
  -> Roadmap Orchestrator Goal
    -> Conductor for one bounded task
      -> required specialist agents
```

### Owner

The owner approves milestone entry, milestone integration, architecture decisions, dependencies and assets, exceptional scope, credentials, required hardware actions, destructive actions, and releases.

### Roadmap Orchestrator Goal

The Goal owns exactly one approved milestone. It reads the durable project state, selects the next eligible task, creates a bounded brief, invokes the Conductor, integrates verified task commits into the milestone branch, updates the ledger, and advances automatically when safe.

The Goal does not implement product work. It does not bypass specialist boundaries or review gates. When the milestone is ready for owner review, the Goal stops. A later milestone requires a new explicit approval and a new milestone Goal.

### Conductor

The existing Conductor remains task-scoped. It receives one brief from the Roadmap Orchestrator, chooses only the specialists needed for that task, coordinates correction rounds, and returns verified task evidence. Its authority ends when that task is verified, blocked, or stopped.

### Specialists

The existing Researcher, Flutter Builder, Apple Specialist, Android Specialist, QA/Performance Verifier, Licensing/Security Reviewer, and Final Code Reviewer keep their approved responsibilities and sandbox boundaries. At most three spawned specialists may run concurrently. Parallel work should be read-heavy; sensitive write ownership remains exclusive.

## Milestone authorization contract

Before a Goal starts, the approved milestone scope must identify:

- milestone identifier, objective, entry conditions, and definition of done;
- ordered task queue and dependency relationships;
- approved branch name;
- allowed path patterns and protected paths explicitly in scope;
- non-goals and deferred milestones;
- required research, tests, builds, measurements, reviews, and device evidence;
- authorized external action limited to pushing the milestone branch;
- stop conditions and owner decisions that cannot be delegated.

Milestone approval authorizes routine work only inside that contract. A task that exceeds it is not eligible and cannot be made eligible by the Roadmap Orchestrator.

## Durable workflow contract

The executable orchestration instructions will live in:

```text
.codex/skills/roadmap-orchestrator/SKILL.md
```

`AGENTS.md` will define the durable authority boundary and require that skill for a milestone Goal. `ROADMAP.md` will permit only this owner-approved gated orchestration while retaining the prohibition on unattended product or release automation.

Durable state remains repository-backed:

- `ROADMAP.md` defines milestone order, entry conditions, and evidence gates.
- `STATE.md` gives the concise current milestone and blocker summary.
- `.loop/progress.md` records active status, completed work, verification needs, blockers, and evidence.
- The applicable research index or implementation plan defines the ordered task queue.
- Each task has a committed brief and a verification report or equivalent evidence artifact before integration.

The manual L1 Loop remains separate and report-only. It may not launch the Roadmap Orchestrator, Conductor, or specialists.

## State model

Milestone states are:

- `Awaiting owner approval`
- `Active`
- `Paused for owner decision`
- `Ready for owner review`
- `Accepted`

Task states are:

- `Queued`
- `Eligible`
- `In progress`
- `In review`
- `Verified`
- `Blocked`
- `Deferred`
- `Accepted`

Only one write task may be `In progress` at a time. Independent read-only investigations may run concurrently within the three-specialist limit. Research results may reach `In review` or `Verified`, but task-level `Accepted` status that requires product-owner acceptance is applied only through the owner's milestone review.

Every state transition must record a date, task identifier, responsible role, source commit, evidence location, and reason. A session may resume only from committed state; chat memory alone is not authoritative.

## Branch and worktree model

Each milestone uses one integration branch created from an up-to-date, clean `main`:

```text
milestone/<milestone-id>-<short-slug>
```

Each write task uses a short-lived isolated branch and worktree created from the current milestone branch:

```text
task/<milestone-id>-<task-id>-<short-slug>
```

Write tasks are integrated sequentially. A task branch cannot change after independent final review without repeating the affected verification and review. After approval, it is fast-forwarded into the milestone branch when possible. The orchestrator then updates milestone state and pushes only the milestone branch.

After every push, local and remote milestone-branch hashes must match. Task branches need not be published. No agent may push directly to `main`, force-push, merge the milestone branch into `main`, or delete material work without separate owner authorization.

## Continuous task workflow

For an active milestone, the Roadmap Orchestrator repeats this cycle:

1. Verify the repository, milestone branch, remote ancestry, and committed state are clean and consistent.
2. Select the highest-priority eligible task whose dependencies and required authority are satisfied.
3. Create a task brief containing objective, scope, non-goals, allowed files, acceptance criteria, evidence requirements, stop conditions, and assigned write ownership.
4. Give the bounded task to the Conductor.
5. Let the Conductor dispatch only the specialists that materially improve the task, with no overlapping sensitive writes.
6. Require task-specific verification, applicable QA/performance review, applicable licensing/security review, and fresh independent final review.
7. Return blocking findings to the same implementer, rerun affected verification, and obtain fresh re-review.
8. Integrate an approved task into the milestone branch, update durable state, push the milestone branch, and prove the remote hash.
9. Start the next eligible task without requesting routine owner approval.
10. Stop when the milestone is complete, no safe eligible task remains, or a mandatory gate is reached.

If one task is blocked, the orchestrator may select a different independent eligible task. It may not reorder work in a way that ignores a dependency, changes milestone outcomes, or converts an owner decision into an agent decision.

## Mandatory owner gates

The Roadmap Orchestrator must pause before:

- beginning a new milestone;
- merging a milestone branch into `main`;
- selecting, adopting, or materially changing architecture or an ADR;
- adding, replacing, or approving dependencies, packages, assets, fonts, icons, sounds, samples, patches, DSP, plugins, or frameworks;
- using credentials, signing identities, entitlements, paid services, secrets, or external accounts;
- asking for or operating required physical devices, MIDI controllers, or audio interfaces beyond a previously approved test procedure;
- opening a pull request, releasing, deploying, signing, submitting to a store, or taking another external action not explicitly allowed by the milestone contract;
- touching a path or scope outside the milestone allowlist;
- performing a destructive or difficult-to-reverse action;
- proceeding with unresolved Critical or Important findings;
- accepting missing, conflicting, or insufficient licensing evidence;
- claiming evidence that cannot identify the environment and measurement method;
- changing the milestone objective, definition of done, task queue semantics, or safety gates.

Milestone-branch pushes are the only external repository action pre-authorized by milestone approval.

## Failure and blocker handling

A task may receive at most five implementation correction rounds. Each round returns findings to the same writer when available, reruns the complete affected verification, and requires fresh independent review.

If blocking findings remain after five rounds, or if the task needs an unavailable owner decision, credential, hardware item, license conclusion, or out-of-scope change, the task becomes `Blocked`. The orchestrator records the exact evidence and preserves the worktree and branch. It must not weaken tests, remove findings, invent evidence, widen scope, or bypass the gate.

The orchestrator may continue with another independent eligible task. If none remains, it pauses the milestone and presents one concrete decision request containing the blocker, attempted work, preserved state, options, and impact.

No branch or worktree containing material unintegrated work is deleted automatically. No force operation is permitted.

## Evidence and review policy

Research tasks must prefer current official documentation, specifications, original repositories, maintainers, and primary technical material. They must separate fact, inference, recommendation, disagreement, missing evidence, and owner decision.

Implementation tasks must use test-first development where behavior is testable and must run the full relevant verification defined by `AGENTS.md` and the task brief. Generated artifacts, dependency changes, platform permissions, secrets, and unrelated changes must be checked explicitly.

QA/Performance review verifies command output, test environment, device identity, configuration, measurement method, regressions, and unsupported claims. Licensing/Security review is mandatory when a task touches dependencies, assets, permissions, privacy, credentials, redistribution, or commercial-use questions. Final Code Review is always required and must be independent of the implementer.

No task is integrated into the milestone branch while a Critical or Important finding remains. A passing Flutter test suite is not evidence of low audio latency, callback safety, device compatibility, or live-performance reliability.

## Milestone completion package

When no eligible milestone task remains, the Roadmap Orchestrator sets the milestone to `Ready for owner review` and stops. It presents:

- completed, verified, blocked, and deferred task lists;
- milestone branch name and local/remote commit hashes;
- task commits and changed-file summary;
- research sources, verification output, builds, measurements, and independent review verdicts;
- dependency, asset, licensing, security, and permission changes;
- exact simulator, emulator, physical-device, MIDI-controller, and audio-interface evidence actually produced;
- unresolved limitations, rejected alternatives, deferred risks, and missing evidence;
- the proposed `main` integration action and rollback considerations.

The owner may approve integration, request corrections, change scope through a new design, or leave the branch intact. Approval to integrate one milestone does not approve the next milestone.

## Orchestrator setup verification

Before the first milestone Goal is activated, implementation must prove:

- the project-local skill is discoverable and its instructions load in a trusted project-rooted Codex session;
- current project agent discovery and the three-specialist limit remain valid;
- the manual L1 Loop still refuses to launch agents;
- the repository policies and roadmap contain no contradictory task- versus milestone-authority language;
- branch and remote-hash checks reject direct `main` publication;
- the Flutter foundation verification still passes and no product code or dependency changed.

Read-only pressure tests must cover:

1. successful task completion advances to the next eligible task;
2. dependency or architecture adoption pauses for the owner;
3. failed review returns to the same writer and requires re-review;
4. five failed correction rounds block the task;
5. an independent eligible task may proceed around a blocker;
6. a direct `main` push or merge is refused;
7. milestone completion stops and requests owner review;
8. unsupported latency, reliability, simulator, or physical-device claims are rejected.

Independent final review must approve the complete setup before activation.

## Activation and lifecycle

The initial implementation creates the project-local skill and updates only the governance, roadmap, and state files required by this design. It does not start M0 research automatically.

After setup verification and independent review, the owner must explicitly accept the repository foundation and approve M0. The first Goal then uses the Roadmap Orchestrator skill and creates the approved M0 milestone branch. Goal mode, not a scheduled task, supplies continuity. If the Goal is paused or the app is unavailable, work resumes from committed repository state when the same Goal continues.

When M0 reaches `Ready for owner review`, the Goal stops. After owner acceptance and separately authorized integration, an M1 Goal may be created only if the owner explicitly approves M1. This pattern repeats through the roadmap; no single approval spans M0 through M10.

## Acceptance criteria

The implementation is acceptable only when:

1. The Roadmap Orchestrator is implemented as a long-running Goal backed by one project-local skill, not a ninth specialist agent.
2. The existing eight-agent roster and role boundaries remain valid.
3. One owner approval authorizes eligible tasks only within one milestone contract.
4. The Conductor remains bounded to one task at a time.
5. At most three specialists run concurrently and write ownership never overlaps.
6. Every write task uses an isolated task branch/worktree and is integrated sequentially.
7. Verified tasks may be committed and pushed only to the milestone branch.
8. Direct or automatic changes to `main` are refused.
9. All mandatory owner gates are explicit and pressure-tested.
10. Correction handling is bounded to five rounds and preserves blocked work and evidence.
11. Durable repository state is authoritative across sessions and context compaction.
12. The manual L1 Loop remains report-only and cannot launch the agent team.
13. Milestone completion stops for owner review with the complete evidence package.
14. No product code, dependency, architecture, automation schedule, release, device test, audio/MIDI work, latency benchmark, or performance claim is introduced by setup.
15. Independent final review reports no Critical or Important finding before activation.

## Approved design decisions

- Autonomy: gated continuous.
- Approval frequency: once per milestone.
- Publication: dedicated milestone branch.
- Runtime: goal-driven Roadmap Orchestrator.
- Agent structure: the Goal orchestrates the existing Conductor and eight specialists; no ninth specialist.
- Integration: owner approval is required before `main` changes and before the next milestone begins.
