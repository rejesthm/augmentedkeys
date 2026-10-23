# R10 mobile live-performance workflow comparison

## Scope and status

This report compares four mobile music products against approved AugmentedKeys preparation and live-use questions. It is M0 documentary research, not a market survey, usability test, ranking, or feature recommendation. Nothing here selects architecture, dependencies, formats, content, minimum OS, performance budgets, or competitor interaction design. AugmentedKeys remains a Flutter shell; none of these capabilities is implemented.

The bounded sample intentionally covers different workflow categories:

- **Camelot Pro** is a dedicated live-performance host and setlist manager on iPad.
- **AUM** is an iOS/iPadOS audio and MIDI routing host organized around mixer sessions.
- **Koala Sampler** is a self-contained sampler/player on iOS/iPadOS and Android, with platform-specific hosting features.
- **Audio Evolution Mobile Studio** is a general mobile production tool represented by a current Android listing and older Android/iOS manuals.

Their first-party pages expose different answers to setup, sound construction, recall, MIDI control, navigation, and recovery. Four products compare those patterns without implying market completeness. Sunday Keys (R08) and desktop MainStage (R09) remain immutable context, not evidence about these products. The sample supports neither Android-absence claims nor popularity rankings.

All bodies were accessed on **2026-10-23**: 20 requests, 20 HTTP 200 HTML bodies, zero raw failures. Parser texts are aids; original HTML controls. Eleven tool payloads and decoded aids are provenance, not 11 sources. H01’s transform failed; H02 repeated the search. Snippets and customer reviews were excluded. The full URL/timestamp/hash register is [`r10-sources.md`](../orchestration/milestones/m0/evidence/r10-sources.md); source-inventory SHA-256 is `c395c9009894d95a699b41845fa4c0ef484af3fc87dd31c3f1827f0266a6ce93`.

## Product identity and currentness

| Product and category | Observed edition, platform, and publisher field | Observed version/date and requirement | Currentness qualification |
|---|---|---|---|
| Camelot Pro — dedicated live host | Apple iPad listing; developer Audio Modeling and seller Audio Modeling Srl | 2.5.4, dated 2026-10-01; iPadOS 13+ [C1] | C1 is the current captured listing. C3 is a historical tutorial around 2.3.0. C2 is an Audio Modeling-branded feature page on a CDN URL; its branding and cross-links support attribution, but the capture does not prove CDN-domain ownership. |
| AUM — routing host | Apple listing for iPhone/iPad; seller Kymatica AB | 1.4.8, dated 2025-11-23; iOS/iPadOS 12+ [A3] | A3 supplies store identity. The online product page and guide [A1–A2] are not version-labelled, so their exact match to 1.4.8 is unverified. |
| Koala Sampler — sampler/player | Separate Apple and Google Play listings; Apple seller Mazbox Limited | Apple 2.0.15, dated 2026-10-16; iOS/iPadOS 15+ [K4]. Google Play body exposes 2.0.15 and “Updated Oct 18, 2026” [K5]. | K3 still says iOS 13 and Android 8.1+ on ARM with Google Play, conflicting with K4’s later Apple requirement. The controller reconciliation records K5 as 2026-09-30, while the retained raw K5 body and derived aid say 2026-10-18; the raw-body observation is reported and the discrepancy remains open. K6 is change history, not a current reliability guarantee. |
| Audio Evolution Mobile Studio — general production tool | Current Google Play Android listing from eXtream Software Development; separate Android and iOS manuals | Android listing updated 2026-10-08 [E1]. No app version is exposed in the captured listing. The manuals carry 2022 copyright but no application-version identity [E2–E8]. | E1 is current listing evidence. The 2022 manual pages describe workflows but cannot establish behavior of the current Android build or any current iOS edition. |

Store OS requirements describe vendor products, not an AugmentedKeys platform decision. The two Koala listings are distinct editions; Koala’s iOS-only AUv3 functions must not be transferred to Android. Audio Evolution’s current Android listing must not make its unversioned iOS manual current.

## Comparable task matrix

“Undocumented in this corpus” means only that the retained pages do not establish the behavior. It does not mean the feature is absent.

