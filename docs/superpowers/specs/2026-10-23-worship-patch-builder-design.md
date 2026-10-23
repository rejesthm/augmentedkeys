# Worship Patch Builder: First-Version Design

Date: 2026-10-23

Status: delivery direction approved; detailed written design pending exact-candidate decision-team acceptance. No implementation milestone is activated by this document.

## Owner request and authorization

The owner requested a fully working, realistic worship patch builder, using Elevation Worship as a musical reference, and approved the recommendation to revise the plan around a playable first version while retaining architecture, licensing, and device verification. The exact reply was `approved!`.

The original planning task owned only `APP_SPEC.md`, `ROADMAP.md`, and this design in the isolated `planning/worship-first-version` worktree. It was a separately authorized product-planning change, not an M0 research task or a manual Loop pass. Existing code, research evidence, agent configuration, contracts, and runtime state are preserved. CT01 later authorizes controller-owned local documentation commits and independent review; it does not authorize external publication.

## Inspected baseline and evidence limits

| Source | Exact inspected commit | What it establishes |
| --- | --- | --- |
| Governance checkout; planning branch base | `4a9a4aa05f47935c7d997c5bbf4c19fc7c1a77a9` | Flutter starter shell, Decision Steward governance, and a recorded M0 pause; two existing uncommitted integration-guard edits are outside this worktree |
| `milestone/m0-research` | `8fdb7444ed80675269f38f90f84b362f90c9af23` | State records OD-005 reactivation, R01/R02 Verified and integrated, and R03–R10 Queued |
| R01 reviewed candidate | `09266fdc17e137db44495d85c6b42cf296efb89c` | Documentary audio-architecture and measurement research; no selected engine or physical-device result |
| R02 reviewed candidate | `8b39e5572f481af21d5fba598c1abf0fe8dc5dec` | Documentary UAPMD evaluation; no adoption, build, or performance approval |

The research branch contains later research-state evidence but does not incorporate all governance-checkout changes. Before any execution contract is activated, the controller must reconcile the applicable governance and research evidence through the existing review process. Neither branch's state is silently substituted for the other. This design is not a G01 verdict or milestone acceptance.

The source reports are `docs/research/MOBILE_AUDIO_ARCHITECTURE.md`, `LOW_LATENCY_RESEARCH.md`, and `UAPMD_EVALUATION.md` at the research tip above. They must be read from that revision, because they are not present in this planning baseline. Their technical claims need current verification when candidates are evaluated; this design makes no new platform or library suitability claim.

## Product outcome

A keyboard player can open the app offline, choose a worship starter patch, hear it immediately after explicitly enabling audio, blend instruments, save the result, and perform a setlist. A patch means saved sounds plus settings; a layer means one instrument inside that patch; a variation means alternate settings using the same loaded instruments.

The full product remains planned for Android phones/tablets and iPhone/iPad. First physical-device validation order is an open owner preference, requested in this conversation. Until answered, planning retains both platforms and claims support for neither. Device choice alone does not authorize operating hardware or establish performance evidence.

### First-version scope

- Three sound categories: piano, ambient pad, and warm synth. The piano must satisfy the approved instrument-quality review using a cleared source; a test oscillator cannot stand in for a delivered piano.
- Six original editable starter patches: Gentle Piano, Piano and Air, Warm Pad, Rising Pad, Soft Synth, and Full Worship. These are working names and recipes to author, not existing assets or claims of equivalence to an artist's patches.
- One to four layers per patch. Each layer has an instrument, enable/mute, level, brightness, and reverb/delay sends. The patch has master level and shared reverb/delay settings. Unused effects can be bypassed.
- Touch audition and a basic wired MIDI path: notes, velocity, sustain, device selection, connection status, disconnect recovery, and a visible Stop Sound action. Supported controller identities must be recorded through testing.
- Save, save as a copy, rename, and delete user patches. Factory patches are immutable; editing one creates a user copy. Deleting a referenced patch requires resolving its setlist references first.
- Three variations per patch, initially Verse, Chorus, and Bridge. They store layer levels, mutes, brightness, and effect settings; they do not replace instruments or load sample content during recall.
- Named songs that reference saved patches, ordered setlists, and a performance view with current/next song and variation controls.
- Offline operation and local persistence with no account or network prerequisite.

Deferred capabilities include third-party plugin hosting, cloud synchronization, sample import, audio recording, backing tracks, MIDI 2.0/MPE breadth, arbitrary modulation, keyboard splits, and desktop/web hosts. The first version targets foreground performance; background playback needs a separate platform scope. Public release remains a later gate.

