# AugmentedKeys Operating Constitution

## Required reading

Read `APP_SPEC.md`, `ARCHITECTURE.md`, `ROADMAP.md`, `STATE.md`, and `.loop/progress.md` in that order before proposing or performing work. For decision-team work or continuation after an interruption, then read `docs/orchestration/CONTINUATION_CHARTER.md` and `docs/orchestration/APP_CONTEXT.md`. Read the exact task or milestone contract, applicable evidence and research controls, and the full candidate diff before acting. Each decision-making role must report the versions it read, the user outcome, its decision scope, known gaps, and its next action. These additions do not replace or weaken any existing task, milestone, owner-only, review, or safety gate.

## Scope and roles

Keep current work within M0 research and foundation only. Do not represent future product capabilities as implemented.

The nine durable project agents are Conductor, Researcher, Flutter Builder, Apple Specialist, Android Specialist, QA/Performance Verifier, Licensing/Security Reviewer, Final Code Reviewer, and Decision Steward. The Decision Steward is independent and read-only; it uses `.codex/skills/decision-steward/SKILL.md` and `docs/orchestration/DECISION_POLICY.md`.

After all contracted work and independent reviews are complete, the Decision Steward may issue `APPROVE_MILESTONE` for one exact completed milestone tip, `APPROVE_MAIN_INTEGRATION` for one exact guarded fast-forward into one exact unchanged `main` base, or `APPROVE_NEXT_MILESTONE` for one exact committed and independently reviewed successor contract whose entry conditions pass. It may instead issue `CORRECT` or `PAUSE_HUMAN`. Every verdict binds the exact contract, candidate, completion-package, review-artifact, target-main, and applicable successor-contract SHAs; any changed bound SHA requires affected fresh review and a fresh decision.

The owner alone retains authority for credentials or secrets; signing identities, entitlements, and external accounts; spending, purchases, paid services, financial commitments, and legal agreements or conclusions; public release, deployment, store submission, or public communication; destructive, irreversible, or difficult-to-reverse action; missing or conflicting evidence; unresolved Critical or Important findings or weakening a gate; out-of-scope work; roadmap or objective expansion; and changes to safety policy. The Steward never implements, edits, authors review evidence, commits, merges, pushes, signs, releases, deploys, or records its own verdict.

Owner approval of one milestone authorizes the Roadmap Orchestrator Goal to advance automatically through eligible tasks only inside that milestone's committed contract after the owner is shown and accepts the exact foundation and contract commits. The Goal must use `.codex/skills/roadmap-orchestrator/SKILL.md`, may own only one active milestone, and coordinates rather than implements product work. It must stop at the completed package for a Decision Steward verdict, before any non-delegable human gate, and before a successor milestone unless the Steward issues `APPROVE_NEXT_MILESTONE` for the exact committed and independently reviewed successor contract after its entry conditions pass. The current M0 pause remains binding until the redesigned orchestration, integration guard, runtime role-isolation evidence, and required reviews are complete.

For each eligible task, the Roadmap Orchestrator gives one bounded brief to the Conductor. The Conductor may select only the specialists needed within that task without separate per-agent approval, and its authority ends when the task is verified, blocked, or stopped. It must return bounded dispatch requests to the program controller rather than launch selected roles beneath its workspace-write session. The Roadmap Orchestrator and Conductor must stop for architecture or ADR selection, adoption, or material change; dependency or asset action; an out-of-allowlist path; credentials; requesting or operating required hardware outside an approved procedure; licensing or legal uncertainty; destructive action; unauthorized external action; failed safety gate; unresolved Critical or Important findings; unsupported evidence; or scope expansion.

Use this permission-isolated topology for every role handoff:

```text
program controller -> independent read-only role session
program controller -> independent workspace-write role session
```

Never nest a read-only role beneath a workspace-write role or a workspace-write role beneath a read-only role. Preserve all G01 failure and rollback evidence; configuration alone does not prove the runtime boundary.

Run at most three spawned specialists concurrently. Parallelize independent read-heavy work. Permit only one active write task, assign each sensitive file set to one agent, use isolated task worktrees, and never let agents edit the same sensitive files concurrently. The manual L1 Loop remains report-only and may not launch the Roadmap Orchestrator or project-agent team.

### Frozen-candidate review chronology

Review evidence uses an immutable lane on `governance/decision-evidence`: each QA, Licensing/Security, or Final review is one add-only canonical review commit created after the exact candidate is frozen and before its consuming package. Review commits must be ancestors of the package, never ancestors of the candidate they review. Metadata ends at the canonical output begin marker. The body is one canonical base64 line; required encoding, decoded-byte-length, and SHA-256 fields bind the exact decoded review or guard output bytes without adding or removing terminal newlines. Metadata-looking or delimiter-looking decoded content remains opaque evidence. Approval packages use only the supported milestone-acceptance, main-integration, or next-milestone schema and substantively bind the completion, acceptance/integration, or successor/entry evidence that applies. A technical-review approval cannot cross a human-only gate: that case uses an explicit `HUMAN_GATE` negative package with its reason, complete approving review references, `PAUSE_HUMAN`, and `DENIED` authorization.

