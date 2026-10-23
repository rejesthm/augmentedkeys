# Sunday Keys public capability and workflow analysis

## Status, scope, and evidence method

This is R08 documentary research under brief `b97672196693657c0c34caea0d90c3cfb9bb1f67`.
It describes public first-party statements captured on **2026-10-23**.
It does not report hands-on use, adoption, architecture, implementation, performance, licensing clearance, or a product requirement decision.
AugmentedKeys remains a Flutter shell; the original offline worship patch builder remains planning context.

The evidence set contains **two request indexes, 26 requests, 26 HTTP 200 bodies, and zero retrieval failures**.
Source IDs are K01–K26.
Original HTML bodies are authoritative; derived text was used only as a reading aid.
No app, account, purchase, agreement, hardware, media, sound, patch, preset, font, image, archive, or executable was accessed.
Customer reviews, video titles, search snippets, and embedded media were excluded as feature evidence.

The canonical URL, timestamp, byte count, and full SHA-256 register is [R08 public-source evidence](../orchestration/milestones/m0/evidence/r08-sources.md).
The register freezes the captured bytes, not the mutable public pages.
All source links below were accessed 2026-10-23.

Evidence labels:

- **Fact** — directly present in a captured first-party or platform-hosted body.
- **Vendor assertion** — a first-party quality, reliability, compatibility, or behavior claim that was not independently tested.
- **Inference** — a bounded interpretation of facts.
- **Recommendation** — an original question or later validation direction, not an adopted requirement.
- **Gap** — the corpus does not establish the stated point.
- **Owner decision** — a choice outside R08 that remains unmade.

## Product identity, edition, platform, and currentness

| ID | Product identity | Captured statement | Evidence treatment |
|---|---|---|---|
| P01 | Sunday Keys standalone app | K01 lists an iPad/Mac app, version **2.5.2**, dated **2026-10-05**; the captured HTML also embeds `2026-10-05 07:31:58 UTC`. | App Store metadata and vendor release notes; no device confirmation. |
| P02 | Standalone requirements | K01 says iPadOS 15.0+ and macOS 13.0+; K24 says iOS 15+/Ventura+. | Vendor/store requirements for Sunday Keys, not an AugmentedKeys minimum-OS decision. |
| P03 | App Store identity fields | K01 displays developer Loop Community, seller OMNISONIC MEDIA GROUP, and copyright OmniSonic Media Group LLC dba Sunday Sounds. | Listing fields only; no corporate ownership or rights investigation. |
| P04 | Sunday Keys for MainStage | K02 describes a separate product designed for MainStage 3. | Separate template; its content, setup, formats, and behavior do not transfer to the standalone app. |
| P05 | Sunday Keys for Ableton Live | K25 describes a Windows/Mac template requiring Live 10.1.41+ Intro, Standard, or Suite; Lite is excluded. | Separate template and vendor compatibility assertion; untested. |
| P06 | Edition separation | K03 says MainStage and Ableton have separate sounds/presets and cannot share patches. | Vendor statement; not evidence about the standalone app's interchange format. |
| P07 | Product-family bundle | K26 says a purchase includes standalone, MainStage, and Ableton formats. | General statement qualified by K24's All-Access exception and edition differences. |
| P08 | Standard/Ultimate | K24 says received sounds remain after non-renewal while Advanced Features cease. | Vendor commercial/access statement, not legal advice or purchase guidance. |
| P09 | All-Access | K24 says it is app-only and content becomes unavailable after a stated 14-day grace period on expiry. | Current app-specific vendor statement; it narrows broader older K04/K22/K26 wording. |

K01 release history extends several older support descriptions.
Version 2.2 added optional Tonic control by snapshots, 2.3 added sound reordering, and 2.4 changed effect slots and claimed migration of existing user content.
Version 2.5.1 claimed a rare patch-change stability fix; 2.5.2 says sound and patch browsers remember the last opened library.
These are dated release-note claims, not proof of persistence, migration success, timing, stability, or current device behavior.
Detailed support pages from 2024 remain useful attributed documentation but are not an exhaustive 2.5.2 schema.

