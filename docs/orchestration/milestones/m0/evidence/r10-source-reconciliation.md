# R10 independent source reconciliation

Source catalog `f93b9c943f0fbbfc77621797a1739ad9dd2493e0`, exact brief `4e5601142e8a60f4db9f19625c7f4cacb04867e3`. Independent read-only Researcher rehashed all20original HTML bodies and amended preliminary version/currentness/setup/recovery/privacy claims. Original handoff and tool failure remain preserved. Unsupported Default Sound Set Internet claim is removed from planned synthesis because its body is outside the capture; no new crawl required. C1current2.5.4/2026-10-01 supersedes2.3.2/no-date. No task verification, adoption, measured performance or rights conclusion. Controller records full output below, trailing whitespace normalized only.

- `researcher-reconciliation.final.txt` SHA256 `731a080621e468debda0cf4331b6a9a571064a0e50d4656369a81bd9b890b116`.
- `researcher-reconciliation-runtime.json` SHA256 `06cec4f6dcd5df927ff1ff1918b190c2e5e8498e602c340a570106d9332d0a27`.
- `researcher-reconciliation-child.jsonl` SHA256 `f1303dd729bd8f158445d65f60f926cf840fc85dcbb562e53333830d35a9d4dc`.
- `researcher-reconciliation-relay.jsonl` SHA256 `a47467f4339c00ce46da2e24614481792a87220c5deb6dd645ef6085fb043e86`.

R10 reconciliation amendment — 2026-10-23
Identity: independent Researcher, configured `terra/high/read-only`.

I re-read the canonical source catalog at `f93b9c943f0fbbfc77621797a1739ad9dd2493e0`, source inventory, all 20 retained HTML bodies and their derived reading aids, and the preliminary handoff. I rehashed all 20 raw source files; each matches the catalog SHA-256. The evidence set contains **20 raw requests, 20 retained HTML bodies, zero raw retrieval failures**, 11 tool payloads, and 11 decoded aids. H01 is a failed transformation; H02 repeats a search. Neither establishes an additional source page.

## Corrections to the preliminary handoff

| Area | Corrected fact | Source / writer treatment |
|---|---|---|
| Camelot current identity | C1 is an Apple App Store listing for Camelot Pro, seller/developer field Audio Modeling/Audio Modeling Srl, iPad-only, iPadOS 13+. Raw current listing version is **2.5.4**, dated **2026-10-01**. | Replace “2.3.2/no visible date.” The release history remains change history, never reliability proof. |
| Camelot setup/recovery | C3 documents selecting/mapping audio I/O and MIDI ports, configuration warning indicators, Panic-button presence, Setlist → Song → Scene organization, and scene layers. C1 says the current release automatically reloads the current song after audio-device change and records various fixes. | State setup/Panic as documented workflow. Treat reload/fix text only as vendor release-note history; do not claim recovery, continuity, or panic semantics. |
| C2 provenance | C2 is a CloudFront-hosted page visually/textually branded “Camelot Pro \| Audio Modeling,” contains Audio Modeling logo/content, and links to Camelot product navigation. C1 and C3 independently identify Camelot and Audio Modeling. | Attribute C2 as a **branded vendor feature page on a CDN URL**, with supportive linkage but no independent domain-ownership proof. Do not call its CloudFront URL alone an official publisher domain. Its feature claims remain vendor assertions. |
| AUM current identity | A3 is an Apple App Store listing, seller Kymatica AB, iOS/iPadOS 12+, current version **1.4.8**, dated **2025-11-23**. | Preliminary date/version was correct; retain it distinctly from the unversioned online guide. |
| Koala current identity | K4 is the Apple listing for Mazbox Limited’s Koala Sampler, current **2.0.15**, raw datetime **2026-10-16**, iOS/iPadOS 15+. K5 is a separate Google Play listing, updated 2026-09-30. | Replace the preliminary App Store “five days ago” observation with the raw date. Keep K4/K5 as separate platform listings. |
| Koala compatibility conflict | K3 says iOS 13 and Android 8.1+ ARM with Google Play; K4 later says iOS/iPadOS 15+. K1/K2 say some features vary by platform, with AUv3 on iOS and no AUv3 on Android. | Preserve the conflict rather than choose one requirement. It demonstrates that platform listing and help-page requirements need version-specific checking. |
| Audio Evolution currentness | E1 is a current Android Play listing, updated **2026-10-08**. E2–E8 are Android/iOS manual pages carrying a 2022 copyright and no app-version identity. | Never use the current Android listing to make the manuals current-platform proof. Separate Android-store facts from older manual instructions. |
| Unsupported download claim | The preliminary statement that a Default Sound Set download requires Internet came from an earlier search excerpt, but that page is absent from the 20-body capture. | Remove that claim from the canonical report unless a separately captured full body is added through the authorized controller process. |

## Save, recovery, and offline corrections

