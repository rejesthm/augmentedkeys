# AugmentedKeys M0 Foundation Design

**Date:** 2026-08-29  
**Status:** Approved for foundation implementation  
**Repository:** `rejesthm/augmentedkeys`  
**Local path:** `/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys`

## 1. Purpose

Create a reviewable foundation for AugmentedKeys, a future professional live keyboard performance application. This phase establishes the Flutter mobile project, project governance, persistent engineering memory, research and architecture controls, and an L1 report-only Loop Engineering workflow.

This phase does not implement the audio engine, MIDI engine, patches, layers, splits, snapshots, songs, setlists, plugin hosting, built-in instruments, performance controls, editing controls, cloud services, or deployment.

## 2. Product identity and platform scope

- Repository name: `AugmentedKeys`
- Flutter package name: `augmented_keys`
- Application identifier: `com.augmentedkeys.app`
- User-facing name: `AugmentedKeys`
- Framework: Flutter
- Supported hosts: Android and Apple mobile
- Supported form factors: phones and tablets, including iPhone and iPad
- Excluded hosts: web, macOS, Windows, and Linux
- Initial milestone: M0 — Research & Architecture

The Flutter scaffold must contain only the Android and iOS platform hosts. It must not generate web or desktop hosts. Android `applicationId` and Apple bundle identifiers must use `com.augmentedkeys.app` exactly.

## 3. Foundation approach

Use a structured M0 foundation: more complete than a bare Flutter project, but smaller and more honest than a full governance scaffold containing unperformed research.

The repository will contain:

- A runnable Flutter shell for Android, iPhone, and iPad.
- A minimal M0 screen that names the product and accurately states its current phase.
- One widget test covering the truthful M0 status.
- Project-level operating instructions and approval boundaries.
- An initial product specification, roadmap, and architecture constraints.
- Research, licensing, testing, device-matrix, ADR, and task structures.
- Loop Engineering state, budget, log, safety gate, and conductor skill.
- No third-party Flutter packages beyond the generated SDK dependencies.

## 4. Repository structure

```text
AugmentedKeys/
├── android/                 Android Flutter host
├── ios/                     iOS and iPadOS Flutter host
├── lib/                     Minimal M0 application shell only
├── test/                    M0 shell widget test
├── docs/
│   ├── adr/                 Architecture decision records and template
│   ├── architecture/        Architecture constraints and research questions
│   ├── product/             Initial goals and product workflows
│   ├── research/            Prioritized research and license ledger
│   ├── superpowers/         Approved design and implementation plans
│   ├── tasks/               Research and engineering task template
│   └── testing/             Test strategy and device matrix
├── .loop/                   Persistent project ledger
├── .codex/skills/           Project-specific Codex workflow skills
├── AGENTS.md                Project operating constitution
├── APP_SPEC.md              Product requirements and non-goals
├── ARCHITECTURE.md          Initial boundaries and undecided decisions
├── ROADMAP.md               M0 through M10 milestone sequence
├── LOOP.md                  Loop behavior and restrictions
├── STATE.md                 Current priorities and state
├── loop-budget.md           Loop execution and cost limits
├── loop-run-log.md          Evidence-backed run history
├── gate.yaml                Human-review boundaries
├── pubspec.yaml             Flutter project configuration
└── README.md                Project introduction and local setup
```

Documents explicitly required for the M0 foundation must contain useful initial content. Documents that depend on future research must be represented by concrete backlog entries rather than empty files or invented findings.

## 5. Minimal Flutter shell

Replace Flutter's generated counter example with a small, accessible M0 status screen using only Flutter SDK widgets.

The screen will show:

- `AugmentedKeys`
- `M0 — Research & Architecture`
- A statement that audio and MIDI features are not implemented
- A statement that the planned targets are Android and Apple phones and tablets

The shell must not imply that the application is performance-ready. It must not contain simulated keyboards, fake meters, non-functional audio controls, placeholder music features, or competitor-derived visual design.

The shell has no network, storage, MIDI, audio, plugin, database, or background-task behavior. Its only error surface is a Flutter rendering or configuration failure, which is covered by static analysis, widget testing, and platform builds when the local toolchain permits them.

## 6. M0 goals

M0 establishes enough evidence and governance to make later architectural decisions safely.

1. Establish product requirements and non-negotiable reliability principles.
2. Create a prioritized research backlog for mobile audio, MIDI, plugins, built-in sound engines, product workflows, and licensing.
3. Define how latency, continuity, stability, and resource use will be measured.
4. Compare architecture approaches with sources and technical spikes before choosing an engine.
5. Identify commercial-use and redistribution risks before dependencies or assets are adopted.
6. Prepare narrowly scoped technical-spike plans for high-risk questions.
7. Produce reviewed Architecture Decision Records before implementing the audio/MIDI core.

M0 does not select UAPMD, JUCE, AudioKit, Rust, C++, AVAudioEngine, Oboe, AAP, AUv3, or a state-management package. Those choices require evidence and explicit approval.

## 7. Architecture boundaries

Flutter owns the user interface and ordinary application coordination. Flutter is not presumed to own hard real-time DSP responsibilities.

Future audio and MIDI components must be isolated behind explicit interfaces so native or shared-native implementations can be evaluated without coupling the product model to one engine. The initial scaffold does not create those interfaces because their shape depends on M0 research.