## Concise source and claim register

The table names the claim anchors used below; full hashes and access timestamps remain in the canonical register.

| Source | Public URL | Captured subject and anchor |
|---|---|---|
| K01 | https://apps.apple.com/us/app/sunday-keys/id1615360535 | App identity, 2.5.2/date, release history, account statement, privacy fields, OS requirements. |
| K02 | https://sundaysounds.com/products/sunday-keys-for-mainstage | Separate MainStage 3 template product. |
| K03 | https://support.sundaysounds.com/article/3258-whats-the-difference-between-sunday-keys-for-mainstage-or-sunday-keys-for | MainStage/Ableton separation; updated 2024-04-12. |
| K04 | https://support.sundaysounds.com/article/3142-faqs | App, touch, gear, library, performance, editions; updated 2025-11-06. |
| K05 | https://support.sundaysounds.com/article/3145-connection-guide | Power, wired/Bluetooth/network MIDI, audio connection; updated 2024-11-11. |
| K06 | https://support.sundaysounds.com/article/3194-settings | Audio/MIDI/performance settings, patch-silence time, routing; updated 2024-04-23. |
| K07 | https://support.sundaysounds.com/article/3132-midi-learn | Primary/Secondary controller and MIDI Learn; updated 2024-04-23. |
| K08 | https://support.sundaysounds.com/article/3167-troubleshooting-midi-connections | MIDI monitor, device/channel, power and connection checks; updated 2024-04-23. |
| K09 | https://support.sundaysounds.com/article/3190-sustain-pedal-issues-latching-switch-reverse-inverted-flipped-with-the | CC64, latching, polarity, monitor troubleshooting; updated 2024-04-12. |
| K10 | https://support.sundaysounds.com/article/3141-sounds | Sounds, ranges, settings, transpose, voices, export; updated 2024-04-23. |
| K11 | https://support.sundaysounds.com/article/3143-patches | Patch instances, library export, silence, program change, AI builder; updated 2024-12-05. |
| K12 | https://support.sundaysounds.com/article/3140-effects | MIDI/audio effects and presets; updated 2024-04-23. |
| K13 | https://support.sundaysounds.com/article/3139-patch-snapshots | Snapshot fields and immediate application wording; updated 2024-04-23. |
| K14 | https://support.sundaysounds.com/article/3182-snapshot-transitions | Default and per-snapshot transition configuration; updated 2024-04-23. |
| K15 | https://support.sundaysounds.com/article/3136-tonic | Tonic controls, default patch independence, Patch Lock; updated 2024-04-23. |
| K16 | https://support.sundaysounds.com/article/3138-setlist-browser | Local setlists and link-based sharing/import; updated 2026-04-21. |
| K17 | https://support.sundaysounds.com/article/3168-troubleshooting-audio-connections | Audio recognition, gain/buffer advice, historical stereo-only claim; updated 2024-04-23. |
| K18 | https://support.sundaysounds.com/article/3150-optimizing-ipad-performance | Setlist load, buffer, preload, visual/resource advice; updated 2024-06-05. |
| K19 | https://support.sundaysounds.com/article/3421-flex-routing-multiple-audio-outputs-in-the-app | Multiple outputs and per-device routing; updated 2025-04-01. |
| K20 | https://support.sundaysounds.com/article/3193-hosting-auv3-au-instrument-plugins | AUv3/AUv2 instrument-host boundary; updated 2024-04-17. |
| K21 | https://support.sundaysounds.com/article/3192-cloud-backups | Vendor-cloud backup and restore; updated 2024-04-23. |
| K22 | https://support.sundaysounds.com/article/3156-downloading-the-sunday-keys-app | License, login, registration, demo and content-download path; updated 2024-04-23. |
| K23 | https://support.sundaysounds.com/article/3188-icloud-backup | iCloud migration/restore plus login/device verification; updated 2024-04-17. |
| K24 | https://sundaysounds.com/pages/sunday-keys-app | Current app marketing, tiers, advanced features, expiry, system claims. |
| K25 | https://sundaysounds.com/pages/sunday-keys-for-ableton | Separate Ableton edition and capture-date requirements. |
| K26 | https://sundaysounds.com/pages/sunday-keys-versions | Product-family edition overview. |