| Task | Camelot Pro | AUM | Koala Sampler | Audio Evolution Mobile Studio |
|---|---|---|---|---|
| Setup and audio/MIDI routing | Historical C3 documents selecting audio I/O, mapping MIDI ports, and warning indicators. C1/C2 document hardware, audio input, AUv3, MIDI patching, and output routing. | A1/A2 document adding hardware/file/plugin channel sources, mix buses, sends, MIDI routing, and hosted AUv3/IAA/Audiobus nodes. A2 warns that moving a cable or hub can invalidate a saved MIDI endpoint and require connection swap. | K1 documents standalone use on iOS and Android, plus AUv3 instrument/effect and multibus output only on iOS. Detailed initial hardware-controller routing is undocumented in this corpus. | E3 says Android class-compliant USB MIDI depends on host mode, power, and connection before launch; E4 documents first-start storage and recording permission prompts. E7 documents iOS class-compliant USB or Bluetooth MIDI and Bluetooth permission. |
| Find/build a piano, pad, or synth blend | C1/C2 describe external hardware presets, hosted software instruments, audio sources, and reusable song/setlist racks. Sound availability depends on external instruments, plugins, and files; no cleared worship sound set is supplied by this evidence. | A1/A2 describe building channels from hardware, files, and plugins. The corpus establishes host construction, not a built-in cleared piano/pad/warm-synth library. | K1/K2 describe samples, the Quokka synth, Chopper, MIDI out, and optional/platform-specific functions. It is a sample/instrument workflow, not evidence for a four-layer worship-keyboard starter. | E1/E2 describe virtual instruments, a virtual analog synth, SoundFonts, loops, and paid optional effects/content. No captured body establishes an original cleared factory piano/pad set. |
| Layer, split, blend, mix, and effects | C2 says Scenes contain Layers and Items; layers join controller inputs to hardware/software generators, support local level/mute/solo/output controls, insert effects, MIDI filtering, transpose, and key ranges. | A1/A2 document channels, buses, sends, effects, node routing, MIDI filters, and per-channel mix control. “Layer” and “split” must be assembled from routing rather than inferred as a dedicated beginner template. | K1/K2 document up to 64 pads, performance effects, mixer channels/effects, and keyboard play. K4 documents routing samples to channels. A general multi-layer keyboard split workflow is undocumented in this corpus. | E1/E2 describe audio/MIDI tracks, mixer automation, parallel FX-grid routing, SoundFont instruments, and a synth. E6 maps controls to tracks, buses, and the active instrument. A dedicated live-keyboard split workflow is undocumented. |
| Map touch and MIDI controls | C1/C2 document MIDI Learn, remote scene/transport/level actions, pedals, keyboards, Bluetooth controls, message transforms, transpose, and filtering. C3 establishes a Panic button’s presence but does not define its messages or audible result. | A2 documents MIDI control binding for mixer and plugin parameters, MIDI routing/filtering, and an on-screen keyboard. Session-load MIDI actions are global rather than session-stored. Panic behavior is undocumented. | K4 documents keyboard triggering, MIDI mapping of effects, MIDI out, and current mapping options in release history. The retained pages do not provide an end-to-end controller preparation procedure or panic semantics. | E6 documents named remote setups, MIDI Learn/manual CC entry, transport/marker/mix/bus/instrument actions, control banks, and optional feedback to a controller. |
| Save edits and recall | C2 documents templates, song/setlist import/export, snapshots that preserve organization rather than copy data, and zipped session backups. These do not prove atomic save or restore. | A2 documents session save/open/clear, automatic last-state storage when backgrounding, clearing, or loading another session, plus restoration of a previous state. Plugin/file dependency completeness is unverified. | K4/K6 mention projects, templates, autosave, mapping, and effect-state fixes across release history. Those entries do not prove current persistence correctness or a recovery contract. | E5/E8 document manual project save/load, autosave versions, and project templates. Android clear-data/uninstall and iOS app removal can delete projects under the documented conditions. |
| Arrange songs, sets, and sections | C2 has a direct Setlist → Song → Scene hierarchy, draggable songs, scene timelines, markers, backing tracks, next-event controls, and optional end-of-song next-song loading. | A2 provides sessions, mixer organization, and transport. A first-party song/setlist/section hierarchy is undocumented in this corpus. | K1/K2 cover samples, sequences, arrangement, and performance effects. A worship-service setlist with ordered songs and three prepared section variations is undocumented. | E5/E8 provide projects and templates; E6 can map marker jumps and transport. A stage-oriented setlist or three-variation model is undocumented. |
| Live switching and tails | C1/C2 assert uninterrupted scene switching and held/sustain continuity as vendor claims, not measurements. Setlist racks are described as keeping selected resources loaded. No tail policy is established. | A1/A3 make latency/quality claims, but no measured song/section switch, tail, held-note, or preload contract appears in the corpus. | Current release pages mention live effects and MIDI mapping; switching continuity, tails, sustain ownership, and preload behavior are undocumented. | E1/E3 make latency claims tied to configurations and optional drivers. No measured section switching, tail ownership, preload, or live continuity contract is established. |
| Offline prerequisites and recovery | C2 exposes attachments, audio files, imports, backups, cloud destinations, plugins, and external hardware. C1 says 2.5.4 automatically reloads the current song after an audio-device change; that is release-note history, not measured recovery. Account, entitlement, and complete-offline behavior are unknown. | A2 allows file sources from the device, cloud services, and USB. It disables a hardware-input node when disconnect would redirect to the microphone, documents limited background-running conditions, and warns against feedback. Atomic restore, entitlement, full offline operation, and plugin recovery are unknown. | Standalone operation is documented, but optional purchases, sample packs, imported files, platform hosting, account/entitlement, and complete-offline behavior remain unresolved. K6 fixes are history only. | E1 exposes Google Drive sync and optional purchases. E3 requires foreground operation for its described Android record/play path and warns some devices halt USB in background. E5/E8 document data-loss conditions. Default Sound Set network behavior and full offline readiness are undocumented in this corpus. |

