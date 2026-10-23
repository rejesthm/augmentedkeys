# MainStage public capability and workflow analysis

Status: R09 documentary research only. No MainStage capability, Apple platform target,
architecture, dependency, content, design detail, or performance budget is adopted for
AugmentedKeys.

Access date for this report: 2026-10-23.

## Question and evidence boundary

This report asks what Apple's current public material says about MainStage tasks that
matter to a worship keyboard player, then turns those observations into questions for
the original offline AugmentedKeys plan. MainStage is a macOS live-performance product;
its desktop workflow is evidence about user tasks and tradeoffs, not evidence that the
same implementation, interface, performance, or recovery behavior will work on iOS or
Android.

The canonical evidence register, complete URLs, retrieval timestamps, byte counts, and
SHA-256 hashes are in
[`r09-sources.md`](../orchestration/milestones/m0/evidence/r09-sources.md). The retained
corpus comprises:

- 37 raw requests: five HTTP 200 HTML bodies, 30 HTTP 404 responses, and two DNS
  failures;
- 32 separately indexed public web-search results: 26 rendered excerpts and six tool
  errors; and
- 13 compound Researcher tool payloads, identified H01-H13. These payloads do not add
  to the source-request totals.

The W items are rendered excerpts rather than raw HTML or independent HTTP-success
proof. The H items combine several source responses and are supporting evidence rather
than extra pages. Repeated versioned and unversioned renderings are not independent
confirmation. Original HTML controls where it exists; derived text and H renderings are
reading aids. No app, media, patch, sound, preset, concert, or binary was downloaded,
and no device or account was used.

This report uses these labels:

- **Fact**: directly documented in the retained first-party body.
- **Vendor assertion**: an Apple product, store, or support claim not independently
  tested here.
- **Inference**: a bounded interpretation for the AugmentedKeys user problem.
- **Recommendation**: a candidate question or later evidence step, not an accepted
  requirement.
- **Disagreement**: retained sources differ or their scopes do not reconcile cleanly.
- **Gap**: the bounded corpus does not answer the question.
- **Owner decision**: a later choice that this report cannot make.

### Compact source register

All rows were accessed 2026-10-23; exact UTC times and hashes are in the canonical
register. “Raw” means retained HTML; “W” means a rendered excerpt.

| ID | URL | Provenance and claim anchor |
|---|---|---|
| G03 | https://apps.apple.com/us/app/mainstage/id634159523 | Raw listing: identity, 4.3.1 date, requirement, privacy. |
| G04 | https://apps.apple.com/us/app/mainstage-perform-live/id6746637089 | Raw listing: separate ID, M1 requirement, subscription/privacy fields. |
| G08 | https://support.apple.com/en-us/101568 | Raw support body: release identity/date and edition scope. |
| G09 | https://support.apple.com/guide/mainstage/welcome/4.3/mac/15.6 | Raw guide landing body: guide selector/currentness. |
| W01 | https://support.apple.com/guide/mainstage/mainstage-workflow-basics-mstg77636284/4.3/mac/15.6 | W L1486-L1508: end-to-end workflow. |
| W13 | https://support.apple.com/guide/mainstage/save-concerts-mstg61cfce7f/4.3/mac/15.6 | W L1486-L1506: selected scope and assets. |
| W20 | https://support.apple.com/guide/mainstage/selecting-patches-while-performing-overview-mstg62dce2b5/4.3/mac/15.6 | W L1486-L1492: selection, held notes, tails, recall. |
| W23 | https://support.apple.com/guide/mainstage/general-settings-mstgaa975f69/4.3/mac/15.6 | W L1513-L1538: overrides, hardware response, autosave, library. |
| W28 | https://support.apple.com/guide/mainstage/override-concert-and-set-level-mappings-mstga273fab9/mac | W L1486-L1504: precedence and explicit overrides. |
| W29 | https://support.apple.com/guide/mainstage/how-saving-affects-parameter-values-mstg2ab24b77/mac | W L1486-L1507: keep/reset/save conditions. |
| W31 | https://support.apple.com/guide/mainstage/defer-patch-changes-mstge338fd69/mac | W L1486-L1493: defer scope and input restrictions. |
| W32 | https://support.apple.com/guide/mainstage/audio-settings-mstg3a9453e0/mac | W L1482-L1516: audio, hot-plug, tails, voice limiting. |