## Documented setup, control, sound-building, and persistence

### Setup and audio

- **Fact (K05):** vendor guidance starts with adequate power for the iPad, hubs, MIDI devices, and audio interface.
- **Fact (K05/K17):** the documented audio path uses built-in output where available or a class-compliant interface to headphones/PA.
- **Fact (K06):** settings expose the selected audio device, buffer size, background/asleep operation, visual-load controls, and patch preloading.
- **Vendor assertion (K04/K05):** class-compliant gear is broadly presented as compatible; individual device behavior remains untested.
- **Vendor assertion (K17):** Bluetooth audio is discouraged for latency/quality; no measurement accompanies the statement.
- **Recommendation:** later original-app tests should make power, selected route, output activity, and playable readiness visible without copying this flow.

### Touch, MIDI, and controller roles

- **Fact (K04):** documentation describes touch controls, an onscreen keyboard, mod wheel, and sustain control.
- **Fact (K06/K07):** one Primary controller supplies notes; Primary and Secondary controllers may drive learned screen controls.
- **Fact (K07):** MIDI Learn maps eligible visible controls and can save presets for hardware configurations.
- **Fact (K07/K09):** default modulation and sustain use CC1 and CC64; explicit learns can override mappings.
- **Fact (K08):** troubleshooting uses device/channel selection and a MIDI monitor for incoming messages.
- **Fact (K09):** sustain guidance addresses CC64, momentary-versus-latching detection, connection order, and pedal polarity.
- **Gap:** no controller was operated, so enumeration, reconnect, ordering, duplicated events, stuck notes, and recovery are unmeasured.
- **Gap:** no app-wide panic/stuck-note-clearing procedure was documented in this bounded corpus; that does not establish global absence.

### Browse, sounds, layers, ranges, and effects

- **Fact (K10):** a patch may contain one or more sounds, layered or spread across keyboard ranges.
- **Fact (K10):** the older page documents browsing/search, per-sound volume, range, eligible ADSR/filter controls, EQ/compression, transpose, sustain blocking, voice count, pan, and output assignment.
- **Fact (K12):** MIDI and audio effects have editable parameters, engage/bypass states, confirm/discard behavior, and reusable presets.
- **Fact (K01):** later releases add layer reordering and revise audio-effect slots; K10/K12 are not an exhaustive current schema.
- **Vendor assertion (K24):** library, sound-quality, and ease claims are marketing, not evaluated content quality.
- **Rights boundary:** vendor sounds, patches, presets, names, layouts, media, and artist-associated material are not source material for AugmentedKeys.

### Save, copy, recall, and portability

- **Fact (K11):** setlist patches are unique instances; duplicate and rename act on the instance.
- **Fact (K11):** exporting creates a library copy, and later edits to the setlist instance do not update that copy automatically.
- **Fact (K10):** a customized sound can similarly be exported to the user library.
- **Fact (K16):** setlists can be created, loaded, renamed, duplicated, deleted, searched, and built from scratch or a template.
- **Fact (K16):** sharing generates a link; importing consumes a link and saves or loads a named copy.
- **Fact (K21):** cloud backup covers saved sets, user-library patches/sounds, and custom effect presets for active license holders.
- **Fact (K23):** iCloud device restoration is followed by Sunday Keys login, device verification, and an offered data restore.
- **Gap:** no local portable file format, schema versioning, integrity checks, rollback, corrupt-data behavior, or fully offline restore is established.
- **Recommendation:** preserve the original question of clear local save/copy/rename/delete semantics and recovery to a last valid document.

## Live performance, sections, switching, and recovery

### Song and service organization