**Camelot.** C2 documents setlist/song import/export with optional attachments/audio, snapshots described as a point-in-time organization view, and a zipped session backup intended for another drive or cloud. It also describes song selection loading instruments/effects/audio tracks, and setlist racks intended to keep some resources loaded. These facts establish dependency and preparation surfaces, not atomic save, all-or-nothing restore, local-only operation, offline entitlement, or successful failed-load recovery. C3’s tutorial is explicitly around Camelot 2.3.0, older than C1’s 2.5.4, so cite it as a tutorial whose current-build coverage is unknown.

**AUM.** A2 documents explicit session save/open/clear; automatic last-state storage when backgrounding, clearing, or loading another session; and a previous-state restore. It also says a hardware-input node is disabled when an interface/headset disconnect would otherwise redirect it to the built-in microphone. A2 records further narrow recovery limits: moving a cable/hub can make saved MIDI endpoints unrecognized, requiring a connection-swap operation; background activity depends on documented session conditions; session-load MIDI actions are global rather than stored per session. This is useful documentary evidence for recovery questions, but it does not establish whole-session atomicity, plugin recovery success, panic semantics, tail handling, or portable offline behavior. A2’s file-player sources include device, cloud-service, and external-USB locations; this means local session use cannot be assumed to be dependency-free.

**Koala.** K1/K2 document standalone operation and platform-delimited feature surfaces; K4/K5 document imports, optional Samurai/Mixer features, packs, and store editions. K6 is a developer release log with fixes involving projects, effects, MIDI, and loading. Treat K6 solely as product change history. It does not establish a recovery contract, no-stuck-note guarantee, persistence correctness, account-free launch, downloaded-content availability, or a universal offline claim. Privacy labels also differ by store body: K4’s Apple declaration identifies diagnostics not linked to identity, while K5’s Google declaration lists app activity, performance/app information, and device-or-other IDs. These are developer/store declarations, not security findings.

**Audio Evolution.** E4 says its documented Android first-start flow requests storage and recording permissions; E5 documents manually saved projects, autosaves, templates, and Android clear-data/storage loss risks; E8 documents analogous iOS project saving and warns app removal deletes projects. E3 advises connecting MIDI before launch and says the Android app must remain foreground for its described recording/playback path; E7 describes iOS USB/Bluetooth setup and Bluetooth permission. E1 documents Android cloud sync to Google Drive, in-app purchase surfaces, and a developer-provided Google Play data-safety declaration. These observations establish permission, foreground, file, cloud, and content dependency questions. They do not prove route recovery, offline readiness, project portability in a selected build, or performance.

## Privacy, edition, and content instructions

- C1’s diagnostics-not-linked declaration, A3’s “Data Not Collected” declaration, K4/K5’s different platform declarations, and E1’s data-safety declaration must each remain source- and edition-qualified. Store disclosures state what the developer supplied to that store; no security, privacy, account, or legal conclusion follows.
- C1/C2/C3 show Camelot’s host/routing/backing-track/attachment model. A1/A2 show AUM’s hosted-node and file-source model. K1/K2/K4 show Koala’s sample, optional add-on, and iOS-only-hosting boundaries. E1/E2 show Audio Evolution’s virtual instruments, SoundFonts, paid effects/content, and cloud surfaces. None clears code, samples, presets, plugins, files, fonts, or other assets for AugmentedKeys. Preserve every item as outside adoption and subject to the existing ledger.
- Do not cite customer reviews embedded in C1/A3/K4/K5/E1 as evidence. Do not infer Android absence from the iPad-only products.

## Eight-criterion writer instructions

1. Use the corrected product/version/date matrix above. Mark C2 provenance qualified; distinguish store listing, branded vendor page, support tutorial, and manual.
2. For setup/routing, cite C3, A2, E3/E4/E7; mark Koala’s detailed controller path unverified in this corpus.
3. For blend/layer/effect claims, state hosted/external or optional content boundaries before any capability comparison. No product supplies evidence of an original cleared piano/pad/warm-synth set.
4. Label C1/C2 scene continuity, A1/A3 quality/latency, and E1/E3 latency statements as vendor assertions. Do not infer measured performance.
5. Map only the user problem: prepared local starters, explicit save/restore, small variations, ordered local songs, visible readiness, and controlled recovery. Do not import setlist/session hierarchies, UI, formats, plug-ins, or timeline behavior.
6. Keep account/download/cloud/offline claims narrow: C2/A2/K1–K6/E1–E8 expose various file/cloud/content surfaces, but none proves complete offline activation or entitlement behavior.
7. Record the capture boundary exactly: 20 HTML / 0 failures; H01 failed transformation and H02 repeated search; aids are derived, original HTML controls. The full catalog contains URLs, timestamps, hashes, and byte counts.
8. Retain later unperformed scenarios for offline launch, local save/restart, wired MIDI, held-note/sustain/Stop Sound, route/controller loss, failed preparation, malformed references, and accessibility. They are evidence methods, without budgets, devices, architecture choice, or adoption.

Remaining gaps are material but bounded: no hands-on playback, latency, route-change, controller, panic, resource-load, entitlement, account, accessibility, performance, security, rights, or full-offline evidence; no product-wide feature absence; and no basis to equate platform editions.