The full register also preserves every supporting W/H item and every failed request;
citations below use those stable IDs rather than presenting repeated copies as new
evidence.

## Product, edition, version, and currentness

| Evidence | Observed identity and requirement | Currentness and limits |
|---|---|---|
| G03, App Store ID `634159523` | **Fact:** `MainStage`, described as “Only for Mac”; store requirement macOS 15.6 or later. Version 4.3.1 has raw `<time datetime="2026-08-13">`. Seller is Apple Inc. | A separate paid listing. Its developer-provided privacy declaration says Data Not Collected. That declaration is unverified and applies only to G03. Store requirements are not AugmentedKeys minimums. |
| G04, App Store ID `6746637089` | **Fact:** `MainStage: Perform Live`, “Only for Mac”; requires macOS 15.6 or later and Apple M1 or later. Version 4.3.1 has the same raw date, 2026-08-13, and is included with Apple Creator Studio. | Its developer-provided Data Linked to You declaration lists Purchases, Identifiers, User Content/Audio Data; Data Not Linked to You lists Usage Data/Other Data. G03's Data Not Collected field does not transfer to G04. |
| G08 | **Fact:** Apple release notes name MainStage 4.3.1 and publish 2026-08-13. They say the notes apply to the one-time purchase and Creator Studio inclusion. | Release identity evidence, not proof that the two store listings have equivalent accounts, entitlements, privacy, offline behavior, or binaries. |
| G09 | **Fact:** the captured Apple guide selector is MainStage 4.3 with macOS 15.6 path context. | Guide version 4.3 differs from app version 4.3.1. The help site is mutable; a path label is not proof that every unversioned W excerpt exactly matches either build. |
| G01 | **Fact:** the requested `https://www.apple.com/mainstage/` body redirected into a Logic Pro page that includes MainStage marketing context. | It is not MainStage product-page authority and provides no MainStage-on-iPad evidence. Logic Pro for iPad does not make MainStage an iPad product. |

G03 and G04 also expose VoiceOver and Voice Control listing declarations. **Gap:** no
accessibility workflow was exercised, and a store declaration is not usability evidence.
The product and guide are current enough to frame questions, but no claim below converts
desktop documentation into a mobile compatibility or quality guarantee.

## Documented model and positive workflow

### Prepare the rig and concert

**Fact:** Apple's workflow begins with a concert template, then patches, channel strips,
instruments/effects, organization, layout, hardware assignments, and parameter mappings
(W01 L1486-L1508). A concert holds the sounds for a performance or series of
performances, its ordered patch list and sets, its visual layout and hardware
connections, and concert-level volume/effects (W27 L1486-L1492). This is a useful task
hierarchy, not a proposed AugmentedKeys data model.

For hardware, Apple documents connecting a USB MIDI keyboard, following any device or
driver instructions, and using an audio interface compatible with macOS/Core Audio
(W05 L1486-L1495; W06 L1488-L1501). Before performing, the user is told to check MIDI,
audio, instruments, microphones, and the exact interface/speakers intended for the show;
verify incoming MIDI and audible output; close resource-heavy apps; and disconnect the
performance computer from networks (W19 L1488-L1501). The network advice supports a
performance-preparation inference only. It does not prove offline activation,
subscription, downloads, updates, shared files, or third-party plug-ins.

**Vendor assertion:** MainStage recognizes many controllers and can automatically map
some hardware controls to screen controls in templates (W01). **Gap:** the corpus does
not establish coverage for a particular keyboard, MIDI interface, driver, cable,
disconnect sequence, or mobile device. Later AugmentedKeys testing needs named hardware,
OS, connection, and observed event/audio boundaries.

### Build layers, splits, and controls

**Fact:** channel strips are patch building blocks. Apple documents software-instrument,
audio, and external-instrument types; output, pan, mute/solo, effects, sends, input/output,
key range, velocity/transform, and MIDI filtering controls (W02 L1486-L1525). Two or more
channel strips can form overlapping keyboard layers or contiguous splits through each
strip's low/high keys (W07 L1486-L1488). A layer can be bypassed through its MIDI-input
bypass attribute (W08 L1486-L1496). These are positive capabilities, not evidence for a
specific four-layer mobile engine.

