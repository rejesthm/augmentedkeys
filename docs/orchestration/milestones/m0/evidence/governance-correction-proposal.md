# Proposed governance correction — owner approval required

Status: Proposal only. No control, guard, contract, app code, architecture, dependency, asset or approval policy is changed by this document.

## Problem and evidence

The independent read-only Final Reviewer assessed accepted snapshot `8e44383a956770386b2a87f6637493fdb04dff1a` under contract `eb0d55bc7e10b219996fdb7ab69a546b1e350e3a` and found zero Critical, two Important protocol defects. Its complete output and immutable runtime hashes accompany the canonical assessment. R10 completion remains a separately authorized research task; its approval cannot close these governance findings.

1. Fresh reviews must cover an exact frozen milestone candidate, but there is no permitted immutable review-artifact lane outside that candidate's changing milestone branch. Recording a review on that branch changes the tip and creates another exact-SHA review requirement.
2. The main guard requires review paths excluded by the contract, requires later truthful reviews to be ancestors of their candidate, and requires the accepted candidate to remain the milestone tip even though the prescribed Accepted-state commit changes that tip.

This prevents M0 acceptance and later main integration. M1 also lacks an independently reviewed successor contract and satisfied activation conditions. No missing evidence, SHA mismatch or gate may be inferred away.

## Requested bounded authorization

Authorize one isolated governance correction task to implement and independently verify the following design. The controller would first commit a bounded task brief and assignment; use one writer, isolated worktree, existing permission-isolated roles, evidence-first transitions, and at most five correction/review rounds. No current milestone acceptance, main integration or successor activation is authorized by approval of this correction task.

### Immutable reviews outside the frozen candidate

Add an append-only review artifact class under `docs/orchestration/decisions/m<digits>/reviews/` on the existing controller-owned `governance/decision-evidence` branch. Each review is its own add-only, single-path, single-parent commit, canonical readable `100644` Markdown, and binds the exact frozen candidate, reviewer role/session/runtime, full review output, findings and verification evidence. The evidence guard permits these review commits only between complete decision/result sequences, before their consuming package; it still refuses incomplete package→verdict→binding sequences, deletion, mutation, symlinks, unexpected paths and invalid historical modes.

A decision package binds the exact review commits and paths. Require those review commits to precede and be ancestors of the consuming governance package; do not require them to be ancestors of the already reviewed product candidate. Preserve exact-SHA review, fresh independent QA/applicable Security/Final approval and zero blocking findings for approvals. No tree-equivalence substitution or approval reuse.

### Separate acceptance from the integration candidate

Keep the immutable milestone-acceptance candidate distinct from any later integration candidate containing the required administrative Accepted-state changes. The acceptance package/verdict binds the former. A separate main-integration package binds both, their exact ancestry and allowed administrative delta, unchanged local/live remote main base, current acceptance binding, and fresh independent reviews of the exact integration candidate.

The permitted delta must be explicitly enumerated and semantically checked for the required milestone status and evidence-reference updates. An arbitrary change within an allowed file is not sufficient. Product code, research content, architecture, dependency, asset, queue or safety-policy changes cannot enter as bookkeeping. Any extra change needs its own authority and review.

After freezing the integration candidate, record its main-integration approval/binding exclusively on the governance evidence branch before mutation, so recording approval cannot itself change the reviewed integration tip. Append result/binding there after the attempt; later state mirrors must not retroactively relabel the integrated SHA or authorize another integration. The deterministic guard remains the only main merger/publisher, with exact explicit refspec, unchanged remote, no force/rebase/conflict resolution, and non-replayable PARTIAL recovery handling.

### Consistent controls and focused verification

Align the M0 contract, Decision Policy, decision evidence schema, both role skills, applicable constitution language, both guards and focused guard fixtures. Expected paths are limited to `AGENTS.md` if its authority text needs alignment; `docs/orchestration/milestones/M0_CONTRACT.md`; `docs/orchestration/DECISION_POLICY.md`; `docs/orchestration/decisions/README.md`; `.codex/skills/decision-steward/SKILL.md`; `.codex/skills/roadmap-orchestrator/SKILL.md`; the two validation guards and their existing test scripts; and bounded controller task/evidence/status files. The brief must enumerate exact paths before writing. No product files or broader roadmap changes.

Tests must model honest chronology: freeze candidate, perform and record reviews afterward, record acceptance, create the allowed administrative descendant, review that exact descendant, obtain separate integration approval, then integrate. Include rejection for stale or mismatched SHAs, altered reviews, unauthorized delta, unexpected paths/modes/parents, incomplete sequences, moved refs, superseded bindings, unsafe retry and failed restoration. Preserve all earlier failure and rollback evidence.

The original checkout's two owner-edited recovery files remain excluded. The correction must assess the preserved recovery advisory and reproduce relevant failures in disposable fixtures before proposing any adoption. Never overwrite or automatically incorporate those edits. Ignored/untracked collision handling and preservation of recovery evidence after a failed restore require explicit proof, not just successful happy-path tests.

## Completion and continuation

Require fresh independent QA/Performance, Licensing/Security and Final reviews of the exact correction, complete fresh fixture output, preserved owner edits and unchanged main. Present the exact correction/foundation and superseding contract commits for owner acceptance before reactivation, as required by the existing constitution. The correction's acceptance would unblock completing M0's original decision process; it would not select an audio engine, add sounds, operate hardware, authorize M1 implementation, or publish the app.

No credentials, accounts, purchases, legal commitments, signing, deployment, release, destructive operations, new automation, dependency or content actions are included. Until authorized and independently verified, retain all ten research outputs and pause milestone progression at the human-only governance boundary.
