# M0 Owner Decisions

## OD-001 — Foundation acceptance and M0 activation

- Decision date: 2026-08-30, Asia/Manila.
- Decision owner: repository owner, through the current Codex conversation.
- Responsible recorder: Roadmap Orchestrator (`/root`).
- Decision source: the owner's message immediately following the displayed foundation, contract, queue, scope, publication boundaries, definition of done, and activation request.
- Accepted foundation: `b1b0c1edd5e42d3ea791f665c22954834e962d05`.
- Accepted contract-changing commit: `0d86705ca130fcc3bdb73a9acf3f21fd803912dd`.
- Contract: `docs/orchestration/milestones/M0_CONTRACT.md`, version 1, unchanged.
- Authorized transition: M0 `Awaiting owner approval` to `Active`.

### Exact owner statement

> I accept the repository foundation and approve M0 activation using the Gated Roadmap Orchestrator.

### Authority and limits

This accepts the named repository foundation and authorizes exactly one M0 Goal, the `milestone/m0-research` branch, and eligible R01–R10 research tasks under the unchanged contract and `.codex/skills/roadmap-orchestrator/SKILL.md`. It does not authorize a different foundation, a later contract version, M1, architecture or ADR adoption, dependencies or assets, product/UI/native code, device operations, credentials/signing, releases, automation, task-branch publication, or merging/pushing `main`.

Only the contract's deterministic guard may publish the exact milestone branch. Every task requires its canonical brief, evidence, transitions, applicable specialist review, and independent final review. All non-delegable owner gates remain in force. This approval supplies no device, compatibility, reliability, audio-continuity, real-time-safety, or low-latency evidence.

### Activation preflight evidence

The controller read the operating constitution, product and architecture boundaries, roadmap, state/progress, contract, ledger, queue, gate/budget, task template, license ledger, and applicable testing/device/real-time controls. No other Goal or active specialist writer existed at preflight. All ten research tasks were `Queued`; canonical M0 decision/transition/task artifacts and the milestone branch were absent before activation setup.

Read-only checks at accepted foundation `b1b0c1edd5e42d3ea791f665c22954834e962d05` confirmed:

- Local `main` and `origin/main` both resolved to the accepted foundation; both existing worktrees were clean.
- `git ls-remote --exit-code -- git@github.com:rejesthm/augmentedkeys.git refs/heads/main` returned `b1b0c1edd5e42d3ea791f665c22954834e962d05` for `refs/heads/main`.
- `git log -1 --format=%H -- docs/orchestration/milestones/M0_CONTRACT.md` returned the accepted contract-changing commit.
- The final setup review recorded APPROVE with zero Critical, Important, and Minor findings; the separate state review also approved. Existing source-backed setup evidence is retained in `.git/worktrees/roadmap-orchestrator/roadmap-orchestrator-validation` in the repository's common Git directory.
- The M0 Goal was created in Codex task `01a04c45-76d8-7ef0-9cb4-101dbe82a224` with the exact accepted commits, full M0 definition of done, skill, boundaries, and owner gates. No token budget was requested or invented.
- `git worktree add -b milestone/m0-research /Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-research b1b0c1edd5e42d3ea791f665c22954834e962d05` created the isolated milestone checkout. The existing ignored `.worktrees/` location was verified; no separate user task or cleanup was created.

### Fresh worktree baseline

- Started: `2026-08-30T15:14:34+0800`.
- Tested commit: `b1b0c1edd5e42d3ea791f665c22954834e962d05`.
- Environment: arm64 macOS 26.6.1 (25G76), Flutter 3.44.8 stable (framework `058e0af2c2`), Dart 3.12.2.
- Device/simulator/emulator: Not applicable; host-side scaffold checks only.
- Configuration: existing repository constraints; no package upgrade, build, app launch, audio/MIDI workload, sample rate, buffer configuration, or physical-device procedure.
- `flutter pub get`: exit 0.
- `dart format --output=none --set-exit-if-changed .`: exit 0; `Formatted 2 files (0 changed)`.
- `flutter analyze`: exit 0; `No issues found!`.
- `flutter test`: exit 0; one widget test, `shows the truthful M0 foundation status`, passed.
- `git diff --check`, clean-worktree check, and unchanged accepted-HEAD check: exit 0; `M0_WORKTREE_BASELINE=PASS`.
- Warning retained: `7 packages have newer versions incompatible with dependency constraints.` The notices concern clock, matcher, material_color_utilities, meta, stack_trace, test_api, and vector_math. No versions were upgraded.
- Evidence source: exact command output retained in the current Codex conversation; this committed record identifies the commands, tested state, environment, results, warnings, and limitations.
- Recorder/reviewer of these baseline outputs: Roadmap Orchestrator (`/root`); this is not a substitute for independent research-task review.