- **Fact (K11/K16):** a setlist contains patches; a selected patch recalls its sounds and settings.
- **Fact (K16):** local browsing and ordering support service preparation; link sharing is a separate network boundary.
- **Fact (K11):** a patch may respond to a MIDI Program Change value.
- **Inference:** players need a legible distinction between reusable sound definitions, song instances, and service order.
- **Recommendation:** test whether an original local workflow explains this distinction without cloud links or competitor terminology.

### Sections and controlled changes

- **Fact (K13):** the 2024 snapshot page lists saved sound volumes, effect engage/bypass states, and patch mod-wheel position.
- **Fact (K13):** it says selection immediately applies those stored values.
- **Fact (K14):** a separate transition system configures duration, mod-wheel participation, and effect-change timing globally or per snapshot.
- **Qualification:** “immediate” stored values and configured transitions are different paths; neither supplies an end-to-end timing guarantee.
- **Fact (K01):** version 2.2 later added optional Tonic snapshot control, so K13's field list is not exhaustive for 2.5.2.
- **Fact (K15):** Tonic can be independent of patch changes by default or have selected settings locked to a patch.
- **Qualification:** default-patch independence does not establish note ownership, sustain, tails, interruption, or timing.

### Patch changes, tails, resource use, and silence

- **Fact (K06):** a configurable period lets a prior patch continue output after a new selection.
- **Fact (K11):** a target patch can instead silence the previous patch immediately.
- **Fact (K18):** neighboring patches can be preloaded; the count trades readiness claims against resource use.
- **Fact (K18):** guidance suggests leaner setlists, larger buffers, fewer preloads/effects, closing other apps, and reduced visual work.
- **Vendor assertion (K04/K06/K18/K24):** “seamless,” reliable, optimized, low-resource, and quality statements are not benchmarks.
- **Gap:** note/sustain ownership, tail cutoff, load readiness, interruption, overflow, dropout, recovery time, CPU, memory, battery, and polyphony are unmeasured.
- **Recommendation:** retain an obvious original Stop Sound action and separately test held notes, sustain, tails, failed preparation, and last-valid recovery.

### Audio-routing disagreement

- **Disagreement (K17):** the page updated 2024-04-23 says only one stereo output and no additional outputs.
- **Later evidence (K19/K06/K01):** 2025 routing guidance, settings, and release history describe Flex Routing and multiple outputs.
- **Inference:** this plausibly reflects product evolution, but does not prove exact version/device behavior or erase the dated conflict.
- **Gap:** device-specific routing, route loss, and recovery require separately authorized version-bound testing.

### Troubleshooting and resume

- **Fact (K08/K09):** MIDI troubleshooting checks power, recognition, selected device/channel, monitor events, CC64, and pedal polarity/latching.
- **Fact (K17/K18):** audio troubleshooting checks class compliance, power, recognition order, output level, gain, buffer/load, and app restart.
- **Fact (K01):** release notes mention fixes for patch-change instability and an audio-interruption crash.
- **Qualification:** troubleshooting steps and release-note fixes are not recovery guarantees.
- **Gap:** controller reconnect, audio route change, crash, incomplete content, and failed patch load behavior remain unknown.

## Account, offline, content, plug-in, privacy, and rights boundaries