## Workflow interpretation

Camelot most directly documents stage preparation: configure I/O and MIDI, create layers/items within scenes, group scenes into songs, order songs in setlists, and map transport or navigation [C1–C3]. Its templates, organization-only snapshots, selective exports, and session backups are distinct tools. The potential benefit is explicit musical and stage units; the potential tradeoff is dependence on plugins, hardware presets, files, routing, and mappings. C2 continuity claims are unmeasured. C3 establishes Panic presence, not its MIDI or audible effect. C1’s route-change reload is release history, not recovery evidence.

AUM documents a mixer-graph path: add sources and processing, route channels through buses/sends, bind controls, and save a session [A1–A2]. The benefit hypothesis is visible signal flow; the tradeoff hypothesis is that piano/pad blends, variations, and songs lack a documented musical hierarchy. Last-state and previous-state mechanisms offer recovery concepts, while endpoint replacement, plugin/file availability, and conditional background operation expose dependencies. Session atomicity, tails, and pressure recovery remain unknown.

Koala documents direct work with pads, samples, sequences, effects, keyboard play, and MIDI [K1–K5]. Its potential benefit is immediacy between material, touch, and performance; the tradeoff hypothesis is that sample/add-on/platform boundaries do not map directly to an original four-layer worship keyboard. The corpus does not establish that workflow, a service setlist, three variations, sustain-aware Stop Sound, or controller-loss recovery. K6 is change history only.

Audio Evolution documents a DAW path: connect hardware, create tracks, assign instruments/effects, map controls, and save a project/template [E1–E8]. Broad production control and reusable templates could help preparation, while stage concepts would need to be adapted from tracks, markers, and transport. The 2022 manuals may not match the current Android listing; no current iOS version was established. All benefits and tradeoffs in this section are hypotheses; no usability test occurred.

## Network, privacy, account, and rights boundaries

The corpus does not establish complete offline readiness. Workflows can depend on plugins, files, samples, packs, cloud locations, store entitlement, or hardware. Camelot exposes exports/backups and attachments/audio; AUM reads device, cloud, and USB files; Koala exposes packs, imports, add-ons, and platform hosting; Audio Evolution exposes Google Drive, optional content, and SoundFonts [C2, A2, K1–K5, E1–E8]. No captured body supports a Default Sound Set Internet claim, so that remains a gap.

The store privacy labels are edition-qualified developer declarations, not audits or observed data flows:

- C1 lists diagnostics not linked to identity for Camelot’s Apple edition.
- A3 states “Data Not Collected” for AUM’s Apple edition.
- K4 lists diagnostics not linked to identity, while K5 separately lists app activity, app information/performance, and device or other IDs for Android.
- E1 states its own Google Play data-safety claims, including no sharing with third parties, some collection, encryption in transit, and inability to delete data.

These labels establish neither account-free launch, offline entitlement, security, nor cross-edition equivalence. C1, A3, and K4 say the developer has not indicated supported accessibility features; that disclosure gap does not prove inaccessibility.

No source clears competitor code, interface, brands, presets, samples, plugins, or media for AugmentedKeys. Host capability does not clear external instruments or content. Future sounds and interactions must be original and pass existing gates. No purchase, account, terms, installation, or content acquisition occurred.

## Questions for the original product