### Two-commit barrier

This decision must be committed first. A separate next commit must record this decision commit's SHA and transition the M0 ledger, `STATE.md`, `.loop/progress.md`, and only the leading M0 status sentence in `ROADMAP.md` together to `Active`. No research or task execution may occur between those two commits. The contract itself remains unchanged; this committed owner decision supplies its activation authority.

### Evidence-retention correction — activation review round 1

The round-0 activation review rejected the bookkeeping because the fresh baseline output was not retained at a durable artifact location; it did not report a test failure. The original command and both output chunks have now been recovered from the source conversation and preserved in `docs/orchestration/milestones/m0/evidence/activation-baseline.md`, with exact source ordinals, fixed-prefix hash, environment, exit code, and warnings. This is the original 15:14:34 run, not a newly performed run. The original rejected review and its source-backed literal reply remain in `activation-review.md` and `activation-review-provenance.md` in the same evidence directory. This addendum changes no owner statement, accepted commit, authority, state transition, or performance claim; independent correction re-review is pending.

## OD-002 — Bounded G01 launch recovery

- Recorded: 2026-08-31, Asia/Manila.
- Decision owner: repository owner in the same Codex conversation.
- Responsible recorder: Roadmap Orchestrator (`/root`).
- Source: the owner's reply to the request for approval to correct and verify agent-launch permissions before research resumes.
- Exact owner statement:

> continue please. what's next?

- Interpretation stated to the owner before acting: permission for the bounded launch correction and validation; research remains paused until the permission checks pass. This is not quoted as a more specific statement than the owner actually made.
- Accepted foundation remains `b1b0c1edd5e42d3ea791f665c22954834e962d05`; accepted contract remains `0d86705ca130fcc3bdb73a9acf3f21fd803912dd`, unchanged.
- Recorded gate: G01 at `411e9ff73b1390ed1c95c24c8c09cc284c63645e`; pause evidence MT-001 at `998fb53884f986154e1238ea3d76539adc565b70`; paused state at `6da91d7520a0473127a6529bda94d54daac4dac4`.

### Bounded scope

Test a command-line-only correction which removes the live `-s workspace-write` override and supplies the parent's existing workspace-write setting through the configuration layer (`-c 'sandbox_mode="workspace-write"'`). This is a hypothesis, not a passing result. Do not edit global/project configuration, role files, skills, contract, app code or dependencies. Do not use bypass flags or broaden the required role permissions.

Use saved runtime evidence to verify the actual Conductor remains `gpt-5.6-sol` / `high` / workspace-write and each configured reader remains its declared model/effort / read-only. First test the preserved Conductor's recovery and a fresh configured Researcher with no-write diagnostic instructions. Only after that passes, validate the QA/Performance, Licensing/Security and fresh Final Code Reviewer boundaries and obtain independent recovery review. Never infer an effective permission from a TOML file or inherited context alone.

The diagnostic task permits no research-body execution, file edits by probe agents, commits by probe agents, package or asset action, hardware, permission escalation, publication, or external mutation. Root alone records allowlisted evidence and shared state. Preserve every original failure, branch, saved writer and unreviewed source note. Stop the probe if its expected permission boundary fails; do not convert a mismatch into permission to work.

### State and continuation

This decision authorizes recovery work, not a claim that G01 is resolved. M0 stays `Paused for owner decision` and R01 stays `Blocked` during diagnostics. Research can continue only after effective-permission evidence and independent review resolve G01, the owner-decision resolution is committed, and the required separate milestone/task state barriers are completed. Any necessary expansion beyond this bounded invocation correction requires new owner direction. Main integration, M1, architecture adoption, product/core/UI/native work, hardware, dependencies, automation, credentials and other existing gates remain excluded.

## OD-003 — Project-only sandbox-default correction