MainStage separates physical **assignment** from target **mapping**. Layout mode connects
a hardware control to a screen control; Edit mode maps that screen control to a patch,
set, concert, channel-strip, plug-in parameter, or action (W01, W09 L1486-L1519). At
performance time, per-control response can Jump, wait for Pickup, or move Relative from
the current value (W21 L1486-L1489; W23 L1513-L1524).

Mapping scope matters. Concert mappings take precedence over set and patch mappings;
set mappings take precedence over patch mappings. MainStage permits an explicit
lower-level override (W28 L1486-L1504). **Inference:** a simplified app still needs an
understandable answer when one hardware gesture could affect global, song, variation, or
layer state. **Owner decision:** AugmentedKeys has not selected an inheritance model,
override UI, or Jump/Pickup/Relative behavior.

### Organize, save, and recall

**Fact:** sets group patches flexibly; Apple gives examples such as one song's patches
or a group sharing a set-level channel strip (W04 L1486-L1497). Patch-list order controls
performance order, and skipped items do not appear in the performance selector, while
patches inside collapsed sets remain selectable (W11; W20 L1486-L1488). MainStage can
export/import patches and sets as `.patch` files; importing a set brings its patches
(W12 L1486-L1512).

Saving is conditional rather than a universal “save everything” rule. W13 L1486-L1506
says saving a concert stores changed mapped values for the selected patch or set, not
other patches or sets, and Save As can include selected asset types. W29 L1486-L1507
adds that default reset behavior restores a prior patch's saved mapped values on change,
whereas Keep current retains its current values and later saving replaces saved values.
Closing without saving restores the previous saved values on reopen. Concert-level
mapped values continue across patch changes (W20 L1489-L1492). Individual screen
controls can override global parameter-value and hardware-response preferences (W23).

Autosave is also scoped: W23 L1525-L1531 says it normally does not run in Perform mode
for performance reasons, but the concert is autosaved when entering Perform. This does
not establish what happens to every asset, plug-in state, external file, crash-time edit,
or selected versus unselected set. **Inference:** explicit dirty-state, save target, and
recall rules are central to a musician trusting a prepared variation. **Owner decision:**
AugmentedKeys persistence and autosave semantics remain unselected.

Apple documents Save As with selected assets (W13), a separate Consolidate operation
that copies selected asset types (W30 L1486-L1493), and backup of concerts by copying
their files or using a system backup (H13, Apple support article published 2025-03-03).
Those features prove file dependencies exist; they do not clear rights or guarantee a
self-contained file.

### Arrange and perform a service

**Fact:** MainStage presents sets and patches in Patch List order and exposes selector,
keyboard, program-change/action, and mapped-hardware navigation paths (W11, W20, W21).
Its documented model can therefore represent a concert, song-like set, and ordered
patches. That is a positive reference for prepare-then-perform tasks, not permission to
copy the hierarchy or interface.

When switching, W20 says the new patch can be played immediately; held or sustained
notes from the previous patch continue until note or sustain release, and effect tails
continue for a configured interval. That same page locates the tail preference in
General settings. W32 L1511-L1516 instead locates `Silence Previous Patch` in Audio
settings and says it applies only to audio and external-instrument strips, excluding
software-instrument strips. **Disagreement:** retain the dated guide conflict; do not
generalize the tail control to every sound path.

W17 L1486-L1492 separately documents a per-patch `Instantly Silence Previous Patch`
attribute. Its page does not state all strip-type exceptions, so it cannot silently
resolve W20/W32. W31 L1486-L1493 documents deferred switching in Perform mode for
incoming MIDI program changes and action-mapped buttons, while excluding Edit mode,
selector clicks, and arrow keys. Its phrase that a switch waits until the last note is
“released or sustained” is ambiguous beyond the source wording. No timing, tail
continuity, or audible-gap guarantee was measured.

