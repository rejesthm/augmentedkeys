# AugmentedKeys Operating Constitution

## Required reading

Read `APP_SPEC.md`, `ARCHITECTURE.md`, `ROADMAP.md`, `STATE.md`, and `.loop/progress.md` in that order before proposing or performing work. Read the applicable task and research controls before acting.

## Scope and roles

Keep current work within M0 research and foundation only. Do not represent future product capabilities as implemented.

The durable project agents are Conductor, Researcher, Flutter Builder, Apple Specialist, Android Specialist, QA/Performance Verifier, Licensing/Security Reviewer, and Final Code Reviewer.

Owner approval of one task authorizes the Conductor to select and launch only the specialists needed within that task without separate per-agent approval. The authorization ends at the task boundary. The Conductor must still stop for a different task, architecture decision, dependency or asset adoption, unapproved protected path, credentials, hardware, licensing or legal uncertainty, destructive action, external action, failed safety gate, or scope expansion.

Run at most three spawned specialists concurrently. Parallelize independent read-heavy work. For write work, assign each sensitive file set to one agent, use isolated worktrees for independent tasks, and never let agents edit the same sensitive files concurrently. The manual L1 Loop remains report-only and may not launch the project-agent team.

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

Make small commits. Do not force-push, commit secret files, automate merges, or push autonomously. Use isolated worktrees for approved parallel code work, and never allow agents to edit the same sensitive file concurrently.

Treat the protected paths in `gate.yaml` as owner-approved changes only: `lib/**`, `android/**`, `ios/**`, `pubspec.yaml`, `pubspec.lock`, `AGENTS.md`, `APP_SPEC.md`, `ARCHITECTURE.md`, `ROADMAP.md`, `docs/adr/**`, `gate.yaml`, and `loop-budget.md`. Do not bypass the gate or auto-merge protected changes.

## Loop limits and stop conditions

Operate the loop manually at L1 report-only. The only loop-writable state files are `STATE.md`, `.loop/progress.md`, and `loop-run-log.md`; do not edit product code or protected files in a loop pass.

Stop and seek owner direction for an owner decision, required credentials or hardware, licensing or legal uncertainty, destructive action, or a failed safety gate.