- Decision date: 2026-09-01, Asia/Manila.
- Decision owner: repository owner in the same Codex conversation.
- Responsible recorder: Roadmap Orchestrator (`/root`).
- Decision source: the owner's reply to the explicit request to set a read-only default in the project's `.codex/config.toml` and re-test agent permissions while leaving global settings and individual agent settings unchanged.
- Exact owner statement:

> approved

- Accepted foundation remains `b1b0c1edd5e42d3ea791f665c22954834e962d05`; accepted M0 contract remains `0d86705ca130fcc3bdb73a9acf3f21fd803912dd`, unchanged.
- Pre-correction milestone tip: `86fac7a614e40490de264b3d736e8936cd9233bd`.
- Prior recovery decision: OD-002 at `4a8349000864b2f06dbe62a287c5a4378e0bd278`; failed invocation-only evidence: `6e0f00b8ba860b53b6d9e412e25c7e06ebed4ca4`.

### Exact authority

Add only `sandbox_mode = "read-only"` as the project-level default in `.codex/config.toml`. Do not change global configuration or any individual agent file. Do not add a CLI sandbox override. First retain the existing failure as the RED baseline, then test whether the effective fresh relay is read-only, the actual configured Conductor remains `gpt-5.6-sol` / `high` / workspace-write, and its actual configured Researcher is `gpt-5.6-terra` / `high` / read-only.

If those boundaries pass, validate the applicable QA/Performance, Licensing/Security and fresh Final Code Reviewer as actual configured read-only roles and preserve their literal results and source-backed effective contexts. No diagnostic agent may edit files, commit, resume R01 research, launch hardware, change configuration/permissions, or perform an external mutation. Root alone may make the approved configuration edit and write allowlisted recovery evidence/state.

### Limits and next gate

This is a separately approved setup correction outside the M0 research allowlist. It does not change the M0 objective, queue, contract or safety gates and does not authorize another configuration file, role/skill change, global setting, product/core/UI/native code, dependency, hardware, credentials, publication, main integration or M1.

This decision authorizes correction and validation only. It is not advance acceptance that G01 is resolved and does not itself reactivate M0 or R01. M0 remains `Paused for owner decision` and R01 remains `Blocked` until the evidence passes, independent review has no unresolved Critical or Important finding, and a later committed owner reactivation decision plus the required separate milestone/task state barriers are completed.

## OD-004 — Narrow role-isolated G01 dispatch correction

- Decision date: 2026-09-02, Asia/Manila.
- Decision owner: repository owner in the same Codex conversation.
- Responsible recorder: Roadmap Orchestrator (`/root`).
- Decision source: the owner's exact reply to the request to supersede only the failed nested dispatch rule, validate separate top-level permission sessions, and reactivate M0 only after independent verification passes.
- Accepted foundation remains `b1b0c1edd5e42d3ea791f665c22954834e962d05`.
- Previously accepted M0 contract commit remains `0d86705ca130fcc3bdb73a9acf3f21fd803912dd` until the narrow correction is implemented, verified, independently approved, and recorded as the superseding contract source.
- Preserved pre-decision milestone tip: `80843d3d0cbbdf8031aaa6406cf71b4d21ab5cac`.

### Exact owner statement

> I approve the narrow G01 role-isolated dispatch correction and authorize M0 reactivation after it passes independent verification.

### Authorized correction

Replace only the failed nested mixed-permission launch topology with root-mediated, permission-isolated top-level sessions:

```text
Roadmap Orchestrator controller
├── independent workspace-write session: Conductor and an assigned writer when needed
└── independent read-only sessions: Researcher, QA/Performance Verifier,
    Licensing/Security Reviewer, and Final Code Reviewer
```

The Conductor may select the specialist roles needed for one bounded task, but it returns exact dispatch requests to the controller. The controller launches each configured role in a separate top-level session with that role's required effective sandbox and relays only the committed brief, exact candidate/evidence commits, and bounded findings. No read-only role may be nested below a workspace-write session, and no write-capable role may be nested below a read-only session.

This decision authorizes only the minimum corresponding corrections to `AGENTS.md`, `.codex/agents/conductor.toml`, `.codex/skills/roadmap-orchestrator/SKILL.md`, `docs/orchestration/milestones/M0_CONTRACT.md`, and allowlisted G01 evidence/state artifacts. It also authorizes non-product runtime probes that prove the actual effective Conductor session is workspace-write and each configured reader session is read-only. Probe agents may not perform research-body work, edit repository files, commit, publish, use hardware, or change permissions.