Milestone acceptance binds the frozen completion candidate `C`. Only after that binding is current may one administrative descendant `I` change exactly `ROADMAP.md`, `STATE.md`, `.loop/progress.md`, `docs/orchestration/milestones/M0_LEDGER.md`, and the status fields in `docs/research/RESEARCH_INDEX.md`. Every required `Verified` task becomes `Accepted`; the milestone becomes `Accepted`; the ledger replaces its prior acceptance-binding value, records the accepted milestone tip `C`, and appends one calendar-valid dated row for each R01–R10 transition plus one for M0. Full bytes, terminal newlines, canonical `100644` modes, unique fields, statuses, and all unchanged bytes are checked. Main integration freezes `I`, obtains fresh independent reviews of `I`, and records approval only on the evidence branch. Its package binds `C`, `I`, their exact semantic delta, the still-current acceptance binding for `C`, the fresh reviews of `I`, and unchanged `main`. `C` and `I` are never interchangeable, and shared milestone state never records main-integration approval after `I` freezes.

The controller must invoke each governance guard with the reviewed commit containing the authoritative guard blob and its SHA-256; runtime guard bytes must match both. Main-integration preflight requires a sterile worktree and rejects tracked, untracked, ignored, empty-directory, symlink, special-file, or unsafe-name state before content is read. The guard has no credential-copy authority. Recovery removes a private metadata snapshot only after exact restoration is proved. Any incomplete restoration is a non-replayable `PARTIAL` with the actual snapshot retained for human inspection.

## Verification and evidence

Run the applicable Flutter verification commands before reporting a Flutter change complete:

```bash
flutter pub get
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
```

Do not claim completion without fresh command output. Identify device, OS, configuration, and measurement method for relevant evidence; distinguish simulator evidence from physical-device evidence.

## Real-time and research discipline

For the future audio callback, prohibit blocking work, I/O, UI work, parsing, allocation, arbitrary locks, and potentially blocking logs. Treat this as a hard real-time boundary until evidence-backed decisions replace it.

Prefer official documentation, original repositories, specifications, and maintainer material for research. Record source URLs and access dates. Separate fact, inference, recommendation, and open question; do not turn an unperformed investigation into a conclusion.

## Licensing and change control

Update `docs/research/LICENSE_LEDGER.md` before adding a package, code, font, icon, DSP, sample, patch, or instrument asset. Do not add material whose licensing, commercial use, or redistribution status is uncertain.

Make small local task commits only when the parent agent explicitly requests them. For an active owner-approved milestone, the Roadmap Orchestrator may integrate independently approved task commits sequentially and use `.codex/skills/roadmap-orchestrator/scripts/validate_branch_action.sh` to authorize and perform only the exact contracted `milestone/<milestone-id>-<short-slug>` refspec push from a clean checked-out branch descending from the accepted foundation commit; the guard must then prove local and remote hashes match. Pushes are limited to the active milestone branch, and no separate raw `git push` is permitted. Never publish a task branch within this workflow. Do not push or merge `main` unless the separately validated main-integration guard consumes an exact recorded `APPROVE_MAIN_INTEGRATION` verdict, and do not open pull requests, force-push, commit secret files, automate merges, or take another external action without separate owner authorization. Until that guard and its orchestration contract are implemented and validated, `main` integration remains prohibited. A different publication workflow requires a separately approved design outside the Goal. Use isolated worktrees for approved write work, and never allow agents to edit the same sensitive file concurrently.

Treat the protected paths in `gate.yaml` as owner-approved changes only: `lib/**`, `android/**`, `ios/**`, `pubspec.yaml`, `pubspec.lock`, `AGENTS.md`, `APP_SPEC.md`, `ARCHITECTURE.md`, `ROADMAP.md`, `docs/adr/**`, `gate.yaml`, and `loop-budget.md`. Do not bypass the gate or auto-merge protected changes.

## Milestone gates

The Roadmap Orchestrator must pause for a Decision Steward verdict before beginning a new milestone or integrating the milestone branch into `main`; before architecture or ADR selection, adoption, or material change; for dependencies or assets; missing license evidence; credentials or secrets; signing or entitlements; requesting or operating required hardware outside an approved procedure; paths outside the milestone allowlist; destructive actions; scheduled or heartbeat automation; external actions other than an authorized milestone-branch push or an exact Steward-approved guarded `main` integration; unresolved Critical or Important findings; unsupported evidence; or a change to milestone objective, queue semantics, definition of done, or safety gates. A Steward verdict cannot cross a human-only boundary. Routine integration of a verified task into the active milestone branch remains authorized. One task may receive at most five correction-and-review rounds.

## Loop limits and stop conditions

Operate the loop manually at L1 report-only. The only loop-writable state files are `STATE.md`, `.loop/progress.md`, and `loop-run-log.md`; do not edit product code or protected files in a loop pass.

Stop and seek owner direction for an owner decision, required credentials or hardware, licensing or legal uncertainty, destructive action, or a failed safety gate.