The comparison narrows planning questions without adopting competitor solutions:

| Existing goal | Evidence-backed design question | Deliberate first-version boundary or risk |
|---|---|---|
| Offline piano, pad, and warm synth | Can the app expose one immediately playable cleared piano, then make pad/synth blending understandable without external hosts or downloads? | No competitor content, plugin hosting, cloud library, sample-pack store, or external-instrument dependency is adopted. |
| Up to four layers | What minimum visible state lets a beginner understand sound source, key range, level, mute, and enabled state for each layer? | Do not import a competitor’s scene/channel-strip graph or assume that four layers are technically feasible before architecture and performance evidence. |
| Six editable starters | Which edits belong to a starter, and how does the user distinguish a saved starter from the currently sounding state? | No factory names, patches, layouts, or content are copied; persistence semantics remain a future design decision. |
| Three prepared variations | Should variations recall only musical settings, or also controller, sustain, effects, and routing state? What must remain sounding across a switch? | No seamlessness, tail, preload, or held-note policy is selected; vendor continuity claims are not budgets. |
| Local setlists | What is the smallest original model that makes service order, current song, next song, and section change legible and recoverable offline? | Timelines, backing tracks, cloud sharing, and automatic show sequencing remain outside the current first-version goal unless separately approved. |
| Persisted edits | What is saved explicitly, what is autosaved, what survives a crash/restart, and how are missing or corrupt references reported? | No competitor session/project format or backup scheme is selected. |
| Touch and basic wired MIDI | Which stage-critical actions need large touch targets and bounded MIDI mappings, and how is controller/route readiness shown? | Bluetooth, MPE, advanced transforms, remote feedback, and broad plugin mapping remain later questions. |
| Safe stage recovery | What single Stop Sound action, route-loss state, reload path, and visible readiness marker can a player understand under pressure? | Panic semantics, automatic reload, fallback input, tail ownership, and retry behavior require original specification and measurement. |

## Future evidence scenarios

These scenarios are **unapproved and unperformed** evidence methods, not requirements or thresholds.

1. **Offline launch and preparation:** with network unavailable and only approved bundled content, launch, choose each starter, edit a layer, save, restart, and verify the exact recalled state and visible readiness. Record every attempted network or missing-content dependency.
2. **Local service flow:** create a short local setlist, prepare three variations for one song, navigate forward/backward, reorder songs, restart, and compare the persisted order and current selection with the saved evidence artifact.
3. **Basic wired MIDI:** connect an approved device under a separate hardware procedure; record endpoint identity, note/velocity/sustain input, mapping recall, duplicate/lost/out-of-order events, disconnect/reconnect behavior, and the boundary from event receipt to audible render.
4. **Held-note and Stop Sound:** switch variations while notes and sustain are active, then invoke Stop Sound. Capture musical state before/after, active-note and sustain state, audible-silence detection, tails, and any unrecovering trial. No behavior is preselected.
5. **Route loss and recovery:** interrupt the selected audio route, observe visible state and audible result, restore the route, and measure from explicit trigger to first conforming audible marker. Preserve failed and censored attempts.
6. **Failed preparation:** exercise missing, malformed, or incompatible local references and interrupted save/reload. Verify that the app identifies the affected item, preserves safe state, and offers a bounded recovery path without inventing content.
7. **Accessibility review:** inspect screen-reader labels, focus order, contrast, text scaling, touch target reach, and nonvisual readiness cues for preparation and stage flows. Store declarations cannot substitute for this check.

Each future run would need an approved device/configuration, exact build identity, raw event/log/media artifacts, reset conditions, and a separately adopted evaluation method. No numeric target, device, architecture, or hardware action is authorized here.

## Evidence gaps and owner decisions

No product was operated. There is no hands-on evidence for latency, loading, recovery, controllers, tails, sustain, panic, resources, accessibility, entitlement, security, rights, or complete offline operation. Store listings are declarations, release notes are history, and manuals can lag releases. Missing corpus evidence is not product-wide absence.

The owner retains decisions on the exact first-version interaction model, platform targets, content, dependencies, architecture, formats, performance thresholds, accessibility acceptance, and any later hardware or external action. Before any implementation decision, the team still needs original workflow specifications, cleared sound content, architecture evidence, and the future tests above under separately approved procedures.

## Source register

All sources were captured on 2026-10-23. Claim anchors name the sections or fields used; the canonical register linked above preserves exact UTC timestamps and SHA-256 hashes.