**Fact:** Panic is a distinct function intended to silence hanging MIDI notes and can be
invoked by keyboard command, MIDI Monitor, or a mapped control (W18 L1486-L1499).
Master Mute separately silences audio output (H07). Neither establishes a portable MIDI
All Notes Off algorithm, external-device recovery, bounded silence time, or restoration
of prior state.

### Resource and route behavior

Apple documents buffer size, sample rate, processing threads, an overload message, and
an optional safety buffer; smaller buffers reduce latency while increasing CPU pressure
and artifact risk (W32 L1482-L1501). The voice limiter may stop oldest voices, and then
more older voices, under high CPU load (W32 L1515-L1516). These are vendor-described
controls, not benchmark results or an accepted AugmentedKeys policy.

W32 also positively documents hot-plug choices: alert, automatically use the device, or
do nothing. W06 describes an alert when an interface is attached while MainStage is
open. These sources do not show what happens to notes, routes, audio, or saved state on
disconnect, failed driver switch, restart, or reconnect. H09 adds MIDI input, routing,
and pass-through conditions, but no route interruption was performed.

The release notes contain past fixes concerning loading, patch switching, audio devices,
held notes, mappings, routes, and stability (G08). **Inference:** these are evidence that
the states are failure-prone enough to test. They are not evidence that version 4.3.1 is
failure-free, and no customer reviews or search snippets are used as capability proof.

## Task matrix for the original user outcome

| User task | Documented MainStage step or capability | Inferred need or friction | Original mobile question | Explicit unknown |
|---|---|---|---|---|
| Prepare | Choose a concert template; connect/test MIDI, audio interface, monitors, and a playable patch; close heavy apps (W01, W05, W06, W19). | A performer needs a short, repeatable preflight and visible input/output health. Desktop driver, menu, and layout setup can be too broad for a basic mobile flow. | Can the existing offline plan expose a bounded preflight for touch and basic wired MIDI without becoming a device manager? | Supported devices, permission flow, first-sound time, route loss, and actual offline readiness. |
| Build a piano-pad-synth blend | Add instrument channel strips, set levels/effects, overlap key ranges for layers, or separate ranges for splits (W02, W07). | Players need fast balance and range editing with predictable ownership of held notes. | Are up to four original layers enough, and which few controls must remain visible? | Engine, instruments, content, DSP, resource cost, tail behavior, and four-layer feasibility. |
| Save | Save selected patch/set mapped values; choose conditional reset/keep behavior; optionally include assets (W13, W29, W30). | Hidden save scope risks rehearsal edits disappearing or unintended live values becoming defaults. | What explicit save, revert, dirty-state, and asset-reference language makes one prepared variation trustworthy? | Snapshot schema, crash consistency, migration, asset packaging, and autosave policy. |
| Arrange a service | Order patches, group them in sets, skip items, and navigate the resulting list (W04, W11, W20). | A desktop hierarchy is flexible but may be more structure than a local worship setlist needs. | Can local songs plus three prepared variations provide clear order without concert/set complexity? | Exact setlist model, reorder/duplicate rules, import/export, and conflict behavior. |
| Perform | Enter Perform mode; use selector, mapped controls, program changes, or keyboard navigation; parameter values follow scoped recall rules (W20-W23). | The player must see current song/variation, next action, MIDI state, and saved/live distinction under stage pressure. | What minimal touch and basic-MIDI actions cover normal playing while remaining accessible? | Focus order, large-control behavior, screen-reader usability, accidental activation, and actual latency. |
| Switch sections | Immediate or qualified deferred patch changes; sustained notes/tails have documented exceptions and a guide conflict (W17, W20, W31, W32). | Musical continuity and deterministic switching can conflict with resource bounds and emergency silence. | How should Verse/Chorus/Bridge changes define new-note routing, old-note ownership, sustain, and tail cut? | Timing, software-instrument scope, rapid repeated changes, overload behavior, and accepted audible result. |
| Recover | Panic for hanging MIDI, Master Mute for output, documented hot-plug choices, and manual backup (W18, W32, H07, H13). | A performer needs a clear safe state and a rehearsable path back to playable sound. | Which separate actions stop notes, mute audio, reset routes, and restore a known variation? | Disconnect/reconnect semantics, restart duration, lost edits, stuck sustain, external-device state, and bounded recovery. |