## User flows and screens

### Library

First launch explains what a patch is in one sentence and offers the Piano and Air starter. The user enables audio explicitly. The screen shows factory and saved patches with clear names and a way to audition the selected patch. It shows real audio readiness and errors, never a simulated connected indicator. No preset browsing or audition waits for a network request.

### Builder

Open a starter, hear it, then adjust a layer while playing. Show a maximum of four layer cards with instrument name, mute, level, brightness, and effect sends. Keep advanced effect parameters behind a labeled panel. The audition keyboard is visible or reachable with one action on a phone; tablet layouts may display it beside the editor.

Adding a fifth layer is refused with a clear explanation of the supported limit. Removing a layer affects the editable patch only. Unsaved changes are indicated; leaving the editor offers Save, Discard, or Cancel. Save failure retains the edit buffer and presents retry/save-copy options without claiming success.

### Variations and performance

Save the current settings into one of three variation slots. Selecting a variation recalls its settings without reloading instruments. The performance view has large Verse/Chorus/Bridge controls, current and next song, MIDI/audio status, master level, and Stop Sound. It separates navigation from destructive editing.

Patch loading prepares resources outside rendering. The current playable patch remains active until a replacement is ready. Failure leaves the current patch available and identifies the failed load. Held-note and sustain ownership across a successful switch must be defined and verified in the architecture spike before continuity claims are made. Stop Sound releases voices, clears sustain, and silences effect tails through the engine's approved bounded procedure.

### Setlists

Create a named setlist, add named songs referencing saved patches, reorder them, save, close the app, reopen, and play in order. Factory patches can also be referenced. Renaming a patch preserves references. A missing or corrupt reference is displayed as unavailable; the app must not silently play a different patch. Advancing to an unavailable song preserves the currently loaded instrument.

## Logical responsibilities and data behavior

These are required responsibilities, not an adopted engine, language, package, ABI, state-management library, or storage technology.

| Responsibility | Owns | Boundary |
| --- | --- | --- |
| Flutter presentation | Library, builder, setlist, performance view, accessibility, user intent | Sends ordinary control intent; never renders DSP on the UI thread |
| Patch coordination | Validation, editing, variation selection, preparation/loading state | Publishes only validated, prepared changes through the future approved engine boundary |
| Audio and MIDI runtime | Rendering, voices, controller events, smoothing, effects, lifecycle | No blocking work, I/O, UI work, parsing, allocation, arbitrary locks, or potentially blocking logs in the audio callback |
| Sound catalog | Stable instrument identity, approved content/version, load requirements | Resolves only approved installed sound sources; prepares them outside the callback |
| Local persistence | Saved patch/setlist documents and recovery | Versioned data; storage and parsing stay outside the real-time path |

Persist stable identifiers rather than display names. A saved patch includes its format version, identity, name, instrument references, layer settings, master/effect settings, and three variations. A setlist includes its identity, name, and ordered song entries with patch references. A document must validate before it becomes active: instrument identifiers exist, layer count is one through four, all numbers are finite and within engine-approved ranges, and variation references match the patch.

Saving must preserve the last valid document if a write is interrupted. Unknown newer formats and corrupt documents are reported without overwriting their original bytes. Failed restoration returns the user to the library with an actionable message; it must not start unexpected audio. Library load failures cannot crash the playing path.

The high-level flow is touch or MIDI input → validated control/note state → prepared engine resources → audio output. Saving, catalog loading, UI updates, and diagnostics are outside rendering. Actual queue bounds, voice limits, memory ownership, serialization, and synchronization require the evidence-backed architecture decision.

## Reliability, accessibility, and content

Controller disconnect, app interruption, route change, and resume each need explicit engine states and tests. Prevent stuck notes after disconnect. Indicate interrupted or unavailable audio, and require a deliberate resume when needed for safe recovery. Resource exhaustion and invalid documents must leave the last valid playable state intact where the platform still permits playback.

Use labeled controls, screen-reader semantics, non-color-only mute/status indication, readable contrast, and at least 48 logical pixels for primary interactive targets. Support portrait and landscape without hiding Stop Sound. Long names and increased text size must not cover performance controls.

