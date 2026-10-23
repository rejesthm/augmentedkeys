# Independent M0 completion-protocol assessment

Controller records the full read-only Final Reviewer output, with trailing whitespace normalized only. This assessment is not a Steward verdict or authority to repair controls. Two Important governance findings remain open; completed research-task approvals do not close them. Exact reviewed snapshot and affected controls are identified below. The relevant controls remain unchanged through the present task-publication record.

- `final-preflight.final.txt` SHA256 `0f18817dee5a36f159b684eaa6e6f8a5fb47c54614be45497a745932b6a50c65`.
- `final-preflight-runtime.json` SHA256 `6f29a62605b2c894cb7712b3d5362753a4bc9666885b72a91ad01ff5e5318093`.
- `final-preflight-child.jsonl` SHA256 `1f1ba27de24961e1e35b2b10ba79543856900a393ab985c997bd32053c5c7617`.
- `final-preflight-relay.jsonl` SHA256 `068bac6d07ecb9835e53cba8f88192519c1c4cfd80c606fedc3038d760e922e0`.

# M0 Completion-Protocol Preflight — No Formal Verdict

**Assessment:** Protocol correction required before M0 milestone acceptance can lawfully complete.

**Finding counts:** Critical 0 / Important 2 / Minor 0

**Reviewer:** Final Code Reviewer, read-only `gpt-5.6-sol/xhigh`, UUID `01a16849-b045-7441-88bc-0b8b08e0b156`
**Reviewed snapshot:** `8e44383a956770386b2a87f6637493fdb04dff1a`
**Accepted contract:** `eb0d55bc7e10b219996fdb7ab69a546b1e350e3a`
**Foundation/main:** `b1b0c1edd5e42d3ea791f665c22954834e962d05`

This is a read-only protocol assessment, not a task approval, milestone decision, Steward verdict, main-integration authorization, successor activation, or app-completion claim.

## Findings

### Important 1 — No lawful immutable lane exists for fresh exact-candidate milestone reviews

The contract requires a fresh milestone Final review and all review artifacts to be ready for the Steward (`M0_CONTRACT.md:35-40,103-110`). Decision policy requires fresh QA/Performance, applicable Licensing/Security, and Final review of the **exact candidate**, each identified by a committed artifact (`DECISION_POLICY.md:23-27`; `decision-steward/SKILL.md:33-47`).

After freezing a Ready candidate, however:

- The milestone allowlist permits milestone task/evidence files and research outputs, but not `docs/orchestration/reviews/m0/**` (`M0_CONTRACT.md:79-93`).
- The governance branch permits only `packages`, `verdicts`, `results`, and `bindings` (`docs/orchestration/decisions/README.md:5-23`; `validate_decision_evidence.sh:77-119`).
- Recording a returned review under any milestone-branch path would create a descendant SHA. The recorded review would cover the predecessor, not that new SHA. Re-reviewing the descendant and committing that review repeats the same cycle. Identical research content or tree equality is not SHA equality, and staleness rules explicitly invalidate changed candidates or review artifacts (`DECISION_POLICY.md:77-81`; `decision-steward/SKILL.md:101-105`).

**Impact:** Once R10 is complete, the project can construct and publish a Ready candidate, but cannot lawfully commit the required fresh exact-SHA reviews and assemble a compliant `APPROVE_MILESTONE` package. This blocks **M0 acceptance**, not merely main integration.

**Concrete correction:** Add an owner-authorized, append-only, guard-validated review-artifact class on the governance evidence branch. Each immutable review must bind the frozen candidate SHA and precede the acceptance package, but must not be required to be an ancestor of that candidate.

### Important 2 — Main-integration rules conflict with both the M0 allowlist and the prescribed Accepted-state transition

The accepted main guard mandates QA, Licensing/Security, and Final paths under `docs/orchestration/reviews/m0/*.md` (`validate_main_integration.sh:118-139`). Those paths are absent from the milestone allowlist, and the evidence guard rejects them on the governance branch. This directly validates the central observation in `integration-path-observation.json:3-20`.

The guard also requires every review commit to be an ancestor of the accepted tip (`validate_main_integration.sh:131-139`). A truthful review of an already frozen tip cannot itself be an ancestor of that tip. The existing test fixture’s ability to construct such history would test mechanics, not establish truthful exact-SHA review chronology.