## Fit to existing planning goals

The source evidence supports asking focused questions about the already planned offline
piano/pad/warm-synth workflow:

- **Up to four layers:** layers, splits, per-layer bypass, level, effects, and MIDI scope
  are meaningful tasks. MainStage does not prove four mobile layers are performant or
  the right interface.
- **Six editable starters:** templates and patch libraries reduce setup work, but no
  MainStage template, preset, name, artwork, or sound may be copied. The six original
  starters and their edit surface remain a content/design decision behind existing
  gates.
- **Saved edits and three prepared variations:** conditional recall and save behavior
  show why saved values, live values, and revert behavior must be explicit. They do not
  select a snapshot schema or exactly three variations.
- **Local setlists:** ordered patches and song-like sets confirm the underlying prepare
  and navigate need. Replicating concert/set/patch hierarchy would add desktop
  complexity and is not recommended by this evidence.
- **Touch and basic wired MIDI:** MainStage supports mapped hardware, but the documented
  desktop assignment/mapping system is broader than the first version needs. A later
  design should test a small, learnable mapping set.
- **Accessibility:** G03/G04 and W23 mention VoiceOver, Voice Control, and controls view.
  These are prompts for original keyboard, screen-reader, contrast, focus, and touch
  acceptance work; they are not tested compliance.

**Recommendation:** keep the first-version question centered on choosing, blending,
saving, ordering, switching, and recovering a small original rig. Advanced hierarchy,
arbitrary plug-in hosting, desktop-grade mapping graphs, content management, broad file
exchange, recording, and DAW features remain deliberate non-goals unless separately
approved.

## Rights, account, privacy, files, plug-ins, and offline boundaries

MainStage documentation and listings distinguish several surfaces that a future design
must not collapse:

- The application listings and public guide permit observation; they do not license
  copying Apple's UI, brand, templates, factory sounds, patches, images, or media.
- G03 is a one-time-purchase listing, while G04 is tied to Creator Studio. W26 lists
  MainStage among subscription apps. The retained sources do not establish equivalent
  acquisition, login, expiry, grace-period, family, restore, or offline-entitlement
  rules.
- W25 documents downloading, updating, deleting, and relocating the Logic Pro Sound
  Library bundle. Installed content availability, ownership, redistribution, and
  recording/composition/performance rights were not established. No pack was fetched.
- Apple describes Logic Pro compatibility and third-party Audio Units/plug-ins (G03,
  G01 context). Plug-in code, licenses, presets, files, saved state, native availability,
  and content dependencies remain separate evidence and adoption questions.
- Concert Save As, `.patch` files, consolidation, and backup show that state can depend
  on files and selected assets (W12, W13, W30, H13). These operations do not prove a
  portable, complete, licensed, or forward-compatible bundle.
- W19's advice to disconnect networking before performance indicates a desirable live
  posture, not full offline proof. Downloads, subscription validation, initial
  activation, update checks, cloud/shared resources, and failure recovery are gaps.
- G03 and G04 privacy declarations conflict by edition and are developer-provided. They
  are not observed data flows, a security assessment, or an Apple-service-wide claim.

No legal, license, privacy, or security conclusion follows. The current license ledger
and approval gates continue to govern every future package, plug-in, font, sound, patch,
instrument, and other asset.

## Claim and source matrix