### Verification and reactivation barrier

M0 remains `Paused for owner decision` and R01 remains `Blocked` while the correction is implemented and tested. G01 is resolved only when committed runtime evidence identifies the exact tool version, project root, configured role, model, reasoning effort, effective sandbox, source session, and no-write/write-boundary result for each required role, and fresh independent review reports no Critical or Important finding.

After that verification passes, the controller must commit a separate reactivation decision artifact bound to the exact corrected contract and validation commits. Separate later commits must transition M0 from `Paused for owner decision` to `Active` and R01 from `Blocked` to `Eligible` under the existing two-commit barriers. No research may execute between these commits.

### Unchanged limits

This decision does not change the M0 objective, R01–R10 queue, dependencies, definition of done, research outputs, one-writer rule, three-specialist limit, evidence requirements, correction limit, or branch/publication rules. It does not authorize product/core/UI/native code, architecture or ADR adoption, dependencies or assets, hardware operations, credentials/signing, releases, automation, task-branch or `main` publication, cleanup, M1, or unmeasured performance claims. Only the existing deterministic milestone-branch guard remains authorized for external publication.

## OD-005 — Verified G01 resolution and M0 reactivation decision

- Decision date: 2026-09-02, Asia/Manila.
- Decision owner: repository owner in the same Codex conversation.
- Responsible recorder: Roadmap Orchestrator (`/root`).
- Decision source: OD-004's exact advance authorization to reactivate M0 after independent verification passes.
- Exact owner authorization: `I approve the narrow G01 role-isolated dispatch correction and authorize M0 reactivation after it passes independent verification.`
- Accepted foundation: `b1b0c1edd5e42d3ea791f665c22954834e962d05`.
- Superseding corrected M0 contract source: `13b864f09ca083d10910bcffa4432b81c040bda9` (`docs/orchestration/milestones/M0_CONTRACT.md`, version 2).
- Runtime validation artifact: `docs/orchestration/milestones/m0/evidence/g01-role-isolated-validation.md`; initial evidence commit `ec4e76345519973d09a4dbeff6d043e6477e67bc`; accurate call-inventory correction included at `5bfbdb5139c4f1936a59ba78c6b1125d8b7cb7db`.
- Independent review artifact: `docs/orchestration/milestones/m0/evidence/g01-role-isolated-review.md`; final review-record commit `88fe4ece13bfedd8b67eaa8882c5adf020654418`.
- Reviewed implementation tip: `5bfbdb5139c4f1936a59ba78c6b1125d8b7cb7db`.
- Fresh review verdict: `APPROVE`; Critical 0, Important 0, Minor 0, Blocking 0.

### Decision

OD-004's verification condition is satisfied. The source-backed Codex CLI `0.150.0-alpha.12.2` evidence proves the configured Conductor at `gpt-5.6-sol` / `high` / `workspace-write` and the configured Researcher, QA/Performance Verifier, Licensing/Security Reviewer, and Final Code Reviewer at their required models/efforts / `read-only`, each through a separate same-sandbox relay and child tree. The fresh independent re-review verified the exact correction, all ten probe rollouts, no probe-authored mutation, unchanged accepted main refs, and preserved paused/blocked state with zero findings.

The owner therefore reactivates M0 under corrected contract source `13b864f09ca083d10910bcffa4432b81c040bda9`. This artifact is the decisive source for the separate M0 `Paused for owner decision` to `Active` state commit. It also resolves G01 as the prerequisite owner decision for the separate R01 `Blocked` to `Eligible` transition artifact and its later ledger commit.

### Required barriers

1. Commit this OD-005 artifact and resolve its exact SHA.
2. In a separate commit, record that SHA and synchronize M0 to `Active` in `M0_LEDGER.md`, `STATE.md`, `.loop/progress.md`, and only ROADMAP's leading M0 status sentence.
3. Commit the canonical `r01-transitions.md` resolution artifact recording the prior blocker, resolution evidence, rechecked eligibility, existing brief commit, and this OD-005 commit.
4. In a separate commit, record that artifact SHA and transition R01 from `Blocked` to `Eligible` in the ledger and permitted mirrored queue state.

