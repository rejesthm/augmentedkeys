# Apple AUv3 hosting research

**Status:** R03 documentary research, Apple findings only. This is not a
commitment to host AUv3, ship an Audio Unit extension, select an engine, or
claim Android/AAP compatibility. Android conclusions are reserved for R04.
**Access date:** 2026-10-23 (Asia/Manila). No plugin, sample project/archive,
SDK, extension, device, simulator, account, signing identity, entitlement, or
executable code was downloaded or run, and no code was adopted. Preserved Apple
documentation contains instructional snippets; reading them is not adoption.

## API/sample availability is not a product baseline

This table transcribes the controller-preserved Apple Markdown metadata. It
does not choose a minimum OS, component support matrix, or product baseline.
`Unknown` means the retrieved metadata did not provide a version; it is not an
inference. All listed facts remain subject to the platform-specific constraints
below.

| API / sample | iOS | iPadOS | Other metadata relevant here | Preserved source |
| --- | ---: | ---: | --- | --- |
| `AUAudioUnit` | 9.0 | 9.0 | macCatalyst 13.1; macOS 10.11 | 13 / 15 |
| `instantiate(with:options:completionHandler:)` | 9.0 | 9.0 | macCatalyst 13.1; macOS 10.11 | 14 |
| `requestViewController` | 9.0 | 9.0 | macCatalyst 13.1; macOS 10.12 | 16 |
| `fullState`, `fullStateForDocument` | 9.0 | 9.0 | macCatalyst 13.1; macOS 10.11 | 17–18 |
| `scheduleMIDIEventBlock` | 9.0 | 9.0 | macCatalyst 13.1; macOS 10.11 | 19 |
| `AUScheduleParameterBlock` type alias | Unknown | Unknown | Metadata shows dashes for all listed platforms | 20 |
| Apple hosting sample | 13.0 | Unknown | macCatalyst 13.0; macOS 10.15; Xcode 16.0 | 12 |

Apple API/sample availability does not prove that a third-party plug-in exists,
can be discovered, supports a route/format, meets a deadline, or is licensed
for the product.

## Claim/source matrix

