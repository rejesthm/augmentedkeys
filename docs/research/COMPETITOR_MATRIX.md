# R10 mobile live-performance workflow comparison

## Scope and method

For comparison, this report assigns four analytic categories: Camelot Pro as dedicated live host, AUM as routing host, Koala Sampler as sampler/player, and Audio Evolution Mobile Studio as general production tool. The labels are not vendor claims. This bounded sample implies neither market completeness, popularity, superiority, nor absence of Android alternatives. Sunday Keys (R08) and desktop MainStage (R09) remain context only.

No product was installed or operated. Nothing here adopts architecture, dependencies, formats, content, platform targets, performance budgets, or interaction design. AugmentedKeys remains a Flutter shell.

The corpus was captured on **2026-10-23**: 20 requests, 20 HTTP 200 HTML bodies, and zero raw failures. Parser text is a reading aid; original HTML controls. Eleven compound tool payloads are not 11 additional sources. H01’s transformation failed and H02 repeated the search. Search snippets and customer reviews are excluded. Exact UTC timestamps, byte counts, and hashes are in [`r10-sources.md`](../orchestration/milestones/m0/evidence/r10-sources.md); the inventory SHA-256 is `c395c9009894d95a699b41845fa4c0ef484af3fc87dd31c3f1827f0266a6ce93`.

## Canonical source facts and register

Each row is the report’s only factual summary of that page. Later sections refer to these source keys without restating page content.

