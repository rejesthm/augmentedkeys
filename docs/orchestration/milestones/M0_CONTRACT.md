# M0 Roadmap Orchestrator Authorization Contract

Status: `Paused for owner decision`
Contract version: 2

## Binding inputs

- Operating constitution: `AGENTS.md`
- Roadmap: `ROADMAP.md`
- Orchestrator skill: `.codex/skills/roadmap-orchestrator/SKILL.md`
- Queue: `docs/research/RESEARCH_INDEX.md`
- Ledger: `docs/orchestration/milestones/M0_LEDGER.md`
- Gate controls: `gate.yaml` and `loop-budget.md`
- Previously accepted contract source: `0d86705ca130fcc3bdb73a9acf3f21fd803912dd` (version 1)
- Narrow correction authority: OD-004 at `82dc35ac2042ab4697b322dabd1fb03c61a5ae5a`

The controller must display and record the exact accepted `main` commit and the latest commit returned by `git log -1 --format=%H -- docs/orchestration/milestones/M0_CONTRACT.md` before requesting activation. Owner approval binds only to those displayed commits.

## Version 2 dispatch correction

OD-004 authorizes only replacement of the failed nested mixed-permission launch topology. For each role selected by the Conductor, the Roadmap Orchestrator controller launches one separate project-rooted top-level relay whose effective permission class matches its exactly one configured child. Relays perform no task work. The Conductor returns exact dispatch requests to the controller and must not directly spawn specialists. No read-only role may be nested below a workspace-write session, and no write-capable role may be nested below a read-only session.

This correction does not reactivate M0 or R01 by itself. M0 remains `Paused for owner decision` and R01 remains `Blocked` until committed runtime evidence proves the configured Conductor and all required read-only roles have their contracted model, reasoning effort, and effective sandbox; a fresh independent reviewer reports no Critical or Important finding; and the controller commits the separate reactivation decision and state barriers required by OD-004. The correction changes no research authority, milestone outcome, queue, dependency, output, definition of done, safety gate, publication authority, or non-goal.

## Objective

Produce verified, evidence-backed answers for the ten contracted M0 research questions without selecting architecture, adopting a dependency or asset, implementing product-core behavior, or claiming unmeasured device performance.

## Entry conditions

1. The gated Roadmap Orchestrator setup has independent approval with no Critical or Important finding.
2. The repository foundation has owner acceptance.
3. Local `main`, `origin/main`, and the displayed foundation commit are identical and clean.
4. The owner has been shown this contract's path, latest content-changing commit, queue, definition of done, branch, allowed paths, evidence, publication authority, and stop conditions.
5. The owner sends the exact M0 activation statement in response to those displayed commits.
6. No Roadmap Orchestrator Goal or write task is active.
7. The branch `milestone/m0-research` is absent, or it is an exact clean resumable branch recorded in the ledger.
8. For reactivation after G01, the role-isolated correction is committed under OD-004 and the controller has committed source-backed runtime proof for the configured Conductor, Researcher, QA/Performance Verifier, Licensing/Security Reviewer, and Final Code Reviewer.
9. A fresh independent read-only review of the exact correction and runtime provenance reports no Critical or Important finding.
10. A separate committed reactivation decision artifact binds the corrected contract and validation/review commits before the milestone and R01 state-transition barriers run; no research executes between those commits.

## Definition of done

1. R01 through R10 are `Verified` or `Accepted` with their contracted outputs, committed briefs, committed verification artifacts, required specialist reviews, and no unresolved Critical or Important finding.
2. Every transition is recorded in the ledger and agrees with the queue, branches, commits, and evidence.
3. Research separates fact, inference, recommendation, disagreement, missing evidence, and owner decision.
4. No research conclusion is represented as architecture adoption, dependency approval, product implementation, or measured device performance.
5. The milestone completion package required by the orchestrator skill is complete and the milestone branch's local and remote hashes match.

A blocked or deferred task remains part of the definition of done. Removing or waiving it requires an owner-approved contract change; otherwise the milestone pauses for owner decision.

## Branches and canonical artifacts

- Milestone branch: `milestone/m0-research`
- State ledger: `docs/orchestration/milestones/M0_LEDGER.md`
- Owner decisions: `docs/orchestration/milestones/m0/evidence/owner-decisions.md`
- Milestone transition evidence: `docs/orchestration/milestones/m0/evidence/milestone-transitions.md`
- Completion package: `docs/orchestration/milestones/m0/evidence/completion-package.md`