- **Fact (K01/K22):** an existing SundaySounds.com account is described even for demo use; full use adds login, device registration, license, and content download.
- **Fact (K11):** AI Patch Builder explicitly requires an active license and internet connection.
- **Fact (K16/K21/K23):** shared links, vendor cloud backup, and iCloud restoration are network/account boundaries.
- **Fact (K20/K24):** instrument plug-in hosting is an Advanced Feature tied to an active license; AUv3 is documented for iPad/Mac and AUv2 for Mac.
- **Fact (K20):** the older hosting page excludes audio and MIDI effect plug-ins.
- **Qualification:** active-license status does not prove continuous internet for local plug-in hosting, output routing, or every Advanced Feature.
- **Inference (K18):** Wi-Fi-off advice shows vendor guidance contemplates a low-network performance context.
- **Gap:** it does not establish offline activation, registration, download, expiry validation, AI, cloud, link import, recovery, or all local paths.
- **Fact (K24):** Standard/Ultimate and All-Access have different expiry/content consequences; broad K04/K22/K26 statements are not universal.
- **Fact (K01):** App Store privacy fields say usage and diagnostics/crash data may be collected without linkage to identity.
- **Qualification:** the privacy fields are developer-provided and expressly unverified by Apple; they are not data-flow or security proof.
- **Security boundary:** account, cloud, iCloud, shared-link, Bluetooth/network MIDI, download, and plug-in surfaces need later review if selected.
- **Rights boundary:** public readability and capability descriptions grant no copying or redistribution rights.
- **Rights boundary:** original content and implementation remain mandatory; every future dependency and asset still requires approval and ledger review.
- **Owner decision:** no engine, plug-in model, cloud feature, account model, content source, license tier, or external service is selected.

## Task-based workflow matrix

| Task | Documented fact or vendor evidence | Inferred need/friction | Original question | Untested gap |
|---|---|---|---|---|
| Prepare gear | K05 foregrounds power, controller, audio interface, and output; K06 exposes devices/settings. | Players need visible readiness before rehearsal or service. | Can the original app make audio enablement, route, controller status, and resume state obvious? | No device, route, power, or recognition test occurred. |
| Choose a starting sound | K10/K11 document browse/search and libraries; K01 says 2.5.2 remembers the last library. | A beginner needs fast access without a large catalog model. | Are six original editable starters enough, and is last-used context helpful without hiding state? | Search speed, accessibility, persistence, and migration are untested. |
| Build a blend | K10 documents sounds, levels, ranges, transpose, filters, sustain rules, and effects. | Players need musical change with limited technical load. | Can one-to-four original piano/pad/warm-synth layers expose level, brightness, mute, and sends clearly? | Content quality and editing usability were not evaluated. |
| Save edits | K11 separates setlist instances from library copies; K10 provides sound export. | Ambiguous save/copy ownership can lose work or preserve stale versions. | Can save-copy-rename-delete and immutable starters remain understandable and recoverable? | Atomicity, corrupt data, undo, conflicts, and upgrades are unknown. |
| Arrange a service | K16 documents create/load/search/duplicate/delete and sharing/import by link. | Players need local ordering and dependable references. | Can local named songs/setlists handle reorder and missing references offline? | Local portability and offline restore are undocumented. |
| Perform | K06/K11/K18 describe selection, silence time, preload, buffer, and resource controls. | Live use needs obvious ready/current/next state with bounded risk. | Can prepared original sounds remain local and expose failure before selection? | No latency, dropout, tail, memory, CPU, or readiness result exists. |
| Switch sections | K13/K14/K01 describe stored states, configured transitions, and later Tonic participation. | Players need texture changes without leaving the keyboard. | Are three prepared Verse/Chorus/Bridge variations with bounded level/mute/brightness/effects sufficient? | Held-note, sustain, tail, transition-time, and rapid-input behavior are untested. |
| Recover/resume | K08/K09/K17/K18 give diagnostics/restart advice; K21/K23 give cloud restore paths. | A performer needs safe silence and a route to the last playable state. | Can Stop Sound, deliberate audio resume, and last-valid local recovery work without cloud? | Panic, reconnect, interruption, failed load, and offline recovery are unknown. |

## Mapping to the existing original AugmentedKeys plan

These are evidence-informed questions within approved planning goals, not adopted competitor features.

