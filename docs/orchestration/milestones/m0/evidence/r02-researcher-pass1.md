# R02 Researcher evidence — pass 1

Status: `READ-ONLY FINDINGS COMPLETE; unreviewed`

## Exact inputs

- Brief: `8652877b5d87706739076da4bdc69a72fd9c01ba`.
- In-progress state: `28bad9934dd6591e578692a14215f0b51d5d5e2c`.
- Assignment evidence: `d7f98804d12c37b8cf7283b3bff42c6119639ca8`.
- Task-start/state base: `bfbe3abd7cc3576386f971a247f4a96e5c1f7187`.
- R01 candidate: `09266fdc17e137db44495d85c6b42cf296efb89c`.
- R01 finalized verification: `1c3d4618b1cbf2c583f2c4950800edaab58ee185`.
- R02 candidate and verification: Not created.

## Source-backed runtime provenance

- Read-only relay: `01a060db-d164-7ca0-9ee1-a8e6e627bedb`; rollout SHA-256 `98b187bd3e85dd928c1547c7c7893847d2ea7d0ae43f098ce8ce09d061693d4c`, 80 lines.
- Configured Researcher: `Goodall`, child `01a060dc-3809-70c3-aacf-ebbee6ef1046`, role `researcher`; rollout SHA-256 `d006aba32ebeaf6b17ef10622cf2f13a46f6f8c1eb97b51294e1bcd28befe488`, 168 lines; literal complete packet at zero-based ordinal 165.
- The child was effective `gpt-5.6-terra` / `high` / `read-only` and project-rooted at `/Users/jestherjordanminor/Documents/Projects/Personal/AugmentedKeys/.worktrees/m0-r02-uapmd`.
- The packet's first line mistakenly reports the relay ID as its child ID. The authoritative session metadata and rollout filename identify the actual child above. The byte-authoritative reply is otherwise preserved unchanged in the hashed rollout.
- No repository edit, clone, submodule initialization, source execution, build, package resolution, benchmark, simulator, emulator, device, hardware, dependency, architecture, legal, publication, or external mutation occurred.

## Decision-preserving evidence packet

### Identity and source limits

- Observed fact: the maintainer repository is <https://github.com/atsushieno/uapmd>, describing UAPMD as “Ubiquitous Audio Plugin MIDI Device,” a modular music-sequencer/plugin-host engine.
- The latest release displayed during access was `0.5.6`, with GitHub showing short commit `93c25a7` and a rendered publication label of `18 Aug 12:41`; the retrieved text did not expose a complete timestamp/timezone.
- Maintainer documentation characterizes most code as MIT, with Apache-2.0 modules including `uapmd-ara`/`uapmd-mir`; release notes state that enabling ARA changes the whole application's stated license to Apache-2.0. These are documentary facts, not adoption or distribution clearance.
- `git ls-remote` could not resolve `github.com` inside the Researcher's sandbox. Exact full upstream commit SHA, tag-object identity, submodule SHAs, and raw-file hashes remain missing. Treat `0.5.6` only as the displayed release identity.

Primary source URLs:

- <https://github.com/atsushieno/uapmd>
- <https://github.com/atsushieno/uapmd/releases/tag/0.5.6>
- <https://github.com/atsushieno/uapmd/releases>
- <https://github.com/atsushieno/uapmd/actions>
- <https://github.com/atsushieno/aap-core>
- <https://developer.apple.com/documentation/audiotoolbox/audio-unit-v3-plug-ins>
- <https://developer.apple.com/documentation/avfaudio/avaudiounit/instantiate(with:options:completionhandler:)>

### Components and documentary flow

- Maintainer documentation identifies `remidy` for plugin API abstraction and UMP-oriented event/parameter handling; `remidy-tooling` for scanning/instancing; `uapmd`/`uapmd-engine` for virtual MIDI 2.0 and graph/engine foundations; `uapmd-data` for track/clip/project and real-time data provision; `uapmd-file` for file/document APIs; and `uapmd-app` for scanning, instancing, control, virtual devices, and state persistence.
- Inference: documented modules suggest a UMP/MIDI-to-plugin-event-to-audio-graph path, with sequencer/project data and persistent plugin state. This is not a code-path audit.
- Documented project save/load, plugin binary state, DAG, latency compensation, remote scanning, offline rendering, JavaScript, and MCP surfaces exceed the minimum live-instrument core and create ownership/security questions.

### Apple and Android paths

