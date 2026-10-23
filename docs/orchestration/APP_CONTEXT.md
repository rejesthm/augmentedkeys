# AugmentedKeys Shared App Context

Snapshot date: 2026-10-23

Initial setup authority: [CT01](CONTINUATION_SETUP_BRIEF.md) at `f6e87ec973dddb26f07da23920e29cb876559a0c`. Read the latest brief in the exact reviewed candidate as well; its authority-language correction narrows the initial wording without expanding scope.

Context status: candidate for independent decision-team review; it records observed state and creates no execution authority

## User outcome

AugmentedKeys is planned as an original, reliable, offline-first live keyboard instrument for Android phones/tablets and iPhone/iPad. The approved first-version direction lets a keyboard player enable audio, choose a worship starter patch, play by touch or a supported wired MIDI controller, blend and edit up to four layers, save the patch, recall Verse/Chorus/Bridge variations, and perform an ordered setlist.

Reliability, latency, audio continuity, usability, and then feature breadth are the product priorities, in that order. The Elevation Worship reference expresses musical direction only. It does not authorize copied recordings, commercial presets, patches, branding, artwork, or endorsement claims.

The detailed workflow, failure behavior, and acceptance scenarios are in the [Worship Patch Builder design](../superpowers/specs/2026-10-23-worship-patch-builder-design.md). The owner approved its delivery direction and delegated routine detailed review to the decision team. Exact-candidate team acceptance is still pending.

## First-version scope

- A small cleared built-in collection covering piano, ambient pad, and warm synth. A placeholder oscillator cannot satisfy the piano requirement.
- Six original editable starter patches: Gentle Piano, Piano and Air, Warm Pad, Rising Pad, Soft Synth, and Full Worship. These are working names and planned recipes, not existing assets.
- One to four layers per patch, with instrument, enable/mute, level, brightness, reverb send, and delay send; master level and shared effect settings live at patch level.
- Touch audition and basic wired MIDI for notes, velocity, sustain, device selection, connection status, disconnect recovery, and a visible Stop Sound action.
- Factory patches remain immutable. Users can save copies, rename, and delete user patches while preserving or explicitly resolving setlist references.
- Three settings-only variations per patch, initially Verse, Chorus, and Bridge; recall does not change instruments or load samples.
- Named songs, ordered setlists, and a performance view with current/next song, variation controls, MIDI/audio status, master level, and Stop Sound.
- Offline local persistence, explicit recovery for failed saves and corrupt or newer documents, and no account or network prerequisite.

Deferred work includes third-party plugin hosting, cloud sync, sample import, recording, backing tracks, MIDI 2.0/MPE breadth, arbitrary modulation, keyboard splits, desktop/web hosts, background playback, and public release. Later scope remains subject to separate contracts and evidence.

## What exists today

The checked-out product implementation is a Flutter mobile shell. It establishes no product-core engine, domain model, audio/MIDI behavior, patch builder, instrument content, persistence, variations, songs, setlists, plugin hosting, or cloud service. Planned terms such as Library, Patch, Layer, Snapshot, Song, and Setlist are vocabulary, not implemented interfaces.

No engine, framework, native boundary, state-management approach, persistence technology, sound format, plugin approach, or cloud design has been selected. No dependency or asset is adopted by CT01. No simulator runtime, emulator runtime, physical-device playback, controller compatibility, audio capture, latency, workload, interruption, lifecycle, or long-run evidence is produced by this setup.

The future audio callback remains a hard real-time boundary: no blocking work, I/O, UI work, parsing, allocation, arbitrary lock waiting, or potentially blocking logging. Flutter owns presentation and ordinary coordination; evaluated native or shared-native code may later own real-time duties behind an approved boundary.

## Versioned evidence snapshot

The repository contains two unreconciled histories. They must be compared, not silently combined or treated as interchangeable.

| Record | Exact commit | Observed meaning |
| --- | --- | --- |
| Planning branch base | `4a9a4aa05f47935c7d997c5bbf4c19fc7c1a77a9` | Governance checkout with a recorded M0 pause and the shell-only product state |
| CT01 setup brief | `f6e87ec973dddb26f07da23920e29cb876559a0c` | Authorizes only the decision-team context and charter setup, with controller-owned commits after the Conductor Git-metadata denial |
| Planning checkout's latest M0 contract change | `b0122f7030331d3e86af28a779075349fc9e74ff` | Current planning-line contract text; it does not reactivate M0 |
| Planning checkout's latest M0 ledger change | `764657c148176d6fd0ba199f4775461f9410876f` | Current planning-line ledger content; state files still report M0 paused and R01 blocked |
| Recorded planning-line M0 pause | `998fb53884f986154e1238ea3d76539adc565b70` | MT-001 pause evidence named by `STATE.md` and `.loop/progress.md` |
| Newer research tip and latest research-line ledger change | `8fdb7444ed80675269f38f90f84b362f90c9af23` | Research line reports M0 active, R01/R02 Verified and integrated, and R03-R10 Queued |
| Research-line contract source | `13b864f09ca083d10910bcffa4432b81c040bda9` | Contract version recorded by the research line after role-isolation correction |
| R01 reviewed candidate | `09266fdc17e137db44495d85c6b42cf296efb89c` | Documentary mobile-audio and measurement research; no engine selection or physical-device result |
| R02 reviewed candidate | `8b39e5572f481af21d5fba598c1abf0fe8dc5dec` | Documentary UAPMD evaluation; no adoption, build, benchmark, or licensing clearance |

