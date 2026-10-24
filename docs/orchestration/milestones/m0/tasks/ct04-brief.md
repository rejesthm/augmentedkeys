# CT04 — Owner-approved governance correction and preservation recovery

Authority: owner replied `approved` on 2026-10-24 to the exact governance-correction proposal at 8138cf965531ffd34a9dd967b1724c837409a1c8 and recovery proposal at 5a23e281b53d38ab43e51a427017c1ea8c0a3918. Both canonical proposal documents are binding design inputs. This is a directly owner-authorized correction outside the paused M0 research queue, not a new research task or reactivation.

Starting base: bfc5b04aa388e99380c2ab135fe036236175859d. Existing accepted M0 contract: eb0d55bc7e10b219996fdb7ab69a546b1e350e3a; ledger snapshot is the starting base. Branch: task/ct04-governance-correction. Worktree: /Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/ct04-governance-correction. Controller owns Git, task state, evidence and recovery. One implementation writer, at most three independent specialists, no mixed-permission nesting. No staging/committing/pushing by specialists. Conductor intake first, then separate assignment. Maximum five correction rounds.

## Objective and exact implementation paths

Implement the approved immutable post-freeze review lane and separate acceptance/integration-candidate protocol, align controls and enforce the chronology with tests. Investigate and reproduce preserved recovery advisory failures before independent fixes. Only these implementation paths may change:

- `AGENTS.md`
- `docs/orchestration/milestones/M0_CONTRACT.md`
- `docs/orchestration/DECISION_POLICY.md`
- `docs/orchestration/decisions/README.md`
- `.codex/skills/decision-steward/SKILL.md`
- `.codex/skills/roadmap-orchestrator/SKILL.md`
- `.codex/skills/roadmap-orchestrator/scripts/validate_decision_evidence.sh`
- `.codex/skills/roadmap-orchestrator/scripts/test_validate_decision_evidence.sh`
- `.codex/skills/roadmap-orchestrator/scripts/validate_main_integration.sh`
- `.codex/skills/roadmap-orchestrator/scripts/test_validate_main_integration.sh`

Controller-only paths: docs/orchestration/milestones/m0/tasks/ct04-brief.md; docs/orchestration/milestones/m0/evidence/ct04-authorization.md, ct04-assignment.md, ct04-status.md, ct04-verification.md, ct04-reviews.md, ct04-recovery.md; docs/orchestration/milestones/M0_LEDGER.md; STATE.md; .loop/progress.md. Private raw records live in .git/decision-team-continuation/2026-10-23/governance-correction. No ROADMAP edit is needed while milestone remains paused. Existing source/review/failure evidence is immutable.

## Required behavior and verification

Follow both approved proposals completely: add-only single-path/single-parent canonical 100644 review commits, exact candidate/runtime/output/findings bindings, reviews before consuming governance package but after frozen candidate, no incomplete sequences or historical sanitization. Separate acceptance candidate C from integration candidate I, require exact ancestry and semantically exact enumerated administrative delta, fresh I reviews, current acceptance binding, unchanged main, governance-only integration approval recording. Refuse stale/mismatched artifacts, altered reviews, arbitrary allowed-file changes, unexpected modes/paths/parents, incomplete sequences, moved refs, superseded bindings, unsafe retry and failed restoration. Preserve recovery snapshots on PARTIAL, prove ignored/untracked collision behavior and snapshot directory validation. No tree-equivalence approval reuse.

Tests first, preserve failing baseline output and complete final fixture output. Both existing guard suites must pass, plus chronology and adversarial regressions. Guard tests may create disposable local Git repositories/remotes only. No live main integration. Applicable skill changes need representative chronology/resume pressure scenarios against old and revised text. Independent QA/Performance, Licensing/Security and Final reviews of exact committed correction, zero unresolved Critical/Important findings. Recheck original owner file hashes and all main refs. No Flutter checks are required absent Flutter changes; make no app/device/performance claim.

## Exact preservation/recovery operations (controller only)

Before each ref action re-prove local evidence tip 0db258d158f1d212497ccfdf07675ec399e6f870, remote evidence absence, live main b1b0c1edd5e42d3ea791f665c22954834e962d05, clean old evidence worktree and preserved owner hashes. Rename the currently checked-out local branch in .worktrees/decision-evidence with `git branch -m archive/m0-decision-evidence-base-error-20261024`; keep the worktree and all commits intact. No reset/rewrite/delete/force. Record exact corrected governance base in the milestone ledger before creating the replacement. Once controls are independently reviewed, create NEW canonical governance/decision-evidence from that exact main base in .worktrees/decision-evidence-corrected with a direct-child anchor that adds only docs/orchestration/decisions/governance-base.md. Any new reviews/packages/verdicts/bindings are single-path commits under reviewed controls and must bind fresh exact SHAs. Obtain a new independent Steward verdict; never replay old verdict. Publish only with reviewed evidence guard authorize/push/verify and equality proof before consumption. A needed main or milestone ref movement not covered here stops for its specific authority.

## Exclusions and completion

Original checkout owner-edited validate_main_integration.sh and test_validate_main_integration.sh are excluded and must not be overwritten, staged or automatically adopted. Advisory and source hashes preserved under ../guard-recovery-advisory. Reproduce issues in isolated fixtures and implement independently within this worktree. No new dependency, asset, architecture/ADR, account/credential, hardware, product behavior, release, public communication, scheduled automation, raw project push or main integration. R01–R10 remain Verified, none Accepted; M0 remains Paused for owner decision. This correction does not consume unpublished binding. Present exact independently reviewed repaired foundation and superseding contract commits for owner acceptance before M0 reactivation.