No research or task-body execution may occur between these barrier commits. R01 may return to `In progress` only through its separate assigned-writer transition evidence and following state commit.

### Limits

This decision reactivates only M0 and resolves only G01. It does not accept any research task, start M1, adopt architecture or an ADR, add a dependency or asset, authorize hardware, credentials, signing, release, automation, task-branch publication, main integration/publication, cleanup, or any product, latency, smoothness, reliability, compatibility, audio/MIDI, simulator/emulator, or physical-device claim. Existing contract gates, evidence requirements, task order/dependencies, one-writer rule, three-specialist limit, correction limit, and guarded milestone-branch-only publication authority remain unchanged.


## OD-006 — Owner-approved combined baseline and M0 reactivation

- Decision date: 2026-10-23, Asia/Manila.
- Decision owner: repository owner, responding directly in controller conversation `01a1671a-5c1d-7ac2-b9a1-5b94d86ed845`.
- Responsible recorder: program controller / Roadmap Orchestrator (`/root`).
- Actual owner reply at `2026-10-23T08:35:22.010Z`: **approved**.
- Approval context: direct response to the request to approve the prepared M0 activation package at `docs/orchestration/BASELINE_CONSTRUCTION_EVIDENCE.md`, section “Owner review package: M0 reactivation.” This records the owner's actual short reply; it does not invent a longer statement.
- Accepted foundation: `b1b0c1edd5e42d3ea791f665c22954834e962d05`.
- Accepted current contract-changing commit: `eb0d55bc7e10b219996fdb7ab69a546b1e350e3a`, `docs/orchestration/milestones/M0_CONTRACT.md`, version 2.
- Independently reviewed combined baseline: `dbd330837391b0ef8ea8bd6f317bd45e50ceaa6d`.
- Exact displayed acceptance-evidence / owner-request tip: `a775b71b105a4b3945308a5ee99e1b654f75f8dd`.
- Unchanged starting milestone: `milestone/m0-research` at `8fdb7444ed80675269f38f90f84b362f90c9af23`.
- Authorized active execution milestone: M0 only, coordinated by this continuation controller; the full working-app objective remains intact and unfinished.

### Decision and entry evidence

The owner accepts the displayed foundation, combined baseline, exact contract and bounded reactivation procedure. This resolves the combined candidate's human-only activation pause. R01/R02 remain Verified; R03–R10 remain in the unchanged contracted queue. No completed task is repeated or waived. The full M0 definition of done remains all ten tasks Verified or Accepted with canonical briefs, evidence, independent reviews, consistent state, a complete reviewed milestone package and equal local/remote milestone hashes.

Fresh read-only checks at `2026-10-23T08:36:32.566137+00:00` proved local main, tracking main and live remote main equal the accepted foundation; the milestone worktree and live remote equal the exact starting milestone; candidate and milestone worktrees clean; candidate descended from that base; the current contract-changing commit equals the displayed binding; the acceptance commit changes only its evidence file; origin has one identical fetch/push endpoint; and the decision-evidence branch is absent locally/remotely. The historical M0 Goal `01a04c45-76d8-7ef0-9cb4-101dbe82a224` was freshly observed blocked and not loaded at `2026-10-23T08:36:28Z`. This continuation Goal was blocked awaiting this reply, with no active M0 research writer. Existing specialist review sessions ended; only this controller owns the activation files.

CT03 QA, Licensing/Security and Final Code Review each approved exact baseline `dbd330837391b0ef8ea8bd6f317bd45e50ceaa6d` with zero findings; their complete records and role-isolation provenance are bound in the accepted evidence package. Historical G01 failure/rollback evidence remains preserved. Current runtime evidence confirms the configured independent Conductor writer and independent read-only review sessions; no mixed-permission nesting is permitted.

The original checkout's separate uncommitted main-guard recovery edits remain byte-for-byte unchanged and excluded. Subsequent advisory QA/Security review rejected those edits; 34 existing fixture scenarios passed, but two additional disposable-fixture reproductions exposed ignored-file data loss and backup deletion. These findings remain unresolved and prohibit adopting those edits or claiming main-integration readiness. They do not authorize or affect this independent research-only activation and milestone-publication guard. No finding is waived by this approval.

### Exact authorized sequence