1. **Original piano/pad/warm synth:** K10/K24 support the problem of quickly combining familiar worship timbres; no vendor sound or patch may be copied.
2. **Up to four layers:** multi-sound patches and resource guidance support testing a bounded layer model; they do not establish four as an engine limit.
3. **Six editable starter patches:** browse and copy/export distinctions support a small original set with explicit copy semantics; content remains uncleared.
4. **Saved edits:** unique instances show why ownership, naming, persistence, and last-valid recovery need direct usability tests.
5. **Verse/Chorus/Bridge variations:** snapshots show the user need for prepared section changes; three original variations remain a smaller planned response.
6. **Local setlists:** K16 validates preparation/ordering; link sharing, cloud, account login, and AI remain outside the offline first-version goal.
7. **Touch/basic wired MIDI:** Primary note input versus Secondary control learning suggests naming note and control roles plainly.
8. **Accessibility:** K01 says the developer has not identified supported accessibility features; this is not absence evidence and does not replace direct original-app testing.

A reasonable original differentiation question is whether a small local workflow removes enough preparation friction:
original cleared instruments, six editable templates, at most four visible layers, three prepared variations, local ordering, explicit save semantics, visible readiness, and Stop Sound.
This framing avoids account, AI, cloud, plug-in, and commercial-content dependencies in the first version.
It does not select architecture, accept performance tradeoffs, or amend APP_SPEC.

## Gaps and precise follow-up evidence

1. **Current behavior:** bind hands-on evidence to exact app version, OS, device, interface, controller, route, and license state.
2. **Offline envelope:** separately test launch, local play, entitlement handling, content presence, relaunch, route recovery, and expiry states.
3. **Switch safety:** capture MIDI, lifecycle, render, and audible markers across held notes, CC64, rapid section/patch changes, tails, and Stop Sound.
4. **Resource readiness:** observe requested load, declared ready, selection, first conforming render, failures, preload boundaries, CPU, memory, and dropout.
5. **Connection recovery:** record disconnect/reconnect and route-change sequences, duplicates/loss/order, active-note state, silence, and deliberate resume.
6. **Persistence:** test save/copy/rename/delete, relaunch, upgrade, malformed/missing references, rollback, and last-valid recovery with local artifacts.
7. **Accessibility:** test the original UI with screen reader, focus navigation, large text, contrast, motor targets, and understandable status/errors.
8. **Rights/security:** before asset, dependency, account, cloud, import, or plug-in work, complete version-specific license and threat review.

No gap authorizes an account, purchase, trial, download, device operation, architecture decision, or requirements expansion.

## Proposed later usability and acceptance scenarios

All scenarios are **unapproved and unperformed**.
They define future evidence questions only and adopt no thresholds.

1. On an approved physical device and audio route, enable audio, select an original cleared starter, and verify route, readiness, and failure state.
2. With touch only, make an original piano/pad/warm-synth blend within four layers, change level/brightness/mute/sends, save a copy, and relaunch offline.
3. With approved basic wired MIDI, confirm note source, CC1/CC64, visible input, and recovery after disconnect without stuck or duplicated state.
4. Build a three-song local service, reorder it, resolve a missing reference, and verify that the last valid document remains playable.
5. Switch Verse/Chorus/Bridge during held notes and sustain while recording event, render, audible, lifecycle, and route evidence; exercise Stop Sound.
6. Interrupt and restore audio, then require deliberate resume and an explicit safe/playable state rather than assuming automatic recovery.
7. Stress four layers and variation changes while recording CPU, memory, dropout, event order, tails, and incomplete/unrecovering trials.
8. Ask a beginner to complete setup, blend, save, service arrangement, switching, and recovery; record confusion and accessibility barriers without copying layout.

## Decision status

- **Established:** product identities, dated first-party workflow claims, account/network/content boundaries, and documentary conflicts listed above.
- **Not established:** measured performance, reliability, latency, quality, device compatibility, full offline behavior, global feature absence, security, or legal rights.
- **Recommendation:** use the findings only to refine later original-design questions and evidence plans.
- **Owner decisions remaining:** architecture, engine, content, dependencies, permissions, platform targets, external services, legal conclusions, hardware procedures, and APP_SPEC changes.
- **R08 outcome:** no Sunday Keys feature, content, commercial model, or implementation is adopted; no AugmentedKeys capability is represented as implemented.
