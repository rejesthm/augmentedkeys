# M0 Roadmap Orchestrator Authorization Contract

Status: `Paused for owner decision`; this superseding governance text does not reactivate M0
Contract version: 2

## Binding inputs

- Operating constitution: `AGENTS.md`
- Roadmap: `ROADMAP.md`
- Orchestrator skill: `.codex/skills/roadmap-orchestrator/SKILL.md`
- Decision Steward policy: `.codex/skills/decision-steward/SKILL.md` and `docs/orchestration/DECISION_POLICY.md`
- Queue: `docs/research/RESEARCH_INDEX.md`
- Ledger: `docs/orchestration/milestones/M0_LEDGER.md`
- Gate controls: `gate.yaml` and `loop-budget.md`

The controller must display and record the exact accepted `main` commit and the latest commit returned by `git log -1 --format=%H -- docs/orchestration/milestones/M0_CONTRACT.md` before requesting activation. Owner approval binds only to those displayed commits.

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
8. Reactivation after G01 additionally requires successful runtime evidence for the permission-isolated top-level role handoffs, all required independent setup reviews with no unresolved Critical or Important finding, and a committed owner decision that resolves the recorded pause.

## Definition of done

1. R01 through R10 are `Verified` or `Accepted` with their contracted outputs, committed briefs, committed verification artifacts, required specialist reviews, and no unresolved Critical or Important finding.
2. Every transition is recorded in the ledger and agrees with the queue, branches, commits, and evidence.
3. Research separates fact, inference, recommendation, disagreement, missing evidence, and owner decision.
4. No research conclusion is represented as architecture adoption, dependency approval, product implementation, or measured device performance.
5. The milestone completion package required by the orchestrator skill is complete and the milestone branch's local and remote hashes match.
6. The exact completed milestone candidate and all required review artifacts are ready for an independent Decision Steward verdict. Completion alone does not authorize acceptance, `main` integration, or M1 activation.

A blocked or deferred task remains part of the definition of done. Removing or waiving it requires an owner-approved contract change; otherwise the milestone pauses for owner decision.

## Branches and canonical artifacts

- Milestone branch: `milestone/m0-research`
- Decision-evidence branch: `governance/decision-evidence`; dedicated isolated controller-owned worktree; append-only; not created or published by this contract update
- Decision-evidence governance base: recorded in `docs/orchestration/milestones/M0_LEDGER.md` before branch creation and repeated in immutable `docs/orchestration/decisions/governance-base.md` by the direct-child creation commit
- Canonical governance-evidence root: `docs/orchestration/decisions/m0/` on `governance/decision-evidence`
- Evidence schema and recovery protocol: `docs/orchestration/decisions/README.md`
- State ledger: `docs/orchestration/milestones/M0_LEDGER.md`
- Owner decisions: `docs/orchestration/milestones/m0/evidence/owner-decisions.md`
- Milestone transition evidence: `docs/orchestration/milestones/m0/evidence/milestone-transitions.md`
- Completion package: `docs/orchestration/milestones/m0/evidence/completion-package.md`
- Decision Steward status index: `docs/orchestration/milestones/m0/evidence/decision-steward-decisions.md`; canonical runtime packages, verdicts, and bindings live on the decision-evidence branch
- Main integration status index: `docs/orchestration/milestones/m0/evidence/main-integration.md`; canonical runtime attempts, results, and bindings live on the decision-evidence branch

The exact branch, brief, and verification-artifact paths for every task are fixed in the queue table below; the Goal may not generate a substitute path.

Task branches are never published by this workflow. Material unintegrated task branches and worktrees are never deleted automatically.

### Acceptance and integration chronology

The completed milestone candidate `C` is frozen before its independent reviews. Each review is then committed as its own immutable add-only file under `docs/orchestration/decisions/m0/reviews/` on `governance/decision-evidence`; review commits precede their consuming package and are not ancestors of `C`. The acceptance package, verdict, and binding bind exactly `C`.

After acceptance, one administrative descendant `I` must update exactly `ROADMAP.md`, `STATE.md`, `.loop/progress.md`, `docs/orchestration/milestones/M0_LEDGER.md`, and the status fields in `docs/research/RESEARCH_INDEX.md`. The guard proves canonical `100644` modes, terminal newlines, full binary bytes, exact unique fields, identifiers, and the permitted semantics: the milestone changes from `Ready for decision` to `Accepted`; all R01–R10 `Verified` task rows and index entries change to `Accepted`; the ledger replaces its prior acceptance-binding value, records the accepted tip, and appends eleven calendar-valid dated rows, one for each R01–R10 transition and one for M0. Every unrelated byte is preserved. Missing, duplicate, stale, mode-only, newline-only, or nonstatus changes are forbidden. Freeze `I`, then commit fresh independent reviews of exact `I` before the main-integration package. That package, verdict, and binding live exclusively on the evidence branch and bind both `C` and `I`, their ancestry, the still-current acceptance binding, unchanged `main`, and the fresh review commits. No shared milestone-state approval edit occurs after `I` freezes, and approval for either SHA cannot substitute for the other.

Both publication and main-integration guards must execute bytes whose SHA-256 equals the canonical executable guard blob at an explicitly supplied reviewed guard commit. This provenance check permits use from separate evidence and `main` worktrees without expanding their path authority. A failed integration must preserve collision bytes and recovery evidence. If complete restoration cannot be proved, the result is non-replayable `PARTIAL`, the private snapshot is retained, and human review is required.