The future real-time audio callback must prohibit:

- Blocking I/O and network access
- UI operations
- Database access
- JSON parsing
- Plugin discovery or loading
- Unbounded or avoidable memory allocation
- Arbitrary mutex waiting
- Potentially blocking logging

Offline playing is a product requirement. Future network services must not sit in or block the audio path.

## 8. Performance and reliability model

Loop Engineering cannot itself guarantee low latency or smooth performance. It enforces a process in which relevant work cannot be completed without objective evidence.

Performance work is divided into:

- Interface responsiveness
- MIDI processing responsiveness
- Input-to-output audio latency
- Audio continuity and callback health
- Patch-switch timing and tail continuity
- CPU, memory, battery, and thermal behavior
- Long-duration stability

Every relevant result must identify the device, OS version, simulator or physical-device status, audio buffer, sample rate, workload, duration, measurement method, and result. The project must never present simulator evidence as real-device verification or invent benchmark values.

M0 will establish measurement methods and defensible target budgets before core implementation. Later milestone gates will use those budgets to detect regressions.

## 9. Loop Engineering model

Initialize the repository with the Loop Engineering `daily-triage` pattern configured for Codex, then reconcile the generated files with this approved design.

The initial loop operates at L1 report-only. It may:

- Read repository files and approved project instructions.
- Run non-destructive formatting, analysis, test, and loop-health checks.
- Identify missing research, evidence, decisions, documentation, and verification.
- Update `STATE.md`, `.loop/progress.md`, and `loop-run-log.md`.
- Recommend one next highest-priority task.

It may not:

- Implement product functionality.
- Modify Flutter or native platform code without approval.
- Add, remove, or update dependencies.
- Change Android or Apple platform configuration.
- Launch specialist agents or scheduled automations.
- Create or merge pull requests.
- Commit, push, sign, release, or deploy automatically.
- Change its budget, permissions, or safety boundaries.

The initial `.codex/skills/loop-conductor/SKILL.md` reads project state, checks the current milestone and approvals, runs only permitted verification, records evidence, recommends one task, and stops for product-owner approval.

Specialist teams from the master prompt are documented as future roles. They are not launched during foundation setup.

## 10. Human review gate

The initial safety gate protects:

```text
lib/**
android/**
ios/**
pubspec.yaml
pubspec.lock
AGENTS.md
APP_SPEC.md
ARCHITECTURE.md
ROADMAP.md
docs/adr/**
gate.yaml
loop-budget.md
```

Only these live state files may be changed by an approved L1 loop without a separate implementation approval:

```text
STATE.md
.loop/progress.md
loop-run-log.md
```

No Codex Automation is created during foundation setup. Scheduling is a later, separately reviewed decision after several useful manual L1 runs.

## 11. Initial documentation

Create and populate:

- `README.md`
- `AGENTS.md`
- `APP_SPEC.md`
- `ROADMAP.md`
- `ARCHITECTURE.md`
- `.loop/progress.md`
- `docs/product/INITIAL_GOALS.md`
- `docs/research/RESEARCH_INDEX.md`
- `docs/research/LICENSE_LEDGER.md`
- `docs/architecture/REALTIME_SAFETY.md`
- `docs/testing/TEST_STRATEGY.md`
- `docs/testing/DEVICE_MATRIX.md`
- `docs/tasks/TASK_TEMPLATE.md`
- `docs/adr/ADR_TEMPLATE.md`

The research index captures all named research streams from the master prompt. It separates confirmed requirements from questions, and it does not contain research conclusions until sourced research is performed.

The public repository receives no root license file in this phase. Public visibility does not itself grant reuse rights. Licensing and distribution terms require a separate owner decision.

## 12. Verification

Foundation verification includes:

```bash
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
npx @cobusgreyling/loop doctor .
```

Also verify:

- Only Android and iOS Flutter hosts exist.
- Android and Apple identifiers equal `com.augmentedkeys.app`.
- The generated counter sample has been removed.
- The application contains no third-party packages or core product features.
- All required foundation documents exist and do not claim unperformed research or testing.
- `git status` is clean after the foundation commit.

Platform builds may be attempted if the generated local toolchain supports them without adding credentials or changing signing configuration. A build not run is reported as not run, never as passing.

## 13. Git and GitHub handoff

- Local primary branch: `main`
- Remote name: `origin`
- Remote URL: `git@github.com:rejesthm/augmentedkeys.git`
- GitHub repository: `https://github.com/rejesthm/augmentedkeys`

The approved design is committed before implementation planning. After foundation implementation and verification, create a separate foundation commit, push `main`, and confirm that the local branch tracks `origin/main`.

Do not create GitHub Actions, releases, tags, branch-protection rules, secrets, signing configuration, store configuration, or deployment workflows in this phase.

## 14. Completion criteria

The M0 foundation setup is complete only when:

1. The approved design and implementation plan are committed.
2. The Flutter Android/iOS shell is runnable and truthfully identifies M0.
3. Formatting, analysis, and widget tests pass with fresh evidence.
4. Loop Engineering is initialized in L1 report-only mode and its health result is recorded.
5. Required project, research, architecture, testing, and safety documents are populated.
6. No core product functionality or unapproved dependency is present.
7. The verified foundation is committed and pushed to `origin/main`.
8. The handoff lists verification evidence, known limitations, and the next proposed task without starting it.