| ID | URL and provenance | Claim anchors |
|---|---|---|
| C1 | [Apple App Store — Camelot Pro](https://apps.apple.com/us/app/camelot-pro/id1326331127), store listing | identity, 2.5.4 date, iPadOS requirement, hierarchy, hosting/routing, mappings, release history, privacy/accessibility fields |
| C2 | [Camelot features](https://d3dnu53q77cvq4.cloudfront.net/camelot/features/), Audio Modeling-branded CDN page with qualified provenance | layers/items, racks, templates, snapshots/backups, import/export, setlist/song/scene/timeline, vendor continuity claims |
| C3 | [Camelot tutorial 2](https://audiomodeling-help.freshdesk.com/support/solutions/articles/206000041677-camelot-tutorial-2-getting-started), vendor support tutorial around 2.3.0 | historical I/O/MIDI setup, warnings, hierarchy, Panic presence |
| A1 | [Kymatica AUM product page](https://www.kymatica.com/apps/aum), publisher page | routing-host identity, channel/mix/plugin overview, vendor quality/latency claims |
| A2 | [AUM guide](https://www.kymatica.com/aum/help), publisher guide, unversioned | sessions, autosave/previous state, channels/buses/files/plugins, MIDI control, endpoint replacement, background/disconnect safeguards |
| A3 | [Apple App Store — AUM](https://apps.apple.com/us/app/aum-audio-mixer/id1055636344), store listing | seller, 1.4.8 date, OS requirements, privacy/accessibility fields |
| K1 | [Koala manual — introduction](https://manual.koalasampler.com/mobile/1-introduction/), publisher manual | standalone/platform roles, pads/sequences/effects/instruments, iOS-only AUv3 boundary |
| K2 | [Koala manual — specifications](https://manual.koalasampler.com/mobile/12-specifications/), publisher manual | bounded platform and capability specifications |
| K3 | [Koala device support](https://koalasampler.com/help/app-store-payment/will-koala-run-on-my-device.html), publisher help page | iOS 13 and Android 8.1+/ARM/Google Play statements; conflict input |
| K4 | [Apple App Store — Koala](https://apps.apple.com/us/app/koala-sampler-beat-maker/id1449584007?platform=ipad), store listing | Apple 2.0.15/date/OS, mapping and optional features, release history, privacy/accessibility fields |
| K5 | [Google Play — Koala](https://play.google.com/store/apps/details?hl=en_CA&id=com.elf.koalasampler), store listing | Android edition/version/update field, optional features, data-safety declaration |
| K6 | [Koala release notes](https://www.elf-audio.com/koala/release-notes.html), publisher change log | historical persistence/MIDI/load fixes only |
| E1 | [Google Play — Audio Evolution](https://play.google.com/store/apps/details?hl=en-US&id=com.extreamsd.aemobile), store listing | Android update date, production features, Google Drive, optional purchases/content, data safety |
| E2 | [Audio Evolution Android manual — introduction](https://www.audio-evolution.com/manual/android/html/Introduction.html), 2022-copyright unversioned manual | audio/MIDI tracks, instruments, SoundFonts, effects and external-device boundaries |
| E3 | [Android manual — MIDI device](https://www.audio-evolution.com/manual/android/html/ConnectingaMIDIDevice.html), 2022-copyright unversioned manual | host/power/class compliance, connect-before-launch, foreground warning, latency configuration claims |
| E4 | [Android manual — starting](https://www.audio-evolution.com/manual/android/html/Startingtheapp.html), 2022-copyright unversioned manual | first-start storage/recording permissions and device availability |
| E5 | [Android manual — project save/load](https://www.audio-evolution.com/manual/android/html/CreatingSavingandLoadingyourProj.html), 2022-copyright unversioned manual | manual save, autosave, versions, templates, clear-data/uninstall risks |
| E6 | [Android manual — MIDI remote](https://www.audio-evolution.com/manual/android/html/MIDIRemoteSetup.html), 2022-copyright unversioned manual | MIDI Learn/manual CC, transport/marker/mix/bus/instrument mappings, banks/feedback, XML setups |
| E7 | [iOS manual — MIDI device](https://www.audio-evolution.com/manual/ios/html/ConnectingaMIDIDevice.html), 2022-copyright unversioned manual | iOS class-compliant USB, power, Bluetooth scan and permission |
| E8 | [iOS manual — project save/load](https://www.audio-evolution.com/manual/ios/html/CreatingSavingandLoadingyourProj.html), 2022-copyright unversioned manual | save, autosave, versions, templates, app-removal data-loss warning |