Canonical review and result artifacts separate metadata from encoded output. Only the header before the begin marker supplies fields. The body is one canonical base64 line, and required encoding, decoded-byte-length, and SHA-256 fields bind the exact decoded output without terminal-newline normalization; metadata-looking or delimiter-looking decoded content remains opaque evidence. Milestone, integration, and successor approvals each require their applicable completion, `C`/`I`/acceptance-binding, or successor/entry-condition bounds in the package, verdict, and binding. No unsupported future decision kind authorizes. If technical reviews approve with zero blocking findings but a non-delegable owner boundary remains, record a `NEGATIVE` `HUMAN_GATE` package with its reason and complete review references, then only `PAUSE_HUMAN` and `DENIED` authorization. For the current recovery, owner acceptance of the repaired contract and paused governance remains such a boundary; this contract change does not accept or reactivate M0.

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
- the leading `Status:` sentence in the M0 section of `ROADMAP.md`, only to mirror a permitted milestone transition to `Active`, `Paused for owner decision`, `Ready for decision`, or Decision-Steward-backed `Accepted` in the second commit of the transition barrier. `Accepted` requires an exact committed `APPROVE_MILESTONE` verdict and authorizes no other roadmap change by itself.

Separately, only the program controller may append canonical reviews, packages, verdicts, results, and bindings under `docs/orchestration/decisions/**` while its dedicated isolated worktree is checked out on `governance/decision-evidence`. That authority is limited by the deterministic evidence-publication guard and does not expand the milestone branch allowlist.

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

Before milestone acceptance, the only pre-authorized external action is asking the existing deterministic milestone guard to push the exact `refs/heads/milestone/m0-research:refs/heads/milestone/m0-research` refspec after it validates the clean checked-out local ref, exact SHA, accepted-foundation ancestry, and contracted branch. That guard remains milestone-only.

The controller may publish `governance/decision-evidence` only from its dedicated clean isolated worktree through `.codex/skills/roadmap-orchestrator/scripts/validate_decision_evidence.sh authorize|push|verify <candidate-tip> <recorded-governance-base>` while providing the reviewed guard commit and SHA-256 required by the script. The first commit must be the recorded base's direct child and add only the immutable canonical `100644` base anchor. The guard may create that exact remote branch once and thereafter may only fast-forward it with the exact `refs/heads/governance/decision-evidence:refs/heads/governance/decision-evidence` refspec. Every later commit has one parent. Reviews are individual add-only commits; every decision is a complete package→verdict→binding sequence; every attempt result is a result→binding pair. Each step changes one exact canonical `100644` Markdown path under `reviews`, `packages`, `verdicts`, `results`, or `bindings`. Co-committed, incomplete, self-referential, stale, mode-invalid, or historically invalid evidence is rejected. Reviews, packages, verdicts, and results are add-only; bindings are add/update-only; deletion is forbidden. A failed push refuses only when the remote is proved unchanged or absent and otherwise returns `PARTIAL`. No direct push, merge, rewrite, force, rebase, tag, signing, product work, or other writer is authorized.

After the current local/remote-equal acceptance binding for `C` is consumed by the exact five-path state barrier and administrative candidate `I` is frozen, fresh reviews of `I` and a separate current package/verdict/binding sequence may authorize `.codex/skills/roadmap-orchestrator/scripts/validate_main_integration.sh authorize|integrate|verify <milestone-branch> <integration-candidate-I> <recorded-main-base> <evidence-binding-commit>` to perform one clean fast-forward from the unchanged recorded `main` base to `I`. Approval remains only on the evidence branch after `I` freezes. Only that guard may merge and push the explicit `refs/heads/main:refs/heads/main` refspec, and it must prove or safely classify the result. Confirmed rejection restores local `main`; proved equality succeeds; ambiguity, unexpected state, or external movement becomes non-replayable `PARTIAL`, retains recovery evidence, and requires `PAUSE_HUMAN`. No separate raw merge or `git push` is permitted.

The Goal may not publish task branches, open a pull request, auto-merge, force-push, rebase, resolve conflicts, release, deploy, sign, create or publish tags, submit to a store, delete material work, or take another external action. Main integration does not authorize M1 activation.

## Stop conditions

Pause for the owner when any mandatory gate in `AGENTS.md` or the orchestrator skill applies; an entry condition fails; a path is outside the allowlist; evidence is missing or unsupported; a Critical or Important finding remains; five correction rounds fail; a blocker prevents the definition of done; local/remote state is inconsistent; or the objective, queue, dependencies, definition of done, safety controls, or contract would change.

When every task satisfies the definition of done, set the milestone to `Ready for decision` through the two-commit barrier and request an independent Decision Steward verdict. Do not accept M0, integrate `main`, or begin M1 unless each action has its own exact committed approval and the required barrier or guard succeeds.

At milestone decision, one committed `CORRECT` verdict may return `Ready for decision` to `Active` for exact corrections already inside this contract and may reopen named `Verified` tasks to `In progress`; every reopened task requires fresh verification and independent review. A changed bound SHA requires affected fresh verification, independent review, and a fresh Decision Steward verdict. Missing, conflicting, ambiguous, unreadable, internally inconsistent, or unverifiable evidence requires `PAUSE_HUMAN`. A correction outside this contract requires a new approved design and contract change. `Accepted` is terminal as the M0 state.

M1 remains inactive until its exact contract is committed, independently reviewed with no unresolved Critical or Important finding, every entry condition passes, and a separate `APPROVE_NEXT_MILESTONE` verdict is committed and consumed through its activation barrier. The current M0 `Paused for owner decision` state remains binding until the redesigned permission-isolated setup has successful runtime evidence, required independent reviews, and a valid reactivation decision.

## Activation statement

After displaying the exact accepted foundation commit and the latest commit that changes this contract, request:

`I accept the repository foundation and approve M0 activation using the Gated Roadmap Orchestrator.`

The statement binds only to the displayed commits and authorizes one M0 Goal plus `milestone/m0-research`. It does not authorize M1 or any non-goal above.