1. Commit only this owner-decision artifact and resolve its SHA.
2. In a separate commit, bind that SHA and synchronize `M0_LEDGER.md`, `STATE.md`, `.loop/progress.md`, and only ROADMAP's leading M0 status sentence to Active. Keep every research task state unchanged. No research, task execution or integration occurs between these commits.
3. Verify those are the only two commits and allowed paths after exact acceptance tip `a775b71b105a4b3945308a5ee99e1b654f75f8dd`. Recheck the clean milestone at its displayed base, then perform only its bounded hook-disabled fast-forward to the verified activation tip.
4. From the clean checked-out milestone branch, use only `validate_branch_action.sh authorize`, `push`, and `verify` with the same activation tip, `milestone/m0-research`, and accepted foundation. Require actual local/remote equality before research.
5. Continue R03–R10 through committed briefs and separate eligibility/assignment barriers, bounded Conductor handoffs, permission-isolated specialists, one writer and independent reviews. The controller owns local commits and shared Git metadata; writers own only their assigned output files. Do not broaden sandbox permissions after a Git metadata denial.

### Limits and provenance

The accepted package's recovery protocol and exclusions apply unchanged. This decision does not activate M1, adopt architecture/ADRs or dependencies/assets, authorize hardware, credentials/signing, spending/legal commitments, product implementation, public release, main integration, raw pushes, task publication, destructive cleanup, or unsupported device/performance claims. Any failed or ambiguous guard action stops with evidence preserved.

Fresh raw checks and the actual owner-response event are retained under the common Git directory `decision-team-continuation/2026-10-23/`. Their hashes follow; this record also states the observed results so the repository does not depend on local-only evidence for the decision's meaning.

- `od006-owner-response.json` SHA-256: `b46487ef14418d4140b0bf8f29c82c5da2ad29cead20f7731f8fe0952838aff4`.
- `od006-entry-preflight.json` SHA-256: `139dedbd699ae766ecf9d3306a57fc36f269955644d6d3107cbb421115a946b1`.
- `od006-prior-goal.json` SHA-256: `d2a7e97baa2a0e2e05e6a2894433bf32db18245c28595a683bcc7b5b090b663d`.


## OD-007 — Repaired foundation and superseding M0 contract accepted

- Decision date: 2026-10-24, Asia/Manila.
- Decision owner: repository owner in controller conversation `01a1671a-5c1d-7ac2-b9a1-5b94d86ed845`.
- Responsible recorder: program controller / Roadmap Orchestrator (`/root`).
- Actual owner reply: **approved**. This records the actual short response, not an invented activation phrase.
- Approval context: direct response to the request to accept repaired foundation `552413198ae9ed488f70b3d3db656469292b89a4` and the superseding M0 contract at that same exact reviewed snapshot, then resume M0 through its gates.
- Accepted repaired foundation: `552413198ae9ed488f70b3d3db656469292b89a4`.
- Accepted contract snapshot: `552413198ae9ed488f70b3d3db656469292b89a4:docs/orchestration/milestones/M0_CONTRACT.md`. Its latest content-changing ancestor is `6d143f53ebb7a553c0d17db8386251ee23704380`; the bytes at these two commits are identical. The approval binds the displayed snapshot and does not claim the contract was edited in C5.
- Original accepted repository/main foundation: `b1b0c1edd5e42d3ea791f665c22954834e962d05`, unchanged locally, in tracking state and on the live remote. Accepting the repaired foundation does not move main.
- Prior milestone tip: `b6ce6e73faa96664847056453cc19bf4c09f54fa`; latest published milestone tip at preflight: `708aaa5968d557a09d3b9f9b207ff3fd77ffd315`.
- Isolated preparation: `task/m0-od007-adoption`, `.worktrees/m0-od007-adoption`; controller is sole writer.
- Reviewed controls integrated without conflicts at `fa0656aecd270bd3ae8a7a120b055f0aec0621de`, with exact parents equal to the prior milestone and accepted repaired foundation. Merge tree `2da2982cec6533492437da7a9add01ef2da76992` matches the preflight merge result. All fourteen candidate paths match C5; unrelated milestone research/evidence/state remains unchanged.

### Resolved gate and evidence