| Claim ID | Category | Source and anchor | Version/currentness | Conclusion boundary |
|---|---|---|---|---|
| MS-01 | Fact | G03/G04 raw listings; G08 release notes | App 4.3.1, 2026-08-13 | Two Mac-only store IDs with different hardware/privacy fields; no iPad identity or entitlement equivalence. |
| MS-02 | Fact | G09 | Guide selector 4.3, macOS 15.6 path | Help context differs from app 4.3.1 and may be mutable. |
| MS-03 | Fact | W01 L1486-L1508; W27 L1486-L1492 | Captured 2026-10-23 | Concert, patch, set, layout, assignment, and mapping workflow exists; no copied architecture. |
| MS-04 | Fact | W02, W07, W08 | Captured 2026-10-23 | Channel-strip layers, splits, ranges, and bypass are documented; no four-layer performance proof. |
| MS-05 | Fact | W09, W21, W23, W28 | Captured 2026-10-23 | Assignment/mapping, response modes, precedence, and explicit override are scoped behavior. |
| MS-06 | Fact | W13, W20, W23, W29, W30 | Captured 2026-10-23 | Save/recall/autosave behavior is conditional; no universal save-all claim. |
| MS-07 | Disagreement | W17, W20, W31, W32 | Versioned and unversioned guide excerpts | Tail-setting location/scope conflicts; immediate/deferred paths have distinct exceptions. |
| MS-08 | Fact plus gap | W18, W32, H07, H09 | Captured 2026-10-23 | Panic, mute, hot-plug options, and routes are documented; disconnect/restart recovery is untested. |
| MS-09 | Vendor assertion | W32; G08 | Guide 4.3 context; release 4.3.1 | Resource controls and fixes exist; no transferred latency, CPU, stability, quality, or compatibility guarantee. |
| MS-10 | Gap | W19, W25, W26, G03/G04 | Captured 2026-10-23 | Performance network advice and content/subscription pages do not establish complete offline behavior. |
| MS-11 | Recommendation | APP_SPEC-linked goals interpreted through MS-03-MS-10 | Planning context only | Ask simpler original workflow questions; no requirement or detailed design is adopted. |
| MS-12 | Owner decision | Existing project gates | Future | Architecture, platform minimums, engine, formats, dependencies, content, rights, and accepted behavior remain owner/gated decisions. |

## Future evidence scenarios

These scenarios are **unapproved and unperformed**. They define later evidence methods,
not numeric thresholds or new goals.

1. **Prepare and first sound:** on named physical devices and OS versions, start from a
   clean installation state already authorized for testing; verify local starter
   availability, touch play, one basic wired MIDI keyboard, route identity, and audible
   output. Record permissions, network state, content state, timestamps, failures, and
   whether restart changes the outcome.
2. **Build, save, and reopen:** create an original piano/pad/warm-synth blend within the
   approved layer limit, edit levels/ranges, save three prepared variations, close and
   reopen, and compare an explicit state manifest. Exercise saved versus live values,
   dirty-state cues, revert, duplicate, migration, and interrupted-write recovery.
3. **Service navigation and accessibility:** assemble a local setlist using only original
   names/content, reorder songs, perform section switches by touch and mapped MIDI, and
   repeat with screen reader, keyboard/focus navigation, larger text, and reduced-motion
   settings. Record errors and observations without borrowing competitor layouts.
4. **Musical switching:** define event, sustain, render, and audible markers; switch
   Verse/Chorus/Bridge during held notes, pedal sustain, long release, rapid repeats, and
   bounded load. Capture event ordering, old/new note ownership, tails, silence gaps,
   resource state, and unsuccessful or censored trials. No budget is accepted here.
5. **Recovery and offline:** after authorized preparation, remove networking and test
   launch, local play, save, and reopen. Separately inject MIDI disconnect, audio-route
   loss, stuck-note/sustain, overload, and restart cases. Distinguish stop-notes, mute,
   reset, and restore actions; measure from each trigger to safe state and then to the
   first conforming rendered and audible result.

Each scenario still requires the appropriate architecture, content/license, device,
and owner gates. A future cleared real piano and other original/approved sounds are
required for musical acceptance; a placeholder tone cannot establish the intended user
outcome.

## Open gaps and decisions

The bounded evidence does not establish MainStage's complete offline entitlement flow,
all account requirements, every plug-in or file dependency, software-instrument tail
semantics, deterministic controller recall, disconnect/reconnect safety, crash
consistency, mobile feasibility, accessibility quality, or performance. Thirty 404s,
two DNS failures, and six W-tool errors remain part of the evidence; they do not prove
feature absence.

Later original-source or device evidence should answer each gap at the point a concrete
design needs it. The owner still decides any architecture, platform target or minimum,
dependency, engine, file format, content/asset, license posture, performance budget, and
detailed product design through the existing gates. R09 makes none of those decisions.