The exact branch, brief, and verification-artifact paths for every task are fixed in the queue table below; the Goal may not generate a substitute path.

Task branches are never published by this workflow. Material unintegrated task branches and worktrees are never deleted automatically.

## Ordered queue and dependencies

| Priority | ID | Research question | Dependencies | Task branch | Brief | Verification artifact | Transition evidence | Contracted output |
|---:|---|---|---|---|---|---|---|---|
| 1 | R01 | Mobile low-latency audio architecture | None | `task/m0-r01-audio-architecture` | `docs/orchestration/milestones/m0/tasks/r01-brief.md` | `docs/orchestration/milestones/m0/evidence/r01-verification.md` | `docs/orchestration/milestones/m0/evidence/r01-transitions.md` | `docs/research/MOBILE_AUDIO_ARCHITECTURE.md`; `docs/research/LOW_LATENCY_RESEARCH.md` |
| 2 | R02 | UAPMD objective evaluation | R01 | `task/m0-r02-uapmd` | `docs/orchestration/milestones/m0/tasks/r02-brief.md` | `docs/orchestration/milestones/m0/evidence/r02-verification.md` | `docs/orchestration/milestones/m0/evidence/r02-transitions.md` | `docs/research/UAPMD_EVALUATION.md` |
| 3 | R03 | iOS/iPadOS audio and AUv3 hosting | None | `task/m0-r03-apple-audio` | `docs/orchestration/milestones/m0/tasks/r03-brief.md` | `docs/orchestration/milestones/m0/evidence/r03-verification.md` | `docs/orchestration/milestones/m0/evidence/r03-transitions.md` | `docs/research/IOS_AUDIO_RESEARCH.md`; `docs/research/PLUGIN_HOSTING_RESEARCH.md` |
| 4 | R04 | Android audio, Oboe/AAudio, AAP/AAP-JUCE | None | `task/m0-r04-android-audio` | `docs/orchestration/milestones/m0/tasks/r04-brief.md` | `docs/orchestration/milestones/m0/evidence/r04-verification.md` | `docs/orchestration/milestones/m0/evidence/r04-transitions.md` | `docs/research/ANDROID_AUDIO_RESEARCH.md`; `docs/research/PLUGIN_HOSTING_RESEARCH.md` |
| 5 | R05 | MIDI 1.0/2.0, Core MIDI, Android MIDI, MPE | None | `task/m0-r05-midi` | `docs/orchestration/milestones/m0/tasks/r05-brief.md` | `docs/orchestration/milestones/m0/evidence/r05-verification.md` | `docs/orchestration/milestones/m0/evidence/r05-transitions.md` | `docs/research/MIDI_RESEARCH.md` |
| 6 | R06 | Built-in sampler/synth engine and SF2/SFZ options | R01 | `task/m0-r06-sound-engine` | `docs/orchestration/milestones/m0/tasks/r06-brief.md` | `docs/orchestration/milestones/m0/evidence/r06-verification.md` | `docs/orchestration/milestones/m0/evidence/r06-transitions.md` | `docs/research/SOUND_ENGINE_RESEARCH.md` |
| 7 | R07 | Licensing risks | R02, R03, R04, R06 | `task/m0-r07-licensing` | `docs/orchestration/milestones/m0/tasks/r07-brief.md` | `docs/orchestration/milestones/m0/evidence/r07-verification.md` | `docs/orchestration/milestones/m0/evidence/r07-transitions.md` | `docs/research/LICENSE_LEDGER.md` |
| 8 | R08 | Sunday Keys public capability/workflow analysis | None | `task/m0-r08-sunday-keys` | `docs/orchestration/milestones/m0/tasks/r08-brief.md` | `docs/orchestration/milestones/m0/evidence/r08-verification.md` | `docs/orchestration/milestones/m0/evidence/r08-transitions.md` | `docs/research/SUNDAY_KEYS_ANALYSIS.md` |
| 9 | R09 | MainStage public capability/workflow analysis | None | `task/m0-r09-mainstage` | `docs/orchestration/milestones/m0/tasks/r09-brief.md` | `docs/orchestration/milestones/m0/evidence/r09-verification.md` | `docs/orchestration/milestones/m0/evidence/r09-transitions.md` | `docs/research/MAINSTAGE_ANALYSIS.md` |
| 10 | R10 | Competing mobile live-performance workflows | None | `task/m0-r10-mobile-competitors` | `docs/orchestration/milestones/m0/tasks/r10-brief.md` | `docs/orchestration/milestones/m0/evidence/r10-verification.md` | `docs/orchestration/milestones/m0/evidence/r10-transitions.md` | `docs/research/COMPETITOR_MATRIX.md` |