A separate inconsistency remains after acceptance:

- The orchestrator requires the published acceptance binding first and then a separate milestone-branch ledger/`STATE.md`/`.loop`/`ROADMAP.md` commit changing Ready to Accepted (`roadmap-orchestrator/SKILL.md:65-84,126-134`).
- That mandatory commit changes the milestone branch tip.
- The main guard later requires the milestone branch tip to equal the Steward-bound accepted tip exactly (`validate_main_integration.sh:84`) and rechecks that the acceptance package and verdict name that same SHA (`lines 143-174`).

Passing the old Ready SHA fails the branch-tip check; calling the new state SHA “accepted” contradicts the prior exact-SHA verdict. Tree similarity cannot resolve this.

**Impact:** This independently blocks later **main integration**, even if M0 acceptance were otherwise recorded.

**Concrete correction:** Revise the contract, policy, orchestrator skill, evidence schema/guard, main guard, and focused tests to distinguish:

1. the immutable Steward-reviewed milestone candidate;
2. immutable governance reviews and acceptance binding; and
3. any later, tightly constrained administrative Accepted-state descendant used as an integration tip.

The separate main-integration package must bind both SHAs, prove the allowed state-only delta, and receive any required fresh review. The current guard’s review-path and candidate-ancestry requirements must be reconciled with the approved governance lane.

## Lawful sequence under current controls

A lawful prefix exists:

1. Finish R10 correction, exact-candidate review, finalized verification, Verified transition, integration, and guarded milestone publication.
2. After R01–R10 are Verified/Accepted, commit the canonical completion package first.
3. In a separate barrier commit, record that package and transition Active → Ready (`roadmap-orchestrator/SKILL.md:167`; `M0_CONTRACT.md:33-40,127-129`).
4. Publish and freeze that exact Ready tip.
5. Run fresh independent milestone QA/Performance, Licensing/Security, and Final reviews against that SHA.

The sequence must stop there under current controls because Important 1 leaves no lawful committed review-artifact lane. Therefore no compliant acceptance package, `APPROVE_MILESTONE`, Accepted transition, later `APPROVE_MAIN_INTEGRATION`, or guarded main integration can presently complete. Completion-package ancestry is **not** defective: committing it before the Ready transition makes it naturally ancestral. Review-artifact ancestry is the real causal defect.

## Decision-boundary disposition

- **Current M0 work:** At snapshot `8e44383…`, R10 is `In progress` and the completion package/evidence branch do not exist (`STATE.md:23,27-38`; `M0_LEDGER.md:24-59,82`). That is an expected incomplete-work blocker, not a protocol finding. This review did not inspect the controller’s concurrent R10 correction.
- **M0 research acceptance:** Blocked after task completion by Important 1.
- **Main integration:** Blocked additionally by Important 2. The excluded original-checkout guard edits and advisory are not accepted code and cannot cure this; they would require a separately authorized proposal and fresh review.
- **M1:** Currently blocked by absent M0 acceptance and absent exact independently reviewed successor contract/entry-condition evidence/`APPROVE_NEXT_MILESTONE`. Main integration and successor activation remain independent decisions; no successful main integration may be inferred to activate M1 (`M0_CONTRACT.md:119-131`; `DECISION_POLICY.md:13-19`).

## Fresh checks and limitations

I read the required app documents in prescribed order, continuation/app context, full accepted contract, both complete role skills, Decision Policy, decisions README, both guards, ledger, and the controller observation. The contract blob at `eb0d55…` equals the blob at `8e443…`; relevant controls were unchanged. Both guard scripts passed `bash -n`; this proves syntax only. Observation hashes matched the inspected authoritative files, and its core conflict is validated, though it understated the milestone-acceptance lane and post-acceptance-tip defects.

Inspection began with clean exact snapshot `8e443…`; the shared branch later advanced concurrently to `378c693b446111dc5fd33d52af8e18c7eeae8cb6`. All cited reads used `git show 8e443…:<path>` and exclude that later R10 work. No remote/network equality, destructive guard mode, fixture, write, or publication was performed. The exact correction design remains an owner decision.

**One next action:** Seek owner authorization for one governance-only protocol correction covering the contract, policy, orchestrator skill, review-evidence schema/guard, main guard, and focused tests; independently review that exact correction before freezing the final M0 candidate.