At research tip `8fdb7444ed80675269f38f90f84b362f90c9af23`, R01 and R02 are `Verified`, not milestone `Accepted`. Their exact evidence and history must be preserved. In this planning checkout, `STATE.md`, `.loop/progress.md`, and [ROADMAP.md](../../ROADMAP.md) still record M0 as paused. CT01 does not decide which branch state becomes executable, rewrite either history, resume R03, accept M0, integrate `main`, or activate M1.

## Architecture and content gates

Architecture choices follow research, spike, benchmark, ADR, required review, and the applicable exact approval before implementation. UAPMD, JUCE, C++, Rust, AVAudioEngine, AudioKit, Oboe, AAudio, AAP, AUv3, sound format, state management, persistence, and cloud sync remain undecided. Apple and Android ecosystems require separate evidence.

Every package, code component, font, icon, DSP implementation, sample, patch, instrument, or other asset needs exact source/version identity and a sufficient [license-ledger](../research/LICENSE_LEDGER.md) entry before adoption. Missing or uncertain redistribution, commercial-use, attribution, source, patent, trademark, or content-rights evidence stops adoption.

Performance claims require a predeclared measurement boundary, device and route, build configuration, workload, warm-up, repetitions or duration, objective acceptance condition, raw artifact location, and independent review. Static checks, builds, setup probes, or simulator evidence cannot prove physical-device latency, continuity, sound quality, or controller support.

## Decision and safety boundaries

Routine reversible choices and automatic progression require express delegation by the exact active committed task or milestone contract, plus evidence and applicable independent reviews. A brief may delegate a class of routine choices. That delegation cannot change a milestone's objective, scope, queue semantics, definition of done, architecture/ADR status, dependency or asset set, safety gates, or human-only boundaries. The owner-approval step for high-risk architecture remains binding. No implementer self-approval or majority vote can override a gate. The Decision Steward retains exact-SHA milestone, guarded-main-integration, and successor-contract authority under [DECISION_POLICY.md](DECISION_POLICY.md).

The owner retains credentials, secrets, signing, entitlements, external accounts, spending, financial or legal commitments and conclusions, public release or communication, deployment and store submission, destructive action, missing or conflicting evidence, unresolved Critical or Important findings, gate weakening, out-of-scope work, roadmap or objective expansion, and safety-policy changes. Required hardware also needs the approved procedure and applicable owner authorization.

Keep one active milestone, one write task, and at most three specialist sessions. The controller launches permission-isolated top-level sessions. Configuration describes intended roles; actual runtime sandbox evidence establishes permission isolation.

## Resume checklist

1. Resolve the branch, exact `HEAD`, task or contract commit, latest relevant ledger-changing commit, candidate commit, and declared base.
2. Confirm the worktree status and sole ownership of every writable path; preserve unrelated changes and all failed-probe or rollback evidence.
3. Read [APP_SPEC.md](../../APP_SPEC.md), [ARCHITECTURE.md](../../ARCHITECTURE.md), [ROADMAP.md](../../ROADMAP.md), [STATE.md](../../STATE.md), and [.loop/progress.md](../../.loop/progress.md), then the [continuation charter](CONTINUATION_CHARTER.md), this context, exact brief or contract, relevant ledger/evidence, and full diff.
4. Compare this snapshot with both exact histories. Record discrepancies instead of merging, overwriting, inferring, or selecting the state that permits more work.
5. Inspect the applicable role TOML and observe the session's effective sandbox before dispatch or mutation.
6. Report the versions read, intended user outcome, decision scope, known gaps, verification evidence, limitations, and one next action.
7. Proceed only when the exact task is eligible, its paths and commit ownership are explicit, required evidence passes, independent reviews have no unresolved Critical or Important finding, and no owner-only boundary is crossed.

## Completion and next task

The app is complete only when the approved audio/MIDI, cleared instruments, patch editing, audible controls, variations, persistence and recovery, songs and setlists, offline performance workflow, accessibility, lifecycle, and required platform/device/performance evidence all pass their exact contracts. Decision-team setup and a UI mockup do not satisfy completion.

After the exact CT01 candidate passes independent QA/Performance, applicable Licensing/Security, and Final Code Review, the next task is a documentation-only baseline and contract reconciliation proposal. It must inventory the difference between planning base `4a9a4aa05f47935c7d997c5bbf4c19fc7c1a77a9` and research tip `8fdb7444ed80675269f38f90f84b362f90c9af23`, preserve R01/R02 and all G01 evidence, bind every proposed state or contract change to full commits, and stop before merging histories, changing executable state, resuming research, or implementing product code.