This owner decision resolves the repaired-foundation/contract adoption gate in the actual independent Steward HUMAN_GATE decision. Published binding `23a4d9975b899d7d17bbb5e7fc8b4df20ab9b7a8`, package `d2b0e788a93e8a30831a68054e44d5483b2d9060`, and verbatim verdict `615478aee5de4f245357a27949eb5110cc0fbbd4` remain immutable. The Steward's PAUSE_HUMAN is not relabeled as approval or consumed as milestone acceptance.

CT04 is Verified through finalized artifact `a15dba413a221e70a02f1a3f9e57a966c2974213` and separate state commit `b6ce6e73faa96664847056453cc19bf4c09f54fa`. Fresh exact-C5 QA/Performance, Licensing/Security and Final Code Review each approved with zero Critical, Important and Minor findings. Canonical review commits are respectively `0b2352271465909a023257c5c4eac01f8f441cec`, `2e7f1900d5503f367d2eed8e2f8f90ad25df67c9`, and `dc12e6b86d5c22fb4d2725779beebd61d288c578`. Controller verification passed 125 evidence-publication scenarios and 118 main-integration scenarios; character/block dynamic coverage remains explicitly unavailable. These existing results are not new runs or product/device evidence.

Historical G01 runtime validation `ec4e76345519973d09a4dbeff6d043e6477e67bc`, correction `5bfbdb5139c4f1936a59ba78c6b1125d8b7cb7db` and independent approval `88fe4ece13bfedd8b67eaa8882c5adf020654418` remain preserved, along with all failed nested-permission attempts. Current CT04 runtime records establish independent read-only review/Steward sessions and the separate writer handoff; no mixed-permission nesting is authorized. No research writer is active. The existing full-app continuation Goal coordinates M0 only; this reactivation neither creates a second Goal nor repeats initial branch creation.

### Authorized sequence and limits

Commit this owner decision first. Its separate next state commit must bind this decision SHA and synchronize M0 to Active in the ledger, STATE, progress, ROADMAP's leading M0 status sentence and verify the research-index statuses remain unchanged. Preserve all R01–R10 Verified states, exact research artifacts and nonblocking R01/R05 limitations; none is Accepted. No task execution or integration may occur between the two barrier commits. Verify the exact prepared descendant before fast-forwarding the existing milestone branch, then use only the milestone guard authorize/push/verify with the accepted repaired-foundation ancestry and identical candidate arguments.

Continue by preparing the complete M0 package, freezing its candidate and obtaining fresh independent reviews and a separate Steward milestone decision. Main integration and successor activation each still require their own exact evidence and guarded authority. No architecture/ADR, dependency/asset, hardware, credentials/signing, spending/legal commitment, product implementation, release/deployment, raw push, task publication, destructive action or safety-gate waiver is authorized by this decision. The app remains a Flutter shell.

The two original owner-edited root guard files remain excluded and unchanged. The erroneous evidence history remains preserved at `0db258d158f1d212497ccfdf07675ec399e6f870` on its archive branch; it is unpublished and unconsumed. Canonical evidence is local/live-remote equal at the binding above. No prior failure is erased or represented as approval.

### Reactivation audit

Independent Researcher `01a1672e-07ef-7650-af24-1a51ffc6d6c0` through same-permission relay `01a1672d-d7a4-7ca1-aee0-7262d495a5f9` audited exact ancestry, path scope, source preservation and barrier ordering read-only. It confirmed a clean non-fast-forward combination and owner-decision then separate reactivation state barrier; research-index states must remain unchanged. Controller performs the combination on the isolated preparation branch before the milestone fast-forward. Actual runtime is gpt-5.6-terra/high/read-only; full raw audit SHA-256 `57f835433dc1e6610623818551f89200c932b0f7c362822de8c0679af4403bc1`, retained under `.git/decision-team-continuation/2026-10-23/governance-correction/od007-researcher.final.txt`. This audit does not substitute for later exact completed-candidate reviews.

Fresh preflight records are in `.git/decision-team-continuation/2026-10-23/od007-adoption/entry-preflight.json`, SHA-256 `275ac34067fb98c71b87e5a66896dd2ab15a096bfc25bec8078216557e05a677`. Initial main/foundation equality and initial one-Goal/branch-creation conditions were satisfied under OD-001; this is reactivation of that existing milestone, with the owner-approved repaired control foundation and unchanged original main, not a new initial activation. No main movement is claimed or authorized.