| ID | Exact URL and provenance | Bounded fact summary |
|---|---|---|
| C1 | [Apple App Store — Camelot Pro](https://apps.apple.com/us/app/camelot-pro/id1326331127), store listing | Audio Modeling iPad host; 2.5.4 (2026-10-01), iPadOS 13+. History mentions route-change reload. Apple labels: unlinked diagnostics; no indicated accessibility features. |
| C2 | [Camelot features](https://d3dnu53q77cvq4.cloudfront.net/camelot/features/), Audio Modeling-branded CDN page; attribution supported, ownership unproved | Sets use songs/scenes/layers. Covers mix/range/routing, racks, templates, snapshots, transfer, backups, timelines, and attachments. Switching/continuity claims are unmeasured. |
| C3 | [Camelot tutorial 2](https://audiomodeling-help.freshdesk.com/support/solutions/articles/206000041677-camelot-tutorial-2-getting-started), vendor support tutorial around 2.3.0 | Historical setup guidance selects and maps audio I/O and MIDI ports, explains warning indicators, and shows hierarchy and Panic-control presence. It does not define Panic messages or audible outcome. Current-build coverage is unknown. |
| A1 | [Kymatica AUM product page](https://www.kymatica.com/apps/aum), publisher page, unversioned | Mixer/host/recorder with hardware, file, plugin, channel, bus, send, MIDI, and control surfaces. Quality/latency claims are unmeasured. |
| A2 | [AUM guide](https://www.kymatica.com/aum/help), publisher guide, unversioned | Covers sessions, last/prior-state restore, MIDI binding, device/cloud/USB files, conditional background use, endpoint replacement after topology change, and feedback protection after input disconnect. |
| A3 | [Apple App Store — AUM](https://apps.apple.com/us/app/aum-audio-mixer/id1055636344), store listing | Kymatica AB; 1.4.8 (2025-11-23), iOS/iPadOS 12+. Apple label: Data Not Collected; no indicated accessibility features. A1/A2 correspondence is unverified. |
| K1 | [Koala manual — introduction](https://manual.koalasampler.com/mobile/1-introduction/), publisher manual | Describes standalone iOS/Android sampling, sequences, performance/mixer effects, playable pads, instruments, and MIDI out. AUv3 instrument/effect and multibus operation are iOS-only. Mixer capability is an add-on. |
| K2 | [Koala manual — specifications](https://manual.koalasampler.com/mobile/12-specifications/), publisher manual | Lists 64 pads, 32 sequence slots, instruments, MIDI import/export, effects, and platform-dependent plugin hosting. It warns that feature availability differs by platform. |
| K3 | [Koala device support](https://koalasampler.com/help/app-store-payment/will-koala-run-on-my-device.html), publisher help page | States iOS 13 and Android 8.1+ on ARM with Google Play. Its iOS statement conflicts with the later Apple listing in K4. |
| K4 | [Apple App Store — Koala](https://apps.apple.com/us/app/koala-sampler-beat-maker/id1449584007?platform=ipad), store listing | 2.0.15 (2026-10-16), iOS/iPadOS 15+; mapping/routing/add-on/history surfaces. Apple label: unlinked diagnostics; no indicated accessibility features. |
| K5 | [Google Play — Koala](https://play.google.com/store/apps/details?hl=en_CA&id=com.elf.koalasampler), store listing | Android 2.0.15. Raw update is 2026-10-18; reconciliation says 2026-09-30. Google label: app activity, app information/performance, and device/other IDs. |
| K6 | [Koala release notes](https://www.elf-audio.com/koala/release-notes.html), publisher change log | Records historical fixes involving projects, effects, MIDI, loading, and crashes. Change history does not prove current persistence, recovery, or reliability. |
| E1 | [Google Play — Audio Evolution](https://play.google.com/store/apps/details?hl=en-US&id=com.extreamsd.aemobile), current Android listing | Updated 2026-10-08; version unknown. Lists audio/MIDI production, instruments, SoundFonts, effects, remote control, Drive sync, and add-ons. Data-safety claims are unaudited. |
| E2 | [Audio Evolution Android manual — introduction](https://www.audio-evolution.com/manual/android/html/Introduction.html), 2022-copyright unversioned manual | Describes audio/MIDI tracks, external MIDI, SoundFont instruments, a virtual analog synth, effects, automation, and separately offered content/effects. It does not clear those assets for AugmentedKeys. |
| E3 | [Android manual — MIDI device](https://www.audio-evolution.com/manual/android/html/ConnectingaMIDIDevice.html), 2022-copyright unversioned manual | Requires USB host, class compliance, and power; advises pre-launch connection and foreground use because some devices halt USB. Latency guidance is unmeasured. |
| E4 | [Android manual — starting](https://www.audio-evolution.com/manual/android/html/Startingtheapp.html), 2022-copyright unversioned manual | Describes required first-start storage and recording permissions plus an available-device view for built-in, USB audio, and USB MIDI devices. |
| E5 | [Android manual — project save/load](https://www.audio-evolution.com/manual/android/html/CreatingSavingandLoadingyourProj.html), 2022-copyright unversioned manual | Documents manual project save/load, autosave versions, and templates. It warns that clear-data or uninstall conditions can remove projects and calls for separate backup. |
| E6 | [Android manual — MIDI remote](https://www.audio-evolution.com/manual/android/html/MIDIRemoteSetup.html), 2022-copyright unversioned manual | Documents named remote setups, MIDI Learn/manual CC assignment, transport/marker/mix/bus/active-instrument actions, control banks, feedback, and XML storage. |
| E7 | [iOS manual — MIDI device](https://www.audio-evolution.com/manual/ios/html/ConnectingaMIDIDevice.html), 2022-copyright unversioned manual | Documents class-compliant USB or Bluetooth MIDI, limited device power, possible powered-hub use, Bluetooth scanning, and Bluetooth permission. |
| E8 | [iOS manual — project save/load](https://www.audio-evolution.com/manual/ios/html/CreatingSavingandLoadingyourProj.html), 2022-copyright unversioned manual | Documents manual save/load, autosave versions, and templates; warns that removing the app deletes projects. |

Store requirements describe vendor editions, not an AugmentedKeys minimum OS. The current E1 listing cannot make the unversioned 2022 manuals current. K4 and K5 remain separate editions. K6 remains history. No captured body supports a Default Sound Set Internet claim.

## Comparable task matrix

Source keys refer to the register; “undocumented” means unverified here, never absent.

| Task | Camelot Pro | AUM | Koala Sampler | Audio Evolution Mobile Studio |
|---|---|---|---|---|
| Setup and controller/audio routing | Evidence C1/C3. Question: how should readiness and missing routes be shown? | Evidence A1/A2. Question: how much routing should a beginner see? | Evidence K1/K4; detailed controller setup undocumented. | Evidence E3/E4/E7. Question: how should compatibility and permission failures appear? |
| Find/build piano, pad, synth blend | Evidence C1/C2; cleared built-in worship sounds undocumented. | Evidence A1/A2; cleared built-in worship sounds undocumented. | Evidence K1/K2; a four-layer worship starter is undocumented. | Evidence E1/E2; cleared built-in worship sounds undocumented. |
| Layer/split/blend/mix/effects | Evidence C2. Question: which layer controls are stage essential? | Evidence A1/A2. Question: can musical intent hide graph complexity? | Evidence K1/K2/K4; keyboard splits undocumented. | Evidence E1/E2/E6; live-keyboard splits undocumented. |
| Touch and MIDI mapping | Evidence C1/C3; Panic semantics undocumented. | Evidence A2; panic semantics undocumented. | Evidence K4; end-to-end preparation and panic semantics undocumented. | Evidence E6. Question: which mappings belong in a first version? |
| Saved edits and recall | Evidence C2; atomicity undocumented. | Evidence A2; plugin/file completeness undocumented. | Evidence K4/K6; current recovery contract undocumented. | Evidence E5/E8. Question: how should destructive lifecycle risks be prevented? |
| Songs, sets, sections | Evidence C2. Question: what is the smallest original service model? | Evidence A2; musical hierarchy undocumented. | Evidence K1/K2; worship setlist and variations undocumented. | Evidence E5/E6/E8; stage setlist and variations undocumented. |
| Switching, tails, preload | Evidence C1/C2; measurements and tail policy absent. | Evidence A1/A3; measured switching/tails/preload absent. | Switching, sustain ownership, and preload undocumented. | Evidence E1/E3; measured switching/tails/preload absent. |
| Offline prerequisites and recovery | Evidence C1/C2; complete offline/account/entitlement behavior unknown. | Evidence A2; atomic/plugin/full-offline recovery unknown. | Evidence K1/K4–K6; entitlement and full-offline recovery unknown. | Evidence E1/E3/E5/E8; full-offline and route recovery unknown. |

## Original comparison and hypotheses

These are AugmentedKeys hypotheses, not paraphrases or usability results:

- A musical hierarchy may reduce stage-preparation ambiguity, while a general host graph may expose dependencies a beginner cannot diagnose.
- A self-contained instrument may make first sound faster, while a production project may offer more edit depth than a stage workflow needs.
- Explicit save, readiness, and recovery states may matter more on stage than the number of routing or effects options.
- Product categories are not interchangeable. A host can depend on external content; a sampler can center imported material; a DAW can optimize project production rather than service navigation.

The comparison does not establish which approach is better. The consolidated evidence gaps below apply to every hypothesis.

## Network, privacy, content, and rights boundaries

Source-specific network, privacy, content, permission, and dependency facts appear only in the register. Their unresolved behaviors are consolidated under Gaps.

No competitor material is adopted or cleared. Future sounds and interactions must be original and pass existing gates. No purchase, account, terms, installation, or content acquisition occurred.

## Questions for the original product

| Existing goal | Original design question | First-version boundary or risk |
|---|---|---|
| Offline piano, pad, warm synth | Can one cleared piano play immediately and blend with pad/synth without external hosts or downloads? | No competitor content, plugin hosting, cloud library, or sample store is adopted. |
| Up to four layers | What visible state explains source, key range, level, mute, and enabled state? | Four-layer feasibility still requires architecture and performance evidence. |
| Six editable starters | Which edits belong to a starter, and how is saved state distinguished from sounding state? | No competitor names, patches, layouts, or formats are copied. |
| Three variations | Which musical, controller, sustain, effect, and route state should recall? | No seamlessness, tail, preload, or held-note policy is selected. |
| Local setlists | What minimal model shows service order, current/next song, and section changes offline? | Timelines, backing tracks, cloud sharing, and automatic show sequencing remain outside the current goal. |
| Persisted edits | What saves explicitly or automatically, survives restart, and happens when references fail? | No competitor session, project, or backup format is selected. |
| Touch/basic wired MIDI | Which stage actions need large touch targets or bounded mappings, and how is readiness shown? | Bluetooth, MPE, transforms, feedback, and broad plugin mapping remain later questions. |
| Safe recovery | How should Stop Sound, route loss, reload, and readiness behave under pressure? | Panic, fallback, tail ownership, and retry behavior need original specification and measurement. |

## Future evidence scenarios

All scenarios are **unapproved and unperformed**; they define methods, not thresholds.

1. Launch offline with only approved bundled content; play, edit, save, restart, and record missing dependencies.
2. Build a short local service with three variations; navigate, reorder, restart, and compare persisted state.
3. Under an approved hardware procedure, record wired-MIDI identity, notes, velocity, sustain, mappings, event loss/order, disconnect, and reconnect.
4. Switch variations during held notes/sustain, invoke Stop Sound, and capture state, tails, audible silence, and failed trials.
5. Interrupt and restore an audio route; capture visible/audible state and trigger-to-first-conforming-marker recovery.
6. Exercise missing, malformed, or incompatible local references and interrupted save/reload; verify bounded diagnosis and safe state.
7. Inspect screen-reader labels, focus, contrast, scaling, touch targets, and nonvisual readiness cues.

Any run needs an approved build, configuration, device, reset conditions, raw artifacts, and evaluation method. No numeric target, hardware action, architecture, or platform choice is authorized.

## Gaps and owner decisions

Across the corpus, hands-on performance, recovery, accessibility, security, rights, account/entitlement, and complete-offline evidence is unavailable. Listings are declarations; histories and manuals can lag.

The owner retains decisions on interaction model, platforms, content, dependencies, architecture, formats, performance, accessibility acceptance, and external action. Implementation still requires original workflow specifications, cleared sound content, architecture evidence, and separately approved tests.
