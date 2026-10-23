# Apple AUv3 hosting research

**Status:** R03 documentary research, Apple findings only. This is not a
commitment to host AUv3, ship an Audio Unit extension, select an engine, or
claim Android/AAP compatibility. Android conclusions are reserved for R04.
**Access date:** 2026-10-23 (Asia/Manila). No plugin, sample, SDK, extension,
device, simulator, account, signing identity, entitlement, or executable code
was downloaded, run, or adopted.

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
| P10 | App Review Guidelines require rights for included content and responsibility for third-party SDK compliance. | [App Review Guidelines](https://developer.apple.com/app-store/review/guidelines/) — public guidelines, retrieved 2026-10-23 | Review outcome and rights clearance remain unknown. |

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

### R07 adoption-only ledger questions

1. For every candidate plugin: publisher, version, distribution channel,
   commercial-hosting rights, redistribution prohibition/permission, content
   rights, update/revocation policy, support, privacy/data behavior, and
   signature/provenance verification.
2. For any Apple sample/source considered: exact download revision, bundled
   license/notice, permitted use, modification, redistribution, attribution,
   and dependency provenance. This research did not download sample code, so
   no sample-code license conclusion is made.
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
raw records currently reside in shared Git evidence. The cited APIs establish
interfaces and the table’s metadata availability—not a selected minimum OS,
real plugin availability, third-party behavior, desktop compatibility,
Android equivalence, performance, legal clearance, or release approval.