Every adopted dependency, DSP implementation, instrument, recording, and other asset needs a version/source-specific license-ledger entry and the required approval. Factory content must be original or explicitly licensed for intended use and redistribution. The Elevation Worship reference is an aesthetic direction; it does not authorize copied presets, recordings, logos, or endorsement claims. If suitable piano content is unavailable, record a blocked requirement rather than mislabeling another sound as a delivered piano.

## Proposed research rebaseline

The existing M0 contract still requires R01–R10. This design proposes the following exact scope changes for a separately reviewed contract amendment; it does not execute them or change their current statuses.

| Existing work | Proposed first-version treatment |
| --- | --- |
| R01/R02 verified reports | Preserve exact candidates, verification, and history; use as evidence inputs rather than repeat completed documentary work |
| R03/R04 platform research | Prioritize built-in playback, lifecycle, routing, permissions, and Flutter/native boundaries; move the deeper AUv3/AAP hosting investigation into the later hosting scope |
| R05 MIDI | Establish the basic wired note/velocity/sustain/disconnect scope first; retain advanced MIDI as later work |
| R06 sound engine | Evaluate the smallest engine/content approach that supports piano, pads, synth, four layers, and the specified effects |
| R07 licensing | Review all exact first-version candidates and content before adoption; plugin-related reviews remain required before later hosting adoption |
| R08/R09/R10 workflow comparisons | Explicitly defer from the first-version prerequisite set; preserve their questions and queued history without marking them verified or accepted |

The amendment must name its changed outputs, dependencies, definition of done, paths, and deferred work. It must resolve the governance/research history discrepancy, pass independent review, and receive the applicable exact-commit activation decision. The owner approval to revise this plan does not itself constitute those later evidence or architecture decisions.

## Delivery sequence and acceptance

| Delivery | Observable acceptance scenario | Evidence required |
| --- | --- | --- |
| M1: sound and input | Enable audio; play each cleared instrument by touch and supported MIDI; release keys/sustain; disconnect/reconnect | Deterministic note-lifetime tests; actual audio capture; lifecycle tests; named physical-device/controller configuration and predeclared latency/workload criteria |
| M2: build and save | Start with Piano and Air; change audible controls; add/remove layers; save as Sunday Opener; restart and recover the same settings | Unit/widget/integration tests; save-failure and corruption recovery; audio evidence that controls affect output; four-layer workload results |
| M3: variations | Hold a chord with sustain; switch Verse/Chorus/Bridge; switch patches; exercise Stop Sound and failed loading | Render/signal and device tests under approved continuity criteria; no unexplained stuck voices; active patch retained after failed preparation |
| M4: setlist | Create three songs using saved patches; reorder; restart offline; play through the sequence | End-to-end workflow, reference-integrity, accessibility, interruption and long-run rehearsal evidence |

For a Flutter change, run `flutter pub get`, `dart format --output=none --set-exit-if-changed .`, `flutter analyze`, and `flutter test`, plus the task's native/audio/integration checks. Passing Flutter checks alone does not prove sound quality, low latency, or physical-device support.

Before each performance experiment, approve the exact measurement boundary, devices and routes, build configuration, workload, warm-up, repetitions/duration, numeric budget or objective acceptance condition, raw artifact location, and reviewer. No numeric performance target is invented here. Missing device evidence leaves the corresponding capability unverified.

## Next bounded work and review checklist

The next deliverable is the research-rebaseline contract proposal with its history-reconciliation evidence, followed by narrowly scoped platform/engine/licensing evaluation and an approved audible spike. It is not a full-app implementation task. Detailed code plans must follow the accepted subsystem design and architecture evidence; they must not guess an engine or install packages to make a mockup appear functional.

- [x] Inspect existing code, required documents, branch states, and task controls.
- [x] Preserve R01/R02 evidence and distinguish current checkout from research branch.
- [x] Record the approved playable-first direction and its concrete user workflow.
- [x] Define feature limits, failure behavior, content obligations, and acceptance scenarios.
- [x] Revise product specification and future delivery priorities without altering runtime state or executable contracts.
- [ ] The decision team reviews the exact committed written scope and records acceptance or bounded corrections; selecting or operating validation hardware remains subject to the existing device procedure and owner-only gates.
- [ ] Reconciled execution baseline and exact research-contract amendment receive required review and activation.
- [ ] Architecture spike, measurements, license evidence, and ADR receive required approval.
- [ ] Create and execute the first bounded implementation plan with fresh verification.

Rollback for this planning task is removal of this isolated branch's three document changes. Existing worktrees, uncommitted guard changes, research history, and product code are unaffected.
