# AugmentedKeys Operating Constitution

## Required reading

Read `APP_SPEC.md`, `ARCHITECTURE.md`, `ROADMAP.md`, `STATE.md`, and `.loop/progress.md` in that order before proposing or performing work. Read the applicable task and research controls before acting.

## Scope and roles

Keep current work within M0 research and foundation only. Do not represent future product capabilities as implemented.

The durable project agents are Conductor, Researcher, Flutter Builder, Apple Specialist, Android Specialist, QA/Performance Verifier, Licensing/Security Reviewer, and Final Code Reviewer.

Owner approval of one milestone authorizes the Roadmap Orchestrator Goal to advance automatically through eligible tasks only inside that milestone's committed contract after the owner is shown and accepts the exact foundation and contract commits. The Goal must use `.codex/skills/roadmap-orchestrator/SKILL.md`, may own only one milestone, coordinates rather than implements product work, and must stop before the next milestone or any non-delegable owner gate.

For each eligible task, the Roadmap Orchestrator gives one bounded brief to the Conductor. The Conductor may select and launch only the specialists needed within that task without separate per-agent approval, and its authority ends when the task is verified, blocked, or stopped. The Roadmap Orchestrator and Conductor must stop for architecture or ADR selection, adoption, or material change; dependency or asset action; an out-of-allowlist path; credentials; requesting or operating required hardware outside an approved procedure; licensing or legal uncertainty; destructive action; unauthorized external action; failed safety gate; unresolved Critical or Important findings; unsupported evidence; or scope expansion.

Run at most three spawned specialists concurrently. Parallelize independent read-heavy work. Permit only one active write task, assign each sensitive file set to one agent, use isolated task worktrees, and never let agents edit the same sensitive files concurrently. The manual L1 Loop remains report-only and may not launch the Roadmap Orchestrator or project-agent team.

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

Make small local task commits only when the parent agent explicitly requests them. For an active owner-approved milestone, the Roadmap Orchestrator may integrate independently approved task commits sequentially and use `.codex/skills/roadmap-orchestrator/scripts/validate_branch_action.sh` to authorize and perform only the exact contracted `milestone/<milestone-id>-<short-slug>` refspec push from a clean checked-out branch descending from the accepted foundation commit; the guard must then prove local and remote hashes match. Pushes are limited to the active milestone branch, and no separate raw `git push` is permitted. Never publish a task branch within this workflow. Do not push or merge `main`, open pull requests, force-push, commit secret files, automate merges, or take another external action without separate owner authorization. A different publication workflow requires a separately approved design outside the Goal. Use isolated worktrees for approved write work, and never allow agents to edit the same sensitive file concurrently.

Treat the protected paths in `gate.yaml` as owner-approved changes only: `lib/**`, `android/**`, `ios/**`, `pubspec.yaml`, `pubspec.lock`, `AGENTS.md`, `APP_SPEC.md`, `ARCHITECTURE.md`, `ROADMAP.md`, `docs/adr/**`, `gate.yaml`, and `loop-budget.md`. Do not bypass the gate or auto-merge protected changes.

## Milestone gates

The Roadmap Orchestrator must pause before beginning a new milestone or integrating the milestone branch into `main`; before architecture or ADR selection, adoption, or material change; for dependencies or assets; missing license evidence; credentials or secrets; signing or entitlements; requesting or operating required hardware outside an approved procedure; paths outside the milestone allowlist; destructive actions; scheduled or heartbeat automation; external actions other than an authorized milestone-branch push; unresolved Critical or Important findings; unsupported evidence; or a change to milestone objective, queue semantics, definition of done, or safety gates. Routine integration of a verified task into the active milestone branch remains authorized. One task may receive at most five correction-and-review rounds.

## Loop limits and stop conditions

Operate the loop manually at L1 report-only. The only loop-writable state files are `STATE.md`, `.loop/progress.md`, and `loop-run-log.md`; do not edit product code or protected files in a loop pass.

Stop and seek owner direction for an owner decision, required credentials or hardware, licensing or legal uncertainty, destructive action, or a failed safety gate.