- Apple fact: the UAPMD platform table lists iOS with AUv3 and documents an iOS simulator build script. Apple documents AUv3 as an app-extension model with asynchronous instantiation and in-process or extension-process options. No build was run.
- Apple gaps: exact iPhone/iPad OS range, discovery/instantiation failure policy, UI containment, AVAudioSession ownership, interruption/route recovery, teardown, App Store viability, device compatibility, continuity, and performance.
- Android fact: the table lists Android with AAP and a Gradle build command. It says Android virtual MIDI 2.0 devices are missing while AAP has static support. No build was run.
- Release-history fact: `0.5.0` describes an incompatible AudioPluginService V4 transition; `0.5.1` says it requires AAP `0.11.1`, not `0.11.0`. This does not prove `0.5.6`'s exact resolved dependency.
- AAP's maintainer describes Binder IPC/shared-memory host separation and characterizes hosting APIs as reference-level/unstable with potentially obsolete or ahead-of-implementation documentation. These are AAP facts, not proof of UAPMD behavior.
- Android gaps: API/NDK range, vendor/device coverage, crash/stall recovery, Binder/shared-memory deadlines, permissions, UI/service lifecycle, and device performance.

### Comparison and real-time evidence

- Unweighted baseline: platform-native lifecycle ownership plus portable control/DSP boundary; UAPMD `0.5.6`; JUCE; and lower-level CPAL/miniaudio. Available evidence does not justify numeric scoring.
- UAPMD's documentary strength is reusable modular layers and stated iOS/AUv3 plus Android/AAP coverage. Gaps include broad host/DAW scope and absent pinned-code, lifecycle, callback, build, and device proof.
- `0.5.6` notes report fixes for DFT work on the real-time thread, non-real-time-safe snapshot publication, a shutdown crash, and graph defects, plus a replacement snapshot publisher and asynchronous document mutations.
- Inference: this shows active attention to real-time/lifetime risks and that such risks existed in the release line; it does not prove compliance with AugmentedKeys' hard callback prohibition.
- Missing: complete callback graph, allocation/lock/I/O/logging audit, bounded queue proof, plugin-call safety, route/interruption/disconnect handling, repeated lifecycle/teardown tests, deadline/underrun evidence, and device measurement. This is neither proof of safety nor unsafety.

### Maturity, licensing, and security

- Observed activity signals at access: release `0.5.6`, 1,686 displayed commits, 12 visible issues, Actions workflows including `build android` and `build dist`, and 1,208 displayed workflow runs. Activity and CI presence are not successful build/test or suitability evidence.
- The sub-1.0 line, recent real-time/shutdown fixes, and moving-documentation warning leave API and behavior stability unproven.
- Documented inputs include submodules, CMake `FetchContent`, directly included libraries, optional ML/model features, plugin SDKs, queues/logging libraries, and fonts across multiple stated license families.
- R07 must pin the complete graph, downloads, optional features, notices, assets and exact licenses; evaluate ARA license effects; separate SDK/plugin/font/model/trademark/patent/attribution/redistribution questions; and audit JavaScript/MCP, remote scanning, binary state, listeners/authentication, untrusted plugins, Android process boundaries, permissions, privacy, credentials, retention, and provenance.

### Classification and disposition

- Fact: only the source-backed observations above.
- Inference: module relationships suggest the stated control/audio flow; recent fixes and broad scope raise reliability and ownership questions.
- Recommendation: preserve UAPMD only as a candidate for a later bounded comparison and freeze a complete immutable revision before any code, license, or measurement claim.
- Disagreement: no direct source contradiction established. AAP's caveat limits reliance; it does not contradict UAPMD's stated Android support.
- Missing evidence: full revision, raw source hashes, exact release manifest, platform lifecycle contracts, security posture, license clearance, builds/tests, supported OS/device matrix, benchmarks, and performance data.
- Disposition: `retain for later spike comparison`. This is not architecture selection, dependency approval, license clearance, implementation authorization, or a reliability/performance conclusion.

Future owner-gated work would freeze exact revisions, run source-only callback/lifecycle/security audit, separate Apple AUv3 and Android AAP failure/recovery spikes, and apply the R01 physical-device measurement procedure. Owner decisions remain required for spike authority, exact module/version scope, plugin-hosting scope, devices/routes/controllers/budgets, licensing/security scope, ADRs, and adoption.

## Method and limitations

- Environment: macOS `26.6.1` (`25G76`), arm64, Git `2.50.1`; device/simulator status: Not applicable.
- Primary-source access window recorded by the Researcher: `2026-09-02T14:46:52+0800` through `2026-09-02T14:46:56+0800`; earlier corroborating retrieval occurred the same date.
- Rendered source line counts: UAPMD repository 427; release 208; Actions 396; AAP 328.
- This is an unreviewed read-only evidence packet for the Conductor. It is not the contracted R02 report, a candidate, verification, reviewer verdict, or task transition.