The order is priority order, not permission to ignore dependencies. If the highest-priority task is blocked, another dependency-independent task may proceed only under the orchestrator skill.

## Allowed paths

The Goal may change only:

- `STATE.md` and `.loop/progress.md`;
- `docs/orchestration/milestones/M0_LEDGER.md`;
- `docs/orchestration/milestones/m0/tasks/*.md`;
- `docs/orchestration/milestones/m0/evidence/*.md`;
- `docs/research/RESEARCH_INDEX.md` status fields;
- the exact contracted research outputs listed in the queue table;
- the leading `Status:` sentence in the M0 section of `ROADMAP.md`, only to mirror a permitted milestone transition to `Active`, `Paused for owner decision`, `Ready for owner review`, or owner-decision-backed `Accepted` in the second commit of the transition barrier. `Accepted` requires the exact committed owner acceptance decision; it authorizes no other roadmap change.

`ROADMAP.md` is the only protected path explicitly in scope, and only for the exact M0 status sentence. The contract, skill, operating constitution, product specification, architecture file, ADRs, gate, budget, manifests, lockfile, product code, native hosts, agent configuration, and manual Loop skill are outside the allowlist.

## Non-goals

- No product-core, audio, MIDI, plugin-hosting, sound-engine, UI, native-host, release, deployment, signing, or store-submission implementation.
- No architecture or ADR selection, adoption, or material change.
- No dependency, package, framework, asset, font, icon, sound, sample, patch, DSP, or plugin adoption.
- No credential, paid-service, entitlement, hardware, destructive, scheduled, or heartbeat action.
- No promise of smoothness, continuity, reliability, real-time safety, compatibility, or low latency without the required real-device evidence.

## Required evidence and review

- Use current primary and official sources, original repositories, specifications, and maintainer material; record URLs and access dates.
- Record exact source versions, disagreements, missing evidence, limitations, and decisions still owned by the owner.
- Commit one bounded brief and one verification artifact per task at the canonical paths.
- Require QA/Performance review for measurement, environment, device, real-time, latency, and evidence claims.
- Require Licensing/Security review for dependencies, assets, permissions, privacy, credentials, redistribution, commercial use, or supply-chain questions.
- Require fresh independent Final Code Review for every task and for the milestone package.
- Physical-device, controller, or interface work requires a separately approved procedure and identified hardware.

## Publication authority

The only pre-authorized external action is asking the deterministic guard to push the exact `refs/heads/milestone/m0-research:refs/heads/milestone/m0-research` refspec after it validates the clean checked-out local ref, exact SHA, accepted-foundation ancestry, and contracted branch. The guard performs the push and must prove the remote hash equals the authorized local hash. No separate raw `git push` is permitted.

The Goal may not publish task branches, push or merge `main`, open a pull request, auto-merge, force-push, release, deploy, sign, submit to a store, delete material work, or take another external action.

## Stop conditions

Pause for the owner when any mandatory gate in `AGENTS.md` or the orchestrator skill applies; an entry condition fails; a path is outside the allowlist; evidence is missing or unsupported; a Critical or Important finding remains; five correction rounds fail; a blocker prevents the definition of done; local/remote state is inconsistent; or the objective, queue, dependencies, definition of done, safety controls, or contract would change.

When every task satisfies the definition of done, set the milestone to `Ready for owner review` and stop. Do not integrate `main` or begin M1.

At owner review, one committed owner decision may return `Ready for owner review` to `Active` for exact corrections already inside this contract and may reopen named `Verified` tasks to `In progress`; every reopened task requires fresh verification and independent review. A correction outside this contract requires a new approved design and contract change. `Accepted` is terminal.

## Activation statement

After displaying the exact accepted foundation commit and the latest commit that changes this contract, request:

`I accept the repository foundation and approve M0 activation using the Gated Roadmap Orchestrator.`

The statement binds only to the displayed commits and authorizes one M0 Goal plus `milestone/m0-research`. It does not authorize M1 or any non-goal above.