| ID | Fact (not a guarantee of a third-party plugin) | Primary Apple source / retrieval | Availability / limitation |
| --- | --- | --- | --- |
| P1 | Apple’s sample locates components by `AudioComponentDescription`, including effect and music-device types, and instantiates the selected AU. | [Incorporating Audio Effects and Instruments](https://developer.apple.com/documentation/audiotoolbox/incorporating-audio-effects-and-instruments) — public sample documentation, retrieved 2026-10-23 | Sample is instructional, not proof of a product host. |
| P2 | On iOS, the sample says third-party plug-ins are AUv3 App Extensions running out of process and communicating by IPC. | [Apple AU hosting sample](https://developer.apple.com/documentation/audiotoolbox/incorporating-audio-effects-and-instruments) — public documentation, retrieved 2026-10-23 | Separate process is not a latency, crash-recovery, safety, or capability guarantee. |
| P3 | The sample says iOS supports only OS-provided AUv2; macOS also supports third-party AUv2. AUv2 runs in the host process. AUv3 defaults out of process; `loadInProcess` is macOS-only when supported by the AUv3 component. | [Apple AU hosting sample](https://developer.apple.com/documentation/audiotoolbox/incorporating-audio-effects-and-instruments), [AUAudioUnit](https://developer.apple.com/documentation/audiotoolbox/auaudiounit?changes=la) — public documentation, retrieved 2026-10-23 | No mobile/desktop plugin parity is implied. |
| P4 | Async instantiation returns an AU or error; Apple warns not to block the main thread waiting for it. | [instantiate(with:options:completionHandler:)](https://developer.apple.com/documentation/audiotoolbox/auaudiounit/instantiate%28with%3Aoptions%3Acompletionhandler%3A%29?changes=_5_1&language=objc) — public API reference, retrieved 2026-10-23 | No host recovery policy is supplied. |
| P5 | AU busses, format-change hook, render resource allocation, render block, maximum frames, and parameter scheduling are public interfaces. | [AUAudioUnit](https://developer.apple.com/documentation/AudioToolbox/AUAudioUnit) — public API reference, retrieved 2026-10-23 | Current reference; no product baseline selected. |
| P6 | A custom AU UI is optional; the async view-controller request may return `nil` and invokes its completion on an internal thread/queue. | [requestViewController](https://developer.apple.com/documentation/audiotoolbox/auaudiounit/requestviewcontroller%28completionhandler%3A%29?changes=__9_2&language=objc) — public API reference, retrieved 2026-10-23 | UI hosting and accessibility are untested. |
| P7 | `fullState` / `fullStateForDocument` are persistable state snapshots; `fullState` should omit transitory stream formats. | [fullState](https://developer.apple.com/documentation/audiotoolbox/auaudiounit/fullstate?changes=_2_9&language=objc), [fullStateForDocument](https://developer.apple.com/documentation/audiotoolbox/auaudiounit/fullstatefordocument?changes=_4) — public API references, retrieved 2026-10-23 | Content, size, safety, restore compatibility, and plugin correctness are unguaranteed. |
| P8 | MIDI scheduling and parameter scheduling use sample-time event interfaces. | [scheduleMIDIEventBlock](https://developer.apple.com/documentation/audiotoolbox/auaudiounit/schedulemidieventblock?changes=_8&language=objc), [AUScheduleParameterBlock](https://developer.apple.com/documentation/audiotoolbox/auscheduleparameterblock?changes=l_2_9%2Cl_2_9&language=objc%2Cobjc) — public API references, retrieved 2026-10-23 | Protocol/controller scope remains R05. |
| P9 | Apple’s program terms require use of documented APIs and put third-party content/SDK responsibility on the developer. | [Apple Developer Program License Agreement](https://developer.apple.com/support/terms/apple-developer-program-license-agreement/) — public terms, retrieved 2026-10-23 | This is a source of contractual facts, not legal clearance. |
| P10 | App Review Guidelines require rights for included content and responsibility for third-party SDK compliance. | [App Review Guidelines](https://developer.apple.com/app-store/review/guidelines/) — public guidelines, last updated 2026-10-16, retrieved 2026-10-23 | Review outcome and rights clearance remain unknown. |
| P11 | Current general Apple guidance says an app’s sandbox container is accessible only to its owning app; sharing files with its app extension requires an app group for both processes and proper entitlement. | [Shared data](https://developer.apple.com/documentation/technologyoverviews/shared-data) — current Apple overview, retrieved 2026-10-23 by web search/open | General app/extension rule; it does not establish AUv3 host/plugin rights. |
| P12 | Current App Groups guidance says app groups are for apps developed by the same developer/team; they can share data between an app extension and its host app and expose shared-container APIs. | [Configuring app groups](https://developer.apple.com/documentation/Xcode/configuring-app-groups?changes=l__8&language=objc) — current Apple article, retrieved 2026-10-23 by web search/open | Entitlement/configuration is an adoption-only future decision. |
| P13 | Historical Apple extension guidance says a containing app and its contained extension have no direct access to each other’s containers; an enabled shared container gives participating contained extensions read/write access. | [Handling Common Scenarios](https://developer.apple.com/library/archive/documentation/General/Conceptual/ExtensibilityPG/ExtensionScenarios.html) — historical guide, retrieved 2026-10-23 | Historical context, corroborated for generic sharing by P11/P12; not an AUv3-specific rule. |

## 1. What “host AUv3” means; what it does not mean

### Facts

- Apple’s sample uses `AVAudioUnitComponentManager`/an
  `AudioComponentDescription` to search registered components, distinguishing
  effects (`kAudioUnitType_Effect`) and MIDI instruments
  (`kAudioUnitType_MusicDevice`) [P1]. A host then instantiates the selected
  component.
- In iOS Apple documents third-party AUv3 as an App Extension in a dedicated
  process with IPC to the app [P2]. This is hosting another developer’s
  component, not shipping AugmentedKeys as an AU extension.
- The sample says iOS can use existing AUv2 only when the operating system
  provides it; macOS can also use third-party AUv2. It says such AUv2 plug-ins
  always run in the host process. For AUv3, the sample says the default is
  out-of-process and `loadInProcess` is a macOS-only request for an
  appropriately packaged component [P3]. These platform facts prohibit an
  Apple-mobile/desktop or Apple/Android parity claim.
- Shipping an AUv3 is a separate producer activity: Apple documents an app
  extension with an `AudioComponents` `Info.plist` entry and an
  `AUAudioUnitFactory` principal class [P3]. That activity is out of scope.

### Boundaries and non-guarantees

| Host must own | Component/plugin supplies or may vary | Not guaranteed by the cited APIs |
| --- | --- | --- |
| Discovery UX, selection, instantiation/error handling, graph insertion, session coordination, persistence policy, UI containment, telemetry outside render, and recovery policy. | Component type, supported busses/formats, optional UI, parameter tree, presets/state, processing code, and error behavior. | Arbitrary third-party availability, compatibility, sound quality, CPU/latency, isolation sufficiency, crash recovery, state schema/size/security, or desktop/AU/AAP parity. |

**Inference:** Out-of-process execution reduces direct address-space coupling but
does not, by itself, establish a safe recovery strategy or real-time deadline
behavior. That follows from P2/P4/P5; it requires failure and timing evidence.

## 2. Discovery, instantiation, lifecycle, and failure handling

### Documented host flow

1. Form a component description that expresses the component class the host
   seeks; enumerate matching registered components [P1]. Do not represent
   enumeration as an entitlement for every installed or marketed plugin.
2. Instantiate asynchronously with `AVAudioUnit.instantiate` or the
   `AUAudioUnit` interface, retaining an explicit error path. Apple warns that
   waiting on the main thread can deadlock [P4].
3. Query/validate busses, formats, max frames, available parameter tree, state,
   and optional UI before connecting the component to a graph [P5–P7].
4. Allocate/prepare outside the render path, connect only a validated graph,
   then maintain a recoverable control-plane state if instantiation,
   negotiation, rendering, UI, state restore, route, or extension lifecycle
   fails. Step 4 is a project recommendation, not an Apple-prescribed policy.

### Required future failure matrix (unperformed)

| Scenario | Future host observation / expected safe state |
| --- | --- |
| No matching component / unavailable plugin | Selection remains unavailable; no stale selection or route claim. |
| Instantiate returns error or never reaches usable graph | Capture error/timing; return to a known built-in or silent state without blocking render. |
| Plugin extension terminates, disconnects, stalls, or cannot render | Preserve bounded diagnostic state outside callback; detach/replace only from control plane after declared policy. |
| Bus/format/channel mismatch or resource allocation failure | Reject/disable configuration rather than coercing an unverified format. |
| Custom UI absent, fails, or returns on non-main thread | Host presents a generic/limited state only if explicitly designed; UI work is returned to the UI context [P6]. |
| Full-state/preset restore fails or schema changes | Treat saved state as untrusted/versioned data; report failure and avoid partial hidden restore. |
| Route/session reset during hosting | Revalidate session, graph, busses, format, resources, component presence, and user policy before any resume. |

No scenario above has run. Specific process termination notification/restart
semantics for AUv3 components remain evidence gaps for a later Apple spike.

## 3. Graph, format, rendering, and resource boundary

### Facts

- `AUAudioUnit` exposes input and output bus arrays. `shouldChange(to:for:)`
  participates in a bus format change; `maximumFramesToRender`,
  `allocateRenderResources`, `deallocateRenderResources`, and `renderBlock`
  define related render/resource interfaces [P5].
- An effect and an instrument differ in their component type and expected graph
  role, but the host cannot infer every third-party bus topology or channel
  capability from the coarse type alone [P1, P5].
- Apple’s migration article maps v2 render to a v3 render block and explicitly
  describes rendering as real-time context: [Migrating a host](https://developer.apple.com/documentation/audiotoolbox/migrating-your-audio-unit-host-to-the-auv3-api), retrieved 2026-10-23.

### Real-time policy

The project’s hard real-time rules apply to the host callback and every invoked
path: no I/O, UI, discovery, loading, initialization/teardown, parsing,
allocation, arbitrary locks, or possibly blocking logs. Fetch blocks and
establish resource allocation on an approved non-real-time path before
rendering; P5 documents interfaces, **not** the thread-safety or allocation
behavior of an arbitrary plugin. The host must not call Flutter/Dart/UI/session
configuration or persistence from the render callback. A third-party plugin’s
callback conduct, internal allocation/locking, CPU bound, and failure behavior
are unknown until component-specific evidence exists.

## 4. UI, parameters, automation, presets, and state

### Facts

- `requestViewController` is asynchronous, may return no controller, and its
  completion occurs on an audio-unit internal thread/queue [P6]. The host owns
  correct UI-thread integration and must not assume a custom UI exists.
- Parameters are organized in an `AUParameterTree`; `scheduleParameterBlock`
  schedules address/value changes by sample time and optional ramp duration
  [P5, P8]. Parameter availability/range/meaning is component-defined.
- `fullState` is intended for a user-preset snapshot. Apple says it should not
  persist transitory properties such as stream formats. `fullStateForDocument`
  may represent state appropriate to a user document; subclasses not
  implementing it fall back to `fullState` [P7]. Factory/user presets and
  support flags are public concepts, not universal plugin guarantees [P5, P7].

### State/security requirements for a later spike (recommendations)

- Store plugin identity/version and a bounded, validated state envelope with
  explicit size, schema, retention, migration, restore failure, and deletion
  policies. Neither P7 nor P9 specifies safe state size/content.
- Treat component-provided state, names, preset metadata, UI output, and
  parameter descriptions as external input. Do not claim it lacks personal,
  copyrighted, executable, malformed, or sensitive data without inspection.
- Do not load plugin state, serialize it, or surface its UI on the render path.
  No project policy yet selects storage, encryption, sync, or privacy behavior.

## 5. Apple-hosted audio/MIDI event boundary (R05 reservation)

### Facts

- A host intending to schedule MIDI must fetch `scheduleMIDIEventBlock` before
  rendering; it can be `nil` for a component that is neither music device nor
  effect [P8]. Events delivered through it reach the component as render-event
  lists [P8].
- The retrieved `AUScheduleParameterBlock` documentation says that **when
  scheduling during the render cycle**, `AUEventSampleTimeImmediate` plus an
  optional offset of fewer than 4096 frames schedules at that position in the
  **current** render cycle. It also documents sample-time/ramp fields [P8].
- The captured `scheduleMIDIEventBlock` page says to fetch the block before
  rendering and describes delivery to render-event lists, but it does not state
  an `Immediate` timing rule. The captured parameter page does not establish an
  outside-render `Immediate` rule. Therefore this report makes no universal
  next-cycle or outside-render timing claim.

### Boundary statement

These APIs document host-facing timing mechanisms, not measured MIDI ingress,
controller support, MIDI 1.0/2.0/MPE semantics, timestamp accuracy, or
audible-output latency. R05 owns protocol and controller scope. A future AUv3
spike may measure host-to-plugin event timing only after its exact event source,
sample-clock boundary, route, device, workload, and accepted error budget are
approved.

## 6. Distribution, licensing, sandbox, and supply chain

### Facts and constraints

- Apple’s public program terms require documented APIs and make the developer
  responsible for application compliance, including third-party SDKs/services
  [P9]. The App Review Guidelines require rights to included content and say
  the developer is responsible for third-party SDK compliance [P10].
- AUv3’s documented extension/process model is not a grant to copy, bundle,
  redistribute, download, or sell a third-party plugin/content [P2, P9, P10].
- Background execution, signing, entitlements, privacy disclosures, App Store
  review, and third-party agreements are adoption/release questions; none is
  changed here. App extensions and background modes have distinct configuration
  implications, but no conclusion about required permissions for a future host
  should be drawn without an approved implementation and component inventory.

### Process, sandbox, container, and data-access boundary

**Facts about distinct layers:** The AU sample documents iOS third-party AUv3
as out-of-process IPC [P2]. That is **process isolation**, not a statement
about sandbox/container/file rights. Current general Apple guidance says an
app’s own sandbox container is accessible only by that app; sharing files with
an app extension requires an app group for both processes and proper
entitlement [P11]. Current App Groups guidance describes shared containers and
shared preferences between an app extension and its host app, but limits app
groups to apps developed by the same developer/team [P12]. Historical Apple
guidance more specifically says that a **containing app** and its
**contained** extension have no direct access to one another’s containers, and
that permitted participants in an enabled shared container gain read/write
access [P13].

**Necessary distinction:** The containing-app relationship in P13 is not
established for an independent third-party AUv3 selected by an unrelated host.
Neither P2 nor the generic P11/P12 guidance proves that an AUv3 host and an
independent plugin share an app group, containers, files, presets, assets, or
any entitlement. Owner approval cannot by itself create cross-team app-group
sharing for an unrelated AUv3. The only AUv3-specific process fact cited here
is P2’s out-of-process/IPC statement.

**Questions for a later approved component inventory/spike:**

1. Is a selected component a containing app’s own extension, an OS-provided
   component, or an independently distributed third-party AUv3? Who signs and
   distributes it, and what exact host/component relationship is documented?
2. Which data crosses documented AU host interfaces/IPC, and which host data,
   plugin state, presets, files, resources, identities, and diagnostics must
   remain inaccessible to the other process? Current R03 evidence does not
   answer this component-by-component.
3. Does either party request an app-group shared container? If so, which
   same-developer/team processes may receive the entitlement, what files/records
   are shared, and what ownership, validation, synchronization, retention, and
   revocation rules apply? Do not assume the answer is yes for AUv3 or that
   owner approval creates cross-team sharing.
4. What file/resource access does the component require for its own operation,
   and can the host instead use a bounded, validated control-plane exchange?
   No source here establishes third-party file access or permission scope.

These questions are a risk inventory, not an entitlement request, architecture
choice, sandbox design, or legal conclusion. Any shared-container I/O must
remain outside the future render callback.

### R07 adoption-only ledger questions

1. For every candidate plugin: publisher, version, distribution channel,
   commercial-hosting rights, redistribution prohibition/permission, content
   rights, update/revocation policy, support, privacy/data behavior, and
   signature/provenance verification.
2. For any Apple sample/source considered: exact download revision, bundled
   license/notice, permitted use, modification, redistribution, attribution,
   and dependency provenance. This research downloaded no sample project or
   archive and adopted no code; captured documentation’s instructional snippets
   do not support a sample-code license conclusion.
3. For a release candidate: current Apple agreement and review applicability,
   entitlement/background/privacy disclosures, required signing, store policy,
   user data/state retention, and supply-chain review. These are not legal
   advice and require owner/legal authority where applicable.

## 7. Bounded later hosting spike plan

All quantities/procedures are proposals only; hardware and budgets are not
approved. Every fixed count below is a proposed study-design count, not an
approved test, duration, acceptance budget, or a claim of known workload.

1. Select one owner-approved device/OS/route and a legally cleared test
   component. Repeat discovery/instantiate/remove **a proposed 30 times**, recording component
   identity, wall-clock control-plane duration, errors, leak indicators, route,
   format/channel negotiation, and any main/UI blocking observation.
2. For one approved instrument and one effect, test **a proposed 30** state save/restore and
   **a proposed 30** preset/UI requests. Record state byte count, schema/version metadata,
   absent UI, restore errors, resulting parameter values, and recovery path;
   never log sensitive state blindly.
3. Under a predeclared live workload, perform **a proposed 30** controlled interruption/route
   scenarios and **a proposed 30** deliberate component failure/termination scenarios where a
   safe test procedure exists. Record note/sustain cleanup, engine/route state,
   callback durations, deadline misses, underruns, event drops, recovery time,
   and audible outcome using approved instrumentation.
4. Run an owner-approved long duration at a declared maximum workload; retain
   component version, CPU/memory/thermal data, callback/underrun counters,
   route/lifecycle events, and all failures. No maximum plugin count, polyphony,
   CPU target, latency target, or duration is known now.

## Conclusion, gaps, and next action

Apple supplies a documented AU host surface for discovery, async instantiation,
bus/format/resource/render management, optional UI, parameter events, and
persistable state [P1–P8]. It does not make an AUv3 hosting product low-latency,
safe under failure, commercially licensed, or cross-platform. The first
research/spike-scoping recommendation is to defer hosting behind built-in
playback/session lifecycle work, then approve a narrowly bounded Apple-only
host-failure and state/format experiment after R07 clears a test component.

**Retrieval provenance and limitations:** The writer’s initial research used
four public web searches and excerpts, rather than successfully opening full
Apple pages. The controller subsequently direct-retrieved every cited source
from Apple Markdown endpoints or original HTML with HTTP 200, access times,
SHA-256 hashes, and preserved responses. The controller-owned catalog is to be
recorded at `docs/orchestration/milestones/m0/evidence/r03-source-evidence.md`;
raw records currently reside in shared Git evidence. The writer initially
reached the new current generic extension/container pages through the browser’s
official Apple search/open path; `web.open` exposed JavaScript shells while the
search response supplied excerpts, and a direct shell `curl` to Apple Markdown
endpoints failed DNS resolution. The controller has now direct-urllib captured
and hashed sources 24–27, including the archived route guide and the current
shared-data, App-Groups, and historical container-guidance bodies. The cited
APIs establish
interfaces and the table’s metadata availability—not a selected minimum OS,
real plugin availability, third-party behavior, desktop compatibility,
Android equivalence, performance, legal clearance, or release approval.

---

# Android AAP and AAP-JUCE hosting research (R04)

**Scope and preservation note:** The preceding Apple AUv3 report is preserved
byte-for-byte as one contiguous R03 section; its earlier Android reservation is
historical. This separately dated section records Android-only documentary
research. It does not claim AUv3/AAP parity, adopt AAP/JUCE, select a host, or
report any installed plugin, device, runtime, latency, callback-safety, or
compatibility result. Access date: 2026-10-23 (Asia/Manila).

## Source and status register

| ID | Original source / inspected moving identity | Documentary fact or limitation |
| --- | --- | --- |
| H1 | [AAP core README](https://github.com/atsushieno/aap-core), `main` at access | README labels AAP as active/unstable and documents apps/services, metadata, MIDI 2 messaging, and AAPXS. Browser did not expose a full branch-tip SHA. |
| H2 | [AAP Developers Guide](https://github.com/atsushieno/aap-core/blob/main/docs/DEVELOPERS.md), `main` at access | Inspected full host/plugin package, service, metadata, AIDL/Binder, shared-memory, lifecycle, and hosting text. Full immutable SHA unavailable through browser. |
| H3 | [AAP core LICENSE](https://github.com/atsushieno/aap-core/blob/main/LICENSE), `main` at access | Repository license text is MIT; README names additional component licenses. This is not clearance. |
| H4 | [AAP-JUCE README](https://github.com/atsushieno/aap-juce/blob/main/README.md), `main` at access | Inspected host/plugin, instability, porting, UI, patch, and build-toolchain statements. Full immutable SHA unavailable through browser. |
| H5 | [AAP-JUCE GUI guide](https://github.com/atsushieno/aap-juce/blob/main/docs/JUCE_GUI_SUPPORT.md), `main` at access | Inspected remote-view/plugin-process GUI and manifest/service examples; it labels requirements including API 29 for that route. |
| H6 | [AAP-JUCE LICENSE](https://github.com/atsushieno/aap-juce/blob/main/LICENSE), `main` at access | License body identifies GNU AGPLv3. |

The controller must later retain full bodies and pin full Git SHAs for H1–H6
before a source-dependent spike. This task read no archive or repository clone,
ran no build, and incorporated no code.

**Retrieval limitation:** Browser-opened AAP pages did not expose a full
branch-tip SHA. A read-only `git ls-remote` for both repositories failed on
2026-10-23 with `Could not resolve host: github.com`; no clone, download, or
write occurred. These moving-branch pages are not substitutes for immutable
controller-captured source evidence.

## Host/plugin/process boundary

### Facts

- AAP describes plugins as Android application packages (APK/AAB) containing
  native shared libraries. A plugin exposes an exported
  `org.androidaudioplugin.AudioPluginService` with an AAP intent action and
  `aap_metadata.xml`; one package can describe multiple plugins [H2].
- Hosts discover services through `PackageManager.queryIntentServices()` and,
  on Android 11+, the cited guide says the host needs the relevant manifest
  `<queries>` intent declaration for service queries [H2]. Discovery metadata
  includes developer/name/unique ID/version/category/library/entrypoint and
  can expose parameters/extensions without instantiating the service [H2].
- The guide says a host queries then connects with Binder. Its AIDL excerpt
  includes create, extension/shared-memory descriptor, prepare, activate,
  process, deactivate, and destroy methods [H2]. It says the host needs Java
  `Context.bindService()`/JNI for service binding because there is no NDK API
  for it, while the documented hosting API is C++ and explicitly subject to
  change [H2].
- AAP says host and plugin live in separate processes by Android platform
  nature and describes MIDI 2 event messaging/AAPXS extensions. It does not
  call this real-time safe [H1]. The Developers Guide expressly says Kotlin is
  not real-time safe and Binder is not real-time safe [H2].

### Boundary ledger for a future experiment

| Boundary | Known from H1–H5 | Unknown / must be separately tested |
| --- | --- | --- |
| Package/identity | PackageManager finds exported services; metadata carries a plugin unique ID/version. | Authenticity, signer continuity, naming collision policy, update/revocation policy, and Play-distribution status. |
| Process/UID | Host/client and plugin service are distinct application/process participants; Binder is used. | Exact UID relation, SELinux/domain behavior, permissions, crash/stall containment, memory/CPU scheduling, or recovery guarantees. |
| IPC/data | AIDL/Binder methods and `ParcelFileDescriptor` shared-memory exchange are documented. | Validation/size/lifetime/ownership of buffers, data confidentiality/integrity, backpressure, fd leakage, malformed service behavior, and deadline bounds. |
| State | AAP supports extension/state concepts and metadata includes identity/version. | State schema/size/source trust, storage/container location, migration, encryption, retention, deletion, backup, or privacy disclosure. |
| UI | AAP-JUCE documents a remote Android View/plugin-process editor path and says it is preliminary. | View lifecycle, accessibility, input focus, malicious/misbehaving UI, host containment, UI crash recovery, and Flutter integration. |
| MIDI/render | AAP uses MIDI 2/UMP-related messaging and plugin processing lifecycle exists. | Controller compatibility, timestamp semantics, render timing, audible latency, event loss/ordering, and callback safety. |

Separate process or Binder transport is not a proof of safety, sandbox
sufficiency, reliable recovery, low latency, trusted input, or compatible
plugin behavior. No AAP source establishes cross-app file/container access for
an arbitrary host and plugin; all file/resource/state access must therefore be
treated as an explicit component-specific question.

## Lifecycle, render, and control-plane separation

The AAP Developers Guide describes plugin lifecycle in this order: factory,
instantiate with plugin ID/sample rate/extensions, prepare initial buffers,
activate, process blocks/MIDI2 events, deactivate, terminate/destroy [H2]. It
also says a host can use synchronous creation for already-bound services and
asynchronous creation to dynamically bind a service [H2]. These descriptions
do not prescribe product shutdown ordering or prove that a third-party plugin
meets a deadline.

**Recommendation:** Place package queries, manifest/metadata parsing, service
binding, instantiation, state/UI work, file I/O, logging, route/focus work,
and `destroy` on a non-real-time control plane. Only an evidence-backed,
bounded, preallocated data-exchange path could later become render-visible.
Do not invoke Binder, JNI, Kotlin, service discovery, UI, persistence, plugin
load/unload, or arbitrary plugin control calls from the future audio callback.

**Disagreement/limit:** AAP's guide presents service/process architecture and
some tracing capability; it also says APIs are unstable, Kotlin/Binder are not
RT-safe, and the supplied proof-of-concept host is a static generator rather
than live processing [H1–H2]. That is evidence against treating framework
availability or separate processes as callback-safety evidence. It does not
prove an AAP host cannot be engineered safely after a bounded platform-specific
spike.

## AAP-JUCE surface and toolchain limits

AAP-JUCE describes itself as integration modules, helper scripts, and patches
for JUCE apps in the AAP environment. It warns that AAP has breaking API/ABI
changes, that local changes are required, and that documentation is limited
[H4]. It identifies `aap-juce-simple-host` as able to enumerate installed AAP
plugins and instantiate them; this is an upstream project statement, not a
result for AugmentedKeys [H4].

The README says CMake is preferred but not officially supported by upstream
JUCE according to the document; historical Projucer support is possible but no
longer supported/recommended and can require generated-project replacement
[H4]. The GUI guide documents a preliminary native plugin-process GUI route,
remote Android view, plugin service/view service, AndroidX Startup, manifest
declarations, required patches, and API 29+ for the stated
`SurfaceControlViewHost` route [H5]. None chooses a build tool, min SDK,
manifest, service export, permission, UI strategy, or plugin product policy.

Desktop-oriented JUCE plugin UI can fail or be unsuitable on Android according
to the README, including mobile-unfriendly UI, unavailable Android APIs,
global-desktop accesses, file-selection mismatch, and possible performance
issues [H4]. This is a warning about porting risk, not an assertion that every
JUCE plugin fails or that a universal Android plugin ecosystem exists.

## License, privacy, and supply-chain characterization

- The inspected AAP core root LICENSE is MIT [H3]. Its README calls out
  additional copied/imported components and licenses, so an itemized revision
  and transitive review remains necessary.
- The inspected AAP-JUCE repository license is AGPLv3 [H4, H6]. The README
  associates this with JUCE but does not resolve which future source,
  distribution, linking, patch, generated code, or commercial arrangement
  would apply to any proposed product.
- Discovery can reveal package/service/metadata fields. State, preset, UI,
  names, plugin metadata, shared-memory contents, files, diagnostics, and
  control messages must be treated as external/untrusted data until a later
  validated data contract exists.
- Future R07 questions include exact source revision; notices; AGPL/MIT and
  every transitive license; Android/Play policy; signing/signers; export and
  query visibility; component permissions; service attack surface; storage and
  backup; user data; vulnerability/update policy; and redistribution. No legal
  conclusion, adoption, ledger approval, or component clearance is made here.

## Proposed later hosting experiment (unperformed/unapproved)

After the built-in Android lifecycle spike and R07 review, a single
owner-approved host/plugin/device/OS/route configuration could record:

1. Host and plugin package names, version/full SHA/build provenance, signer,
   UID/process observations, manifest `queries`/services/exported flags,
   declared/requested permissions, metadata unique ID, and service binding
   result.
2. Control-plane discovery/bind/create/prepare/activate/deactivate/destroy
   durations and errors; no control-plane duration is a render deadline.
3. Exact shared-memory/Binder/AIDL exchange dimensions, ownership/lifetime,
   plugin state size/schema, file/container accesses, UI presence/failure, and
   recovery behavior after controlled service/process removal where an approved
   procedure permits it.
4. Predeclared callback-duration/deadline/underrun/event-loss counters outside
   the callback, plus route, focus, overload, disconnect, recovery, and
   long-run observations under a declared workload and approved measurement
   budget.

For study design only, a proposed 30 discovery/bind/create/destroy cycles and
30 controlled service/route recovery cycles could be paired with one proposed
60-minute declared-workload run. Those quantities do not request hardware or
authorize a plugin, procedure, duration, overload method, or acceptance value.

The unknown acceptance budgets are latency, continuity, maximum plugin count,
polyphony/workload, CPU/memory/thermal/battery, state size, timeout/retry,
event loss, disconnect recovery, duration, and security/privacy criteria. No
hardware, procedure, numeric budget, or measurement has been approved.

## Android conclusion and open questions

AAP has a documented Android package/service discovery and remote-instance
surface, while AAP-JUCE documents an unstable, patch/toolchain/UI-heavy bridge
for JUCE-related apps [H1–H5]. The evidence supports a later constrained
hosting investigation only. It does not support selecting AAP/AAP-JUCE,
asserting Android/AUv3 parity, claiming a broad hostable plugin ecosystem, or
claiming real-time safety/latency/compatibility/security.

The first recommended research sequence remains built-in Android
stream/lifecycle evidence, then one component-specific hosting experiment with
immutable source capture, R07 review, and approved physical-device procedure.
